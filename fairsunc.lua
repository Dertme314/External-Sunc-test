--[[
    Fair Dunc Lab v4.5
    Universal UNC & Behavior Tests
]]

local Players = game:GetService("Players")
local ReStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")

local CONFIG = {
    TITLE           = "Fair Dunc Lab v4.5",
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
}

local function resolve(name)
    local env = getEnvironment()

    if name == "game:HttpGet" then return function(url) return game:HttpGet(url) end end
    if name == "game:HttpPost" then return function(url, data) return game:HttpPost(url, data) end end

    local res = deep_index(env, name)
    if res then return res end

    if Aliases[name] then
        for _, alias in ipairs(Aliases[name]) do
            res = deep_index(env, alias)
            if res then return res end
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
    if not func then
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

-- Categories

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
        local uri = f("test_asset.txt")
        assert(type(uri) == "string", "Invalid return")
        assert(string.match(uri, "rbxasset"), "Not an asset URI")
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
        local rf = resolve("readfile")
        if rf then
            local d = rf(CONFIG.TEST_FILE_2)
            assert(d == "_append_data", "Append failed: got '" .. tostring(d) .. "'")
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
        f(part.ClickDetector)
        task.wait(CONFIG.LAB_WAIT)
        assert(part.BrickColor == BrickColor.new("Lime green"), "Visual feedback missing")
    end)

    test("fireproximityprompt", function(f)
        local part = lab:WaitForChild("PromptTestPart", 3)
        if not part then error("PromptTestPart missing") end
        f(part.ProximityPrompt)
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
        if not gk or not gd then error("Deps missing") end

        local key = gk()
        local data = f("test", key)
        local dec = gd(data, key)
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
        assert(type(l) == "table" or type(l) == "userdata", "Invalid drawing object type: " .. type(l))
        l.Visible = false
        l:Remove()
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
        local original = gti and gti() or nil
        f(3)
        if gti then assert(gti() == 3, "Identity not set") end
        if original then f(original) end
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
        if original then f(original) end
    end)

    test("getfpscap", function(f)
        assert(type(f()) == "number", "Expected number")
    end)

    test("isrbxactive", function(f)
        assert(type(f()) == "boolean", "Expected boolean")
    end)

    test("queue_on_teleport", function(f) f('print("queued")') end)
end

-- Main

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
    print(string.rep("\u{2550}", 42) .. "\n")

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