# fair sunc test (dunc lab)

## what is this?

Basically a test for **Roblox External Executors**. senS made sUNC which is good, but i wanted something that actually checks if externals are faking their scores. Most externals say they have 100% UNC but then half the functions dont even work.

The goal is to stop the capped scores. We wanna see what your executor _actually_ does.

> [!NOTE]
> Its open source. If you think a test is bad or want to add something new just open a PR.

---

## UNC vs sUNC (dont get scammed)

### 1. UNC

UNC is just naming. It asks "does `writefile` exist?". Any dev can just do `getgenv().writefile = function() end` and get a 100% score while doing nothing. Thats a fake score.

### 2. sUNC / Behavior

This is what actually matters. Instead of just checking the name, we check if it works. If you say you have `request` but it cant even get data from a site, it fails. Dunc Lab is basically that but for externals.

---

## how we catch the fakes 😁

We do deep checks so devs cant just spoof the results:

- **round-trips**: we write a file and try to read it back. if it doesnt match, its broken.
- **speed checks**: if `getrunningscripts` takes 2 seconds, its probably a slow lua polyfill and not native.
- **bytecode stuff**: we check if `debug` functions can actually find unique constants inside a function.
- **identity checks**: we dont just check the number for `setthreadidentity`, we see if it actually lets you touch `CoreGui`.
- **overlay detection**: our `Drawing.new` test looks for signs of lua-based overlays (like adding stuff to CoreGui).

---

## externals are hard

Externals have it way harder than internals and sunc is being mean to externals. You probably wont see 100% on `hookmetamethod` or `getrawmetatable` because of how they work.

Dunc Lab is meant to be **Fair**. A high score on a good external is worth way more than a "100% UNC" on some executor that just spools fake functions to look good.

---

## what we test

### env & closures

The basics: `getgenv`, `getrenv`, `gethui`. Also check if `checkcaller` is actually working.

### filesystem

The most important part. `writefile`, `readfile`, `appendfile`. We make sure they actually save data right.

### network

Verifying `request` and `HttpGet`. We use live links to see if the executor can actually talk to the internet.

### input

For your auto-farms. `keypress`, clicks, and mouse movement.

### debug & metatable

Checks `getconstants`, `getupvalues`, `getprotos`, and `getinfo`. We make sure they actually touch the bytecode. Also check `setreadonly` fakes (catches the table.clone trick).

### drawing & crypt

Testing native drawing and crypto (Base64, AES, LZ4).

---

## want to help?

If you wanna add a test:

1. fork it.
2. put your test in a `run_Category` function.
3. use `assert()` to check if it **actually works**, not just if it exists.
4. open a PR.
