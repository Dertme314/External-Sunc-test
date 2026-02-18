--[[
    Fair Dunc Lab v4.5
    Universal UNC & Behavior Tests
    - Fake / Stub Detection
]]

local Players = game:GetService("Players")
local ReStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")

local CONFIG = {
    TITLE           = "Fair Dunc Lab",
    TEST_FILE       = "_dunc_lab_test.txt",
    TEST_FILE_2     = "_dunc_lab_append.txt",
    LIST_FOLDER     = "_dunc_lab_test_list",
    HTTP_URL        = "https://httpbin.org/get",
    LAB_WAIT        = 0.6,
    CLEANUP         = true,
}

local Lab = {
    Passed = 0, Failed = 0, Missing = 0, Total = 0,
    Results = {}, StartTime = 0,
    CurrentCategory = ""
}

local function getServerComponents()
    local token = ReStorage:FindFirstChild("DUNC_Token")
    local remote = ReStorage:FindFirstChild("DUNC_Verifier")
    return token, remote
end

local function getEnvironment()
    return (type(getgenv) == "function" and getgenv()) or _G
end

local function deep_index(tbl, path)
    if type(tbl) ~= "table" then return nil end
    local current = tbl
    for segment in string.gmatch(path, "[^%.]+") do
        if type(current) ~= "table" then return nil end
        current = current[segment]
        if current == nil then return nil end
    end
    return current
end

local Aliases = {
    delfile = {"deletefile"},
    makefolder = {"makedir", "mkdir", "createfolder"},
    delfolder = {"deletefolder", "removefolder", "rmdir"},
    listfiles = {"listdir"},
    request = {"http.request", "syn.request", "fluxus.request"},
    rconsoleprint = {"rconsoleprintln", "consoleprintln"},
    rconsoleclear = {"consoleclear"},
    rconsolecreate = {"consolecreate"},
    rconsoleclose = {"consoleclose"},
    rconsolename = {"rconsoletitle", "consolesettitle"},
    ["crypt.base64encode"] = {"base64.encode", "base64_encode"},
    ["crypt.base64decode"] = {"base64.decode", "base64_decode"},
    ["crypt.encrypt"] = {"crypto.encrypt"},
    ["crypt.decrypt"] = {"crypto.decrypt"},
    ["crypt.generatekey"] = {"crypto.generatekey"},
    ["crypt.generatebytes"] = {"crypto.generatebytes"},
    ["crypt.hash"] = {"crypto.hash"},
    getthreadidentity = {"getidentity", "getthreadcontext", "syn.get_thread_identity"},
    setthreadidentity = {"setidentity", "setthreadcontext", "syn.set_thread_identity"},
    setclipboard = {"toclipboard", "writeclipboard"},
    identifyexecutor = {"getexecutorname"},
    isrbxactive = {"isgameactive"},
    mouse1click = {},
    keypress = {},
    queue_on_teleport = {"queue_teleport", "queueonteleport"},
    getfpscap = {},
    -- aliases
    ["debug.getconstant"]  = {},
    ["debug.getconstants"] = {},
    ["debug.getupvalue"]   = {},
    ["debug.setupvalue"]   = {},
    ["debug.setconstant"]  = {},
    ["debug.getstack"]     = {},
    ["debug.setstack"]     = {},
    ["debug.getprotos"]    = {},
    ["debug.getproto"]     = {},
    getconnections         = {},
    getrunningscripts      = {"getscripts"},
    saveinstance           = {},
    ["Drawing.new"]        = {},
}

local function resolve(name)
    local env = getEnvironment()

    if name == "game:HttpGet" then return function(url) return game:HttpGet(url) end end
    if name == "game:HttpPost" then return function(url, data) return game:HttpPost(url, data) end end

    local res = deep_index(env, name)
    if res ~= nil then return res end

    if Aliases[name] then
        for _, alias in ipairs(Aliases[name]) do
            res = deep_index(env, alias)
            if res ~= nil then return res end
        end
    end

    return nil
end

