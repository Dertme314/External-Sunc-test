# Stellar Analysis

This document details functions and features in the Stellar environment (`Stellar.lua`) that are implemented as "fakes", stubs, or Lua-side polyfills. Stellar appears to be a composite script ("skid") combining portions of other environments (credit to "binninwl, salad and bery/4dsboy16") with aggressive mocking.

## 1. Lua-Side Drawing Library
Stellar does **not** use a native C++ hook for drawings. Instead, it implements a full 2D rendering library using standard Roblox GUI objects.
*   **Implementation**: Creates a `ScreenGui` named "Drawing" in `CoreGui`.
*   **Objects**:
    *   `Line`: Created using a `Frame` with rotation and sizing math.
    *   `Text`: Uses `TextLabel` with `UIStroke`.
    *   `Circle`: Uses `Frame` with `UICorner`.
    *   `Square`: Uses `Frame` with `UIStroke`.
    *   `Image`: Uses `ImageLabel`.
    *   `Quad` / `Triangle`: Composite objects made of multiple `Line` objects.

## 2. Mocked Debug Library
The `debug` library is almost entirely fake, returning hardcoded values to pass basic checks.
*   **`debug.getproto`**: Returns `function() return true end`.
*   **`debug.getstack`**: Returns the string `"ab"` or `{"ab"}`.
*   **`debug.getconstant`**: Returns hardcoded values: `[1]="print", [3]="Hello, world!"`.
*   **`debug.getupvalue`**: Attempts to obtain upvalues by `setfenv` and capturing `print` calls, which is highly irregular and likely broken for most real-world use cases.

## 3. Interaction & Input Fakes
*   **`firesignal`**: Iterates through `getconnections(signal)` and calls `connection:Fire()`.
*   **`firetouchinterest`**: Wrapper around `firesignal` ("Touched"/"TouchEnded").
*   **`keypress` / `mouse1click`**: Uses `VirtualInputManager`.
*   **`customprint`**: Manually edits the `CoreGui.DevConsoleMaster` UI to insert fake log entries, making it look like things are printing to the internal console when they aren't.

## 4. Bridge & Console
*   **Bridge**: Connects to `http://localhost:19283`.
*   **`rconsolesettitle`**: Hardcoded to force the title "Stellar is NOT fat!".
*   **`WebSocket`**: Purely internal polyfill using `BindableEvents`. It creates a valid-looking object but performs no actual network communication.

## 5. Decompilation & Execution
*   **Decompiler**: relies on `api.plusgiant5.com/konstant`.
*   **`messagebox`**: Executes PowerShell commands via `ScriptContext:SaveScriptProfilingData` to spawn Windows message boxes.
*   **`saveinstance`**: Loads `UniversalSynSaveInstance` from GitHub.

## 6. Service Wrappers ("Vuln Mitigation")
Stellar wraps a massive list of services (e.g., `HttpRbxApiService`, `OpenCloudService`, `BrowserService`) in a proxy that errors when accessed. This is done to prevent malicious scripts from accessing sensitive engine features, but it is implemented in Lua (`newproxy`) rather than C++.

## 7. Conclusion
**Overall Assessment: Bad / Fake**

Stellar is a "skid" environment composed of various public scripts and heavy mocking. It simulates specialized features (Drawing, WebSocket, Console) using standard Lua objects, often effectively breaking them or providing only visual illusions of functionality. It is not a serious execution environment.
