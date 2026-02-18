# Cloudy Analysis

This document details functions and features in the Cloudy environment (`Cloudy pasted.lua`) that are implemented as "fakes", stubs, or Lua-side polyfills rather than native C++ hooks.

## 1. Instance & Environment Management
Cloudy uses a bridge-based system to communicate with an external server for many operations, but falls back to Lua polyfills for others.

### Faked Functions:
* **`gethui`**
  * Returns a folder named `Cloudy` in `RobloxReplicatedStorage`.
  * Alternatively, creates a `Container` in `CoreGui`.
  * Does not return the actual internal `Hui` service.

* **`getrunningscripts`**
  * Only returns scripts that are tracked by the internal `objects` table or specifically added via `getscriptbytecode` calls.
  * Misses almost all game scripts unless they naturally interact with the environment.

* **`identifyexecutor`**
  * Hardcoded to return `"Cloudy", "v2.0.0"`.

## 2. Drawing Library (Polyfill)
* **`Drawing`**
  * Loaded via `loadstring` from a GitHub URL (`Fynex/drawinglib`).
  * Implemented using standard Roblox `CoreGui` instances (`Frame`, `TextLabel`, `ImageLabel`).
  * Detectable by any script scanning `CoreGui`.

## 3. Crypt Library (Weak Implementation)
* **`crypt.encrypt` / `crypt.decrypt`**
  * Implements a simple **XOR** cipher, not standard AES.
  * Symmetric encryption (encrypt == decrypt).
  * Insecure and breaks compatibility with scripts expecting AES.

* **`crypt.hash`**
  * Loaded via `loadstring` from a GitHub URL (`Fynex/hash`).

## 4. HTTP & Networking
* **`request`**
  * Routes all traffic through a local Python bridge server (`http://localhost:19283`).
  * Adds a custom header `ExternalExecutor-Fingerprint`.
  * If the bridge server is down, all HTTP requests fail.

## 5. Script Execution
* **`loadstring`**
  * Sends source code to the bridge server to be "compiled".
  * Returns a wrapper that loads the bytecode via a `ModuleScript` trick in `RobloxReplicatedStorage`.
  * Heavily reliant on the bridge's uptime and latency.

## 6. Input Simulation
* **`keypress`, `mouse1click`, etc.**
  * Uses `VirtualInputManager` methods (e.g., `SendKeyEvent`, `SendMouseButtonEvent`).
  * This is standard for externals but technically "simulated" rather than hooked execution.

## 7. File System
* **`writefile`, `readfile`, `listfiles`**
  * All file operations are sent to the bridge server.
  * Includes a "Virtual File System" (`virtualFilesManagement`) that attempts to sync files, likely to handle unsaved changes or latency.
