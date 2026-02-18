# Solara Analysis

This document details functions and features in the Solara environment (`Solara.lua`) that are implemented as "fakes", stubs, or Lua-side polyfills. Solara uses a unique, heavily proxied approach to bypass standard engine security checks.

## 1. The "Protected" Proxy System
Solara wraps almost every critical Roblox service (`HttpService`, `MarketplaceService`, `CoreGui`, etc.) in a Lua proxy object (`tbl_29_upvr`).
*   **Mechanism**: Uses `newproxy(true)` and `getmetatable` to create fake versions of userdata.
*   **Blocked Methods**: Explicitly errors on dozens of sensitive methods like `OpenBrowserWindow`, `PerformPurchase`, `TakeScreenshot`, and `ReportAbuse`.
*   **Faked Methods**: Replaces `HttpGet` and `HttpPost` with custom implementations that route through a local bridge.

## 2. HTTP & Bridge System
*   **Local Bridge**: Communicates with `http://localhost:9912` via `RequestInternal`.
*   **Roproxy**: Requests to `roblox.com` are automatically rewritten to `roproxy.com`.
*   **Telemetry stripping**: Attempts to remove headers like `ROBLOSECURITY` and blocks "bad_actor_telemetry" payloads.

## 3. Instance Faking (`createMockInstance`)
Solara has a complex system to create fake Instances that mimic real ones.
*   **`createMockInstance`**: Wraps real instances in a proxy to intercept `__index` and `__namecall`.
*   **Why?**: This allows Solara to "hide" or "fake" properties (like `scriptable`) without actually modifying the C++ engine state in a way that triggers detection.

## 4. Execution (`loadstring`)
*   **Implementation**:
    1.  Compiles source to bytecode via bridge (`loadstring` request).
    2.  Clones a random existing `ModuleScript` from the game.
    3.  Renames it to a random string (e.g., `_Loadstring83921`) to obscure it.
    4.  Uses `require()` to execute the bytecode.
    5.  Wraps the result in a new environment using `setfenv`.

## 5. Mocked Debug Library
*   **`debug.getinfo`**: Pure Lua re-implementation that parses the result of the real `debug.info` and constructs a table manually (`short_src`, `currentline`, etc.).
*   **`checkcaller`**: Checks `debug.getmemorycategory() == "Exp"`. This is a very common (and often detected) method.

## 6. Drawing Library
*   **Lua Polyfill**: Solara creates a `ScreenGui` named "Drawing" in `CoreGui`.
*   **`isrenderobj`**: Checks if the object's `__tostring` returns "Drawing".
*   **`cleardrawcache`**: Simply iterating through `CoreGui.Drawing:GetChildren()` and destroying them.

## 7. WebSocket
*   **`WebSocket.connect`**: Returns a wrapper that sends `WS_CONNECT` / `WS_SEND` requests to the local bridge (`localhost:9912`). It relies on the external bridge executable to handle the actual socket connection.

## 8. Conclusion
**Overall Assessment: Fake (Sophisticated) / Bad**

Solara is the most technically complex of the analyzed external environments, involving a massive dedicated proxy system to wrap the entire game engine. However, it remains a **fake** environment. It relies on a local HTTP bridge for all privileged operations, uses `require()` hacking for execution, and polyfills its Drawing library. While impressive engineering went into the fakes, it is still simulating a native environment rather than being one.
