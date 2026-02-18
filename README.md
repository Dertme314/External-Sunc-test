# External SUNC Test (Dunc Lab)

## What is this?
**Dunc Lab** is a open-source SUNC test made specifically for **Roblox External Executors**. It's inspired by the original sUNC test by **senS**, but pivoted to focus on the actual capabilities of external tools especially those that can't just hook into internal engine pointers like DLLs do.

The goal here is transparency. We want to see what an executor can *really* do without all the spoofed results and fake scores.

> [!NOTE]
> This project is 100% open-source. If you've got a better way to test something or want to add a new category, just open a PR.

---

## UNC vs. sUNC: Don't get fooled by fake scores

### 1. UNC (Naming)
UNC was the first attempt at a standard, but it's hit a wall. Most people use it to check "Does the function `writefile` exist?" The problem is, an executor can just put `getgenv().writefile = function() end` and get a 100% score while doing absolutely nothing. That's a "faked" score.

### 2. sUNC (Behavior)
This is where **senS** changed the game. Instead of just checking if a name exists, sUNC checks if the function actually *works*. If an executor says it has `request` but can't actually pull data from a website, it fails. Dunc Lab takes this philosophy and applies it to the external landscape.

---

## How we catch the fakes
We use deep behavioral checks to ensure an executor isn't just return-spoofing results:

- **Round-Trips**: For files and upvalues, we write/set a value and immediately try to read it back. If they don't match, the behavior is broken.
- **Performance Benchmarks**: Some tests (like `getrunningscripts`) are benchmarked. A native implementation should be near-instant; if it takes too long, it's likely a slow Lua polyfill.
- **Constant & Upvalue Integrity**: We verify that `debug` functions can actually find and modify unique constants and upvalues inside a probe function.
- **Capability Checks**: For `setthreadidentity`, we don't just check the number; we verify if setting a high identity actually grants access to privileged services like `CoreGui`.
- **Polyfill Detection**: Our `Drawing.new` test looks for telltale signs of Lua-based overlays, like adding instances to `CoreGui` or returning tables instead of userdata.

---

## The Reality of Externals
Let's be real: external executors have a harder time than DLLs. You're not going to see 100% on things like `hookmetamethod` or `getrawmetatable` on most externals because they're running in a totally different process.

Dunc Lab is designed to be **Fair**. A high score on a solid external is worth way more than a "100% UNC" score on an executor that spools fake functions just to look good.

---

## What we're testing

### Environment & Closures
Checking the basics: `getgenv`, `getrenv`, and `gethui`. We also run performance checks on `getrunningscripts` and use `checkcaller` to verify the execution context is actually isolated.

### FileSystem
This is the bread and butter of externals. We test `writefile`, `readfile`, and `appendfile`, ensuring they persist correctly and handle data without corruption.

### Network & HttpService
Verifying `request` and `game:HttpGet`. We hit live endpoints to make sure the executor can actually talk to the internet and bring back usable data.

### Input Simulation
Crucial for auto-farms. We test `keypress`, mouse clicks, and both absolute and relative mouse movement.

### Debug & Metatable
- **Debug**: Extensive consistency checks for `getconstants`, `getupvalues`, `getprotos`, and `getinfo`. We ensure the debug library actually interacts with the function's bytecode.
- **Metatable**: Testing `getrawmetatable`, `setreadonly`, and `isreadonly`.

### Drawing & Crypt
- **Drawing**: Verifying native rendering capabilities and checking for polyfill overlays.
- **Crypt**: Testing essentials like Base64, AES (encrypt/decrypt) round-trips, and LZ4 compression.

---

## Want to help?
Since we're open-source, help is always welcome. If you want to add a test:
1. Fork it.
2. Throw your test in a `run_Category` function.
3. Use `assert()` to check **behavior**, not just existence.
4. Open a PR.
