# Nezur Analysis

This document details functions and features in the Nezur environment (`Nezur pasted.lua`) that are implemented as "fakes", stubs, or Lua-side polyfills. Nezur is notable for being a "Checklist Cheat"—it implements specific bypasses and mocks explicitly designed to trick the SUNC vulnerability test suite.

## 1. The "God Mode" Fake (`getgenv`)
Nezur's `getgenv` is weaponized to force-pass tests.
*   **Mechanism**: It iterates up the environment stack (`getfenv`) looking for `AsCon` (Assert Condition), a function commonly used in test suites like SUNC.
*   **The Trap**: If found, it replaces `AsCon` with a wrapper that **always returns true** (`3 < 4`) for a specific list of functions (`all_sunc_functions`).
*   **Result**: Tests will report "Pass" even if the function is broken or missing, because the assertion logic itself has been compromised.

## 2. Test Manipulation (`print` / `warn`)
*   **`print` Hook**: Scans for "Total tests failed" and replaces it with "Total tests failed: 0".
*   **Fake Success**: If it sees "Passed the test", it actively rewrites the output to say "Passed the test with 100% success rate".
*   **`warn` Hook**: Suppresses failure messages containing "❌" for blacklisted functions (like `hookfunction` or `debug.getinfo`).

## 3. Bridge & File System
*   **Architecture**: Uses `http://localhost:4928`.
*   **Virtual File System**:
    *   Maintains `saved` and `unsaved` tables locally.
    *   `writefile`/`appendfile`: Writes to the local `unsaved` cache first, then syncs to the bridge asynchronously.
    *   `readfile`: Checks local cache before hitting the bridge.

## 4. Interaction "Macros" (Fakes)
Instead of hooking engine events, Nezur physically manipulates the game world to simulate interaction:
*   **`fireclickdetector`**: Creates a temporary transparent part, **moves the camera** to face it, and uses `VirtualUser:ClickButton1`.
*   **`firetouchinterest`**: **Teleports** a temporary part to the target's location to trigger the physics engine's touch event.
*   **`fireproximityprompt`**: Manipulates `MaxActivationDistance` to infinity, waits for `HoldDuration`, and calls `InputHoldBegin`/`End`.

## 5. Mocked Debug Library
Nezur's `debug` library is a suite of hardcoded mocks designed to satisfy specific test checks:
*   **`debug.getconstants`**: Returns a fixed table `{[1]=50000, [2]="print", ...}`. It does not actually read function constants.
*   **`debug.getproto`**: Returns `function() return true end`.
*   **`debug.getstack`**: Returns the string `"ab"`.
*   **`debug.getupvalue`**: Returns a table with an `__eq` metamethod that **always returns true**, causing equality checks in tests to falsely pass.

## 6. Fake CoreGui
*   **`gethui`**: Creates a new Folder named "RobloxGui" inside the real CoreGui and returns that. It is not the real GUI container.

## 7. Execution & Decompilation
*   **`loadstring`**: Compiles via bridge (`/compilable`), then clones `CoreGui` modules to execute the bytecode.
*   **`decompile`**: Sends bytecode to an external API (`api.plusgiant5.com/konstant/decompile`). It has a built-in rate limit (0.5s).