local function updateServer(status)
    local token, remote = getServerComponents()
    if token and remote then
        local score = Lab.Total > 0 and math.floor((Lab.Passed / Lab.Total) * 100) or 0
        pcall(function()
            remote:FireServer({
                Token = token.Value,
                Type = "Update",
                Score = score,
                Status = status
            })
        end)
    end
end

local function record(name, status, detail)
    Lab.Total += 1

    local prefix = ""
    if status == "PASS" then
        Lab.Passed += 1
        prefix = "  🟢 "
        print(prefix .. name .. (detail and (" (" .. detail .. ")") or ""))
    elseif status == "FAIL" then
        Lab.Failed += 1
        prefix = "  🔴 "
        task.spawn(error, prefix .. name .. " -> " .. tostring(detail), 0)
    elseif status == "MISSING" then
        Lab.Missing += 1
        prefix = "  🟡 "
        warn(prefix .. name .. " (not found)")
    end

    table.insert(Lab.Results, {
        name = name,
        status = status,
        detail = detail,
        category = Lab.CurrentCategory
    })

    if Lab.Total % 5 == 0 then
        updateServer("Testing (" .. name .. ")...")
    end
end

local function test(name, callback)
    task.wait()
    local func = resolve(name)
    if func == nil then
        record(name, "MISSING")
        return
    end

    local s, e = pcall(callback, func)
    if s then
        record(name, "PASS")
    else
        record(name, "FAIL", e)
    end
end

local function testRaw(name, callback)
    task.wait()
    local s, e = pcall(callback)
    if s then
        record(name, "PASS")
    else
        record(name, "FAIL", e)
    end
end

-- Standard Tests


local function run_Environment()
    Lab.CurrentCategory = "Environment"
    print("\n Env Check")

    test("getgenv", function(f)
        assert(type(f()) == "table", "Not a table")
        assert(f() == f(), "Identity mismatch")
    end)

    test("getrenv", function(f)
        assert(type(f()) == "table", "Not a table")
        assert(f().game == game, "Does not contain game")
    end)

    test("gethui", function(f)
        assert(typeof(f()) == "Instance", "Not an Instance")
    end)

    test("getcustomasset", function(f)
        local wf = resolve("writefile")
        if not wf then error("Requires writefile") end
        wf("test_asset.txt", "data")
        task.wait(0.1)
        local uri = f("test_asset.txt")
        assert(type(uri) == "string", "Invalid return")
        assert(string.match(uri, "rbxasset"), "Not an asset URI")
    end)

    testRaw("getrunningscripts check", function()
        local f = resolve("getrunningscripts")
        if not f then
            record("getrunningscripts check", "MISSING")
            return
        end

        local scripts = f()
        assert(type(scripts) == "table", "not a table")

        local t0 = os.clock()
        for _ = 1, 10 do f() end
        local elapsed = os.clock() - t0

        if elapsed > 0.25 then
            error(string.format("10 calls took %.3fs", elapsed))
        end

        for _, s in ipairs(scripts) do
            assert(typeof(s) == "Instance",
                "Entry is " .. typeof(s) .. ", expected Instance")
            assert(s:IsA("LuaSourceContainer"),
                "Entry is " .. s.ClassName .. ", not a script class")
        end
    end)
end

local function run_Closures()
    Lab.CurrentCategory = "Closures"
    print("\n Closures")

    test("checkcaller", function(f)
        assert(f() == true, "Must return true in executor")
    end)

    test("iscclosure", function(f)
        assert(f(print) == true, "print should be C closure")
    end)

    test("islclosure", function(f)
        assert(f(function() end) == true, "Lua func should be L closure")
    end)

    test("newcclosure", function(f)
        local l = function() return "test" end
        local c = f(l)
        local isc = resolve("iscclosure")
        if isc then assert(isc(c) == true, "Did not wrap") end
        assert(c() == "test", "Wrapped execution failed")
    end)

    test("clonefunction", function(f)
        local original = function() return "cloned" end
        local c = f(original)
        assert(c ~= original, "Not cloned (same reference)")
        assert(c() == "cloned", "Clone behavior mismatch")
    end)

    test("hookfunction", function(f)
        local old = f(warn, function(...) return "hooked" end)
        assert(type(old) == "function", "Did not return original")
        local result = warn("test")
        assert(result == "hooked", "Hook did not take effect")
        f(warn, old)
    end)

    test("loadstring", function(f)
        local c, e = f('return "loaded"')
        assert(c() == "loaded", "Execution failed")
    end)
