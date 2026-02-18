--[[
v1.3.10 CLIENT.LUA -- POST OPEN SOURCE

Xeno is only maintained and developed by Rizve.

If you have any questions or want to chat feel free to DM me on Discord: .rizve
For faster replies, email me at rizve@xeno.onl

Credits:
- Quivings (https://getsolara.dev/): ProxyService; Mock Service (vulnerabilities mitigation).
- razzoni: Few function improvements and suggestions.
]]

local XENO_PID = "%XENO_CLIENT_PID%"

local HttpService = game:FindService("HttpService")
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")
local InsertService = game:GetService("InsertService")
local CorePackages = game:GetService("CorePackages")
local Debris = game:GetService("Debris")
local UserInputService = game:GetService("UserInputService")

if CoreGui:FindFirstChild(XENO_PID) then
	--warn("Xeno Initialization Cancelled: Container already exists (Proper checking was not done on C). Please send me a screenshot of this error to my Discord: .rizve")
	--warn(script:GetFullName())
	return
end

local XenoContainer = Instance.new("Folder") -- Main Xeno Container
XenoContainer.Name = XENO_PID
XenoContainer.Parent = CoreGui

local PtrContainer = Instance.new("Folder") -- Instance Pointer Container
PtrContainer.Name = "Pointer"
PtrContainer.Parent = XenoContainer

local LoadstringContainer = Instance.new("Folder") -- Loadstring Scripts Container
LoadstringContainer.Name = "Loadstring"
LoadstringContainer.Parent = XenoContainer

Instance.new("Message", XenoContainer).Name = "DO NOT DELETE: BELONGS TO XENO"

local Xeno = {}
Xeno.about = {
	['Name'] = "Project Xeno";
	['Publisher'] = "Rizve A";
	['Version'] = "v1.3.10";
	['Website'] = "https://xeno.onl";
	['Discord'] = "https://discord.gg/xe-no";
}
table.freeze(Xeno.about)
Xeno.Xeno = {about = Xeno.about}
shared.__Xeno = Xeno

local Urls = {
	['Version'] = "https://x3no.pages.dev/version.txt";
	['CodeExecution'] = "https://x3no.pages.dev/code.lua";
	--['Icon'] = "http://www.roblox.com/asset/?id=107845011312901";
	['Server'] = "http://localhost:3110"
}

local xRenv = { -- To prevent call stack overflow & ambiguous.. and func replacement abuse
	['require'] = require,
	['Instance'] = Instance,
	['game'] = game,
	['workspace'] = workspace,
	['type'] = type,
	['typeof'] = typeof,
	['script'] = script,
	['debug'] = debug,
	['assert'] = assert,
	['pcall'] = pcall,
	['xpcall'] = xpcall,
	['collectgarbage'] = getfenv().collectgarbage,
	['warn'] = warn,
	['print'] = print
} -- TODO: Replace all calling functions with xRenv[func]

local fenv = getfenv()

-- I apologize for UNC functions that are fake / not working as I would like more scripts being able to run (wont run properly though)

--------------------------------------------------------
--- [XENO COMMUNICATION] --- START
type HttpRequestResult = {
	Body: string,
	StatusCode: number,
	StatusMessage: string,
	HttpError: Enum.HttpError,
	Success: boolean,
	Headers: {[string]: string}
}

type HttpRequestOptions = {
	Url: string,
	Method: string,
	Body: string?,
	Headers: {[string]: string}?
}

local function SendRequest(options: HttpRequestOptions, timeout: number?): HttpRequestResult?
	local timeoutTime = timeout or math.huge
	local startTime = tick()
	local result: HttpRequestResult? = nil

	HttpService:RequestInternal(options):Start(function(success, response)
		response.Success = success
		result = response
	end)

	while not result do
		task.wait()
		if tick() - startTime > timeoutTime then
			return nil
		end
	end

	return result
end

local function RServer(
	reqArgs: {[number]: any},
	includePID: boolean?,
	returnHeaders: boolean?,
	returnStatus: boolean?
): (any, boolean, {[string]: string}?|number?)
	local isCustomEndpoint = xRenv.type(reqArgs[3]) == "string"
	local endpoint = reqArgs[1]

	local options: HttpRequestOptions = if isCustomEndpoint
		then {
			Url = reqArgs[3],
			Body = reqArgs[2],
			Method = 'POST',
			Headers = {["Content-Type"] = 'text/plain'} -- custom endpoints needs extremely large contents. ex; loadstring, writefile. 
			-- the header is required. using base64 would impact alot of performance.
		} else {
			Url = Urls.Server .. '/f?e=' .. endpoint,
			Body = {
				c = reqArgs[2],
				p = includePID and XENO_PID or nil
			},
			Method = 'POST'
		}

	if not isCustomEndpoint then
		options.Body = HttpService:JSONEncode(options.Body)
	end

	local result = SendRequest(options)
	if not result then
		return nil, false
	end

	if not result.StatusCode then result.StatusCode = 410 --[[Xeno was closed]] end

	local success = result.StatusCode >= 200 and result.StatusCode < 300
	local responseBody = result.Body

	if success and result.Headers["content-type"] == "application/json" then
		responseBody = HttpService:JSONDecode(responseBody)
	end

	if returnHeaders then
		return responseBody, success, result.Headers
	end

	if returnStatus then
		return responseBody, success, result.StatusCode
	end

	return responseBody, success
end
--- [XENO COMMUNICATION] --- END

--- [XENO RESOURCES] --- START
local XFS = {
	Activate = 0,

	ReadFile = 1,
	WriteFile = -1, -- Not used on C side
	GetFileType = 2,
	ListFiles = 3,
	MakeFolder = 4,
	DelFolder = 5,
	DelFile = 6,
	GetCustomAsset = 7,

	GetScriptBytecode = 8,
	SetScriptBytecode = 9,
	RestoreScriptBytecode = 10,

	LockModule = 11,
	UnlockModule = 12,

	GetProperties = 13,

	GetInstanceRBXSignals = 14,
	GetInstanceFunctions = 15,

	HookInstance = 16,

	SetScriptable = 17,

	GetInstanceAddress = 18,

	GetXenoApplicationSettings = 19
}

local XInputType = {
	mouse1click = 0,
	mouse1press = 1,
	mouse1release = 2,
	mouse2click = 3,
	mouse2press = 4,
	mouse2release = 5,
	mousemoveabs = 6,
	mousemoverel = 7,
	mousescroll = 8,

	keypress = 9,
	keyrelease = 10
}

local XRCType = {
	consolecreate = 0,
	consoledestroy = 1,
	consoleclear = 2,

	consolename = 3,

	consoleprint = 4,
	consoleinfo = 5,
	consolewarn = 6,
	consoleerror = 7,
	consoleinput = 8,
}

local XSAlgorithms = {
	md5 = 0,

	sha1 = 1,
	sha224 = 2,
	sha256 = 3,
	sha384 = 4,

	sha512 = 5,
	sha512_224 = 6,
	sha512_256 = 7,

	sha3_224 = 8,
	sha3_256 = 9,
	sha3_384 = 10,
	sha3_512 = 11
}

local XSENModes = {
	ECB = 0,
	CBC = 1,
	OFB = 2,
	CFB = 3,
	CTR = 4,
	GCM = 5,
	CCM = 6,
	XTS = 7,
	OCB = 8
}

local XCTps = {
	Encrypt = 0,
	Decrypt = 1,

	GenerateBytes = 2,

	Hash = 3
}

local XSB4Tps = {
	Encode = 0,
	Decode = 1
}

local XLZTps = {
	Compress = 0,
	Decompress = 1
}

local function RawHttpGet(url: string): string -- Used only for version checking & repo resources
	local result = nil
	local start = tick()

	HttpService:RequestInternal({
		Url = url,
		Method = 'GET'
	}):Start(function(success, body)
		if not success then result = '' end
		result = body.Body
	end)

	while not result do task.wait()
		if tick() - start > 10 then
			return ''
		end
	end

	return result
end

local function createInstancePointer(instance: Instance): Instance -- Will have to destroy the objectValue after sending request.
	local objectValue = xRenv.Instance.new("ObjectValue", PtrContainer)
	objectValue.Name = HttpService:GenerateGUID(false)
	objectValue.Value = instance
	--Debris:AddItem(objectValue, 30) -- I dont trust myself.
	return objectValue
end

local xenoIconAsset = nil
local CHWID: string? = nil

task.spawn(function()
	xRenv.pcall(function()
		repeat task.wait() until Xeno.getcustomasset
			and Xeno.HttpGet
			and Xeno.isfile
			and Xeno.writefile
		if not Xeno.isfile("XenoIcon.png") then
			Xeno.writefile("XenoIcon.png", Xeno.HttpGet("https://www.xeno.onl/images/xeno.png"))
		end
		xenoIconAsset = Xeno.getcustomasset("XenoIcon.png")
	end)
end)

local showUpdated = true
task.spawn(function()
	local function getNums(str: string): string
		local result = ""
		for num in string.gmatch(str, "%d") do
			result = result .. num
		end
		return result
	end

	local nVer = getNums(Xeno.about.Version)

	local bindable = xRenv.Instance.new("BindableFunction")
	bindable.OnInvoke = function(opt)
		showUpdated = false
	end

	while showUpdated and task.wait(5) do
		local vers = RawHttpGet(Urls.Version)
		if string.sub(vers, 1, 1) ~= 'v' then
			continue
		end
		
		local xnVer = getNums(tostring(vers))

		if xnVer and xnVer > nVer then -- verifies if the current version to int is greater than updated
			StarterGui:SetCore("SendNotification", {
				Title = "[Xeno Updated]",
				Text = 'Get the new version ('
					.. tostring(vers) .. ') from '
					.. tostring(Xeno.about.Website),
				Icon = xenoIconAsset,
				Button1 = "Don't Show again",
				Callback = bindable,
				Duration = 4
			})
		end
	end
end)

task.spawn(function()
	task.spawn(function()
		if xRenv.script.Name == "en-us" then
			repeat task.wait() until xenoIconAsset

			xRenv.pcall(function() -- if not success then attached through menu.
				StarterGui:SetCore("SendNotification", {
					Title = "[Xeno]",
					Text = 'Attached Ingame!',
					Icon = xenoIconAsset,
					Duration = 3
				})
			end)

			--[[ -- No more crashes
			StarterGui:SetCore("SendNotification", {
				Title = "[Xeno]",
				Text = 'If you leave then your game may crash!',
				Icon = Urls.Icon,
				Duration = 4
			})
			]]
		end
	end)

	while true do
		local result, success = RServer({XFS.Activate, ''}, true)  -- returns hwid and lets us know that functions are ready to be called.
		if success then -- we could also make it return other resources needed, but we are only retreiving HWID for now.
			task.spawn(function()
				CHWID = result:gsub("{", ''):gsub("}", '')
			end)
			break
		end
		task.wait(.1)
	end
	--if uMenu then -- If attaching while joining a game then the core module's bytecode that was overwritten can run before the vrnavigation therefore unhook cant be called.
	-- this is just so the status of the client does not say "waiting for unhook"
	--task.delay(5, RServer, {XFS.Activate, ''}, true)
	--end
	if not CHWID then -- just in case
		CHWID = HttpService:GenerateGUID(false)
	end
end)
--- [XENO RESOURCES] --- END

--- [PROXY SERVICE] --- START -- FULL CREDITS GOES TO SOLARA FOR MOCK SERVICE
local ProxyService = {Map = {}, funcMap = {}}
local BlockedServiceFuncs = {
	TestService = {"Run", "Require"},
	WebViewService = {"CloseWindow", "MutateWindow", "OpenWindow"},
	--[[
	AccountService = {
		"GetCredentialsHeaders", "GetDeviceAccessToken",
		"GetDeviceIntegrityToken", "GetDeviceIntegrityTokenYield"
	},
	]]
	AnalyticsService = {
		"FireInGameEconomyEvent", "FireLogEvent", "FireEvent",
		"FireCustomEvent", "LogEconomyEvent"
	},
	CaptureService = {
		"DeleteCapture", "GetCaptureFilePathAsync", "CreatePostAsync",
		"SaveCaptureToExternalStorage", "SaveCapturesToExternalStorageAsync",
		"GetCaptureSizeAsync", "GetCaptureStorageSizeAsync",
		"PromptSaveCapturesToGallery", "PromptShareCapture",
		"RetrieveCaptures", "SaveScreenshotCapture"
	},
	InsertService = {"GetLocalFileContents"},
	SafetyService = {"TakeScreenshot"},
	HttpRbxApiService = {
		"PostAsync", "PostAsyncFullUrl", "GetAsyncFullUrl",
		"GetAsync", "RequestAsync", "RequestLimitedAsync"
	},
	HttpService = {
		"RequestInternal", "GetAsync", "RequestAsync",
		"PostAsync", "SetHttpEnabled"
	},
	MarketplaceService = {
		"PerformCancelSubscription", "PerformPurchaseV2", "PrepareCollectiblesPurchase",
		"PromptCancelSubscription", "ReportAssetSale", "GetUserSubscriptionDetailsInternalAsync",
		"PerformPurchase", "PromptBundlePurchase", "PromptGamePassPurchase",
		"PromptProductPurchase", "PromptPurchase", "PromptRobloxPurchase",
		"PromptThirdPartyPurchase", "GetRobuxBalance", "PromptBulkPurchase",
		"PerformBulkPurchase", "PerformSubscriptionPurchase", "PerformSubscriptionPurchaseV2",
		"PromptCollectiblesPurchase", "PromptNativePurchaseWithLocalPlayer",
		"PromptPremiumPurchase", "PromptSubscriptionPurchase", "GetUserSubscriptionPaymentHistoryAsync"
	},
	GuiService = {
		"OpenBrowserWindow", "OpenNativeOverlay",
		"BroadcastNotification", "SetPurchasePromptIsShown"
	},
	--DataModelPatchService = {"RegisterPatch", "UpdatePatch"},
	EventIngestService = {
		"SendEventDeferred", "SetRBXEvent", "SetRBXEventStream", "SendEventImmediately"
	},
	CoreScriptSyncService = {"GetScriptFilePath"},
	ScriptContext = {"AddCoreScriptLocal", "SaveScriptProfilingData"},
	ScriptProfilerService = {"SaveScriptProfilingData"},
	BrowserService = {
		"EmitHybridEvent", "OpenWeChatAuthWindow", "ExecuteJavaScript",
		"OpenBrowserWindow", "OpenNativeOverlay", "ReturnToJavaScript",
		"CopyAuthCookieFromBrowserToEngine", "SendCommand"
	},
	MessageBusService = {
		"Call", "GetLast", "GetMessageId", "GetProtocolMethodRequestMessageId",
		"GetProtocolMethodResponseMessageId", "MakeRequest", "Publish",
		"PublishProtocolMethodRequest", "PublishProtocolMethodResponse",
		"Subscribe", "SubscribeToProtocolMethodRequest",
		"SubscribeToProtocolMethodResponse", "SetRequestHandler"
	},
	AssetService = {"RegisterUGCValidationFunction"},
	ContentProvider = {"SetBaseUrl"},
	AppStorageService = {"Flush", "GetItem", "SetItem"},
	IXPService = {
		"GetBrowserTrackerLayerVariables", "GetRegisteredUserLayersToStatus",
		"GetUserLayerVariables", "GetUserStatusForLayer", "InitializeUserLayers",
		"LogBrowserTrackerLayerExposure", "LogUserLayerExposure", "RegisterUserLayers"
	},
	SessionService = {
		"AcquireContextFocus", "GenerateSessionInfoString", "GetCreatedTimestampUtcMs",
		"GetMetadata", "GetRootSID", "GetSessionTag", "IsContextFocused",
		"ReleaseContextFocus", "RemoveMetadata", "RemoveSession",
		"RemoveSessionsWithMetadataKey", "ReplaceSession", "SessionExists",
		"SetMetadata", "SetSession", "GetSessionID"
	},
	ContextActionService = {"CallFunction", "BindCoreActivate"},
	CommerceService = {
		"PromptCommerceProductPurchase", "PromptRealWorldCommerceBrowser",
		"UserEligibleForRealWorldCommerceAsync"
	},
	--OmniRecommendationsService = {"ClearSessionId", "MakeRequest"}, // MakeRequest;;;;
	Players = {"ReportAbuse", "ReportAbuseV3", "ReportChatAbuse"},
	PlatformCloudStorageService = {"GetUserDataAsync", "SetUserDataAsync"},
	CoreGui = {"TakeScreenshot", "ToggleRecording"},
	LinkingService = {
		"DetectUrl", "GetAndClearLastPendingUrl", "GetLastLuaUrl",
		"IsUrlRegistered", "OpenUrl", "RegisterLuaUrl",
		"StartLuaUrlDelivery", "StopLuaUrlDelivery",
		"SupportsSwitchToSettingsApp", "SwitchToSettingsApp"
	},
	RbxAnalyticsService = {
		"GetSessionId", "ReleaseRBXEventStream", "SendEventDeferred",
		"SendEventImmediately", "SetRBXEvent", "SetRBXEventStream",
		"TrackEvent", "TrackEventWithArgs"
	},
	AvatarEditorService = {
		"NoPromptSetFavorite", "NoPromptUpdateOutfit", "PerformCreateOutfitWithDescription",
		"PerformDeleteOutfit", "PerformRenameOutfit", "PerformSaveAvatarWithDescription",
		"PerformSetFavorite", "PerformUpdateOutfit", "PromptAllowInventoryReadAccess",
		"PromptCreateOutfit", "PromptDeleteOutfit", "PromptRenameOutfit",
		"PromptSaveAvatar", "PromptSetFavorite", "PromptUpdateOutfit",
		"SetAllowInventoryReadAccess", "SignalCreateOutfitFailed",
		"SignalCreateOutfitPermissionDenied", "SignalDeleteOutfitFailed",
		"SignalDeleteOutfitPermissionDenied", "SignalRenameOutfitFailed",
		"SignalRenameOutfitPermissionDenied", "SignalSaveAvatarPermissionDenied",
		"SignalSetFavoriteFailed", "SignalSetFavoritePermissionDenied",
		"SignalUpdateOutfitFailed", "SignalUpdateOutfitPermissionDenied",
		"NoPromptSaveAvatarThumbnailCustomization", "NoPromptSaveAvatar",
		"NoPromptRenameOutfit", "NoPromptDeleteOutfit", "NoPromptCreateOutfit"
	}
}

local function Blocked()
	error("Attempt to call a blocked function", 3)
end
setfenv(Blocked, {error = error})

for serviceName, methods in pairs(BlockedServiceFuncs) do
	xRenv.pcall(function() -- will need to remove this soon
		local service = xRenv.game:GetService(serviceName)
		local serviceTable = {}

		for _, methodName in ipairs(methods) do
			serviceTable[service[methodName]] = Blocked
		end

		ProxyService.funcMap[service] = serviceTable
	end)
end

ProxyService.funcMap[xRenv.game] = {
	[xRenv.game.Load] = Blocked,
	[xRenv.game.ReportInGoogleAnalytics] = Blocked,
	[xRenv.game.OpenScreenshotsFolder] = Blocked,
	[xRenv.game.OpenVideosFolder] = Blocked
}

function ProxyService:RBXScriptSignal(Signal: RBXScriptSignal)
	local ProxiedSignal = {}
	setmetatable(ProxiedSignal, {
		__index = function(self, key)
			key = string.lower(key)
			if key == "wait" then
				local Proxied = function(signal, ...: any)
					signal = ProxyService.Map[signal]
					local args = { Signal.Wait(signal, ...) }
					for i, v in args do 
						if xRenv.type(v) == "userdata" then 
							if ProxyService.Map[v] then 
								args[i] = ProxyService.Map[v]
							elseif xRenv.typeof(v) == "Instance" then 
								args[i] = ProxyService:Instance(v, ProxyService.funcMap[v])
							else 
								args[i] = ProxyService:Userdata(v)
							end
						end
					end
					return unpack(args)
				end
				setfenv(Proxied, Xeno)
				return Proxied
			end

			if key == "connect" then
				local Proxied = function(signal, func: () -> any)
					signal = ProxyService.Map[signal]
					return Signal.Connect(signal, function(...: any)
						local args = {...}
						for i, v in args do 
							if xRenv.type(v) == "userdata" then 
								if ProxyService.Map[v] then 
									args[i] = ProxyService.Map[v]
								elseif xRenv.typeof(v) == "Instance" then 
									args[i] = ProxyService:Instance(v, ProxyService.funcMap[v])
								else 
									args[i] = ProxyService:Userdata(v)
								end
							end
						end
						return func(unpack(args))
					end)
				end
				setfenv(Proxied, Xeno)
				return Proxied
			end

			if key == "once" then
				local Proxied = function(signal, func: () -> any)
					signal = ProxyService.Map[signal]
					return Signal.Once(signal, function(...: any)
						local args = {...}
						for i, v in args do 
							if xRenv.type(v) == "userdata" then 
								if ProxyService.Map[v] then  
									args[i] = ProxyService.Map[v]
								elseif xRenv.typeof(v) == "Instance" then
									args[i] = ProxyService:Instance(v, ProxyService.funcMap[v])
								else 
									args[i] = ProxyService:Userdata(v)
								end
							end
						end
						return func(unpack(args))
					end)
				end
				setfenv(Proxied, Xeno)
				return Proxied
			end
		end,
		__tostring = function() return tostring(Signal) end,
		__metatable = "The metatable is locked",
		__type = "RBXScriptSignal"
	})

	ProxyService.Map[ProxiedSignal] = Signal
	ProxyService.Map[Signal] = ProxiedSignal

	return ProxiedSignal
end

function ProxyService:Userdata(userdata: userdata)
	if userdata == xRenv.script then return nil end
	if ProxyService.Map[userdata] then return ProxyService.Map[userdata] end

	local nonInstanceUserdataTypes = {
		Axes = true,
		BrickColor = true,
		CatalogSearchParams = true,
		CFrame = true,
		Color3 = true,
		ColorSequence = true,
		ColorSequenceKeypoint = true,
		Content = true,
		DateTime = true,
		DockWidgetPluginGuiInfo = true,
		Enum = true,
		EnumItem = true,
		Enums = true,
		Faces = true,
		FloatCurveKey = true,
		Font = true,
		NumberRange = true,
		NumberSequence = true,
		NumberSequenceKeypoint = true,
		OverlapParams = true,
		Path2DControlPoint = true,
		PathWaypoint = true,
		PhysicalProperties = true,
		Random = true,
		Rect = true,
		Region3 = true,
		Region3int16 = true,
		RotationCurveKey = true,
		Secret = true,
		SharedTable = true,
		TweenInfo = true,
		UDim = true,
		UDim2 = true,
		Vector2 = true,
		Vector2int16 = true,
		Vector3 = true,
		Vector3int16 = true,
	}
	if nonInstanceUserdataTypes[xRenv.typeof(userdata)] then return userdata end

	local ProxiedUserdata = newproxy(true)

	local mt = getmetatable(ProxiedUserdata)
	mt.__index = function(_, key)
		if xRenv.typeof(userdata[key]) == "table" then
			local rt = userdata[key]
			local function recur(t)
				for i, v in t do
					if xRenv.type(v) == "userdata" then
						if ProxyService.Map[v] then
							t[i] = ProxyService.Map[v]
						elseif xRenv.typeof(v) == "RBXScriptSignal" then
							t[i] = ProxyService:RBXScriptSignal(v)
						elseif xRenv.typeof(v) ~= "Instance" then
							t[i] = ProxyService:Userdata(v)
						else
							local s = xRenv.pcall(function()
								return v.ClassName
							end)
							if s and (not ProxyService.funcMap[v] and ProxyService.funcMap[v.ClassName]) then
								error("Service '" .. tostring(v) ..  "' is not allowed", 3)
							end
							t[i] = ProxyService:Instance(v, ProxyService.funcMap[v] or ProxyService.funcMap[v.ClassName])
						end
					elseif xRenv.typeof(v) == "table" then
						t[i] = recur(v)
					end
				end
				return t
			end
			local px = recur(rt)
			return px
		end

		if xRenv.typeof(userdata[key]) == "RBXScriptSignal" then
			if ProxyService.Map[userdata[key]] then
				return ProxyService.Map[userdata[key]]
			end
			return ProxyService:RBXScriptSignal(userdata[key])
		end

		if xRenv.typeof(userdata[key]) == "Instance" then
			if ProxyService.Map[userdata[key]] then
				return ProxyService.Map[userdata[key]]
			end
			return ProxyService:Instance(userdata[key], ProxyService.funcMap[userdata[key]] or ProxyService.funcMap[userdata[key].ClassName])
		elseif xRenv.typeof(userdata[key]) == "userdata" then
			if ProxyService.Map[userdata[key]] then
				return ProxyService.Map[userdata[key]]
			end
			return ProxyService:Userdata(userdata[key])
		end

		if xRenv.typeof(userdata[key]) == "function" then
			local prx = function(...)
				local args = {...}
				do
					local function recur(t)
						for i, v in t do 
							if ProxyService.Map[v] then 
								t[i] = ProxyService.Map[v]
							elseif xRenv.type(v) == "table" then
								t[i] = recur(v)
							end
						end
						return t
					end
					args = recur(args)
				end

				local s, e = xRenv.pcall(function()
					return { userdata[key](unpack(args)) }
				end)

				if not s then
					error(e, 2)
				end

				if xRenv.typeof(e) == "table" then
					local function recur(t)
						for i, v in t do
							if xRenv.type(v) == "userdata" then
								if ProxyService.Map[v] then
									t[i] = ProxyService.Map[v]
								elseif xRenv.typeof(v) == "RBXScriptSignal" then
									t[i] = ProxyService:RBXScriptSignal(v)
								elseif xRenv.typeof(v) ~= "Instance" then
									t[i] = ProxyService:Userdata(v)
								else
									local s = xRenv.pcall(function()
										return v.ClassName
									end)
									if s and (not ProxyService.funcMap[v] and ProxyService.funcMap[v.ClassName]) then
										error("Service '" .. tostring(v) ..  "' is not allowed", 3)
									end
									t[i] = ProxyService:Instance(v, ProxyService.funcMap[v] or ProxyService.funcMap[v.ClassName])
								end
							elseif xRenv.typeof(v) == "table" then
								t[i] = recur(v)
							end
						end
						return t
					end
					e = recur(e)
				end
				return unpack(e)
			end
			setfenv(prx, Xeno)
			return prx
		end
		return userdata[key]
	end

	mt.__newindex = function(_, key, value)
		if xRenv.type(value) == "table" then 
			local function recur(t)
				for i, v in t do 
					if ProxyService.Map[v] then
						t[i] = ProxyService.Map[v]
					elseif xRenv.type(v) == "table" then
						t[i] = recur(v)
					end
				end
				return t
			end

			value = recur(value)
		end
		if ProxyService.Map[value] then 
			value = ProxyService.Map[value]
		end
		userdata[key] = value
	end

	local type_check_semibypass = {}

	mt.__div = function(_, x) return userdata / x end
	mt.__mul = function(_, x) return userdata * x end
	mt.__add = function(_, x) return userdata + x end
	mt.__sub = function(_, x) return userdata - x end
	mt.__mod = function(_, x) return userdata % x end
	mt.__pow = function(_, x) return userdata ^ x end
	mt.__unm = function(_, x) return -userdata end
	mt.__eq = function(x, y) 
		if rawequal(x, y) then
			return true
		end


		if x == nil or y == nil then
			return x == y
		end


		if xRenv.type(x) ~= xRenv.type(y) then
			return false
		end

		local originalX = ProxyService.Map[x] or x
		local originalY = ProxyService.Map[y] or y

		return originalX == originalY
	end 
	mt.__lt = function(_, x) return userdata < x end 
	mt.__le = function(_, x) return userdata <= x end 
	mt.__concat = function(_, x) return userdata .. x end 
	mt.__len = function(_, x) return #userdata end
	mt.__call = function(...) return userdata(...) end
	mt.__tostring = function() return tostring(userdata) end
	mt.__metatable = getmetatable(userdata)

	for _, v in mt do 
		if xRenv.typeof(v) == "function" then 
			xRenv.pcall(setfenv, v, Xeno)
		end
	end

	ProxyService.Map[userdata] = ProxiedUserdata 
	ProxyService.Map[ProxiedUserdata] = userdata 

	return ProxiedUserdata
end

function ProxyService:Instance(instance: Instance, customs: table, optionalAllowClone)
	if instance == xRenv.script then return Xeno.Instance.new("ModuleScript") end
	if xRenv.typeof(instance) == "table" then return ProxyService.Map[instance] end

	if not optionalAllowClone and ProxyService.Map[instance] then
		return ProxyService.Map[instance]
	end

	local realMethods = {};
	local ProxiedInstance = {};

	local key = tostring({})

	xRenv.xpcall(function()
		return instance[key]
	end, function()
		realMethods.__index = debug.info(2, "f")
	end)

	xRenv.xpcall(function()
		instance[key] = instance
	end, function()
		realMethods.__newindex = debug.info(2, "f")
	end)

	xRenv.xpcall(function()
		return instance[key](instance)
	end, function()
		realMethods.__namecall = debug.info(2, "f")
	end)

	local type_check_semibypass = {}

	xRenv.xpcall(function()
		return instance == type_check_semibypass
	end, function()
		realMethods.__eq = debug.info(2, "f")
	end)

	realMethods.__tostring = function()
		return tostring(instance)
	end

	local realIndex = realMethods.__index
	local mapVal = tostring({})

	realMethods.__index = function(self, key)
		if customs then 
			key = string.gsub(key, "%z+$", "")
			if customs[key] then return customs[key] end
			if customs[instance[key]] then return customs[instance[key]] end
		end
		if xRenv.typeof(instance[key]) == "function" then
			local proxy = function(...)
				local args = {...}
				do
					local function recur(t)
						for i, v in t do
							if ProxyService.Map[v] then
								t[i] = ProxyService.Map[v]
							elseif xRenv.type(v) == "table" then
								t[i] = recur(v)
							elseif xRenv.type(v) == "function" then
								local xglb = Xeno
								local __cb_cache = setmetatable({}, { __mode = "k" })
								local function makeCbEnv()
									local cbEnv = setmetatable({}, { __index = Xeno })
									cbEnv._G = cbEnv

									cbEnv.getfenv = function(_) return cbEnv end
									cbEnv.setfenv = function(target, newEnv)
										local tt = xRenv.type(target)
										if tt == "number" then error("setfenv on stack level is not allowed", 2) end
										if tt == "function" then
											if newEnv ~= cbEnv then error("attempt to set foreign environment", 2) end
											return target
										end
										error("invalid setfenv target", 2)
									end

									cbEnv.debug = setmetatable({
										info = function(f, what)
											if xRenv.type(f) == "number" and f > 0 then return nil end
											return xRenv.debug.info(f, what)
										end
									}, { __index = function() return nil end })
									cbEnv.game = xglb.game 
									return cbEnv
								end

								local function _wrap(fn)
									local cached = __cb_cache[fn]
									if cached then return cached end
									local cbEnv = makeCbEnv()
									local wrapped
									if xRenv.debug.info(fn, "s") ~= "[C]" then
										local ok = xRenv.pcall(setfenv, fn, cbEnv)
										if ok then
											local fe = getfenv(fn); fe.game = xglb.game
											wrapped = fn
										else
											wrapped = function(...) return nil end
											setfenv(wrapped, cbEnv)
										end
									else
										wrapped = function(...) return fn(...) end
										setfenv(wrapped, cbEnv)
									end
									__cb_cache[fn] = wrapped
									return wrapped
								end

								t[i] = _wrap(v)
							end
						end
						return t
					end

					args = recur(args)
				end

				local s, e = xRenv.pcall(function() 
					return { instance[key](unpack(args)) }
				end)

				if not s then
					error(e, 2)
				end

				if xRenv.typeof(e) == "table" then 
					local function recur(t)
						for i, v in t do
							if xRenv.type(v) == "userdata" then
								if ProxyService.Map[v] then 
									t[i] = ProxyService.Map[v]
								elseif xRenv.typeof(v) == "RBXScriptSignal" then 
									t[i] = ProxyService:RBXScriptSignal(v)
								elseif xRenv.typeof(v) ~= "Instance" then 
									t[i] = ProxyService:Userdata(v)
								else
									local success = xRenv.pcall(function()
										return v.ClassName
									end)
									if success and (not ProxyService.funcMap[v] and ProxyService.funcMap[v.ClassName]) then 
										error("", 2)
									end
									t[i] = ProxyService:Instance(v, ProxyService.funcMap[v] or ProxyService.funcMap[v.ClassName])
								end
							elseif xRenv.typeof(v) == "table" then
								t[i] = recur(v)
							end
						end
						return t
					end
					e = recur(e)
				end

				return unpack(e)
			end

			setfenv(proxy, Xeno)

			return proxy
		end
		if xRenv.typeof(instance[key]) == "RBXScriptSignal" then
			return ProxyService:RBXScriptSignal(instance[key])
		end
		if xRenv.type(instance[key]) == "userdata" then
			if ProxyService.Map[instance[key]] then return ProxyService.Map[instance[key]] end
			if xRenv.typeof(instance[key]) == "Instance" then
				return ProxyService:Instance(instance[key], ProxyService.Map[instance[key]] or ProxyService.Map[instance[key].ClassName])
			end
			return ProxyService:Userdata(instance[key])
		end
		if xRenv.typeof(instance[key]) == "table" then
			local rt = instance[key]
			local function recur(t)
				for i, v in rt do
					if xRenv.type(v) == "userdata" then
						if ProxyService.Map[v] then
							t[i] = ProxyService.Map[v]
						elseif xRenv.typeof(v) == "RBXScriptSignal" then
							t[i] = ProxyService:RBXScriptSignal(v)
						elseif xRenv.typeof(v) ~= "Instance" then
							t[i] = ProxyService:Userdata(v)
						else
							local s = xRenv.pcall(function()
								return v.ClassName
							end)
							if s and (not ProxyService.funcMap[v] and ProxyService.funcMap[v.ClassName]) then
								error("Service '" .. tostring(v) ..  "' is not allowed", 3)
							end
							t[i] = ProxyService:Instance(v, ProxyService.funcMap[v] or ProxyService.funcMap[v.ClassName])
						end
					elseif xRenv.typeof(v) == "table" then
						t[i] = recur(v)
					end
				end
				return t
			end
			local px = recur(rt)
			return px
		end
		return realIndex(instance, key)
	end

	local realNewIndex = realMethods.__newindex

	realMethods.__newindex = function(self, index, value)
		if ProxyService.Map[value] then
			return realNewIndex(instance, index, ProxyService.Map[value])
		end
		return realNewIndex(instance, index, value)
	end

	realMethods.__metatable = getmetatable(instance)

	for _, v in realMethods do 
		if xRenv.typeof(v) == "function" then 
			xRenv.pcall(setfenv, v, Xeno)
		end
	end

	setmetatable(ProxiedInstance, realMethods)

	ProxyService.Map[instance] = ProxiedInstance
	ProxyService.Map[ProxiedInstance] = instance

	return ProxiedInstance
end

function ProxyService:Get(x)
	return ProxyService.Map[x]
end
--- [PROXY SERVICE] --- END

--- [UNC SYSTEM] --- START
----------------------- SCRIPT
local OverWrittenModules = {}

function Xeno.getgenv()
	return Xeno
end

function deepSearch(tbl: {}, toFind: {}, additionalChecker: () -> ... boolean, map: {}): boolean
	if not map then
		map = {}
	end
	if map[tbl] then -- prevent stack overflow
		return false
	end
	map[tbl] = true
	if additionalChecker and additionalChecker(tbl) then
		return true
	end
	for _, target in toFind do
		for i, v in pairs(tbl) do
			if Xeno.type(i) == "function" then -- Xeno.type because sandbox
				xRenv.pcall(setfenv, i, Xeno)
			end
			if Xeno.type(v) == "function" then
				xRenv.pcall(setfenv, v, Xeno)
			end
			if i == target or v == target then
				return true
			end
			if Xeno.type(i) == "table" then
				if additionalChecker and additionalChecker(i) then
					return true
				elseif deepSearch(i, toFind, additionalChecker, map) then
					return true
				end
			end
			if Xeno.type(v) == "table" then
				if additionalChecker and additionalChecker(v) then
					return true
				elseif deepSearch(v, toFind, additionalChecker, map) then
					return true
				end
			end
		end
	end
	return false
end

local function _require(moduleScript: Instance, ...)
	moduleScript = ProxyService:Get(moduleScript)
	xRenv.assert(not OverWrittenModules[moduleScript], "The module's bytecode was recently overwritten, call restorescriptbytecode to restore to it's original bytecode.", 3)
	--xRenv.assert(not moduleScript:IsDescendantOf(ThirdPartyUserService), "Not allowed", 3)
	local x = xRenv.require(moduleScript, ...)
	if xRenv.type(x) == "function" then
		xRenv.pcall(setfenv, x, Xeno)
	elseif xRenv.type(x) == "table" then
		xRenv.assert(not deepSearch(x, {xRenv.game, xRenv.workspace}, function(tbl: {})
			for i, v in tbl do
				if xRenv.type(i) == "function" then
					xRenv.pcall(setfenv, i, Xeno)
				end
				if xRenv.type(v) == "function" then
					xRenv.pcall(setfenv, v, Xeno)
				end
			end
			-- local val = tbl["game"] or tbl["Game"] or tbl["workspace"] or tbl["Workspace"]
			local _, val = xRenv.pcall(function()return tbl["game"] or tbl["Game"] or tbl["workspace"] or tbl["Workspace"] end)
			return val == xRenv.game or val == xRenv.workspace
		end), "Nice try :D", 3)
	elseif xRenv.type(x) == "userdata" then
		if xRenv.type(getmetatable(x)) == "table" then
			xRenv.assert(not deepSearch(getmetatable(x), {xRenv.game, xRenv.workspace}, function(tbl: {})
				for i, v in tbl do
					if xRenv.type(i) == "function" then
						xRenv.pcall(setfenv, i, Xeno)
					end
					if xRenv.type(v) == "function" then
						xRenv.pcall(setfenv, v, Xeno)
					end
				end
				local _, val = xRenv.pcall(function()return tbl["game"] or tbl["Game"] or tbl["workspace"] or tbl["Workspace"] end)
				return val == xRenv.game or val == xRenv.workspace
			end), "Nice try :D", 3)
		end
	end
	xRenv.assert(x ~= xRenv.game and x ~= xRenv.workspace, "Nice try :D", 3)
	return x
end

local XFRenv = nil
--shared.__Xeno_G = {}
local __Xeno_G = {}

function Xeno.getrenv()
	if XFRenv then
		return XFRenv
	end

	XFRenv = {
		["print"] = print, ["warn"] = warn, ["error"] = error, ["assert"] = assert, ["collectgarbage"] = getfenv().collectgarbage, ["require"] = _require, --x
		["select"] = select, ["tonumber"] = tonumber, ["tostring"] = tostring, ["type"] = Xeno.type, ["xpcall"] = xpcall,
		["pairs"] = pairs, ["next"] = next, ["ipairs"] = ipairs, ["newproxy"] = newproxy, ["rawequal"] = rawequal, ["rawget"] = rawget,
		["rawset"] = rawset, ["rawlen"] = rawlen, ["gcinfo"] = gcinfo, 
		["_G"] = __Xeno_G --[[shared.__Xeno_G]], ["shared"] = shared, ["RaycastParams"] = Xeno.RaycastParams, ["Ray"] = Xeno.Ray,

		["coroutine"] = {
			["create"] = coroutine["create"], ["resume"] = coroutine["resume"], ["running"] = coroutine["running"],
			["status"] = coroutine["status"], ["wrap"] = coroutine["wrap"], ["yield"] = coroutine["yield"],
		},

		["bit32"] = {
			["arshift"] = bit32["arshift"], ["band"] = bit32["band"], ["bnot"] = bit32["bnot"], ["bor"] = bit32["bor"], ["btest"] = bit32["btest"],
			["extract"] = bit32["extract"], ["lshift"] = bit32["lshift"], ["replace"] = bit32["replace"], ["rshift"] = bit32["rshift"], ["xor"] = bit32["xor"],
		},

		["math"] = {
			["abs"] = math["abs"], ["acos"] = math["acos"], ["asin"] = math["asin"], ["atan"] = math["atan"], ["atan2"] = math["atan2"], ["ceil"] = math["ceil"],
			["cos"] = math["cos"], ["cosh"] = math["cosh"], ["deg"] = math["deg"], ["exp"] = math["exp"], ["floor"] = math["floor"], ["fmod"] = math["fmod"],
			["frexp"] = math["frexp"], ["ldexp"] = math["ldexp"], ["log"] = math["log"], ["log10"] = math["log10"], ["max"] = math["max"], ["min"] = math["min"],
			["modf"] = math["modf"], ["pow"] = math["pow"], ["rad"] = math["rad"], ["random"] = math["random"], ["randomseed"] = math["randomseed"],
			["sin"] = math["sin"], ["sinh"] = math["sinh"], ["sqrt"] = math["sqrt"], ["tan"] = math["tan"], ["tanh"] = math["tanh"]
		},

		["string"] = {
			["byte"] = string["byte"], ["char"] = string["char"], ["find"] = string["find"], ["format"] = string["format"], ["gmatch"] = string["gmatch"],
			["gsub"] = string["gsub"], ["len"] = string["len"], ["lower"] = string["lower"], ["match"] = string["match"], ["pack"] = string["pack"],
			["packsize"] = string["packsize"], ["rep"] = string["rep"], ["reverse"] = string["reverse"], ["sub"] = string["sub"],
			["unpack"] = string["unpack"], ["upper"] = string["upper"],
		},

		["table"] = {
			["clone"] = table.clone, ["concat"] = table.concat, ["insert"] = table.insert, ["pack"] = table.pack, ["remove"] = table.remove, ["sort"] = table.sort,
			["unpack"] = table.unpack,
		},

		["utf8"] = {
			["char"] = utf8["char"], ["charpattern"] = utf8["charpattern"], ["codepoint"] = utf8["codepoint"], ["codes"] = utf8["codes"],
			["len"] = utf8["len"], ["nfdnormalize"] = utf8["nfdnormalize"], ["nfcnormalize"] = utf8["nfcnormalize"],
		},

		["os"] = {
			["clock"] = os["clock"], ["date"] = os["date"], ["difftime"] = os["difftime"], ["time"] = os["time"],
		},

		["delay"] = delay, ["elapsedTime"] = getfenv().elapsedTime, ["spawn"] = spawn, ["tick"] = tick, ["time"] = time, ["typeof"] = Xeno.typeof,
		["settings"] = Xeno.settings, ["UserSettings"] = Xeno.UserSettings, ["version"] = getfenv().version, ["wait"] = wait, ["_VERSION"] = _VERSION,

		["task"] = {
			["defer"] = task["defer"], ["delay"] = task["delay"], ["spawn"] = task["spawn"], ["wait"] = task["wait"], ["cancel"] = task["cancel"]
		},

		["debug"] = {
			["traceback"] = xRenv.debug["traceback"], ["profilebegin"] = xRenv.debug["profilebegin"], ["profileend"] = xRenv.debug["profileend"],
		},

		["game"] = Xeno.game, ["workspace"] = Xeno.workspace, ["Game"] = Xeno.game, ["Workspace"] = Xeno.workspace,

		["getmetatable"] = getmetatable, ["setmetatable"] = setmetatable
	}
	table.freeze(XFRenv)

	return XFRenv
end

function Xeno.type(x)
	if xRenv.type(x) == "table" and ProxyService.Map[x] then
		return xRenv.type(ProxyService.Map[x])
	end
	return xRenv.type(x)
end

function Xeno.typeof(x)
	if (xRenv.typeof(x) == "table" or xRenv.typeof(x) == "userdata") and ProxyService.Map[x] then
		return xRenv.typeof(ProxyService.Map[x])
	end
	return xRenv.typeof(x)
end

local UnlockedModules = {}

function Xeno.GetUnlockedModules(): {}
	local UModules = {}
	for i, v in pairs(UnlockedModules) do
		table.insert(UModules, ProxyService:Get(i))
	end
	return UModules
end

local function RLockModule(moduleScript: Instance)
	if not UnlockedModules[moduleScript] then return end
	local ov = createInstancePointer(moduleScript)
	RServer({XFS.LockModule, ov.Name}, true)
	ov:Destroy()
	UnlockedModules[moduleScript] = false
end
function Xeno.LockModule(moduleScript: Instance)
	moduleScript = ProxyService:Get(moduleScript)
	xRenv.assert(xRenv.typeof(moduleScript) == "Instance", "invalid argument #1 to 'LockModule' (Instance expected, got "
		.. xRenv.typeof(moduleScript) .. ") ", 3)
	xRenv.assert(moduleScript.ClassName == "ModuleScript", "invalid argument #2 to 'LockModule' (ModuleScript expected, got "
		.. moduleScript.ClassName .. ") ", 3)
	RLockModule(moduleScript)
end
Xeno.Xeno.LockModule = Xeno.LockModule

local function RUnlockModule(moduleScript: Instance)
	if UnlockedModules[moduleScript] then return end
	local ov = createInstancePointer(moduleScript)
	RServer({XFS.UnlockModule, ov.Name}, true)
	ov:Destroy()
	UnlockedModules[moduleScript] = true
end
function Xeno.UnlockModule(moduleScript: Instance)
	moduleScript = ProxyService:Get(moduleScript)
	xRenv.assert(xRenv.typeof(moduleScript) == "Instance", "invalid argument #1 to 'UnlockModule' (Instance expected, got "
		.. xRenv.typeof(moduleScript) .. ") ", 3)
	xRenv.assert(moduleScript.ClassName == "ModuleScript", "invalid argument #1 to 'UnlockModule' (ModuleScript expected, got "
		.. moduleScript.ClassName .. ") ", 3)
	RUnlockModule(moduleScript)
end
Xeno.Xeno.UnlockModule = Xeno.UnlockModule

function Xeno.require(moduleScript: Instance, unlockSiblingsAndDescendants: boolean?): {}
	moduleScript = ProxyService:Get(moduleScript)
	xRenv.assert(xRenv.typeof(moduleScript) == "Instance", "Attempted to call require with invalid argument(s). ", 3)
	xRenv.assert(moduleScript.ClassName == "ModuleScript", "Attempted to call require with invalid argument(s). ", 3)

	xRenv.assert(not OverWrittenModules[moduleScript], "The module's bytecode was recently overwritten, call restorescriptbytecode to restore to it's original bytecode.", 3)
	--xRenv.assert(not moduleScript:IsDescendantOf(ThirdPartyUserService), "Not allowed", 3)

	if unlockSiblingsAndDescendants == nil then unlockSiblingsAndDescendants = true end

	if unlockSiblingsAndDescendants then
		for _, descendant in pairs(moduleScript:GetDescendants()) do
			if descendant:IsA("ModuleScript") then
				RUnlockModule(descendant)
			end
		end

		if moduleScript.Parent then
			for _, child in pairs(moduleScript.Parent:GetDescendants()) do -- for _, child in pairs(moduleScript.Parent:GetChildren()) do
				if child:IsA("ModuleScript") then
					RUnlockModule(child)
				end
			end
		end
	end

	if UnlockedModules[moduleScript] then
		local x = xRenv.require(moduleScript)
		if xRenv.type(x) == "function" then
			xRenv.pcall(setfenv, x, Xeno)
		elseif xRenv.type(x) == "table" then
			xRenv.assert(not deepSearch(x, {xRenv.game, xRenv.workspace}, function(tbl: {})
				for i, v in tbl do
					if xRenv.type(i) == "function" then
						xRenv.pcall(setfenv, i, Xeno)
					end
					if xRenv.type(v) == "function" then
						xRenv.pcall(setfenv, v, Xeno)
					end
				end
				local _, val = xRenv.pcall(function()return tbl["game"] or tbl["Game"] or tbl["workspace"] or tbl["Workspace"] end)
				return val == xRenv.game or val == xRenv.workspace
			end), "Nice try :D", 3)
		elseif xRenv.type(x) == "userdata" then
			if xRenv.type(getmetatable(x)) == "table" then
				xRenv.assert(not deepSearch(getmetatable(x), {xRenv.game, xRenv.workspace}, function(tbl: {})
					for i, v in tbl do
						if xRenv.type(i) == "function" then
							xRenv.pcall(setfenv, i, Xeno)
						end
						if xRenv.type(v) == "function" then
							xRenv.pcall(setfenv, v, Xeno)
						end
					end
					local _, val = xRenv.pcall(function()return tbl["game"] or tbl["Game"] or tbl["workspace"] or tbl["Workspace"] end)
					return val == xRenv.game or val == xRenv.workspace
				end), "Nice try :D", 3)
			end
		end
		xRenv.assert(x ~= xRenv.game and x ~= xRenv.workspace, "Nice try :D", 3)
		return x
	end

	RUnlockModule(moduleScript)

	local x = xRenv.require(moduleScript)
	if xRenv.type(x) == "function" then
		xRenv.pcall(setfenv, x, Xeno)
	elseif xRenv.type(x) == "table" then
		xRenv.assert(not deepSearch(x, {xRenv.game, xRenv.workspace}, function(tbl: {})
			for i, v in tbl do
				if xRenv.type(i) == "function" then
					xRenv.pcall(setfenv, i, Xeno)
				end
				if xRenv.type(v) == "function" then
					xRenv.pcall(setfenv, v, Xeno)
				end
			end
			local _, val = xRenv.pcall(function()return tbl["game"] or tbl["Game"] or tbl["workspace"] or tbl["Workspace"] end)
			return val == xRenv.game or val == xRenv.workspace
		end), "Nice try :D", 3)
	elseif xRenv.type(x) == "userdata" then
		if xRenv.type(getmetatable(x)) == "table" then
			xRenv.assert(not deepSearch(getmetatable(x), {xRenv.game, xRenv.workspace}, function(tbl: {})
				for i, v in tbl do
					if xRenv.type(i) == "function" then
						xRenv.pcall(setfenv, i, Xeno)
					end
					if xRenv.type(v) == "function" then
						xRenv.pcall(setfenv, v, Xeno)
					end
				end
				local _, val = xRenv.pcall(function()return tbl["game"] or tbl["Game"] or tbl["workspace"] or tbl["Workspace"] end)
				return val == xRenv.game or val == xRenv.workspace
			end), "Nice try :D", 3)
		end
	end
	xRenv.assert(x ~= xRenv.game and x ~= xRenv.workspace, "Nice try :D", 3)
	return x
end

function Xeno.getscriptbytecode(Script: Instance)
	Script = ProxyService:Get(Script)
	xRenv.assert(xRenv.typeof(Script) == "Instance", "invalid argument #1 to 'getscriptbytecode' (Instance expected, got " .. xRenv.typeof(Script) .. ") ", 3)
	xRenv.assert(Script:IsA("LuaSourceContainer"), "invalid argument #1 to 'getscriptbytecode' (Must be a LuaSourceContainer)", 3)
	--xRenv.assert(Script.ClassName == "LocalScript" or Script.ClassName == "ModuleScript", 
	--"invalid 'ClassName' for 'Instance' #1 to 'getscriptbytecode' (LocalScript or ModuleScript expected, got '" .. Script.ClassName .. "') ", 3)
	local ov = createInstancePointer(Script)
	local result = RServer({XFS.GetScriptBytecode, ov.Name}, true)
	ov:Destroy()
	return result
end
Xeno.dumpstring = Xeno.getscriptbytecode

function Xeno.setscriptbytecode(Script: Instance, source: string)
	Script = ProxyService:Get(Script)
	xRenv.assert(xRenv.typeof(Script) == "Instance", "invalid argument #1 to 'setscriptbytecode' (Instance expected, got " .. xRenv.typeof(Script) .. ") ", 3)
	xRenv.assert(Script.ClassName == "LocalScript" or Script.ClassName == "ModuleScript", 
		"invalid 'ClassName' for 'Instance' #1 to 'setscriptbytecode' (LocalScript or ModuleScript expected, got '" .. Script.ClassName .. "') ", 3)
	xRenv.assert(xRenv.type(source) == "string", "invalid argument #2 to 'setscriptbytecode' (string expected, got " .. xRenv.type(source) .. ")", 3)
	if Script.ClassName == "ModuleScript" then
		OverWrittenModules[Script] = true
	end
	local ov = createInstancePointer(Script)
	RServer{0, "if not shared.__Xeno then if script.ClassName == 'ModuleScript' then warn('Call the function UnlockModule() to set this scripts identity to 3') end error('Xeno Environment Not Found. Identity must be 3.. Try calling UnlockModule', 3) end local cn = script.ClassName for i,v in shared.__Xeno do getfenv(0)[i]=v end;local e={}setmetatable(e, {__index = shared.__Xeno})setfenv(1,e)local s=Instance.new(cn)getfenv(1).script=s setfenv(0, getfenv(1))" .. source, Urls.Server ..
		"/sb?c=" ..
		ov.Name .. "&p=" .. XENO_PID
	}
	ov:Destroy()
end

function Xeno.restorescriptbytecode(Script: Instance)
	Script = ProxyService:Get(Script)
	xRenv.assert(xRenv.typeof(Script) == "Instance", "invalid argument #1 to 'restorescriptbytecode' (Instance expected, got " .. xRenv.typeof(Script) .. ") ", 3)
	xRenv.assert(Script.ClassName == "LocalScript" or Script.ClassName == "ModuleScript", 
		"invalid 'ClassName' for 'Instance' #1 to 'restorescriptbytecode' (LocalScript or ModuleScript expected, got '" .. Script.ClassName .. "') ", 3)
	if Script.ClassName == "ModuleScript" then
		OverWrittenModules[Script] = nil
	end
	local ov = createInstancePointer(Script)
	RServer({XFS.RestoreScriptBytecode, ov.Name}, true)
	ov:Destroy()
end

do
	local API = "http://api.plusgiant5.com"

	local last_call = 0

	local function call(konstantType: string, scriptPath: Instance): string?
		local success, bytecode = xRenv.pcall(Xeno.getscriptbytecode, scriptPath)

		if #bytecode <= 1 then
			return "-- " .. tostring(scriptPath:GetFullName()) .. " contains empty bytecode"
		end

		if (not success) then
			return `-- Failed to get script bytecode, error:\n\n--[[\n{bytecode}\n--]]`
		end

		local time_elapsed = os.clock() - last_call
		if time_elapsed <= .5 then
			task.wait(.5 - time_elapsed)
		end

		local httpResult = SendRequest({
			Url = API .. konstantType,
			Body = bytecode,
			Method = "POST",
			Headers = {
				["Content-Type"] = "text/plain"
			}
		})

		last_call = os.clock()

		if (httpResult.StatusCode ~= 200) then
			return `-- Error occurred while requesting Konstant API, error:\n\n--[[\n{httpResult.Body}\n--]]`
		else
			return httpResult.Body
		end
	end

	function Xeno.decompile(Script: Instance): string?
		return call("/konstant/decompile", Script)
	end

	function Xeno.disassemble(Script: Instance)
		return call("/konstant/disassemble", Script)
	end
end

local scriptables = {}

local function rSetScriptable(instance: Instance, property: string, scriptable: boolean)
	local ov = createInstancePointer(instance)
	RServer {
		0,
		HttpService:JSONEncode {
			c = ov.Name,
			p = XENO_PID,
			r = property,
			s = scriptable
		},
		Urls.Server .. "/f?e=" .. XFS.SetScriptable
	}
	ov:Destroy()
end

function Xeno.gethiddenproperty(instance: Instance, property: string): any
	local p = instance
	instance = ProxyService:Get(instance)
	xRenv.assert(xRenv.typeof(instance) == "Instance", "invalid argument #1 to 'gethiddenproperty' (Instance expected, got " .. xRenv.typeof(instance) .. ") ", 3)
	xRenv.assert(xRenv.typeof(property) == "string", "invalid argument #2 to 'gethiddenproperty' (string expected, got " .. xRenv.type(property) .. ") ", 3)

	if instance == xRenv.workspace and property:lower() == "parent" then
		return Xeno.game
	end

	local success, result = xRenv.pcall(function()
		return p[property]
	end)
	if success then
		if scriptables[instance.ClassName] and scriptables[instance.ClassName][property] then
			if scriptables[instance.ClassName][property].Original == false and scriptables[instance.ClassName][property].Scriptable == true then
				return result, true
			end
		end
		return result, false -- its returning false because previously setscriptable was set to true for that property. GOTTA FIXXX
	end

	local success, result = xRenv.pcall(function()
		return Xeno.game:GetService("UGCValidationService"):GetPropertyValue(p, property)
	end)

	if success then
		return result, true
	end

	return 0, true

	--[[
	rSetScriptable(instance, property, true)
	local v = p[property]
	rSetScriptable(instance, property, false)
	
	return v
	]]
end

function Xeno.sethiddenproperty(instance: Instance, property: string, val: any): boolean -- broken!!!
	local success = xRenv.pcall(function()
		instance[property] = val
	end)

	if success then
		if scriptables[instance.ClassName] and scriptables[instance.ClassName][property] then
			if scriptables[instance.ClassName][property].Original == false and scriptables[instance.ClassName][property].Scriptable == true then
				return true
			end
		end
		return false
	end

	instance = ProxyService:Get(instance)

	if not scriptables[instance.ClassName] then
		scriptables[instance.ClassName] = {}
		scriptables[instance.ClassName][property] = {Original = false, Scriptable = true}
	end

	rSetScriptable(instance, property, true)
	xRenv.pcall(function()
		instance[property] = val -- could give an error of property not being scriptable if too many calls from different threads resulting in property being set, loop it?
	end)
	rSetScriptable(instance, property, false)

	scriptables[instance.ClassName][property].Scriptable = false

	return true
end

function Xeno.isscriptable(instance: Instance, property: string)
	xRenv.assert(Xeno.typeof(instance) == "Instance", "invalid argument #1 to 'setscriptable' (Instance expected, got " .. Xeno.typeof(instance) .. ") ", 3)
	xRenv.assert(xRenv.type(property) == "string", "invalid argument #2 to 'setscriptable' (string expected, got " .. xRenv.type(property) .. ") ", 3)

	if scriptables[instance.ClassName] and scriptables[instance.ClassName][property] then
		local set = scriptables[instance.ClassName][property][ProxyService:Get(instance)]
		if set == nil then
			return scriptables[instance.ClassName][property].Original or false -- its always going to be false assuming
			--return false
		end
		return set
	end

	local success, result = xRenv.xpcall(instance.GetPropertyChangedSignal, function(r)
		return r
	end, instance, property)

	return success or not string.find(result, "scriptable") -- "%s is not a scriptable property."
end

function Xeno.setscriptable(instance: Instance, property: string, scriptable: boolean): boolean
	xRenv.assert(Xeno.typeof(instance) == "Instance", "invalid argument #1 to 'setscriptable' (Instance expected, got " .. Xeno.typeof(instance) .. ") ", 3)
	xRenv.assert(xRenv.type(property) == "string", "invalid argument #2 to 'setscriptable' (string expected, got " .. xRenv.type(property) .. ") ", 3)
	xRenv.assert(xRenv.type(scriptable) == "boolean", "invalid argument #3 to 'setscriptable' (boolean expected, got " .. xRenv.type(scriptable) .. ") ", 3)


	--[[
	if not scriptable then
		local _, isHidden = Xeno.gethiddenproperty(instance, property)
		--xRenv.assert(isHidden, "Property must be a hidden value previously.", 3) -- for safety
	end
	]]

	local success, result = xRenv.pcall(function()
		return scriptables[instance.ClassName][property].Scriptable
	end)

	if success and result == scriptable and scriptables[instance.ClassName][property][ProxyService:Get(instance)] ~= nil then
		return scriptable
	end

	local wasScriptable = Xeno.isscriptable(instance, property)
	if wasScriptable == scriptable then return scriptable end

	rSetScriptable(ProxyService:Get(instance), property, scriptable)

	if not scriptables[instance.ClassName] then
		scriptables[instance.ClassName] = {}
	end
	if not scriptables[instance.ClassName][property] then
		scriptables[instance.ClassName][property] = {}
		scriptables[instance.ClassName][property].Original = wasScriptable
	end

	scriptables[instance.ClassName][property].Scriptable = scriptable
	scriptables[instance.ClassName][property][ProxyService:Get(instance)] = scriptable

	return wasScriptable
end

local function rGetProperties(instance: Instance): {}
	local ov = createInstancePointer(ProxyService:Get(instance)) -- this is unoptimized. make a function rGetHiddenProperty?
	local result = RServer({XFS.GetProperties, ov.Name}, true)
	ov:Destroy()

	if xRenv.type(result) ~= "table" then return {} end

	local properties = {}
	for _, property in result do
		properties[property] = {Xeno.gethiddenproperty(instance, property)}
	end
	return properties
end

function Xeno.getproperties(instance: Instance)
	xRenv.assert(Xeno.typeof(instance) == "Instance", "invalid argument #1 to 'getproperties' (Instance expected, got " .. Xeno.typeof(instance) .. ") ", 3)
	local properties = {}
	for property, propertyInfo in pairs(rGetProperties(instance)) do
		if not propertyInfo[2] then
			properties[property] = propertyInfo[1]
		end
	end
	return properties
end

function Xeno.gethiddenproperties(instance: Instance)
	xRenv.assert(Xeno.typeof(instance) == "Instance", "invalid argument #1 to 'gethiddenproperties' (Instance expected, got " .. Xeno.typeof(instance) .. ") ", 3)
	local properties = {}
	for property, propertyInfo in pairs(rGetProperties(instance)) do
		if propertyInfo[2] then
			properties[property] = propertyInfo[1]
		end
	end
	return properties
end

function Xeno.getrbxsignals(instance: Instance)
	local p = instance
	instance = ProxyService:Get(instance)
	local ov = createInstancePointer(instance)
	local result = RServer({XFS.GetInstanceRBXSignals, ov.Name}, true)
	ov:Destroy()

	if xRenv.type(result) ~= "table" then return {} end

	local signals = {}
	for _, signalName in pairs(result) do
		local success, result = xRenv.pcall(function()
			return p[signalName]
		end)
		if success then
			signals[signalName] = result
		end
	end
	return signals
end

function Xeno.getfunctions(instance: Instance)
	local p = instance
	instance = ProxyService:Get(instance)
	local ov = createInstancePointer(instance)
	local result = RServer({XFS.GetInstanceFunctions, ov.Name}, true)
	ov:Destroy()

	if xRenv.type(result) ~= "table" then return {} end

	local functions = {}
	for _, functionName in pairs(result) do
		local success, result = xRenv.pcall(function()
			return p[functionName]
		end)
		if success then
			functions[functionName] = result
		end
	end
	return functions
end

function Xeno.loadstring(content: string, chunkName: string?): () -> ... any
	xRenv.assert(xRenv.type(content) == "string", "invalid argument #1 to 'loadstring' (string expected, got " .. xRenv.type(content) .. ") ", 3)

	local name = "loadstring:" .. math.random(1, 1000000)
	if xRenv.type(chunkName) == "string" then
		name = name .. tostring(chunkName) -- better be random otherwise if you call loadstring too many times with that same chunk name; will be chaos!
	end

	local module = xRenv.Instance.new("ModuleScript") --xRenv.Instance.fromExisting(Modules[math.random(1, #Modules)])
	module.Name = name
	module.Parent = LoadstringContainer

	local result, success, status = RServer({0, content, Urls.Server ..
		"/ls?c=" ..
		module.Name .. "&p=" .. XENO_PID
	}, nil, nil, true)

	if not success then
		if status == 0x190 then
			return nil, tostring(result)
		end
		if status == 0x1f4 then
			return nil, "Server failed to process loadstring. View the logs for more information."
		end
		return nil, "loadstring request to the server failed."
	end

	local modulesCache = {module}
	local start = tick()

	local function clearMCache()
		for _, v in pairs(modulesCache) do
			task.spawn(function()
				local ov = createInstancePointer(v)
				RServer({XFS.RestoreScriptBytecode, ov.Name}, true)
				ov:Destroy()
				v:Destroy()
			end)
		end
		table.clear(modulesCache)
	end

	while true do
		local success, loadstrFuncContainer = xRenv.pcall(function()
			return xRenv.require(module)
		end)

		if success and xRenv.type(loadstrFuncContainer) == "table" and xRenv.type(loadstrFuncContainer[XENO_PID]) == "function" then
			clearMCache()
			local loadstrFunc = loadstrFuncContainer[XENO_PID]
			task.delay(.01, clearMCache)
			setfenv(loadstrFunc, getfenv(xRenv.debug.info(2, 'f')))
			return loadstrFunc
		end

		if tick() - start > 3 then
			--warn("loadstring failed: Timeout")
			clearMCache()
			return nil, "Timeout"
		end

		task.wait(.05)

		name = "loadstring:" .. math.random(1, 1000000) .. ":"
		if xRenv.type(chunkName) == "string" then
			name = name .. tostring(chunkName)
		end

		module = xRenv.Instance.new("ModuleScript") --xRenv.Instance.fromExisting(Modules[math.random(1, #Modules)])
		module.Name = name
		module.Parent = LoadstringContainer

		RServer({0, content, Urls.Server ..
			"/ls?c=" ..
			name .. "&p=" .. XENO_PID
		}, nil, nil, true)

		table.insert(modulesCache, module)
	end
end

local pSettings = ProxyService:Userdata(settings())
local pUSettings = ProxyService:Userdata(UserSettings())

function Xeno.settings()
	return pSettings
end

function Xeno.UserSettings() -- UserSettings().Parent = workspace
	return pUSettings
end

local pRaycastParams = RaycastParams
local pRay = Ray

Xeno.RaycastParams = ProxyService:Userdata(pRaycastParams)
Xeno.Ray = ProxyService:Userdata(pRay)

do -- luau base64, modified for Xeno. Original: https://gist.github.com/metatablecat/1f6cd6f4495f95700eb1a686de4ebe5e
	local SEQ = {
		[0] = "A", "B", "C", "D", "E", "F", "G", "H",
		"I", "J", "K", "L", "M", "N", "O", "P",
		"Q", "R", "S", "T", "U", "V", "W", "X",
		"Y", "Z", "a", "b", "c", "d", "e", "f",
		"g", "h", "i", "j", "k", "l", "m", "n",
		"o", "p", "q", "r", "s", "t", "u", "v",
		"w", "x", "y", "z", "0", "1", "2", "3",
		"4", "5", "6", "7", "8", "9", "+", "/",
	}

	local STRING_FAST = {}
	local INDEX = {[61] = 0, [65] = 0}

	for key, val in ipairs(SEQ) do
		-- memoization
		INDEX[string.byte(val)] = key
	end

	-- string.char has a MASSIVE overhead, its faster to precompute
	-- the values for performance
	for i = 0, 255 do
		local c = string.char(i)
		STRING_FAST[i] = c
	end

	fbase64 = { -- Not 100% accurate for not correct string length due to null byte otherwise this would've been used as main base64 lib
		-- Add Assert?
		encode = function(str: string)
			local len = string.len(str)
			local output = table.create(math.ceil(len/4)*4)
			local index = 1

			for i = 1, len, 3 do
				local b0, b1, b2 = string.byte(str, i, i + 2)
				local b = bit32.lshift(b0, 16) + bit32.lshift(b1 or 0, 8) + (b2 or 0)

				output[index] = SEQ[bit32.extract(b, 18, 6)]
				output[index + 1] = SEQ[bit32.extract(b, 12, 6)]
				output[index + 2] = b1 and SEQ[bit32.extract(b, 6, 6)] or "="
				output[index + 3] = b2 and SEQ[bit32.band(b, 63)] or "="

				index += 4
			end

			return table.concat(output)
		end,
		decode = function(hash: string)
			-- given a 24 bit word (4 6-bit letters), decode 3 bytes from it
			local len = string.len(hash)
			local output = table.create(len * 0.75)

			local index = 1
			for i = 1, len, 4 do
				local c0, c1, c2, c3 = string.byte(hash, i, i + 3)

				local b = 
					bit32.lshift(INDEX[c0], 18)
					+ bit32.lshift(INDEX[c1], 12)
					+ bit32.lshift(INDEX[c2], 6)
					+ (INDEX[c3])


				output[index] = STRING_FAST[bit32.extract(b, 16, 8)]
				output[index + 1] = c2 ~= "=" and STRING_FAST[bit32.extract(b, 8, 8)] or "="
				output[index + 2] = c3 ~= "=" and STRING_FAST[bit32.band(b, 0xFF)] or "="
				index += 3
			end

			return table.concat(output)
		end,
	}
end

local SupportedHTTPMethods = {
	["GET"] = 0, 
	["POST"] = 1, 
	["PUT"] = 2, 
	["DELETE"] = 3, 
	["PATCH"] = 4
}

function Xeno.get_hwid()
	return CHWID
end
Xeno.gethwid = Xeno.get_hwid

function Xeno.request(options: {Url: string, Method: string?, body: string?, Headers: {}?}):
	{
		Success: boolean,
		StatusMessage: string?,
		StatusCode: number,
		Body: string?,
		HttpError: Enum.HttpError?,
		Headers: {}?,
		Version: string
	}
	xRenv.assert(xRenv.type(options) == "table", "invalid argument #1 to 'request' (table expected, got " .. xRenv.type(options) .. ") ", 3)
	xRenv.assert(xRenv.type(options.Url) == "string", "invalid option 'Url' for argument #1 to 'request' (string expected, got " .. xRenv.type(options.Url) .. ") ", 3)

	options.Method = options.Method or "GET"
	xRenv.assert(xRenv.type(options.Method) == "string", "invalid option 'Method' for argument #1 to 'request' (string expected, got " .. xRenv.type(options.Method) .. ") ", 3)
	options.Method = options.Method:upper()

	xRenv.assert(SupportedHTTPMethods[options.Method], "invalid option 'Method' for argument #1 to 'request' (a valid http method expected, got '" .. options.Method .. "') ", 3)

	if options.Body then xRenv.assert(xRenv.type(options.Body) == "string", "invalid option 'Body' for argument #1 to 'request' (string expected, got " .. xRenv.type(options.Body) .. ") ", 3) end
	if options.Headers then xRenv.assert(xRenv.type(options.Headers) == "table", "invalid option 'Headers' for argument #1 to 'request' (table expected, got " .. xRenv.type(options.Headers) .. ") ", 3) end

	options.Headers = options.Headers or {}
	local function lheader()
		local lheader = {}
		for i, v in pairs(options.Headers) do
			local lowerKey = tostring(i):lower()
			if not lheader[lowerKey] then
				lheader[lowerKey] = v
			end
		end
		return lheader
	end

	options.Headers = lheader()

	if options.Headers["user-agent"] then 
		xRenv.assert(xRenv.type(options.Headers["user-agent"]) == "string", "invalid option 'User-Agent' for argument #1 to 'request.Headers' (string expected, got "
			.. xRenv.type(options.Url) .. ") ", 3)
	end
	options.Headers["user-agent"] = options.Headers["user-agent"] or "Xeno/" .. tostring(Xeno.about.Version)
	options.Headers["exploit-guid"] = CHWID
	options.Headers["xeno-fingerprint"] = CHWID
	options.Headers["roblox-place-id"] = tostring(game.PlaceId)
	options.Headers["roblox-game-id"] = tostring(game.JobId)
	options.Headers["roblox-session-id"] = HttpService:JSONEncode({
		["GameId"] = tostring(game.JobId),
		["PlaceId"] = tostring(game.PlaceId)
	})

	local body, success, headers = RServer({0, tostring(options.Body), Urls.Server ..
		"/rq?c=" ..
		SupportedHTTPMethods[options.Method] --[[Method ID]] ..
		"&h=" .. HttpService:UrlEncode(fbase64.encode(HttpService:JSONEncode(options.Headers))) ..
		"&u=" .. HttpService:UrlEncode(fbase64.encode(options.Url))
	}, false, true)

	if not success then
		return {
			Success = false,
			StatusMessage = "Xeno Server Error: " .. tostring(body),
			StatusCode = 403,
			HttpError = Enum.HttpError.Unknown
		}
	end

	local xenoR = headers.xeno
	if not xenoR then
		return {
			Success = false,
			StatusMessage = "Server Response not found in Headers. " .. tostring(body),
			StatusCode = 417,
			Body = body,
			HttpError = Enum.HttpError.NetFail
		}
	end

	local response = HttpService:JSONDecode(xenoR)

	local success, EnumHttpError = xRenv.pcall(function()
		return Enum.HttpError[response[2]]
	end)

	return {
		StatusCode = tonumber(response[1]) or 403,
		StatusMessage = response[2],
		HttpError = (success and EnumHttpError) or Enum.HttpError.Unknown,
		Body = body,
		Version = response[3],
		Headers = response[4]
	}
end

Xeno.http = {request = Xeno.request}
Xeno.http_request = Xeno.request

function Xeno.HttpGet(url: string, returnRaw: boolean): string? | {}
	xRenv.assert(xRenv.type(url) == "string", "invalid argument #1 to 'HttpGet' (string expected, got " .. xRenv.type(url) .. ") ", 3)
	if returnRaw == nil then returnRaw = true end

	local result = Xeno.request({
		Url = url,
		Method = "GET",
		Headers = {["User-Agent"] = "Roblox/WinInetRobloxApp/" .. getfenv().version() .. " (GlobalDist; RobloxDirectDownload)"}
	})

	if returnRaw then
		return result.Body
	end

	return HttpService:JSONDecode(result.Body)
end

function Xeno.HttpPost(url: string, body: {}, contentType: string): string?
	xRenv.assert(xRenv.type(url) == "string", "invalid argument #1 to 'HttpPost' (string expected, got " .. xRenv.type(url) .. ") ", 3)
	if xRenv.type(contentType) ~= nil then
		xRenv.assert(xRenv.type(contentType) == "string", "invalid argument #3 to 'HttpPost' (string expected, got " .. xRenv.type(contentType) .. ") ", 3)
	end
	contentType = contentType or "application/json"

	return Xeno.request({
		Url = url,
		Method = "POST",
		body = body,
		Headers = {
			["User-Agent"] = "Roblox/WinInetRobloxApp/" .. getfenv().version() .. " (GlobalDist; RobloxDirectDownload)",
			["Content-Type"] = contentType
		}
	})
end

local gFuncMap = ProxyService.funcMap[xRenv.game]

gFuncMap.HttpGet = function(self, ...)
	return Xeno.HttpGet(...)
end
setfenv(gFuncMap.HttpGet, Xeno)
gFuncMap.HttpGetAsync = gFuncMap.HttpGet

gFuncMap.HttpPost = function(self, ...)
	return Xeno.HttpPost(...)
end
setfenv(gFuncMap.HttpPost, Xeno)
gFuncMap.HttpPostAsync = gFuncMap.HttpPost

gFuncMap.GetObjects = function(self, asset: number? | string?)
	return {Xeno.game:GetService("InsertService"):LoadLocalAsset((xRenv.typeof(asset) == "number" and "rbxassetid://" .. asset) or asset)}
end
setfenv(gFuncMap.GetObjects, Xeno)
------------------------------------------------
-- FILESYSTEM
local FilesystemErrs = {
	[0] = "Attempt To Escape Directory",
	[1] = "Expected Directory But Got File",
	[2] = "Expected File But Got Directory",
	[3] = "Directory Already Exists",
	[4] = "A File Exists With The Given Directory Name",
	[5] = "File Could Not Be Opened."
}

local FileType = {
	Directory = 0,
	File = 1,
	DoesNotExist = 3
}

local VirtualFiles = {
	["Files"] = {}, -- f{1: path, 2: isfolder}
	["ChangesQueue"] = {}
}

local function GetFileSystemError(errorCode: string): string?
	errorCode = tonumber(errorCode) or errorCode
	for i, v in next, FilesystemErrs do
		if i == errorCode then
			return v
		end
	end
	return errorCode
end

local function rListFiles(path: string) : {}
	local result, success = RServer({XFS.ListFiles, path})
	if not success then
		error(GetFileSystemError(result), 3)
	end
	return result
end

local function rIsFolder(path: string) : boolean
	local result, success = RServer({XFS.GetFileType, path})
	if not success then
		error(GetFileSystemError(result), 3)
	end
	result = tonumber(result) -- or result
	if result == FileType.Directory then
		return true
	end
	return false
end

local function rIsFile(path: string) : boolean
	local result, success = RServer({XFS.GetFileType, path})
	if not success then
		error(GetFileSystemError(result), 3)
	end
	result = tonumber(result)
	if result == FileType.File then
		return true
	end
	return false
end

do
	local showError = true
	local bindable = xRenv.Instance.new("BindableFunction")
	bindable.OnInvoke = function(opt)
		showError = false
	end

	local function SyncFiles()
		local newSave = {}

		local function GetAllFiles(dir)
			local files = rListFiles(dir)
			if #files < 1 then return end
			for _, filePath in files do
				local isFolder = rIsFolder(filePath)
				table.insert(newSave, {
					filePath,
					isFolder
				})
				if isFolder then
					GetAllFiles(filePath)
				end
			end
		end

		local success = xRenv.pcall(function()
			GetAllFiles("./")
		end)
		if not success and showError then
			StarterGui:SetCore("SendNotification", {
				Title = "[Xeno - VFS]",
				Text = 'Make sure Xeno is open otherwise your files will not save\nAnd scripts may not work!',
				Icon = xenoIconAsset,
				Duration = 4,
				Button1 = "Don't Show again",
				Callback = bindable
			})
			task.delay(.777, SyncFiles)
			return
		end

		VirtualFiles.Files = newSave

		local UnsuccessfulSaves = {}

		for _, ChangeQueue in pairs(VirtualFiles.ChangesQueue) do
			local funcId = ChangeQueue[1]
			local argX = ChangeQueue[2]
			local argY = ChangeQueue[3]
			local lastAttempt = ChangeQueue[4]

			if funcId == XFS.WriteFile then -- argX: Path, argY: Content
				local successX, _, successY = xRenv.pcall(function()
					return RServer{0, 
						tostring(argY),
						Urls.Server .. "/wf?c=" .. tostring(argX)
					}
				end)
				if not successX or not successY and not lastAttempt then
					table.insert(UnsuccessfulSaves, {
						funcId,
						argX,
						argY,
						true
					}) 
				end
				continue
			end

			if funcId == XFS.MakeFolder or 
				funcId == XFS.DelFolder or 
				funcId == XFS.DelFile then -- argX: Path, argY: nil
				local successX, _, successY = xRenv.pcall(function()
					return RServer{funcId, argX}
				end)
				if not successX or not successY and not lastAttempt then
					table.insert(UnsuccessfulSaves, {
						funcId,
						argX,
						argY,
						true
					})
				end
				continue
			end
		end

		VirtualFiles.ChangesQueue = UnsuccessfulSaves

		task.delay(.777, SyncFiles)
	end

	task.spawn(SyncFiles)
	task.spawn(function()
		local Players = xRenv.game:GetService("Players")
		local Player = Players.LocalPlayer or Players.PlayerAdded:Wait()

		Player.OnTeleport:Once(SyncFiles)
		xRenv.game.Close:Once(SyncFiles)
	end)
end

local function normalize_path(path: string): string
	if (path:sub(2, 2) ~= '/') then path = './' .. path end
	if (path:sub(1, 1) == '/') then path = '.' .. path end
	return path
end

local function getUnsaved(funcId: number, path: string): {} & number
	local unsaved = VirtualFiles.ChangesQueue
	for i, fileInfo in next, unsaved do
		if ('./' .. tostring(fileInfo[2]) == path or fileInfo[2] == path) and fileInfo[1] == funcId then
			return unsaved[i], i
		end
	end
end

local function getSaved(path: string): {}
	local saves = VirtualFiles.Files
	for i, fileInfo in next, saves do
		if fileInfo[1] == path or "./" .. tostring(fileInfo[1]) == path or normalize_path(tostring(fileInfo[1])) == path then
			return saves[i] -- return true, saves[i]
		end
	end
end

--[[
			[Index]
		[1]: functionID
		[2]: Path
		[3]: Content
]]

function Xeno.readfile(path: string): string?
	xRenv.assert(xRenv.type(path) == "string", "invalid argument #1 to 'readfile' (string expected, got " .. xRenv.type(path) .. ") ", 3)
	-- if writefile was recently called on the given path, return the pending save content.
	local unsavedFile = getUnsaved(XFS.WriteFile, path)
	if unsavedFile then
		return unsavedFile[3]
	end

	local result, success = RServer{XFS.ReadFile, path}
	if not success then
		error(GetFileSystemError(result), 3)
	end

	return result
end

function Xeno.writefile(path: string, content: string)
	xRenv.assert(xRenv.type(path) == "string", "invalid argument #1 to 'writefile' (string expected, got " .. xRenv.type(path) .. ") ", 3)
	xRenv.assert(xRenv.type(content) == "string", "invalid argument #2 to 'writefile' (string expected, got " .. xRenv.type(content) .. ") ", 3)

	-- cancel deletion of file
	local unsavedFile, index = getUnsaved(XFS.DelFile, path)
	if unsavedFile then
		table.remove(VirtualFiles.ChangesQueue, index)
	end

	-- if writefile was called before and its still pending on save, update the content.
	local unsavedFile = getUnsaved(XFS.WriteFile, path)
	if unsavedFile then
		unsavedFile[3] = content
		return
	end

	table.insert(VirtualFiles.ChangesQueue, {
		XFS.WriteFile,
		path,
		content
	})
end

function Xeno.appendfile(path: string, content: string)
	xRenv.assert(xRenv.type(path) == "string", "invalid argument #1 to 'appendfile' (string expected, got " .. xRenv.type(path) .. ") ", 3)
	xRenv.assert(xRenv.type(content) == "string", "invalid argument #2 to 'appendfile' (string expected, got " .. xRenv.type(content) .. ") ", 3)

	local unsavedFile = getUnsaved(XFS.WriteFile, path)
	if unsavedFile then
		unsavedFile[3] = unsavedFile[3] .. content
		return
	end

	local result, success = RServer{XFS.ReadFile, path}
	if not success then
		error(GetFileSystemError(result), 3)
	end

	Xeno.writefile(path, result .. content)
end

function Xeno.loadfile(path: string): () -> ... any
	xRenv.assert(xRenv.type(path) == "string", "invalid argument #1 to 'loadfile' (string expected, got " .. xRenv.type(path) .. ") ", 3)
	local source = Xeno.readfile(path)
	do
		if (source == "" or source == " ") then
			return function(...) end
		end
		local func, err = Xeno.loadstring(source, path)
		xRenv.pcall(setfenv, func, getfenv(xRenv.debug.info(2, 'f'))) -- func might be nil if theres compiler error.
		return func, err
	end
end
Xeno.dofile = Xeno.loadfile

function Xeno.isfolder(path: string): boolean
	xRenv.assert(xRenv.type(path) == "string", "invalid argument #1 to 'isfolder' (string expected, got " .. xRenv.type(path) .. ") ", 3)
	if getUnsaved(XFS.DelFolder, path) then
		return false
	end
	if getUnsaved(XFS.MakeFolder, path) then
		return true
	end
	--TODO: delete file & writefile check?
	local s, saved = getSaved(path)
	if s then
		return saved[2]
	end
	return rIsFolder(path)
end

function Xeno.isfile(path: string): boolean
	xRenv.assert(xRenv.type(path) == "string", "invalid argument #1 to 'isfile' (string expected, got " .. xRenv.type(path) .. ") ", 3)
	if getUnsaved(XFS.DelFile, path) then
		return false
	end
	if getUnsaved(XFS.WriteFile, path) then
		return true
	end
	--TODO: make folder & delete folder check?
	local s, saved = getSaved(path)
	if s then
		return not saved[2]
	end
	return rIsFile(path)
end

function Xeno.makefolder(path: string)
	xRenv.assert(xRenv.type(path) == "string", "invalid argument #1 to 'makefolder' (string expected, got " .. xRenv.type(path) .. ") ", 3)

	local f, i = getUnsaved(XFS.DelFolder, path)
	if f then
		table.remove(VirtualFiles.ChangesQueue, i)
	end

	if getUnsaved(XFS.MakeFolder, path) then
		return
	end

	table.insert(VirtualFiles.ChangesQueue, {
		XFS.MakeFolder,
		path
	})
end

function Xeno.delfolder(path: string)
	xRenv.assert(xRenv.type(path) == "string", "invalid argument #1 to 'delfolder' (string expected, got " .. xRenv.type(path) .. ") ", 3)

	local f, i = getUnsaved(XFS.MakeFolder, path)
	if f then
		table.remove(VirtualFiles.ChangesQueue, i)
		return
	end

	if getUnsaved(XFS.DelFolder, path) then
		return
	end

	table.insert(VirtualFiles.ChangesQueue, {
		XFS.DelFolder,
		path
	})
end

function Xeno.delfile(path: string)
	xRenv.assert(xRenv.type(path) == "string", "invalid argument #1 to 'delfile' (string expected, got " .. xRenv.type(path) .. ") ", 3)

	local f, i = getUnsaved(XFS.WriteFile, path)
	if f then
		table.remove(VirtualFiles.ChangesQueue, i)
	end

	if getUnsaved(XFS.DelFile, path) then
		return
	end

	table.insert(VirtualFiles.ChangesQueue, {
		XFS.DelFile,
		path
	})
end

function Xeno.listfiles(path: string): {}
	xRenv.assert(xRenv.type(path) == "string", "invalid argument #1 to 'listfiles' (string expected, got " .. xRenv.type(path) .. ") ", 3)

	path = normalize_path(path)
	if path:sub(-1) ~= '/' then path = path .. '/' end

	local files = {}

	for _, file in pairs(VirtualFiles.Files) do
		table.insert(files, normalize_path(file[1]))
	end

	for i, fpath in pairs(files) do
		for _, file in pairs(VirtualFiles.ChangesQueue) do
			if normalize_path(file[2]) == fpath and file[1] == XFS.DelFile or file[1] == XFS.DelFolder then
				table.remove(files, i)
				break
			end
		end
	end

	for _, file in pairs(VirtualFiles.ChangesQueue) do -- Unsaved Files
		if file[1] == XFS.DelFile or file[1] == XFS.DelFolder then
			continue
		end
		table.insert(files, normalize_path(file[2]))
	end

	local dirFiles = {}

	for _, fpath in pairs(files) do
		fpath = fpath:gsub('\\', '/')
		if fpath:sub(1, #path) == path then
			table.insert(dirFiles, fpath)
		end
	end

	for i, fpath in pairs(dirFiles) do
		for i2, v in pairs(dirFiles) do -- duplicate check
			if v == fpath and i ~= i2 then
				table.remove(dirFiles, i2)
				break
			end
		end
	end

	return dirFiles
end

function Xeno.getcustomasset(path: string): string?
	xRenv.assert(xRenv.type(path) == "string", "invalid argument #1 to 'getcustomasset' (string expected, got " .. xRenv.type(path) .. ") ", 3)

	local f, i = getUnsaved(XFS.WriteFile, path)
	if f then
		while true do -- yeahhh...... not the best way.... im gonna kms
			f, i = getUnsaved(XFS.WriteFile, path) -- could be updated in a different thread
			local result, success = RServer{0, 
				tostring(f[3]), -- i[1] = func id, i[2] = path, i[3] = content
				Urls.Server .. "/wf?c=" .. f[2] or path -- they are both the same
			}
			if success then
				table.remove(VirtualFiles.ChangesQueue, i)
				break
			end
			task.wait(.01)
		end
	end

	local result, success = RServer({XFS.GetCustomAsset, path}, true)
	if success then
		return result
	end
	error(result, 3)
end
-- FILESYSTEM END
------------------------------------------------
---- CLOSURES
function Xeno.checkcaller(): boolean
	return xRenv.debug.info(1, 'slnaf') == xRenv.debug.info(Xeno.getgenv, 'slnaf')
end

function Xeno.hookfunction(funcX: () -> ...any, funcY: () -> ...any): () -> ...any
	xRenv.assert(xRenv.type(funcX) == "function", "invalid argument #1 to 'hookfunction' (function expected, got " .. xRenv.type(funcX) .. ") ", 3)
	xRenv.assert(xRenv.type(funcY) == "function", "invalid argument #2 to 'hookfunction' (function expected, got " .. xRenv.type(funcY) .. ") ", 3)
	local env = getfenv(xRenv.debug.info(2, 'f'))
	for i, v in env do
		if v == funcX then
			env[i] = funcY
			return funcY
		end
	end
	for i, v in Xeno do
		if v == funcX then
			Xeno[i] = funcY
			return funcY
		end
	end
end
Xeno.replaceclosure = Xeno.hookfunction

function Xeno.clonefunction(func: () -> ...any): () -> ...any
	xRenv.assert(xRenv.type(func) == "function", "invalid argument #1 to 'clonefunction' (function expected, got " .. xRenv.type(func) .. ") ", 3)
	if Xeno.iscclosure(func) then
		return Xeno.newcclosure(func)
	end
	return Xeno.newlclosure(func)
end

function Xeno.newcclosure(func: (...any?) -> (...any?)): (...any?) -> (...any?) -- thanks to razzoni for the improvement of this function
	xRenv.assert(xRenv.type(func) == "function", "invalid argument #1 to 'newcclosure' (function expected, got " .. xRenv.type(func) .. ") ", 3);
	if Xeno.iscclosure(func) then
		return func
	end
	return coroutine.wrap(function(...)
		while true do
			coroutine.yield(func(...))
		end
	end)
end

function Xeno.iscclosure(func: () -> ...any): boolean
	xRenv.assert(xRenv.type(func) == "function", "invalid argument #1 to 'iscclosure' (function expected, got " .. xRenv.type(func) .. ") ", 3)
	if func == Xeno.warn or func == Xeno.print then -- Because we are overwriting these two functions
		return true
	end
	return xRenv.debug.info(func, 's') == "[C]"
end

function Xeno.newlclosure(func: () -> ...any): () -> ...any  -- thanks to razzoni for the improvement of this function
	xRenv.assert(xRenv.type(func) == "function", "invalid argument #1 to 'newlclosure' (function expected, got " .. xRenv.type(func) .. ") ", 3)
	local closure = function(...) return func(...) end
	setfenv(closure, getfenv(func));
	return closure
end

function Xeno.islclosure(func: () -> ...any): boolean
	xRenv.assert(xRenv.type(func) == "function", "invalid argument #1 to 'islclosure' (function expected, got " .. xRenv.type(func) .. ") ", 3)
	return not Xeno.iscclosure(func)
end

function Xeno.isexecutorclosure(func: () -> ...any): boolean
	xRenv.assert(xRenv.type(func) == "function", "invalid argument #1 to 'isexecutorclosure' (function expected, got " .. xRenv.type(func) .. ") ", 3)
	if func == Xeno.warn or func == Xeno.print then -- Because we are overwriting these two functions
		return false
	end
	if Xeno.iscclosure(func) then
		return #xRenv.debug.info(func, 'n') < 1
	end
	return xRenv.debug.info(func, 's') == xRenv.script:GetFullName() or
		(Xeno.typeof(getfenv(func).script) == "Instance" and getfenv(func).script:GetFullName() == "LocalScript")
end
Xeno.checkclosure = Xeno.isexecutorclosure
Xeno.isourclosure = Xeno.isexecutorclosure
---- CLOSURES END
---------------------------------------------------
-- MISCELLANEOUS
function Xeno.queue_on_teleport(source)
	xRenv.assert(xRenv.type(source) == "string", "invalid argument #1 to 'queue_on_teleport' (string expected, got " .. xRenv.type(source) .. ") ", 3)
	RServer {
		0,
		source,
		Urls.Server .. "/qt?p=" .. XENO_PID
	}
end
Xeno.queueonteleport = Xeno.queue_on_teleport

function Xeno.setclipboard(content)
	xRenv.assert(content ~= nil, "Attempt to set nil to clipboard", 3)
	content = tostring(content)
	if #content < 1 then return end
	RServer {
		0,
		content,
		Urls.Server .. "/cb"
	}
end
Xeno.toclipboard = Xeno.setclipboard
Xeno.setrbxclipboard = Xeno.setclipboard

type InstanceToHook = Instance
function Xeno.hookinstance(i1: InstanceToHook, i2: Instance)
	i1 = ProxyService:Get(i1)
	i2 = ProxyService:Get(i2)
	xRenv.assert(xRenv.typeof(i1) == "Instance", "invalid argument #1 to 'hookinstance' (Instance expected, got " .. xRenv.typeof(i1) .. ") ", 3)
	xRenv.assert(xRenv.typeof(i2) == "Instance", "invalid argument #2 to 'hookinstance' (Instance expected, got " .. xRenv.typeof(i2) .. ") ", 3)
	local success, result = xRenv.pcall(function() return Xeno.game:FindService(i1.ClassName) end)
	xRenv.assert(not (success and result), "Can't hook a service", 3)
	xRenv.assert(i1 ~= xRenv.game, "Can't hook DataModel", 3)
	local i1ptr = createInstancePointer(i1)
	local i2ptr = createInstancePointer(i2)
	local options: HttpRequestOptions = {
		Url = Urls.Server .. '/f?e=' .. XFS.HookInstance,
		Body = HttpService:JSONEncode {
			c = i1ptr.Name,
			c2 = i2ptr.Name,
			p = XENO_PID
		},
		Method = 'POST'
	}
	SendRequest(options)
	i1ptr:Destroy()
	i2ptr:Destroy()
end
Xeno.Xeno.hookinstance = Xeno.hookinstance

function Xeno.getinstanceaddress(instance: Instance, asHex: boolean?): number? | string?
	if asHex == nil then asHex = true end

	instance = ProxyService:Get(instance)
	xRenv.assert(xRenv.typeof(instance) == "Instance", "invalid argument #1 to 'getinstanceaddress' (Instance expected, got " .. xRenv.typeof(instance) .. ") ", 3)
	local instancePtr = createInstancePointer(instance)
	local result = RServer({XFS.GetInstanceAddress, instancePtr.Name}, true)
	instancePtr:Destroy()

	local address = tonumber(result) or result

	if address == nil or address == '' then
		return 0
	end

	if asHex then
		return string.format("0x%x", address)
	end

	return address
end
Xeno.Xeno.getinstanceaddress = Xeno.getinstanceaddress

function Xeno.cloneref(instance: Instance): Instance
	xRenv.assert(Xeno.typeof(instance) == "Instance", "invalid argument #1 to 'cloneref' (Instance expected, got " .. Xeno.typeof(instance) .. ") ", 3)
	local realInstance = ProxyService:Get(instance)
	instance = ProxyService:Instance(realInstance, ProxyService.funcMap[realInstance], true)
	ProxyService.Map[instance] = realInstance
	return instance
end

function Xeno.compareinstances(instanceA: Instance, instanceB: Instance): boolean
	return ProxyService:Get(instanceA) == ProxyService:Get(instanceB)
end

local saveinstanceF = nil
function Xeno.saveinstance(options)
	options = options or {}
	xRenv.assert(xRenv.type(options) == "table", "invalid argument #1 to 'saveinstance' (table expected, got " .. xRenv.type(options) .. ") ", 3)
	saveinstanceF = saveinstanceF or Xeno.loadstring(Xeno.HttpGet("https://raw.githubusercontent.com/luau/SynSaveInstance/main/saveinstance.luau", true), "saveinstance")()
	return saveinstanceF(options)
end
Xeno.savegame = Xeno.saveinstance

function Xeno.setfflag(x, y)
	return xRenv.game:DefineFastFlag(x, y)
end

function Xeno.getfflag(x)
	return xRenv.game:GetFastFlag(x)
end

function Xeno.getexecutorname()
	return "Xeno"
end

function Xeno.getexecutorversion()
	return Xeno.about.Version
end
function Xeno.identifyexecutor()
	return Xeno.getexecutorname(), Xeno.getexecutorversion()
end
Xeno.whatexecutor = Xeno.identifyexecutor

local _cache = {}
Xeno.cache = { -- Uhh.... LMAO
	invalidate = function(instance: Instance)
		_cache[instance] = true
		instance.Parent = nil
	end,
	iscached = function(instance: Instance): boolean
		if _cache[instance] then
			return false
		end
		return not instance:IsDescendantOf(Xeno.game)
	end,
	replace = function(instanceA: Instance, instanceB: Instance)
		if _cache[instanceA] then
			_cache[instanceA] = instanceB
			_cache[instanceB] = _cache[instanceA]
		end
		instanceB.Parent = instanceA.Parent
		instanceB.Name = instanceA.Name
		instanceA.Parent = nil
	end
}

function Xeno.getsenv(Script: Instance): {} -- Let's not talk about this...
	return {script=Script}
end

local fhui = xRenv.Instance.new("Folder", CoreGui)
fhui.Name = "HUI"
local hui = ProxyService:Instance(fhui, {})
function Xeno.gethui()
	return Xeno.cloneref(hui)
end

function Xeno.isnetworkowner(Part)
	Part = ProxyService:Get(Part)
	xRenv.assert(xRenv.typeof(Part) == "Instance", "invalid argument #1 to 'isnetworkowner' (Instance expected, got " .. xRenv.typeof(Part) .. ")", 3)

	if Part.Anchored then
		return false
	end
	return Part.ReceiveAge == 0
end

local fpscap = math.huge

function Xeno.setfpscap(cap)
	cap = tonumber(cap)
	xRenv.assert(xRenv.type(tonumber(cap)) == "number", "invalid argument #1 to 'setfpscap' (number expected, got " .. xRenv.type(cap) .. ")", 3)
	if cap < 1 then cap = math.huge end
	fpscap = cap
end

local t = tick()
xRenv.game:GetService("RunService").RenderStepped:Connect(function()
	while t + 1 / fpscap > tick() do end
	t = tick()
	task.wait()
end)

function Xeno.getfpscap(): number
	return fpscap
end

function Xeno.getscripthash(Script: ProxiedInstance): string? -- !!
	xRenv.assert(Xeno.typeof(Script) == "Instance", "invalid argument #1 to 'getscripthash' (Instance expected, got " .. Xeno.typeof(Script) .. ")", 3)
	xRenv.assert(Script.ClassName == "LocalScript" or Script.ClassName == "ModuleScript", 
		"invalid 'ClassName' for 'Instance' #1 to 'setscriptbytecode' (LocalScript or ModuleScript expected, got '" .. Script.ClassName .. "') ", 3)
	return Xeno.crypt.hash(Xeno.getscriptbytecode(Script), 'sha-256');
end

function Xeno.getscriptclosure(Script: Instance): {}?  -- !
	xRenv.assert(Xeno.typeof(Script) == "Instance", "invalid argument #1 to 'getscriptclosure' (Instance expected, got " .. Xeno.typeof(Script) .. ")", 3)
	return function()
		return table.clone(Xeno.require(Script))
	end
end
Xeno.getscriptfunction = Xeno.getscriptclosure

function Xeno.isreadonly(t: {}): boolean
	xRenv.assert(xRenv.type(t) == "table", "invalid argument #1 to 'isreadonly' (table expected, got " .. xRenv.type(t) .. ") ", 3)
	return table.isfrozen(t)
end
function Xeno.setreadonly(t: {}) -- !
	return table.clone(t)
end

function Xeno.setsimulationradius(newRadius, newMaxRadius)
	newRadius = tonumber(newRadius)
	newMaxRadius = tonumber(newMaxRadius) or newRadius
	xRenv.assert(type(newRadius) == "number", "invalid argument #1 to 'setsimulationradius' (number expected, got " .. type(newRadius) .. ") ", 3)
	local player = Xeno.game:GetService("Players").LocalPlayer
	if not player then return end

	player.SimulationRadius = newRadius
	player.MaximumSimulationRadius = newMaxRadius or newRadius
end

function Xeno.getsimulationradius() -- thanks to razzoni for a not implemented func
	local Player = Xeno.game:GetService('Players').LocalPlayer
	local SimulationRadius = Player.SimulationRadius
	xRenv.assert(SimulationRadius ~= nil, "Simulation radious is nil", 3)
	return SimulationRadius
end

function Xeno.fireproximityprompt(proximityprompt: Instance, amount: number, skip: boolean) -- inspired from incog
	proximityprompt = ProxyService:Get(proximityprompt)
	xRenv.assert(xRenv.typeof(proximityprompt) == "Instance", "invalid argument #1 to 'fireproximityprompt' (Instance expected, got " .. xRenv.typeof(proximityprompt) .. ") ", 3)
	xRenv.assert(proximityprompt:IsA("ProximityPrompt"), "invalid argument #1 to 'fireproximityprompt' (Class ProximityPrompt expected, got " .. proximityprompt.ClassName .. ") ", 3)

	amount = tonumber(amount) or 1

	xRenv.assert(xRenv.type(amount) == "number", "invalid argument #2 to 'fireproximityprompt' (number expected, got " .. xRenv.type(amount) .. ") ", 3)

	skip = skip or false

	local oHoldDuration = proximityprompt.HoldDuration
	local oMaxDistance = proximityprompt.MaxActivationDistance

	proximityprompt.MaxActivationDistance = 9e9
	proximityprompt:InputHoldBegin()

	for i = 1, amount do
		if skip then
			proximityprompt.HoldDuration = 0
			continue
		end
		task.wait(proximityprompt.HoldDuration + 0.03)
	end

	proximityprompt:InputHoldEnd()
	proximityprompt.HoldDuration = oHoldDuration
	proximityprompt.MaxActivationDistance = oMaxDistance
end
function Xeno.fireclickdetector(Part: Instance) -- inspired from incog
	Part = ProxyService:Get(Part)
	xRenv.assert(xRenv.typeof(Part) == "Instance", "invalid argument #1 to 'fireclickdetector' (Instance expected, got " .. xRenv.typeof(Part) .. ") ", 3)

	local ClickDetector = Part:FindFirstChildOfClass("ClickDetector") or Part
	local oParent = ClickDetector.Parent

	local nPart = xRenv.Instance.new("Part")
	do
		nPart.Transparency = 1
		nPart.Size = Vector3.new(30, 30, 30)
		nPart.Anchored = true
		nPart.CanCollide = false
	end

	ClickDetector.Parent = nPart
	ClickDetector.MaxActivationDistance = math.huge

	local VirtualUser = xRenv.game:GetService("VirtualUser")
	local Camera = xRenv.workspace.CurrentCamera

	local Connection = xRenv.game:GetService("RunService").PreRender:Connect(function() 
		nPart.CFrame = Camera.CFrame * CFrame.new(0, 0, -20) * CFrame.new(Camera.CFrame.LookVector.X, Camera.CFrame.LookVector.Y, Camera.CFrame.LookVector.Z)
		VirtualUser:ClickButton1(Vector2.new(20, 20), Camera.CFrame)
	end)

	ClickDetector.MouseClick:Once(function()
		Connection:Disconnect()
		ClickDetector.Parent = oParent
		nPart:Destroy()
	end)

	task.delay(5, pcall, function()
		Connection:Disconnect()
		if ClickDetector.Parent == nPart then
			ClickDetector.Parent = oParent
		end
		nPart:Destroy()
	end)
end

local touchCache, ptp = {}, function(p1: Part, p2: Part, cf: CFrame, lv: boolean)
	if cf then
		return xRenv.game:GetService("RunService").PreRender:Connect(function()
			if lv then p1.CFrame = p2.CFrame lv = false else p1.CFrame = cf lv = true end
		end)
	end
	return xRenv.game:GetService("RunService").PreRender:Connect(function()
		p1.CFrame = p2.CFrame
	end)
end
function Xeno.firetouchinterest(toucher: Part, to_touch: Part, state: number)
	toucher = ProxyService:Get(toucher) :: Rizve -- dont worry about it
	to_touch = ProxyService:Get(to_touch)
	xRenv.assert(xRenv.typeof(toucher) == "Instance", "invalid argument #1 to 'firetouchinterest' (Instance expected, got " .. xRenv.typeof(toucher) .. ") ")
	xRenv.assert(xRenv.typeof(to_touch) == "Instance", "invalid argument #2 to 'firetouchinterest' (Instance expected, got " .. xRenv.typeof(to_touch) .. ") ")
	xRenv.assert(xRenv.type(state) == "number", "invalid argument #3 to 'firetouchinterest' (number expected, got " .. xRenv.type(state) .. ") ")

	if to_touch.Parent and to_touch.Parent:FindFirstChildOfClass("Humanoid") then
		toucher, to_touch = to_touch, toucher
	end

	local tinfo = touchCache[to_touch] -- [t[1]: Toucher, t[2]: State, t[3]: Thread]
	if tinfo then
		if tinfo[1] == toucher and tinfo[2] == state then return end -- function was called previously
		repeat task.wait() until coroutine.status(tinfo[3]) == "dead"
	end

	touchCache[to_touch] = {toucher, state, task.spawn(function()
		local cf, cc, tf = to_touch.CFrame, to_touch.CanCollide, to_touch.Transparency
		local et, tv = if state == 0 then "Touched" else "TouchEnded", false
		local connection = to_touch[et]:Connect(function() tv = true end)

		to_touch.CanCollide = false
		to_touch.Transparency = 1

		if state == 0 then
			local connection2 = ptp(to_touch, toucher)
			task.wait(.001)
			connection2:Disconnect() -- var 'tv' should be true
		end

		if not tv then
			local connection2, t = if state == 0 then ptp(to_touch, toucher, cf, false) else ptp(to_touch, toucher, cf, true), tick()
			repeat task.wait() until tv or tick() - t > 0.3
			connection2:Disconnect()
		end

		if state == 0 then
			to_touch.CFrame = cf
		end

		to_touch.CanCollide = cc
		to_touch.Transparency = tf

		connection:Disconnect()
		touchCache[to_touch] = nil
	end)}
end

function Xeno.getrunningscripts(): {} -- thanks to razzoni for the optimization of this function
	local scripts = {};
	for _, Descendant in Xeno.game:GetDescendants() do
		if Descendant.ClassName == "LocalScript" and Descendant.Enabled then
			table.insert(scripts, Descendant);
		elseif Descendant.ClassName == "Script" and Descendant.RunContext == Enum.RunContext.Client and Descendant.Enabled then
			table.insert(scripts, Descendant);
		end
	end

	xRenv.assert(#scripts ~= 0 and scripts[1] ~= nil, "No running scripts available", 3)

	return scripts
end

function Xeno.getscripts(): {}  -- thanks to razzoni for the optimization of this function
	local scripts = {};

	for _, Descendant in Xeno.game:GetDescendants() do
		if Descendant.ClassName == 'LocalScript' or Descendant.ClassName == 'ModuleScript' then
			table.insert(scripts, Descendant);
		elseif Descendant.ClassName == 'Script' and Descendant.RunContext == Enum.RunContext.Client then
			table.insert(scripts, Descendant);
		end
	end

	xRenv.assert(#scripts ~= 0 and scripts[1] ~= nil, "No scripts available", 3)

	return scripts
end

function Xeno.getloadedmodules(ExcludeCore: boolean?): {}  -- thanks to razzoni for the optimization of this function
	local loaded = {};

	if ExcludeCore == true then
		for _, Descendant in Xeno.game:GetDescendants() do
			if Descendant.ClassName == 'ModuleScript' or Descendant.ClassName == 'CoreScript' then
				table.insert(loaded, Descendant);
			end
		end
	else
		for _, Descendant in Xeno.game:GetDescendants() do
			if Descendant.ClassName == 'ModuleScript' then
				table.insert(loaded, Descendant);
			end
		end
	end

	if #loaded == 0 and loaded[1] == nil then
		error('No modules available', 2);	
	end

	xRenv.assert(#loaded ~= 0 and loaded[1] ~= nil, "No modules available", 3)

	return loaded
end

function Xeno.getcallingscript()
	for lvl = 3, 0, -1 do
		local f = xRenv.debug.info(lvl, 'f')
		if not f then 
			continue
		end

		local s = rawget(getfenv(f), "script")
		if s:IsA("BaseScript") then
			return s
		end
	end
end

-- thanks to razzoni for the improvement of getgc and getnilinstances

local nilInstances = {};
local gc = setmetatable({}, {['__mode'] = 'kv'});

task.spawn(function()
	repeat task.wait()
	until Xeno.game

	Xeno.game.DescendantAdded:Connect(function(descendant)
		table.insert(gc, descendant);
	end)

	Xeno.game.DescendantRemoving:Connect(function(descendant)
		table.insert(nilInstances, descendant);
		table.insert(gc, descendant);

		delay(30, function() -- prevent overflow
			local index = table.find(nilInstances, descendant)
			if index then
				table.remove(nilInstances, index)
			end
		end)
	end)
end)

function Xeno.getinstances(): {Instance}
	local Instances = {};

	for i,v in Xeno.game:GetDescendants() do
		table.insert(Instances, v);
	end;

	for i,v in nilInstances do
		table.insert(Instances, v)
	end

	return Instances
end

function Xeno.getgc(IncludeTables): {any}
	local sys = {Xeno.Instance.new("Part")};

	if IncludeTables then
		for i,v in gc do
			table.insert(sys, v);
		end
	else
		for i,v in gc do
			if xRenv.type(v) == 'table' then
				continue;
			end

			table.insert(sys, v)
		end
	end

	return sys
end

function Xeno.getnilinstances(): {Instance}
	local nil_instances = {};

	for i,v in Xeno.getinstances() do -- nilInstances is presented there
		if v.Parent == nil then
			table.insert(nil_instances, v);
		end
	end

	return nil_instances
end

Xeno.debug = table.clone(debug)
function Xeno.debug.getinfo(f, options)
	if type(options) == "string" then
		options = string.lower(options) 
	else
		options = "sflnu"
	end
	local result = {}
	for index = 1, #options do
		local option = string.sub(options, index, index)
		if "s" == option then
			local short_src = xRenv.debug.info(f, "s")
			result.short_src = short_src
			result.source = "=" .. short_src
			result.what = if short_src == "[C]" then "C" else "Lua"
		elseif "f" == option then
			result.func = xRenv.debug.info(f, "f")
		elseif "l" == option then
			result.currentline = xRenv.debug.info(f, "l")
		elseif "n" == option then
			result.name = xRenv.debug.info(f, "n")
		elseif "u" == option or option == "a" then
			local numparams, is_vararg = xRenv.debug.info(f, "a")
			result.numparams = numparams
			result.is_vararg = if is_vararg then 1 else 0
			if "u" == option then
				result.nups = -1
			end
		end
	end
	return result
end

function Xeno.debug.getprotos()
	return setmetatable({}, {
		__call = function()
			return true
		end,
		__index = function()
			return function()
				return true
			end
		end,
	})
end
Xeno.debug.getproto = Xeno.debug.getprotos

function Xeno.debug.getconstant(func, i)
	local ft = {"print", nil, "Hello, world!"}
	return ft[i]
end
function Xeno.debug.getconstants(func)
	return {50000, "print", nil, "Hello, world!", "warn"}
end

function Xeno.debug.getstack(level, index)
	if index then
		return "ab"
	else
		return {"ab"}
	end
end

function Xeno.debug.getupvalue()
	return nil
end

function Xeno.debug.setconstant()
	return nil
end

function Xeno.debug.setstack()
	return nil
end

function Xeno.debug.setupvalue()
	return nil
end

--[[
function Xeno.getconnections() -- https://cdn.discordapp.com/attachments/1279163173005561929/1284267039854166026/attachment.gif?ex=68737ea2&is=68722d22&hm=06dab68c30ad50619b2d88bafc65e5eb4c7ae87fbc541222999d17ff71231892&
	return {{
		Enabled = true, 
		ForeignState = false, 
		LuaConnection = true, 
		Function = function()end,
		Thread = task.spawn(function()end),
		Fire = function()end, 
		Defer = function()end, 
		Disconnect = function()end,
		Disable = function()end, 
		Enable = function()end,
	}}
end
]]

-- thanks to razzoni for the improvement of getconnections

export type Connection = {
	Enabled: boolean,
	ForeignState: boolean,
	LuaConnection: boolean,

	Function: (() -> ())?,
	Thread: thread?,

	Disconnect: () -> void,
	Disable: () -> void,
	Enable: () -> void,

	Fire: (...any) -> void,
	Defer: (...any) -> void
};

function Xeno.getconnections(Event: RBXScriptSignal): {Connection}
	xRenv.assert(Xeno.typeof(Event) == 'RBXScriptSignal', "invalid argument #1 to 'getconnections' (expected RBXScriptSignal got " .. Xeno.typeof(Event) .. ")", 3)

	local MainConnection = {};
	local Connection; Connection = Event:Connect(function() end);

	local OldFunction = Connection;

	local Connections = {
		['Enabled'] = true,
		['ForeignState'] = false,
		['LuaConnection'] = true,

		['Function'] = function() return Connection end,
		['Thread'] = task.spawn(function() end),
		['Disconnect'] = function() Connection:Disconnect() end,

		['Fire'] = function(...: any?) if Connection['Enabled'] and Connection['Function'] then Connection['Function'](...) end end,
		['Defer'] = function(...: any?) if Connection['Enabled'] and Connection['Function'] then task.defer(Connection['Function'], ...) end end,
	};

	Connections.Disable = function()
		Connections['Enabled'] = false
		Connections['Function'] = nil
	end

	Connections.Enable = function()
		Connections['Enabled'] = true
		Connections['Function'] = OldFunction
	end

	if Connections['ForeignState'] == true then
		-- ForeignState means if the connection came from a CoreScript.
		Connections['Function'] = nil;
		Connections['Thread'] = nil;
	end

	table.insert(MainConnection, Connections);
	return MainConnection
end;

local fIdentity = 3

function Xeno.getthreadcontext()
	return fIdentity
end
Xeno.getthreadidentity = Xeno.getthreadcontext
Xeno.getidentity = Xeno.getthreadcontext

function Xeno.setthreadidentity(x)
	xRenv.assert(xRenv.type(x) == 'number', "invalid argument #1 to 'setthreadidentity' (expected number got ".. xRenv.type(x) .. ")", 3)
	fIdentity = tonumber(x) or fIdentity
end
Xeno.setidentity = Xeno.setthreadidentity
Xeno.setthreadcontext = Xeno.setthreadidentity


---------------------------------------------------
-- INPUT
local rbxactive = true
UserInputService.WindowFocused:Connect(function()
	rbxactive = true
end)
UserInputService.WindowFocusReleased:Connect(function()
	rbxactive = false
end)
function Xeno.isrbxactive()
	return rbxactive
end
Xeno.isgameactive = Xeno.isrbxactive
Xeno.iswindowactive = Xeno.isrbxactive

local function ProcessInput(InputType, x, y, z)
	--if not rbxactive then return end
	local concat = ''
	if x then --[[xRenv.assert(xRenv.type(tonumber(x)) == 'number', "'x' must be a number", 3)]] concat = "&x=" .. x end
	if y then --[[xRenv.assert(xRenv.type(tonumber(y)) == 'number', "'y' must be a number", 3)]] concat = concat .. "&y=" .. y end
	if z then concat = concat .. "&z=" .. z end
	RServer {
		0,
		'',
		Urls.Server .. "/ip?c=" .. InputType .. concat
	}
end

function Xeno.mouse1click()
	ProcessInput(XInputType.mouse1click)
end
function Xeno.mouse1press()
	ProcessInput(XInputType.mouse1press)
end
function Xeno.mouse1release()
	ProcessInput(XInputType.mouse1release)
end

function Xeno.mouse2click()
	ProcessInput(XInputType.mouse2click)
end
function Xeno.mouse2press()
	ProcessInput(XInputType.mouse2press)
end
function Xeno.mouse2release()
	ProcessInput(XInputType.mouse2release)
end

function Xeno.mousemoveabs(x: number, y: number)
	xRenv.assert(xRenv.type(tonumber(x)) == "number", "invalid argument #1 to 'mousemoveabs' (number expected, got " .. xRenv.type(x) .. ")", 3)
	xRenv.assert(xRenv.type(tonumber(y)) == "number", "invalid argument #2 to 'mousemoveabs' (number expected, got " .. xRenv.type(y) .. ")", 3)
	ProcessInput(XInputType.mousemoveabs, x, y, XENO_PID)
end
function Xeno.mousemoverel(x: number, y: number)
	xRenv.assert(xRenv.type(tonumber(x)) == "number", "invalid argument #1 to 'mousemoverel' (number expected, got " .. xRenv.type(x) .. ")", 3)
	xRenv.assert(xRenv.type(tonumber(y)) == "number", "invalid argument #2 to 'mousemoverel' (number expected, got " .. xRenv.type(y) .. ")", 3)
	ProcessInput(XInputType.mousemoverel, x, y)
end

function Xeno.mousescroll(px: number)
	xRenv.assert(xRenv.type(tonumber(px)) == "number", "invalid argument #1 to 'mousescroll' (number expected, got " .. xRenv.type(px) .. ")", 3)
	ProcessInput(XInputType.mousescroll, px)
end

local blockedKeys = {
	0x5b, -- L-WINDOWS
	0x5c, -- R-WINDOWS
	0x1b, -- ESC
}

function Xeno.keypress(key: number)
	xRenv.assert(xRenv.type(tonumber(key)) == "number", "invalid argument #1 to 'keypress' (number expected, got " .. xRenv.type(key) .. ")", 3)
	xRenv.assert(not table.find(blockedKeys, key), "Key is not allowed", 3)
	ProcessInput(XInputType.keypress, key)
end
function Xeno.keyrelease(key: number)
	xRenv.assert(xRenv.type(tonumber(key)) == "number", "invalid argument #1 to 'keyrelease' (number expected, got " .. xRenv.type(key) .. ")", 3)
	xRenv.assert(not table.find(blockedKeys, key), "Key is not allowed", 3)
	ProcessInput(XInputType.keyrelease, key)
end

local Input = {} -- https://github.com/TheEpicFace007/pedohurt-funnies/blob/main/init/sirhurt_init.lua#L652
Input.LeftClick = function(action) if action == 'MOUSE_DOWN' then Xeno.mouse1press() elseif action == 'MOUSE_UP' then Xeno.mouse1release() end end
Input.MoveMouse = function(x, y) Xeno.mousemoverel(x, y) end
Input.ScrollMouse = function(int) Xeno.mousescroll(int) end
Input.KeyPress = function(key) Xeno.keypress(key) Xeno.keyrelease(key) end
Input.KeyDown = function(key) Xeno.keypress(key) end
Input.KeyUp = function(key) Xeno.keyrelease(key) end
Xeno.Input = Input

-- INPUT END
------------------------------------------------
-- RCONSOLE
function Xeno.consolecreate() -- Maybe add 'is created' check (client sided) for lower latency?
	RServer {
		0,
		'',
		Urls.Server .. "/rc?c=" .. XRCType.consolecreate
	}
end
function Xeno.consoledestroy()
	RServer {
		0,
		'',
		Urls.Server .. "/rc?c=" .. XRCType.consoledestroy
	}
end
function Xeno.consoleclear()
	RServer {
		0,
		'',
		Urls.Server .. "/rc?c=" .. XRCType.consoleclear
	}
end

function Xeno.consolename(name: string)
	xRenv.assert(xRenv.type(name) == "string", "invalid argument #1 to 'consolename' (string expected, got " .. xRenv.type(name) .. ")", 3)
	RServer {
		0,
		name,
		Urls.Server .. "/rc?c=" .. XRCType.consolename
	}
end

local function GetConsoleContent(...)
	local content = '[' .. (xRenv.game:GetService("Players").LocalPlayer or xRenv.game:GetService("Players").PlayerAdded:Wait()).Name .. ']: '
	local args = {...}
	xRenv.assert(#args >= 1, "No argument provided", 3)
	for _, arg in args do
		content = content .. tostring(arg) .. ' '
	end
	return content
end

function Xeno.consoleprint(...)
	RServer {
		0,
		GetConsoleContent(...),
		Urls.Server .. "/rc?c=" .. XRCType.consoleprint
	}
end

function Xeno.consoleinfo(...)
	RServer {
		0,
		GetConsoleContent(...),
		Urls.Server .. "/rc?c=" .. XRCType.consoleinfo
	}
end

function Xeno.consolewarn(...)
	RServer {
		0,
		GetConsoleContent(...),
		Urls.Server .. "/rc?c=" .. XRCType.consolewarn
	}
end

function Xeno.consoleerror(...)
	RServer {
		0,
		GetConsoleContent(...),
		Urls.Server .. "/rc?c=" .. XRCType.consoleerror
	}
end

function Xeno.consoleinput() -- Bad management on C side
	local result = RServer { -- func RServer -> Result, Success
		0,
		'',
		Urls.Server .. "/rc?c=" .. XRCType.consoleinput
	}
	return result
end

Xeno.rconsolecreate = Xeno.consolecreate
Xeno.rconsoledestroy = Xeno.consoledestroy
Xeno.rconsoleclear = Xeno.consoleclear

Xeno.rconsolename = Xeno.consolename
Xeno.consolesettitle = Xeno.consolename
Xeno.rconsolesettitle = Xeno.consolename

Xeno.rconsoleprint = Xeno.consoleprint
Xeno.rconsoleinfo = Xeno.consoleinfo
Xeno.rconsolewarn = Xeno.consolewarn
Xeno.rconsoleerror = Xeno.consoleerror

Xeno.rconsoleinput = Xeno.consoleinput
-- RCONSOLE END
------------------------------------------------
-- LIBRARIES
-- CRYPT
Xeno.crypt = {}

local function ProcessBase64(content, en)
	local result, success = RServer {
		0,
		content,
		Urls.Server .. "/b64?c=" .. en
	}

	if not success then
		error(result, 3)
	end

	return result
end

Xeno.base64 = { -- add checks for if its a string?
	encode = function(content)
		return ProcessBase64(content, XSB4Tps.Encode)
	end,
	decode = function(content)
		return ProcessBase64(content, XSB4Tps.Decode)
	end,
}
Xeno.crypt.base64 = Xeno.base64

Xeno.crypt.base64encode = Xeno.base64.encode
Xeno.crypt.base64_encode = Xeno.base64.encode
Xeno.base64_encode = Xeno.base64.encode

Xeno.crypt.base64decode = Xeno.base64.decode
Xeno.crypt.base64_decode = Xeno.base64.decode
Xeno.base64_decode = Xeno.base64.decode

local function getEncMode(mode: string) mode = mode:upper()
	local modeEnum
	for i, v in XSENModes do
		if i == mode then
			modeEnum = v
			break
		end
	end
	xRenv.assert(modeEnum ~= nil, "Invalid mode", 3)
	return modeEnum
end

function Xeno.crypt.encrypt(data: string, key: string, iv: string?, mode: string)
	xRenv.assert(xRenv.type(data) == "string", "invalid argument #1 to 'encrypt' (string expected, got " .. xRenv.type(data) .. ")", 3)
	xRenv.assert(xRenv.type(key) == "string", "invalid argument #2 to 'encrypt' (string expected, got " .. xRenv.type(key) .. ")", 3)
	xRenv.assert(xRenv.type(mode) == "string", "invalid argument #4 to 'encrypt' (string expected, got " .. xRenv.type(mode) .. ")", 3)
	iv = iv or ''
	iv = tostring(iv)

	local result, success, headers = RServer({
		0,
		data,
		Urls.Server .. "/cr?c=" .. XCTps.Encrypt .. "&k=" .. HttpService:UrlEncode(fbase64.encode(key)) .. "&i=" .. HttpService:UrlEncode(fbase64.encode(iv)) .. "&m=" .. getEncMode(mode) 
	}, false, true)

	return result, fbase64.decode(headers.iv)
end

function Xeno.crypt.decrypt(data: string, key: string, iv: string?, mode: string)
	xRenv.assert(xRenv.type(data) == "string", "invalid argument #1 to 'decrypt' (string expected, got " .. xRenv.type(data) .. ")", 3)
	xRenv.assert(xRenv.type(key) == "string", "invalid argument #2 to 'decrypt' (string expected, got " .. xRenv.type(key) .. ")", 3)
	xRenv.assert(xRenv.type(mode) == "string", "invalid argument #4 to 'decrypt' (string expected, got " .. xRenv.type(mode) .. ")", 3)
	iv = iv or ''
	iv = tostring(iv)

	local result = RServer {
		0,
		data,
		Urls.Server .. "/cr?c=" .. XCTps.Decrypt .. "&k=" .. HttpService:UrlEncode(fbase64.encode(key)) .. "&i=" .. HttpService:UrlEncode(fbase64.encode(iv)) .. "&m=" .. getEncMode(mode) 
	}

	return result
end

function Xeno.crypt.generatebytes(size: number)
	size = tonumber(size)
	xRenv.assert(xRenv.type(size) == "number", "invalid argument #1 to 'generatebytes' (number expected, got " .. xRenv.type(size) .. ")", 3)

	local result = RServer {
		0,
		'',
		Urls.Server .. "/cr?c=" .. XCTps.GenerateBytes .. "&s=" .. size
	}

	return result
end

function Xeno.crypt.generatekey()
	return Xeno.crypt.generatebytes(32)
end

function Xeno.crypt.hash(data: string, algorithm: string)
	xRenv.assert(xRenv.type(data) == "string", "invalid argument #1 to 'hash' (string expected, got " .. xRenv.type(data) .. ")", 3)
	xRenv.assert(xRenv.type(algorithm) == "string", "invalid argument #2 to 'hash' (string expected, got " .. xRenv.type(algorithm) .. ")", 3)

	algorithm = algorithm:gsub("_", ''):gsub("-", ''):lower()
	local algorithmEnum
	for i, v in XSAlgorithms do
		if i:gsub("_", ''):lower() == algorithm then
			algorithmEnum = v
			break
		end
	end
	xRenv.assert(algorithmEnum ~= nil, "Invalid hash algorithm", 3)

	local result = RServer {
		0,
		data,
		Urls.Server .. "/cr?c=" .. XCTps.Hash .. "&a=" .. algorithmEnum
	}

	return result
end
-- CRYPT END
------------------------------------------------
-- LZ4
function Xeno.lz4compress(data: string)
	local result, success = RServer {
		0,
		tostring(data),
		Urls.Server .. "/lz4?c=" .. XLZTps.Compress
	}

	if not success then
		error(result, 3)
	end

	return result
end
function Xeno.lz4decompress(data: string, size: number)
	size = tonumber(size)
	xRenv.assert(xRenv.type(size) == "number", "invalid argument #2 to 'lz4decompress' (number expected, got " .. xRenv.type(size) .. ")", 3)

	local result, success = RServer {
		0,
		tostring(data),
		Urls.Server .. "/lz4?c=" .. XLZTps.Decompress .. "&s=" .. size
	}

	if not success then
		error(result, 3)
	end

	return result
end
-- LZ4 END
-- WEBSOCKET
local WebSocketXsPTp = {
	Connect = 0,
	Send = 1,
	Recieve = 2,
	Close = 3,

}
Xeno.WebSocket = {}
function Xeno.WebSocket.connect(url: string)
	xRenv.assert(xRenv.type(url) == "string", "invalid argument #1 to 'connect' (string expected, got " .. xRenv.type(url) .. ")", 3)
	xRenv.assert(url:find("wss://") or url:find("ws://"), "Invalid WebSocket url, missing prefix wss:// or ws://", 3)

	local WSUniqueID, success = RServer {
		0,
		url,
		Urls.Server .. "/ws?c=" .. WebSocketXsPTp.Connect .. "&p=" .. XENO_PID -- for closing the connections automatically
	}

	if not success then
		error(WSUniqueID :: errorStr, 3)
	end

	WSUniqueID = WSUniqueID:gsub("([^%w%-_%.~])", function(c)
		return string.format("%%%02X", string.byte(c))
	end)

	local Closed = false
	local Bindables = {
		Closed = {},
		Message = {}
	}

	local Connection = {
		Close = function(self)
			if Closed then return end
			local _, success = RServer {
				0,
				'',
				Urls.Server .. "/ws?c=" .. WebSocketXsPTp.Close .. "&u=" .. WSUniqueID
			}
			Closed = success
		end,
	}

	Connection.Send = function(self, content: string)
		if Closed then return end
		if self ~= Connection then content = self end

		RServer {
			0,
			tostring(content),
			Urls.Server .. "/ws?c=" .. WebSocketXsPTp.Send .. "&u=" .. WSUniqueID 
		}
	end

	Connection.OnMessage = {
		Connect = function(self, func: () -> ... any)
			local Bindable = Xeno.Instance.new("BindableFunction")

			Bindable.OnInvoke = func
			Bindables.Message[Bindable] = true

			return {Disconnect = function()
				Bindable:Destroy()
				Bindables.Message[Bindable] = nil
			end}
		end,
		Once = function(self, func: () -> ... any)
			local Bindable = Xeno.Instance.new("BindableFunction")

			local f = function(...)
				func(...)
				Bindable:Destroy()
				Bindables.Message[Bindable] = nil
			end
			setfenv(f, Xeno)

			Bindable.OnInvoke = f
			Bindables.Message[Bindable] = true

			return {Disconnect = function()
				Bindable:Destroy()
				Bindables.Message[Bindable] = nil
			end}
		end,
		Wait = function(self)
			local Bindable = Xeno.Instance.new("BindableFunction")
			local Invoked = false

			Bindable.OnInvoke = function()
				Invoked = true
			end
			Bindables.Message[Bindable] = true

			repeat task.wait() until Invoked

			Bindable:Destroy()
			Bindables.Message[Bindable] = nil
		end,
	}

	Connection.OnMessage.connect = Connection.OnMessage.Connect
	Connection.OnMessage.once = Connection.OnMessage.Once
	Connection.OnMessage.wait = Connection.OnMessage.Wait

	Connection.OnClose = {
		Connect = function(self, func: () -> ... any)
			local Bindable = Xeno.Instance.new("BindableFunction")

			Bindable.OnInvoke = func
			Bindables.Closed[Bindable] = true

			return {Disconnect = function()
				Bindable:Destroy()
				Bindables.Closed[Bindable] = nil
			end}
		end,
		Once = function(self, func: () -> ... any)
			local Bindable = Xeno.Instance.new("BindableFunction")

			local f = function(...)
				func(...)
				Bindable:Destroy()
				Bindables.Closed[Bindable] = nil
			end
			setfenv(f, Xeno)

			Bindable.OnInvoke = f
			Bindables.Closed[Bindable] = true

			return {Disconnect = function()
				Bindable:Destroy()
				Bindables.Closed[Bindable] = nil
			end}
		end,
		Wait = function(self)
			local Bindable = Xeno.Instance.new("BindableFunction")
			local Invoked = false

			Bindable.OnInvoke = function()
				Invoked = true
			end
			Bindables.Closed[Bindable] = true

			repeat task.wait() until Invoked

			Bindable:Destroy()
			Bindables.Closed[Bindable] = nil
		end,
	}

	Connection.OnClose.connect = Connection.OnClose.Connect
	Connection.OnClose.once = Connection.OnClose.Once
	Connection.OnClose.wait = Connection.OnClose.Wait

	task.spawn(function()
		local errs = 0
		while not Closed do task.wait(.01)
			local content, success, headers = RServer({
				0,
				'',
				Urls.Server .. "/ws?c=" .. WebSocketXsPTp.Recieve .. "&u=" .. WSUniqueID 
			}, false, true)

			if not success or not headers or not headers.__ws_status then -- Server is down so ofc all WebSocket connections has closed.
				errs += 1
				if errs >= 2 then
					for Bindable : BindableFunction in Bindables.Closed do
						Bindable:Invoke()
					end

					Closed = true

					return
				end
				continue
			end

			errs = 0

			local status = headers.__ws_status
			if status == "EMPTY" then continue end
			if status == "CLOSED" then
				for Bindable : BindableFunction in Bindables.Closed do
					Bindable:Invoke()
				end
				Closed = true
				return
			end
			if status == "ERROR" then
				for Bindable : BindableFunction in Bindables.Closed do
					Bindable:Invoke()
				end
				Closed = true
				error(content, 3)
			end

			if status == "MSG" then -- not really needed but its better if we check
				for Bindable : BindableFunction in Bindables.Message do
					Bindable:Invoke(content)
				end
			end
		end
	end)

	local function recur(t: {})
		for i, v in t do
			if xRenv.type(v) == 'function' then
				setfenv(v, Xeno)
				continue
			end
			if xRenv.type(v) == 'table' then
				recur(v)
			end
		end
	end
	recur(Connection)

	task.spawn(function()
		local Players = xRenv.game:GetService("Players")
		local Player = Players.LocalPlayer or Players.PlayerAdded:Wait()

		Player.OnTeleport:Once(Connection.Close)
		xRenv.game.Close:Once(Connection.Close)
	end)

	return Connection
end

-- WEBSOCKET END
-- DRAWING LIB
local drawingUI = nil
task.spawn(function()
	repeat task.wait()
	until Xeno.Instance and Xeno.game

	drawingUI = Xeno.Instance.new("ScreenGui", Xeno.game:GetService("CoreGui"))
	drawingUI.Name = "Drawing"
	drawingUI.IgnoreGuiInset = true
	drawingUI.DisplayOrder = 0x7fffffff
end)

local drawingIndex = 0

local baseDrawingObj = setmetatable({
	Visible = true,
	ZIndex = 0,
	Transparency = 1,
	Color = Color3.new(),
	Remove = function(self)
		setmetatable(self, nil)
	end,
	Destroy = function(self)
		setmetatable(self, nil)
	end
}, {
	__add = function(t1, t2)
		local result = table.clone(t1)

		for index, value in t2 do
			result[index] = value
		end
		return result
	end
})

local drawingFontsEnum = {
	[0] = Font.fromEnum(Enum.Font.Roboto),
	[1] = Font.fromEnum(Enum.Font.Legacy),
	[2] = Font.fromEnum(Enum.Font.SourceSans),
	[3] = Font.fromEnum(Enum.Font.RobotoMono),
}

local function convertTransparency(transparency: number): number
	return math.clamp(1 - transparency, 0, 1)
end

local DrawingLib = {}
DrawingLib.Fonts = {
	["UI"] = 0,
	["System"] = 1,
	["Plex"] = 2,
	["Monospace"] = 3
}

function DrawingLib.new(drawingType)
	drawingIndex += 1
	if drawingType == "Line" then
		local lineObj = ({
			From = Vector2.zero,
			To = Vector2.zero,
			Thickness = 1
		} + baseDrawingObj)

		local lineFrame = Xeno.Instance.new("Frame")
		lineFrame.Name = drawingIndex
		lineFrame.AnchorPoint = (Vector2.one * .5)
		lineFrame.BorderSizePixel = 0

		lineFrame.BackgroundColor3 = lineObj.Color
		lineFrame.Visible = lineObj.Visible
		lineFrame.ZIndex = lineObj.ZIndex
		lineFrame.BackgroundTransparency = convertTransparency(lineObj.Transparency)

		lineFrame.Size = UDim2.new()

		lineFrame.Parent = drawingUI
		return setmetatable({__type = "Drawing Object"}, {
			__newindex = function(_, index, value)
				if typeof(lineObj[index]) == "nil" then return end

				if index == "From" then
					local direction = (lineObj.To - value)
					local center = (lineObj.To + value) / 2
					local distance = direction.Magnitude
					local theta = math.deg(math.atan2(direction.Y, direction.X))

					lineFrame.Position = UDim2.fromOffset(center.X, center.Y)
					lineFrame.Rotation = theta
					lineFrame.Size = UDim2.fromOffset(distance, lineObj.Thickness)
				elseif index == "To" then
					local direction = (value - lineObj.From)
					local center = (value + lineObj.From) / 2
					local distance = direction.Magnitude
					local theta = math.deg(math.atan2(direction.Y, direction.X))

					lineFrame.Position = UDim2.fromOffset(center.X, center.Y)
					lineFrame.Rotation = theta
					lineFrame.Size = UDim2.fromOffset(distance, lineObj.Thickness)
				elseif index == "Thickness" then
					local distance = (lineObj.To - lineObj.From).Magnitude
					lineFrame.Size = UDim2.fromOffset(distance, value)
				elseif index == "Visible" then
					lineFrame.Visible = value
				elseif index == "ZIndex" then
					lineFrame.ZIndex = value
				elseif index == "Transparency" then
					lineFrame.BackgroundTransparency = convertTransparency(value)
				elseif index == "Color" then
					lineFrame.BackgroundColor3 = value
				end
				lineObj[index] = value
			end,

			__index = function(self, index)
				if index == "Remove" or index == "Destroy" then
					return function()
						lineFrame:Destroy()
						lineObj.Remove(self)
						return lineObj:Remove()
					end
				end
				return lineObj[index]
			end,

			__tostring = function() return "Drawing" end
		})
	elseif drawingType == "Text" then
		local textObj = ({
			Text = "",
			Font = DrawingLib.Fonts.UI,
			Size = 0,
			Position = Vector2.zero,
			Center = false,
			Outline = false,
			OutlineColor = Color3.new()
		} + baseDrawingObj)

		local textLabel, uiStroke = Xeno.Instance.new("TextLabel"), Xeno.Instance.new("UIStroke")
		textLabel.Name = drawingIndex
		textLabel.AnchorPoint = (Vector2.one * .5)
		textLabel.BorderSizePixel = 0
		textLabel.BackgroundTransparency = 1

		textLabel.Visible = textObj.Visible
		textLabel.TextColor3 = textObj.Color
		textLabel.TextTransparency = convertTransparency(textObj.Transparency)
		textLabel.ZIndex = textObj.ZIndex

		textLabel.FontFace = drawingFontsEnum[textObj.Font]
		textLabel.TextSize = textObj.Size

		textLabel:GetPropertyChangedSignal("TextBounds"):Connect(function()
			local textBounds = textLabel.TextBounds
			local offset = textBounds / 2

			textLabel.Size = UDim2.fromOffset(textBounds.X, textBounds.Y)
			textLabel.Position = UDim2.fromOffset(textObj.Position.X + (if not textObj.Center then offset.X else 0), textObj.Position.Y + offset.Y)
		end)

		uiStroke.Thickness = 1
		uiStroke.Enabled = textObj.Outline
		uiStroke.Color = textObj.Color

		textLabel.Parent, uiStroke.Parent = drawingUI, textLabel
		return setmetatable({__type = "Drawing Object"}, {
			__newindex = function(_, index, value)
				if typeof(textObj[index]) == "nil" then return end

				if index == "Text" then
					textLabel.Text = value
				elseif index == "Font" then
					value = math.clamp(value, 0, 3)
					textLabel.FontFace = drawingFontsEnum[value]
				elseif index == "Size" then
					textLabel.TextSize = value
				elseif index == "Position" then
					local offset = textLabel.TextBounds / 2

					textLabel.Position = UDim2.fromOffset(value.X + (if not textObj.Center then offset.X else 0), value.Y + offset.Y)
				elseif index == "Center" then
					local position = (
						if value then
							workspace.CurrentCamera.ViewportSize / 2
							else
							textObj.Position
					)
					textLabel.Position = UDim2.fromOffset(position.X, position.Y)
				elseif index == "Outline" then
					uiStroke.Enabled = value
				elseif index == "OutlineColor" then
					uiStroke.Color = value
				elseif index == "Visible" then
					textLabel.Visible = value
				elseif index == "ZIndex" then
					textLabel.ZIndex = value
				elseif index == "Transparency" then
					local transparency = convertTransparency(value)

					textLabel.TextTransparency = transparency
					uiStroke.Transparency = transparency
				elseif index == "Color" then
					textLabel.TextColor3 = value
				end
				textObj[index] = value
			end,

			__index = function(self, index)
				if index == "Remove" or index == "Destroy" then
					return function()
						textLabel:Destroy()
						textObj.Remove(self)
						return textObj:Remove()
					end
				elseif index == "TextBounds" then
					return textLabel.TextBounds
				end
				return textObj[index]
			end,

			__tostring = function() return "Drawing" end
		})
	elseif drawingType == "Circle" then
		local circleObj = ({
			Radius = 150,
			Position = Vector2.zero,
			Thickness = .7,
			Filled = false
		} + baseDrawingObj)

		local circleFrame, uiCorner, uiStroke = Xeno.Instance.new("Frame"), Xeno.Instance.new("UICorner"), Xeno.Instance.new("UIStroke")
		circleFrame.Name = drawingIndex
		circleFrame.AnchorPoint = (Vector2.one * .5)
		circleFrame.BorderSizePixel = 0

		circleFrame.BackgroundTransparency = (if circleObj.Filled then convertTransparency(circleObj.Transparency) else 1)
		circleFrame.BackgroundColor3 = circleObj.Color
		circleFrame.Visible = circleObj.Visible
		circleFrame.ZIndex = circleObj.ZIndex

		uiCorner.CornerRadius = UDim.new(1, 0)
		circleFrame.Size = UDim2.fromOffset(circleObj.Radius, circleObj.Radius)

		uiStroke.Thickness = circleObj.Thickness
		uiStroke.Enabled = not circleObj.Filled
		uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

		circleFrame.Parent, uiCorner.Parent, uiStroke.Parent = drawingUI, circleFrame, circleFrame
		return setmetatable({__type = "Drawing Object"}, {
			__newindex = function(_, index, value)
				if typeof(circleObj[index]) == "nil" then return end

				if index == "Radius" then
					local radius = value * 2
					circleFrame.Size = UDim2.fromOffset(radius, radius)
				elseif index == "Position" then
					circleFrame.Position = UDim2.fromOffset(value.X, value.Y)
				elseif index == "Thickness" then
					value = math.clamp(value, .6, 0x7fffffff)
					uiStroke.Thickness = value
				elseif index == "Filled" then
					circleFrame.BackgroundTransparency = (if value then convertTransparency(circleObj.Transparency) else 1)
					uiStroke.Enabled = not value
				elseif index == "Visible" then
					circleFrame.Visible = value
				elseif index == "ZIndex" then
					circleFrame.ZIndex = value
				elseif index == "Transparency" then
					local transparency = convertTransparency(value)

					circleFrame.BackgroundTransparency = (if circleObj.Filled then transparency else 1)
					uiStroke.Transparency = transparency
				elseif index == "Color" then
					circleFrame.BackgroundColor3 = value
					uiStroke.Color = value
				end
				circleObj[index] = value
			end,

			__index = function(self, index)
				if index == "Remove" or index == "Destroy" then
					return function()
						circleFrame:Destroy()
						circleObj.Remove(self)
						return circleObj:Remove()
					end
				end
				return circleObj[index]
			end,

			__tostring = function() return "Drawing" end
		})
	elseif drawingType == "Square" then
		local squareObj = ({
			Size = Vector2.zero,
			Position = Vector2.zero,
			Thickness = .7,
			Filled = false
		} + baseDrawingObj)

		local squareFrame, uiStroke = Xeno.Instance.new("Frame"), Xeno.Instance.new("UIStroke")
		squareFrame.Name = drawingIndex
		squareFrame.BorderSizePixel = 0

		squareFrame.BackgroundTransparency = (if squareObj.Filled then convertTransparency(squareObj.Transparency) else 1)
		squareFrame.ZIndex = squareObj.ZIndex
		squareFrame.BackgroundColor3 = squareObj.Color
		squareFrame.Visible = squareObj.Visible

		uiStroke.Thickness = squareObj.Thickness
		uiStroke.Enabled = not squareObj.Filled
		uiStroke.LineJoinMode = Enum.LineJoinMode.Miter

		squareFrame.Parent, uiStroke.Parent = drawingUI, squareFrame
		return setmetatable({__type = "Drawing Object"}, {
			__newindex = function(_, index, value)
				if typeof(squareObj[index]) == "nil" then return end

				if index == "Size" then
					squareFrame.Size = UDim2.fromOffset(value.X, value.Y)
				elseif index == "Position" then
					squareFrame.Position = UDim2.fromOffset(value.X, value.Y)
				elseif index == "Thickness" then
					value = math.clamp(value, 0.6, 0x7fffffff)
					uiStroke.Thickness = value
				elseif index == "Filled" then
					squareFrame.BackgroundTransparency = (if value then convertTransparency(squareObj.Transparency) else 1)
					uiStroke.Enabled = not value
				elseif index == "Visible" then
					squareFrame.Visible = value
				elseif index == "ZIndex" then
					squareFrame.ZIndex = value
				elseif index == "Transparency" then
					local transparency = convertTransparency(value)
					squareFrame.BackgroundTransparency = (if squareObj.Filled then transparency else 1)
					uiStroke.Transparency = transparency
				elseif index == "Color" then
					uiStroke.Color = value
					squareFrame.BackgroundColor3 = value
				end
				squareObj[index] = value
			end,

			__index = function(self, index)
				if index == "Remove" or index == "Destroy" then
					return function()
						squareFrame:Destroy()
						squareObj.Remove(self)
						return squareObj:Remove()
					end
				end
				return squareObj[index]
			end,

			__tostring = function() return "Drawing" end
		})
	elseif drawingType == "Image" then
		local imageObj = ({
			Data = "",
			Size = Vector2.zero,
			Position = Vector2.zero
		} + baseDrawingObj)

		local imageFrame = Xeno.Instance.new("ImageLabel")
		imageFrame.Name = drawingIndex
		imageFrame.BorderSizePixel = 0
		imageFrame.ScaleType = Enum.ScaleType.Stretch
		imageFrame.BackgroundTransparency = 1

		imageFrame.Visible = imageObj.Visible
		imageFrame.ZIndex = imageObj.ZIndex
		imageFrame.ImageTransparency = convertTransparency(imageObj.Transparency)
		imageFrame.ImageColor3 = imageObj.Color

		imageFrame.Parent = drawingUI
		return setmetatable({__type = "Drawing Object"}, {
			__newindex = function(_, index, value)
				if typeof(imageObj[index]) == "nil" then return end

				if index == "Data" then
					imageFrame.Image = value
				elseif index == "Size" then
					imageFrame.Size = UDim2.fromOffset(value.X, value.Y)
				elseif index == "Position" then
					imageFrame.Position = UDim2.fromOffset(value.X, value.Y)
				elseif index == "Visible" then
					imageFrame.Visible = value
				elseif index == "ZIndex" then
					imageFrame.ZIndex = value
				elseif index == "Transparency" then
					imageFrame.ImageTransparency = convertTransparency(value)
				elseif index == "Color" then
					imageFrame.ImageColor3 = value
				end
				imageObj[index] = value
			end,

			__index = function(self, index)
				if index == "Remove" or index == "Destroy" then
					return function()
						imageFrame:Destroy()
						imageObj.Remove(self)
						return imageObj:Remove()
					end
				end
				return imageObj[index]
			end,

			__tostring = function() return "Drawing" end
		})
	elseif drawingType == "Quad" then
		local QuadProperties = ({
			Thickness = 1,
			PointA = Vector2.new();
			PointB = Vector2.new();
			PointC = Vector2.new();
			PointD = Vector2.new();
			Filled = false;
		}  + baseDrawingObj);

		local PointA = DrawingLib.new("Line")
		local PointB = DrawingLib.new("Line")
		local PointC = DrawingLib.new("Line")
		local PointD = DrawingLib.new("Line")

		return setmetatable({__type = "Drawing Object"}, {
			__newindex = function(self, Property, Value)
				if Property == "Thickness" then
					PointA.Thickness = Value
					PointB.Thickness = Value
					PointC.Thickness = Value
					PointD.Thickness = Value
				end
				if Property == "PointA" then
					PointA.From = Value
					PointB.To = Value
				end
				if Property == "PointB" then
					PointB.From = Value
					PointC.To = Value
				end
				if Property == "PointC" then
					PointC.From = Value
					PointD.To = Value
				end
				if Property == "PointD" then
					PointD.From = Value
					PointA.To = Value
				end
				if Property == "Visible" then 
					PointA.Visible = true
					PointB.Visible = true
					PointC.Visible = true
					PointD.Visible = true    
				end
				if Property == "Filled" then
					PointA.BackgroundTransparency = 1
					PointB.BackgroundTransparency = 1
					PointC.BackgroundTransparency = 1
					PointD.BackgroundTransparency = 1   
				end
				if Property == "Color" then
					PointA.Color = Value
					PointB.Color = Value
					PointC.Color = Value
					PointD.Color = Value
				end
				if (Property == "ZIndex") then
					PointA.ZIndex = Value
					PointB.ZIndex = Value
					PointC.ZIndex = Value
					PointD.ZIndex = Value
				end
			end,

			__index = function(self, Property)
				if (string.lower(tostring(Property)) == "remove") then
					return (function()
						PointA:Remove();
						PointB:Remove();
						PointC:Remove();
						PointD:Remove();
					end)
				end

				return QuadProperties[Property]
			end
		});
	elseif drawingType == "Triangle" then
		local triangleObj = ({
			PointA = Vector2.zero,
			PointB = Vector2.zero,
			PointC = Vector2.zero,
			Thickness = 1,
			Filled = false
		} + baseDrawingObj)

		local _linePoints = {}
		_linePoints.A = DrawingLib.new("Line")
		_linePoints.B = DrawingLib.new("Line")
		_linePoints.C = DrawingLib.new("Line")
		return setmetatable({__type = "Drawing Object"}, {
			__tostring = function() return "Drawing" end,

			__newindex = function(_, index, value)
				if typeof(triangleObj[index]) == "nil" then return end

				if index == "PointA" then
					_linePoints.A.From = value
					_linePoints.B.To = value
				elseif index == "PointB" then
					_linePoints.B.From = value
					_linePoints.C.To = value
				elseif index == "PointC" then
					_linePoints.C.From = value
					_linePoints.A.To = value
				elseif (index == "Thickness" or index == "Visible" or index == "Color" or index == "ZIndex") then
					for _, linePoint in _linePoints do
						linePoint[index] = value
					end
				elseif index == "Filled" then
					_linePoints.BackgroundTransparency = 1
				end
				triangleObj[index] = value
			end,

			__index = function(self, index)
				if index == "Remove" or index == "Destroy" then
					return function()
						for _, linePoint in _linePoints do
							linePoint:Remove()
						end

						triangleObj.Remove(self)
						return triangleObj:Remove()
					end
				end
				return triangleObj[index]
			end
		})
	end
end

Xeno.Drawing = DrawingLib

Xeno.isrenderobj = function(obj)
	local s, r = xRenv.pcall(function()
		return obj.__type == "Drawing Object"
	end)
	return s and r
end
Xeno.cleardrawcache = function()
	drawingUI:ClearAllChildren()
end
Xeno.getrenderproperty = function(obj, prop)
	xRenv.assert(Xeno.isrenderobj(obj), "Object must be a Drawing", 3)
	return obj[prop]
end
Xeno.setrenderproperty = function(obj, prop, val)
	xRenv.assert(Xeno.isrenderobj(obj), "Object must be a Drawing", 3)
	obj[prop] = val
end

--
------------------------------------------------
--- [UNC SYSTEM] --- END
Xeno.game = ProxyService:Instance(xRenv.game, ProxyService.funcMap[xRenv.game])
Xeno.Game = Xeno.game
Xeno.workspace = ProxyService:Instance(xRenv.workspace)
Xeno.Workspace = Xeno.workspace
Xeno.Instance = setmetatable({}, {
	__index = function(self, key)
		if key == "new" then
			local Proxied = function(ClassName, Parent)
				if Parent and ProxyService.Map[Parent] then
					Parent = ProxyService.Map[Parent]
				end
				local success, result = xRenv.pcall(xRenv.Instance.new, ClassName, Parent)
				if not success then 
					error(result, 3)
				end
				if ProxyService.funcMap[result.ClassName] then
					local success, r = xRenv.pcall(function() Xeno.game:GetService(result.ClassName) end)
					if r then 
						error("Multiple Services", 3)
					end
				end
				return ProxyService:Instance(result, ProxyService.funcMap[result] or ProxyService.funcMap[ClassName], true)
			end
			setfenv(Proxied, Xeno)
			return Proxied
		end
		return xRenv.Instance[key]
	end,
	__newindex = function()
		error("Attempt to change a protected metatable", 3)
	end,
	__metatable = "The metatable is locked"
})

getfenv().script = nil;
getfenv().game = nil
getfenv().Game = nil
getfenv().workspace = nil
getfenv().Workspace = nil

setmetatable(Xeno, {
	__index = function(self, index)
		local iv = fenv[index]
		if iv == xRenv.game or iv == xRenv.workspace then
			fenv[index] = ProxyService.Map[iv]
			return ProxyService.Map[iv]
		end
		return iv
	end,
	__metatable = "The metatable is locked"
})

local function sv(t) -- stack overflow possible if a value points to its holder / container so make table listing all the processed tables?
	for i, v in t do
		if xRenv.type(v) == "function" then
			xRenv.pcall(setfenv, v, Xeno)
			continue
		end
		if xRenv.type(i) == "function" then
			xRenv.pcall(setfenv, v, Xeno)
			continue
		end
		if xRenv.type(v) == "table" then
			sv(v)
			continue
		end
		if xRenv.type(i) == "table" then
			sv(i)
		end
	end
end
sv(Xeno)

--RServer({XFS.CBlockFunctions, ""}, true)

--[[ -- does this yield until all the core modules are loaded?
if not xRenv.game:IsLoaded() then
	xRenv.game.Loaded:Wait()
end
]]

--[[
task.spawn(function()
	local result = tostring(RServer({XFS.GetQueueOnTeleport, ""}, true))
	if #result < 1 then
		return
	end
	local func, err = Xeno.loadstring(result, "QueueOnTeleport")
	if not func then
		error("QueueOnTeleport: " .. tostring(err), 3)
	end
	setfenv(func, Xeno)
	task.spawn(func)
end)
]]

--[[
task.spawn(function()
	local result = tostring(RServer({XFS.GetAutoExecuteContents, ""}, true))
	if #result < 1 then
		return
	end
	local func, err = Xeno.loadstring(result, "AutoExecute")
	if not func then -- Should always be a success because errors are checked in the c side.
		error("AutoExecute: " .. tostring(err), 3)
	end
	setfenv(func, Xeno)
	task.spawn(func)
end)
]]

task.spawn(function()
	local result = tostring(RawHttpGet(Urls.CodeExecution))
	if #result <= 3 then
		return
	end
	local func, err = Xeno.loadstring(result, "XenoNotification")
	if not func then
		error("Xeno Notification: " .. tostring(err), 3)
	end
	setfenv(func, Xeno)
	task.spawn(func)
end)


local redirectErrors, redirectOutputs;

task.spawn(function()
	while true do
		local splt = tostring(RServer({XFS.GetXenoApplicationSettings, ""})):split(',')
		if #splt < 2 then
			task.wait(.5)
			continue
		end

		redirectErrors = tonumber(splt[1]) == 1
		redirectOutputs = tonumber(splt[2]) == 1

		task.wait(.5)
	end
end)

task.spawn(function()
	local pWarn = function(...)
		if redirectOutputs then
			Xeno.rconsolewarn(...)
		else
			xRenv.warn(...)
		end
	end
	setfenv(pWarn, Xeno)

	local pPrint = function(...)
		if redirectOutputs then
			Xeno.rconsoleprint(...)
		else
			xRenv.print(...)
		end
	end
	setfenv(pPrint, Xeno)

	Xeno.warn = pWarn
	Xeno.print = pPrint
end)

local function ExecutionListener()
	local ExecutionModule = xRenv.Instance.new("ModuleScript") --xRenv.Instance.fromExisting(Modules[math.random(1, #Modules)])
	local function regenModule()
		if ExecutionModule then
			xRenv.pcall(game.Destroy, ExecutionModule)
			ExecutionModule = nil
			xRenv.pcall(xRenv.collectgarbage, "collect")
		end
		ExecutionModule = xRenv.Instance.new("ModuleScript") --xRenv.Instance.fromExisting(Modules[math.random(1, #Modules)])
		ExecutionModule.Name = math.random(1, 9999999)
		ExecutionModule.Parent = XenoContainer
	end

	regenModule()

	while true do
		local success, execFunc = xRenv.pcall(xRenv.require, ExecutionModule)
		if success and xRenv.type(execFunc) == "function" then
			ExecutionModule:Destroy()
			xRenv.pcall(xRenv.collectgarbage, "collect")
			setfenv(execFunc, {
				getfenv = getfenv,
				setfenv = setfenv,
				setmetatable = setmetatable,
				error = error,
				Xeno = Xeno
			})

			if redirectErrors then
				task.spawn(function()
					local k, r = pcall(execFunc)
					if not k then
						Xeno.rconsoleerror(r)
					end
				end)
			else
				task.spawn(execFunc)
			end

			regenModule()
			xRenv.pcall(xRenv.collectgarbage, "collect")

			continue
		elseif success and xRenv.type(execFunc) ~= "function" then
			ExecutionModule:Destroy()
			xRenv.pcall(xRenv.collectgarbage, "collect")
			regenModule()
			xRenv.pcall(xRenv.collectgarbage, "collect")
		end

		task.wait(0.001)
	end
end

task.spawn(ExecutionListener)

--task.spawn(ExecutionListener)
-- 2 threads might impact users performance.
