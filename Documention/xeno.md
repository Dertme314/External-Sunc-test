# Xeno Client Analysis (v1.3.10)

This document details functions and features in the Xeno client (`v1.3.10 CLIENT.lua`) that are implemented as "fakes", stubs, or Lua-side polyfills rather than native C++ hooks.

## 1. Debug Library (Mock Implementation)
The `debug` library is heavily mocked, returning static or meaningless values to prevent scripts from crashing while providing incorrect information.

### Faked Functions:
- **`debug.getprotos` / `debug.getproto`**
  - Returns a dummy table with `__call` and `__index` metamethods that always return `true`.
  - Does not actually retrieve function prototypes.

- **`debug.getconstant`**
  - Ignores the function argument.
  - Returns values from a hardcoded table: `{"print", nil, "Hello, world!"}` based on the index.

- **`debug.getconstants`**
  - Ignores the function argument.
  - Returns a static table: `{50000, "print", nil, "Hello, world!", "warn"}`.

- **`debug.getstack`**
  - Ignores the level/index arguments.
  - Returns `"ab"` or `{"ab"}`.

- **`debug.getupvalue`**
  - Always returns `nil`.

- **`debug.setconstant`, `debug.setstack`, `debug.setupvalue`**
  - Empty stubs that return `nil` and modify nothing.

## 2. Drawing Library (Polyfill)
The `Drawing` library is implemented entirely in Lua using standard Roblox `CoreGui` instances (`Frame`, `TextLabel`, `ImageLabel`, `UIStroke`).

### Implementation Details:
- **Rendering:** Uses `ScreenGui` elements instead of a direct DirectX or overlay hook.
- **Visuals:** Functions like `Line`, `Text`, `Circle`, `Square`, `Image`, `Quad`, and `Triangle` are constructed using `Frame` objects manipulated with `UIGradient`, `UICorner`, and `UIStroke`.
- **Detection:** Because these are standard GuiObjects in `CoreGui`, they are detectable by scripts scanning the interface.

## 3. Connection Management
The connection management functions are wrappers around standard Roblox events but with key limitations for "foreign" signals.

### Issues:
- **`getconnections`**
  - Returns a table wrapper resembling a connection object.
  - For **ForeignState** connections (signals from CoreScripts or C++), the `Function` and `Thread` fields are explicitly `nil`.
  - Methods like `Fire` and `Defer` exist but will fail silently or do nothing for foreign connections where the underlying Lua function is inaccessible.

## 4. Environment & Identity
- **`getthreadidentity` / `setthreadidentity`**
  - Relies on a local Lua variable `fIdentity` (defaulting to 3).
  - This implementation likely desyncs from the actual engine-level thread identity, meaning it "fakes" the identity for scripts checking it via this function but may not grant actual elevated privileges.

## 5. Miscellaneous Stubs
- **`saveinstance`**
  - Loads an external script (`SynSaveInstance`) from GitHub rather than using a native implementation.
- **`getrunningscripts`**
  - Implemented by iterating over `game:GetDescendants()`, which is slower and potentially less complete than a C-side instance list.

## 6. Conclusion
**Overall Assessment: Bad / Fake**

Xeno Client constructs a "fake" environment using Lua-based polyfills for almost every critical internal system. From visual overlays (Drawing) to thread identity and debug information, it simulates functionality rather than hooking it natively. This makes it highly detectable and functionally limited compared to authentic execution environments.