end

local function run_FileSystem()
    Lab.CurrentCategory = "FileSystem"
    print("\n FS")

    test("writefile", function(f)
        f(CONFIG.TEST_FILE, "sunc_test_data")
        local rf = resolve("readfile")
        if rf then
            task.wait(0.1)
            assert(rf(CONFIG.TEST_FILE) == "sunc_test_data", "Write did not persist")
        end
    end)

    test("readfile", function(f)
        local wf = resolve("writefile")
        if not wf then error("Requires writefile") end
        wf(CONFIG.TEST_FILE, "sunc_test_data")
        task.wait(0.1)
        local content = f(CONFIG.TEST_FILE)
        assert(content == "sunc_test_data", "Data mismatch: got '" .. tostring(content) .. "'")
    end)

    test("appendfile", function(f)
        local wf = resolve("writefile")
        if not wf then error("Requires writefile") end
        wf(CONFIG.TEST_FILE_2, "_append")
        f(CONFIG.TEST_FILE_2, "_data")
        if rf then
            local d = rf(CONFIG.TEST_FILE_2)
            assert(d == "_append_data", "Append failed: got '" .. tostring(d) .. "'")
        else
            error("Requires readfile to verify")
        end
    end)

    test("loadfile", function(f)
        local wf = resolve("writefile")
        if not wf then error("Requires writefile") end
        wf(CONFIG.TEST_FILE, "return 'loaded'")
        local c = f(CONFIG.TEST_FILE)
        assert(c() == "loaded", "Load failed")
    end)

    test("isfile", function(f)
        local wf = resolve("writefile")
        if not wf then error("Requires writefile") end
        wf(CONFIG.TEST_FILE, "x")
        assert(f(CONFIG.TEST_FILE) == true, "File not found")
        assert(f("nonexistent_sunc_file_" .. tick()) == false, "False positive")
    end)

    test("isfolder", function(f)
        local mf = resolve("makefolder")
        if not mf then error("Requires makefolder") end
        mf(CONFIG.LIST_FOLDER)
        assert(f(CONFIG.LIST_FOLDER) == true, "Folder not found")
    end)

    test("makefolder", function(f)
        f(CONFIG.LIST_FOLDER)
        local isf = resolve("isfolder")
        if isf then assert(isf(CONFIG.LIST_FOLDER) == true, "Creation failed") end
    end)

    test("delfile", function(f)
        local wf = resolve("writefile")
        if not wf then error("Requires writefile") end
        wf(CONFIG.TEST_FILE, "x")
        f(CONFIG.TEST_FILE)
        local isf = resolve("isfile")
        if isf then assert(isf(CONFIG.TEST_FILE) == false, "Delete failed") end
    end)

    test("delfolder", function(f)
        local mf = resolve("makefolder")
        if not mf then error("Requires makefolder") end
        mf(CONFIG.LIST_FOLDER)
        f(CONFIG.LIST_FOLDER)
        local isf = resolve("isfolder")
        if isf then assert(isf(CONFIG.LIST_FOLDER) == false, "Delete folder failed") end
    end)

    test("listfiles", function(f)
        local mf = resolve("makefolder")
        local wf = resolve("writefile")
        if not mf or not wf then error("Deps missing") end
        mf(CONFIG.LIST_FOLDER)
        wf(CONFIG.LIST_FOLDER .. "/test1.txt", "1")
        local list = f(CONFIG.LIST_FOLDER)
        pcall(resolve("delfile"), CONFIG.LIST_FOLDER .. "/test1.txt")
        
        assert(type(list) == "table", "Did not return table")
        assert(#list > 0, "No files listed")
    end)
end

local function run_Network()
    Lab.CurrentCategory = "Network"
    print("\n Network")

    test("request", function(f)
        local r = f({
            Url = CONFIG.HTTP_URL,
            Method = "GET"
        })
        assert(type(r) == "table", "Response is not a table")
        assert(r.StatusCode == 200, "Status " .. tostring(r.StatusCode))
        assert(r.Body and #r.Body > 0, "Empty body")
    end)

    test("game:HttpGet", function(f)
        local b = f(CONFIG.HTTP_URL)
        assert(type(b) == "string" and #b > 0, "Empty response")
    end)
end

local function run_Input()
    Lab.CurrentCategory = "Input"
    print("\n Input")

    test("keypress", function(f)
        local kr = resolve("keyrelease")
        f(0x41)
        task.wait(0.05)
        if kr then kr(0x41) end
    end)

    test("keyrelease", function(f) f(0x41) end)
    test("mouse1click", function(f) f() end)

    test("mouse1press", function(f)
        local mr = resolve("mouse1release")
        f()
        task.wait(0.05)
        if mr then mr() end
    end)

    test("mouse1release", function(f) f() end)
    test("mouse2click", function(f) f() end)

    test("mouse2press", function(f)
        local mr = resolve("mouse2release")
        f()
        task.wait(0.05)
        if mr then mr() end
    end)

    test("mouse2release", function(f) f() end)
    test("mousemoverel", function(f) f(10, 10) end)
    test("mousemoveabs", function(f) f(100, 100) end)
    test("mousescroll", function(f) f(10) end)
end

local function run_LabInteraction()
    Lab.CurrentCategory = "LabInteraction"
    print("\n Interaction")
    local lab = workspace:WaitForChild("FairDuncLab", 2)

    if not lab then
        warn("  [!] Lab map missing — skipping interaction tests")
        return
    end

    test("fireclickdetector", function(f)
        local part = lab:WaitForChild("ClickTestPart", 3)
        if not part then error("ClickTestPart missing") end
        local cd = part:FindFirstChildOfClass("ClickDetector")
        if not cd then error("ClickDetector child missing") end
        f(cd)
        task.wait(CONFIG.LAB_WAIT)
        assert(part.BrickColor == BrickColor.new("Lime green"), "Visual feedback missing")
    end)

    test("fireproximityprompt", function(f)
        local part = lab:WaitForChild("PromptTestPart", 3)
        if not part then error("PromptTestPart missing") end
        local pp = part:FindFirstChildOfClass("ProximityPrompt")
        if not pp then error("ProximityPrompt child missing") end
        f(pp)
        task.wait(CONFIG.LAB_WAIT)
        assert(part.BrickColor == BrickColor.new("Cyan"), "Visual feedback missing")
    end)

    test("firetouchinterest", function(f)
        local part = lab:WaitForChild("TouchTestPart", 3)
        if not part then error("TouchTestPart missing") end
        local char = Players.LocalPlayer.Character or Players.LocalPlayer.CharacterAdded:Wait()
        local root = char:WaitForChild("HumanoidRootPart", 5)
        if not root then error("Character not loaded") end

        f(root, part, 0)
        task.wait()
        f(root, part, 1)
        task.wait(CONFIG.LAB_WAIT)
        assert(
            part.BrickColor == BrickColor.new("New Yeller") or part.BrickColor == BrickColor.new("Lime green"),
            "Touch feedback missing"
        )
    end)
end

local function run_Crypt()
    Lab.CurrentCategory = "Crypt"
    print("\n Crypt")

    test("crypt.base64encode", function(f)
        assert(f("Hello") == "SGVsbG8=", "Encode fail")
    end)

    test("crypt.base64decode", function(f)
        assert(f("SGVsbG8=") == "Hello", "Decode fail")
    end)

    test("crypt.generatekey", function(f)
        local key = f()
        assert(type(key) == "string" and #key > 0, "No key generated")
    end)

    test("crypt.encrypt", function(f)
        local gk = resolve("crypt.generatekey")
        local gd = resolve("crypt.decrypt")
        local gb = resolve("crypt.generatebytes")
        if not gk or not gd then error("Deps missing") end

        local key = gk()
        local iv = gb and gb(16) or nil
        local data = f("test", key, iv, "CBC")
        local dec = gd(data, key, iv, "CBC")
        assert(dec == "test", "Round trip fail")
    end)

    test("lz4compress", function(f)
        local de = resolve("lz4decompress")
        if not de then error("lz4decompress missing") end
        local raw = "test"
        local data = f(raw)
        assert(type(data) == "string" and #data > 0, "No compressed data")
        local dec = de(data, #raw)
        assert(dec == raw, "LZ4 round trip fail")
    end)
end

local function run_Drawing()
    Lab.CurrentCategory = "Drawing"
    print("\n Drawing")

    test("Drawing.new", function(f)
        local l = f("Line")
        assert(l ~= nil, "Returned nil")
        
        if type(l) == "table" then
             l.Visible = false
             if l.Remove then l:Remove() end
        elseif type(l) == "userdata" then
             pcall(function() l.Visible = false; l:Remove() end)
        end
    end)

    test("Drawing.Fonts", function(f)
        assert(type(f) == "table", "Fonts missing")
    end)

    test("isrenderobj", function(f)
        local dn = resolve("Drawing.new")
        if not dn then error("Drawing.new missing") end
        local l = dn("Line")
        local result = f(l)
        l:Remove()
        assert(result == true, "Check fail")
    end)

    test("getrenderproperty", function(f)
        local dn = resolve("Drawing.new")
        if not dn then error("Drawing.new missing") end
        local l = dn("Line")
        l.Visible = true
        local val = f(l, "Visible")
        l:Remove()
        assert(val == true, "Get fail")
    end)

    test("cleardrawcache", function(f)
        f()
    end)

    testRaw("Drawing.new polyfill check", function()
        local dn = resolve("Drawing.new")
        if not dn then 
            record("Drawing.new polyfill check", "MISSING")
            return 
        end

        local coreGui = game:GetService("CoreGui")
        local before = #coreGui:GetChildren()

        local obj = dn("Line")
        if not obj then return end
        
        pcall(function() obj.Visible = true end)
        task.wait()

        local after = #coreGui:GetChildren()
        
        local isTable = (type(obj) == "table")
        local hasInstance = false
        if isTable then
             for k, v in pairs(obj) do
                if typeof(v) == "Instance" then
                    hasInstance = true
                    break
                end
            end
        end

        pcall(function() obj:Remove() end)

        local errs = {}
        if isTable then table.insert(errs, "returns table instead of userdata") end
        if hasInstance then table.insert(errs, "stores Roblox Instance refs") end
        if after > before then table.insert(errs, "adds children to CoreGui (ScreenGui-based)") end

        if #errs > 0 then
            error("Polyfill detected: " .. table.concat(errs, "; "))
        end
    end)
end

local function run_Debug()
    Lab.CurrentCategory = "Debug"
    print("\n Debug")

    test("debug.getupvalue", function(f)
        local u = 10
        local function x() return u end
        assert(f(x, 1) == 10, "Upvalue mismatch")
    end)

    test("debug.setupvalue", function(f)
        local u = 10
        local function x() return u end
        f(x, 1, 20)
        assert(x() == 20, "Set failed")
    end)

    test("debug.getinfo", function(f)
        local info = f(print)
        assert(type(info) == "table", "Did not return table")
        assert(info.what == "C", "print should be C")
    end)

    -- Extra Debug Consistency Checks
    testRaw("debug.getconstant consistency", function()
        local f = resolve("debug.getconstant")
        if not f then 
            record("debug.getconstant consistency", "MISSING")
            return 
        end

        local function probe()
            local _a = "DUNC_UNIQUE_CONST"
            local _b = 314159
            return _a, _b
        end

        local c1 = f(probe, 1)
        if c1 == "print" then
            error("Returned hardcoded 'print' – ignores actual constants")
        end
        local found = false
        for i = 1, 5 do
            local v = f(probe, i)
            if v == "DUNC_UNIQUE_CONST" or v == 314159 then found = true break end
        end
        assert(found, "None of the returned constants match the real function body")
        
        -- Input independence check
        local function funcA() local _ = "AAA_CONST" return 1 end
        local function funcB() local _ = "BBB_CONST" return 2 end
        local a1 = f(funcA, 1)
        local b1 = f(funcB, 1)
        if a1 == b1 then
             error("Returns identical constant '"..tostring(a1).."' for different functions")
        end
    end)

    testRaw("debug.getconstants consistency", function()
        local f = resolve("debug.getconstants")
        if not f then 
            record("debug.getconstants consistency", "MISSING")
            return 
        end

        local function probe()
            local _x = "DUNC_CONST_ALPHA"
            local _y = 271828
            return _x, _y
        end

        local tbl = f(probe)
        assert(type(tbl) == "table", "not a table")

        for _, v in ipairs(tbl) do
            if v == 50000 or v == "Hello, world!" then
                error("Returned executor hardcoded set {50000,'print',nil,'Hello, world!','warn'}")
            end
        end

        local foundReal = false
        for _, v in ipairs(tbl) do
            if v == "DUNC_CONST_ALPHA" or v == 271828 then foundReal = true break end
        end
        assert(foundReal, "Actual constants ('DUNC_CONST_ALPHA' / 271828) not present")
    end)

    testRaw("debug.getupvalue consistency", function()
        local f = resolve("debug.getupvalue")
        if not f then 
            record("debug.getupvalue consistency", "MISSING")
            return 
        end

        local sentinel = newproxy(false)
        local function capture() return sentinel end

        local v = f(capture, 1)
        assert(v ~= nil, "Always returns nil regardless of upvalue")
        assert(v == sentinel, "Returned wrong value (expected sentinel userdata)")
    end)

    testRaw("debug.get/setupvalue roundtrip", function()
        local fget = resolve("debug.getupvalue")
        local fset = resolve("debug.setupvalue")
        if not fget or not fset then 
            record("debug.get/setupvalue roundtrip", "MISSING")
            return 
        end

        local a, b, c = 111, "hello", true
        local function probe() return a, b, c end

        fset(probe, 1, 222)
        fset(probe, 2, "world")
        fset(probe, 3, false)

        local r1 = fget(probe, 1)
        
        if r1 == 111 then
             error("setupvalue seems to be separate from getupvalue (value unchanged)")
        end
        
        local v1, v2, v3 = probe()
        assert(v1 == 222, "upvalues not modified")
        assert(v2 == "world", "upvalue 2 not modified")
        assert(v3 == false, "upvalue 3 not modified")
    end)

    testRaw("debug.setconstant consistency", function()
        local fset = resolve("debug.setconstant")
        local fget = resolve("debug.getconstants")
        if not fset or not fget then 
             record("debug.setconstant consistency", "MISSING")
             return 
        end

        local function probe() return "SETCONST_ORIG" end
        local consts = fget(probe)
        local idx
        for i, v in ipairs(consts) do
            if v == "SETCONST_ORIG" then idx = i break end
        end
        
        assert(idx, "Could not locate constant in probe function")
        
        fset(probe, idx, "SETCONST_NEW")
        assert(probe() == "SETCONST_NEW", "Function execution did not reflect setconstant change")
    end)

    testRaw("debug.getstack consistency", function()
        local f = resolve("debug.getstack")
        if not f then 
             record("debug.getstack consistency", "MISSING")
             return 
        end

        local r1 = f(1)
        
        local function isAb(v)
            if v == "ab" then return true end
            if type(v) == "table" and #v == 1 and v[1] == "ab" then return true end
            return false
        end

        if isAb(r1) then
             local function deeper() return f(2) end
             if isAb(deeper()) then
                 error("Always returns 'ab'/{'ab'} regardless of level/index")
             end
        end
    end)

    testRaw("debug.setstack consistency", function()
        local fset = resolve("debug.setstack")
        local fget = resolve("debug.getstack")
        if not fset or not fget then 
             record("debug.setstack consistency", "MISSING")
             return 
        end

        local before = fget(1, 1)
        fset(1, 1, "DUNC_STACK_VAL")
        local after = fget(1, 1)
        
        if before and after and before == after and after ~= "DUNC_STACK_VAL" then
             error("Stack slot unchanged after setstack")
        end
    end)

    testRaw("debug.getprotos consistency", function()
        local f = resolve("debug.getprotos")
        if not f then 
             record("debug.getprotos consistency", "MISSING")
             return 
        end

        local function outer()
            local function inner1() return "I1" end
            local function inner2() return "I2" end
            return inner1, inner2
        end

        local protos = f(outer)
        assert(type(protos) == "table", "not a table")
        assert(#protos >= 2, "outer has 2 inner functions but got " .. #protos .. " protos")

        for i, p in ipairs(protos) do
            if type(p) == "table" then
                 local mt = getmetatable(p)
                 if mt and type(mt.__call) == "function" and p("xyz") == true then
                      error("Proto["..i.."] is a dummy table whose __call always returns true")
                 end
                 error("Proto["..i.."] is a table, expected function")
            end
            assert(type(p) == "function", "Proto["..i.."] is "..type(p)..", expected function")
        end
    end)
    
    testRaw("debug.getproto consistency", function()
        local f = resolve("debug.getproto")
        if not f then 
             record("debug.getproto consistency", "MISSING")
             return 
        end

        local function outer()
            local function unique() return "PROTO_REAL" end
            return unique
        end

        local p = f(outer, 1)

        if type(p) == "table" then
             local mt = getmetatable(p)
             if mt and (mt.__call or mt.__index) then
                  local s, r = pcall(p)
                  if s and r == true then
                      error("Returned dummy table with __call→true instead of function")
                  end
             end
             error("Returned table instead of function")
        end
        assert(p() == "PROTO_REAL", "proto returned wrong value")
    end)
    
    testRaw("debug.getinfo accuracy", function()
         local f = resolve("debug.getinfo")
          if not f then 
            record("debug.getinfo accuracy", "MISSING")
            return 
        end
         local cInfo = f(print)
         local lInfo = f(function() end)
         if cInfo.what == lInfo.what then
              error("Returns identical 'what' field ('"..tostring(cInfo.what).."') for both C and Lua functions")
         end
    end)
end

local function run_Console()
    Lab.CurrentCategory = "Console"
    print("\n Console")
    test("rconsolecreate", function(f) f() end)
    test("rconsolename", function(f) f("Fair Dunc Lab") end)
    test("rconsoleprint", function(f) f("Test output\n") end)
    test("rconsoleclear", function(f) f() end)
end

local function run_Metatable()
    Lab.CurrentCategory = "Metatable"
    print("\n MT")

    test("getrawmetatable", function(f)
        local t = setmetatable({}, {
            __index = function() return 42 end,
            __metatable = "locked"
        })
        local mt = f(t)
        assert(type(mt) == "table", "Expected table")
        assert(mt.__index ~= nil, "__index missing")
    end)

    test("setreadonly", function(f)
        local t = {}
        f(t, true)
        local ir = resolve("isreadonly")
        if ir then assert(ir(t) == true, "Not set to readonly") end
        f(t, false)
        if ir then assert(ir(t) == false, "Not set back to writable") end
    end)

    test("isreadonly", function(f)
        local t = table.freeze({})
        assert(f(t) == true, "Frozen table not detected as readonly")
    end)
end

local function run_Thread()
    Lab.CurrentCategory = "Thread"
    print("\n Thread")

    test("getthreadidentity", function(f)
        local id = f()
        assert(type(id) == "number", "Expected number, got " .. type(id))
    end)

    test("setthreadidentity", function(f)
        local gti = resolve("getthreadidentity")
        f(8)
        if gti then assert(gti() == 8, "Identity not set to 8") end
        
        local realAccess = pcall(function()
            local cg = game:GetService("CoreGui")
            local _ = cg:GetChildren() 
        end)
        
        if original then f(original) end
        
        if not realAccess then
             error("Identity set to 8 but failed to access CoreGui")
        end
    end)
end

local function run_Misc()
    Lab.CurrentCategory = "Misc"
    print("\n Misc")

    test("identifyexecutor", function(f)
        local n, v = f()
        assert(type(n) == "string" and #n > 0, "No executor name")
        print("    > Name: " .. tostring(n))
        print("    > Version: " .. tostring(v))
    end)

    test("setclipboard", function(f) f("Dunc Test") end)

    test("setfpscap", function(f)
        local gfc = resolve("getfpscap")
        local original = gfc and gfc() or nil
        f(60)
        if gfc then assert(gfc() == 60, "FPS cap not applied") end
        if original then f(original) end
    end)

    test("getfpscap", function(f)
        assert(type(f()) == "number", "Expected number")
    end)

    test("isrbxactive", function(f)
        assert(type(f()) == "boolean", "Expected boolean")
    end)

    test("queue_on_teleport", function(f) f('print("queued")') end)

    testRaw("getconnections check", function()
        local f = resolve("getconnections")
        if not f then 
            record("getconnections check", "MISSING")
            return 
        end

        local be = Instance.new("BindableEvent")
        local count = 0
        local _c = be.Event:Connect(function() count += 1 end)
        local conns = f(be.Event)
        
        if type(conns) ~= "table" or #conns == 0 then
             be:Destroy()
             error("No connections returned")
        end
        
        local hasFunc = false
        for _, conn in ipairs(conns) do
            if conn.Function then hasFunc = true end
        end
        
        if not hasFunc then
             be:Destroy()
             error("Function field is nil for local connection (should be visible)")
        end
        
        if conns[1].Fire then
             conns[1]:Fire() 
             task.wait()
             if count == 0 then
                  be:Destroy()
                  warn("    [!] getconnections: Fire() did not invoke handler")
             end
        end
        be:Destroy()
    end)

    testRaw("saveinstance check", function()
        local f = resolve("saveinstance")
        if not f then 
            record("saveinstance check", "MISSING")
            return 
        end
        
        local consts = resolve("debug.getconstants")
        if consts then
             local c = consts(f) 
             if c then
                for _, v in ipairs(c) do
                    if type(v) == "string" and (string.find(v, "github") or string.find(v, "HttpGet")) then
                         error("Depends on external HttpGet (found '"..v.."')")
                    end
                end
             end
        end
    end)
end



-- Entry Point


local function main()
    Lab.StartTime = os.clock()
    print("\n" .. string.rep("-", 40))
    print("  Fair Dunc Lab v4.5")
    print(string.rep("-", 40))

    run_Environment()
    run_Closures()
    run_FileSystem()
    run_Network()
    run_Input()
    run_LabInteraction()
    run_Crypt()
    run_Drawing()
    run_Debug()
    run_Console()
    run_Metatable()
    run_Thread()
    run_Misc()

    local elapsed = string.format("%.2fs", os.clock() - Lab.StartTime)
    local score = Lab.Total > 0 and math.floor((Lab.Passed / Lab.Total) * 100) or 0

    print("\n" .. string.rep("-", 42))
    print("  RESULTS (" .. elapsed .. ")")
    print(string.rep("-", 42))
    print("  Score:          " .. score .. "% (" .. Lab.Passed .. "/" .. Lab.Total .. ")")
    print("  Pass:           " .. Lab.Passed)
    print("  Fail:           " .. Lab.Failed)
    print("  Missing:        " .. Lab.Missing)
    print(string.rep("-", 42))

    local cats = {
        "Environment", "Closures", "FileSystem", "Network",
        "Input", "LabInteraction", "Crypt", "Drawing",
        "Debug", "Console", "Metatable", "Thread", "Misc"
    }

    for _, c in ipairs(cats) do
        local cp, ct = 0, 0
        for _, res in ipairs(Lab.Results) do
            if res.category == c then
                ct += 1
                if res.status == "PASS" then cp += 1 end
            end
        end
        if ct > 0 then
            local pct = math.floor((cp / ct) * 100)
            local filled = math.floor(pct / 10)
            local bar = string.rep("\u{2588}", filled) .. string.rep("\u{2591}", 10 - filled)
            print(string.format("  %-15s %s %3d%%", c, bar, pct))
        end
    end
    print(string.rep("-", 42) .. "\n")

    updateServer("Done! Score: " .. score .. "%")

    if CONFIG.CLEANUP then
        local df = resolve("delfile")
        local dfo = resolve("delfolder")
        if df then
            pcall(df, CONFIG.TEST_FILE)
            pcall(df, CONFIG.TEST_FILE_2)
            pcall(df, "test_asset.txt")
        end
        if dfo then
            pcall(dfo, CONFIG.LIST_FOLDER)
        end
    end
end

return main()