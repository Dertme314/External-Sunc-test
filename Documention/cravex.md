# Cravex Analysis

This document details functions and features in the Cravex environment (`Cravex.lua`) that are implemented as "fakes", stubs, or Lua-side polyfills rather than native C++ hooks.

## 1. Architecture & Bridge
Cravex uses a central bridge function called `nukedata` which communicates with a local server at `http://localhost:9611/handle`. Almost all "native" capabilities (file system, clipboard, console, script execution) are routed through this HTTP bridge.

## 2. Instance Proxying
Cravex implements a heavy `proxyobject` wrapper system for Instances.
*   **`Instance.new`**: Returns a proxy wrapper, not the raw instance.
*   **`game` / `workspace`**: Proxied global variables.
*   **`typeof`**: Overridden to return "Instance" for proxy userdata.
*   **Comparison**: Uses `compareinstances` (and likely `__eq` metamethods) to handle proxy identity, which can fail in strict equality checks (`==`).

## 3. Script Execution
*   **`loadstring`**:
    1.  Compiles source via bridge (`nukedata` "compile").
    2.  Clones `AvatarEditorPrompts` into `RobloxReplicatedStorage` as a container.
    3.  Uses `debug.loadmodule` on this cloned module to execute the bytecode.
    4.  Wraps the result in the Cravex environment.
    This is a complex workaround to avoid native execution hooks.

## 4. Debug Library (Stubbed & Wrapped)
*   **`debug.getinfo`**: Pure Lua wrapper around standard `debug.info`. Returns mocked "C" or "Lua" tags based on source.
*   **`debug.getconstants` / `debug.getprotos`**: Return empty tables.
*   **`debug.getupvalue` / `debug.setupvalue`**: Wrappers around the limited standard `debug` library.
*   **`debug.setstack`**: Returns false (not implemented).

## 5. Decompiler (Hybrid)
*   **Lua-Side Decompiler**: Contains a full Lua-based decompiler (`LuaDecompiler` class) that attempts to reconstruct source from bytecode instructions (`OPCODES` table).
*   **Konstant API**: Falls back to an external API (`api.plusgiant5.com`) for `decompile` and `disassemble` if the local one isn't used.

## 6. Crypt Library (XOR)
*   **`crypt.encrypt` / `crypt.decrypt`**:
    *   Implements a basic **XOR** cipher using `bit32.bxor`.
    *   Not AES, not secure.
*   **`crypt.hash`**: Loads from GitHub (`Fynex/hash`).

## 7. Input Simulation
*   **`keypress`, `mouse1click`, etc.**
    *   Routed to `nukedata`, which likely calls C++ input simulation or `VirtualInputManager` on the bridge side.
*   **`fireproximityprompt` / `firetouchinterest`**:
    *   Lua implementations! They physically move parts or the camera to trigger interactions, rather than hooking inner engine signals.
    *   `fireclickdetector`: Creates a temporary part, moves camera, and uses `VirtualInputManager`. These are "macro-style" fakes.

## 8. WebSockets
*   **`WebSocket`**:
    *   Polyfilled via bridge polling (`websocket_poll`).
    *   Uses `BindableExample` for `OnMessage` and `OnClose`.
    *   Not a real async socket connection in the engine thread.
