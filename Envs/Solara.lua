-- Solara init (decompiled) leaked by AnyaDev, thx! 
-- Solara Version: 3.0

local script_upvr = script
getfenv().script = nil
local tbl_52_upvr = {}
for i, v in game:GetDescendants() do
	if v:IsA("ModuleScript") then
		tbl_52_upvr[#tbl_52_upvr + 1] = v
	end
end
task.spawn(function() -- Line 1
	--[[ Upvalues[2]:
		[1]: script_upvr (readonly)
		[2]: tbl_52_upvr (readonly)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	if script_upvr.Name == "JestGlobals" then
		local VirtualInputManager = Instance.new("VirtualInputManager")
		VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Escape, false, game)
		task.wait(0.01)
		VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Escape, false, game)
		VirtualInputManager:Destroy()
	end
	local require_upvr = require
	local function rand_upvr(arg1) -- Line 13, Named "rand"
		local var63 = ""
		for _ = 1, arg1 do
			local randint = math.random(1, 62)
			var63 = var63.."abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789":sub(randint, randint)
		end
		return var63
	end
	local var65_upvr = script_upvr
	var65_upvr:SetAttribute("CONN", '0')
	local clone_3_upvw = tbl_52_upvr[math.random(1, #tbl_52_upvr)]:Clone()
	clone_3_upvw.Name = "_Script"
	clone_3_upvw.Parent = var65_upvr
	task.spawn(function() -- Line 30
		--[[ Upvalues[6]:
			[1]: clone_3_upvw (read and write)
			[2]: script_upvr (copied, readonly)
			[3]: var65_upvr (readonly)
			[4]: rand_upvr (readonly)
			[5]: require_upvr (readonly)
			[6]: tbl_52_upvr (copied, readonly)
		]]
		while true do
			task.wait()
			if clone_3_upvw then
				clone_3_upvw:GetFullName()
			end
			script_upvr:GetFullName()
			if var65_upvr:GetAttribute("CONN") ~= '0' then
				var65_upvr:SetAttribute("CONN", '0')
				clone_3_upvw.Name = "[string \""..rand_upvr(7).."\"]"
				clone_3_upvw.Parent = nil
				local pcall_result1, pcall_result2 = pcall(require_upvr, clone_3_upvw)
				if pcall_result1 then
					setfenv(pcall_result2, {
						getfenv = getfenv;
						shared = shared;
						setfenv = setfenv;
						setmetatable = setmetatable;
					})
					task.spawn(pcall_result2)
				end
				clone_3_upvw = tbl_52_upvr[math.random(1, #tbl_52_upvr)]:Clone()
				clone_3_upvw.Name = "_Script"
				clone_3_upvw.Parent = script_upvr
			end
		end
	end)
	local game_upvr = game
	local Instance_upvr = Instance
	local HttpService_upvr = game_upvr:GetService("HttpService")
	local RequestInternal_upvr = HttpService_upvr.RequestInternal
	local typeof_upvr = typeof
	local type_upvr = type
	local debug_upvr = debug
	local module_12_upvr = {}
	local tbl_9 = {}
	local tbl_63 = {}
	local tbl_36_upvr = {}
	local error_upvr = error
	local assert_upvr = assert
	local tostring_upvr = tostring
	local getmetatable_upvr = getmetatable
	local setmetatable_upvr = setmetatable
	local math_upvr = math
	local table_upvr = table
	local unpack_upvr = unpack
	local pcall_upvr = pcall
	local xpcall_upvr = xpcall
	local task_upvr = task
	local setfenv_upvr = setfenv
	local getfenv_upvr = getfenv
	local tbl_27_upvr = {"dc6d28652ef8e1fb0520e3ebbe8367f8", "valedreamer", "irunyouxx", "paypal.", "egorikusa.space", "oputeruwof", "fojemavigo", "Mp3Q0t6A", "pipedream.net", "accountsettings.roblox.com", "accountsettings.roproxy.com", "accountinformation.roblox.com", "accountinformation.roproxy.com", "apis.roblox.com", "apis.roproxy.com", "auth.roblox.com", "auth.roproxy.com", "billing.roblox.com", "billing.roproxy.com", "economy.roblox.com", "economy.roproxy.com", "twostepverification.roblox.com", "twostepverification.roproxy.com", "/display-names", "/v1/description", "/v1/birthdate", "/v1/gender"}
	local tbl_4_upvr = {
		_is_exploit_env = true;
	}
	local getfenv_upvr_result1 = getfenv_upvr()
	local module_20_upvr = {}
	local var100_upvw = true
	local tbl_21 = {
		__index = getfenv_upvr_result1;
	}
	local function __newindex(arg1, arg2, arg3) -- Line 133
		--[[ Upvalues[1]:
			[1]: error_upvr (readonly)
		]]
		error_upvr("Cannot modify for security reasons. Our getrenv is fake anyway", 2)
	end
	tbl_21.__newindex = __newindex
	tbl_21.__metatable = "Protected"
	setmetatable_upvr(module_20_upvr, tbl_21)
	for i_3 = 0, 255 do
		tbl_36_upvr[i_3] = string.format("%.2X", i_3)
		local var103_upvr
	end
	local buffer_upvr = buffer
	local function encodeHex_upvr(arg1) -- Line 163, Named "encodeHex"
		--[[ Upvalues[5]:
			[1]: table_upvr (readonly)
			[2]: math_upvr (readonly)
			[3]: tbl_36_upvr (readonly)
			[4]: var103_upvr (readonly)
			[5]: buffer_upvr (readonly)
		]]
		-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
		local any_create_result1 = table_upvr.create(math_upvr.ceil(#arg1 / 18))
		local var126
		for i_4 = 1, #arg1 do
			var126 = var126..tbl_36_upvr[var103_upvr.byte(arg1, i_4)]
			if 18 < #var126 then
				table_upvr.insert(any_create_result1, var126)
				var126 = ""
			end
		end
		if 0 < #var126 then
			i_4 = var126
			table_upvr.insert(any_create_result1, i_4)
		end
		for _, _ in ipairs(any_create_result1) do
			local var130
		end
		for _, v_3 in ipairs(any_create_result1) do
			buffer_upvr.writestring(buffer_upvr.create(var130), 0, v_3)
			local var136
		end
		return buffer_upvr.tostring(var136)
	end
	function getrenv() -- Line 189
		--[[ Upvalues[1]:
			[1]: module_20_upvr (readonly)
		]]
		return module_20_upvr
	end
	function getgenv() -- Line 193
		--[[ Upvalues[1]:
			[1]: tbl_4_upvr (readonly)
		]]
		return tbl_4_upvr
	end
	local function blocked() -- Line 197
		--[[ Upvalues[1]:
			[1]: error_upvr (readonly)
		]]
		error_upvr("Blocked function", 2)
	end
	setfenv(blocked, tbl_4_upvr)
	setfenv(getgenv, tbl_4_upvr)
	setfenv(getrenv, tbl_4_upvr)
	local tbl_46_upvr = {}
	local tbl_29_upvr = {
		mockMap = {};
		mocked = {};
		funcMap = {
			[game_upvr:GetService("AccountService")] = {
				[game_upvr:GetService("AccountService").GetCredentialsHeaders] = blocked;
				[game_upvr:GetService("AccountService").GetDeviceAccessToken] = blocked;
				[game_upvr:GetService("AccountService").GetDeviceIntegrityToken] = blocked;
				[game_upvr:GetService("AccountService").GetDeviceIntegrityTokenYield] = blocked;
			};
			[game_upvr:GetService("AnalyticsService")] = {
				[game_upvr:GetService("AnalyticsService").FireInGameEconomyEvent] = blocked;
				[game_upvr:GetService("AnalyticsService").FireLogEvent] = blocked;
				[game_upvr:GetService("AnalyticsService").FireEvent] = blocked;
				[game_upvr:GetService("AnalyticsService").FireCustomEvent] = blocked;
				[game_upvr:GetService("AnalyticsService").LogEconomyEvent] = blocked;
			};
			[game_upvr:GetService("AnimationFromVideoCreatorService")] = {
				[game_upvr:GetService("AnimationFromVideoCreatorService").CreateJob] = blocked;
				[game_upvr:GetService("AnimationFromVideoCreatorService").DownloadJobResult] = blocked;
				[game_upvr:GetService("AnimationFromVideoCreatorService").FullProcess] = blocked;
			};
			[game_upvr:GetService("CaptureService")] = {
				[game_upvr:GetService("CaptureService").DeleteCapture] = blocked;
				[game_upvr:GetService("CaptureService").GetCaptureFilePathAsync] = blocked;
				[game_upvr:GetService("CaptureService").CreatePostAsync] = blocked;
				[game_upvr:GetService("CaptureService").GetCaptureFilePathAsync] = blocked;
				[game_upvr:GetService("CaptureService").SaveCaptureToExternalStorage] = blocked;
				[game_upvr:GetService("CaptureService").SaveCapturesToExternalStorageAsync] = blocked;
				[game_upvr:GetService("CaptureService").GetCaptureSizeAsync] = blocked;
				[game_upvr:GetService("CaptureService").GetCaptureStorageSizeAsync] = blocked;
				[game_upvr:GetService("CaptureService").PromptSaveCapturesToGallery] = blocked;
				[game_upvr:GetService("CaptureService").PromptShareCapture] = blocked;
				[game_upvr:GetService("CaptureService").RetrieveCaptures] = blocked;
				[game_upvr:GetService("CaptureService").SaveScreenshotCapture] = blocked;
				[game_upvr:GetService("CaptureService").PostToFeedAsync] = blocked;
			};
			[game_upvr:GetService("InsertService")] = {
				[game_upvr:GetService("InsertService").GetLocalFileContents] = blocked;
			};
			[game_upvr:GetService("SafetyService")] = {
				[game_upvr:GetService("SafetyService").TakeScreenshot] = blocked;
			};
			[game_upvr:GetService("HttpRbxApiService")] = {
				[game_upvr:GetService("HttpRbxApiService").PostAsync] = blocked;
				[game_upvr:GetService("HttpRbxApiService").PostAsyncFullUrl] = blocked;
				[game_upvr:GetService("HttpRbxApiService").GetAsyncFullUrl] = blocked;
				[game_upvr:GetService("HttpRbxApiService").GetAsync] = blocked;
				[game_upvr:GetService("HttpRbxApiService").RequestAsync] = blocked;
				[game_upvr:GetService("HttpRbxApiService").RequestLimitedAsync] = blocked;
			};
			[game_upvr:GetService("MarketplaceService")] = {
				[game_upvr:GetService("MarketplaceService").PerformCancelSubscription] = blocked;
				[game_upvr:GetService("MarketplaceService").PerformPurchaseV2] = blocked;
				[game_upvr:GetService("MarketplaceService").PrepareCollectiblesPurchase] = blocked;
				[game_upvr:GetService("MarketplaceService").PromptCancelSubscription] = blocked;
				[game_upvr:GetService("MarketplaceService").ReportAssetSale] = blocked;
				[game_upvr:GetService("MarketplaceService").GetUserSubscriptionDetailsInternalAsync] = blocked;
				[game_upvr:GetService("MarketplaceService").PerformPurchase] = blocked;
				[game_upvr:GetService("MarketplaceService").PromptBundlePurchase] = blocked;
				[game_upvr:GetService("MarketplaceService").PromptGamePassPurchase] = blocked;
				[game_upvr:GetService("MarketplaceService").PromptProductPurchase] = blocked;
				[game_upvr:GetService("MarketplaceService").PromptPurchase] = blocked;
				[game_upvr:GetService("MarketplaceService").PromptRobloxPurchase] = blocked;
				[game_upvr:GetService("MarketplaceService").PromptThirdPartyPurchase] = blocked;
				[game_upvr:GetService("MarketplaceService").GetRobuxBalance] = blocked;
				[game_upvr:GetService("MarketplaceService").PromptBulkPurchase] = blocked;
				[game_upvr:GetService("MarketplaceService").PerformBulkPurchase] = blocked;
				[game_upvr:GetService("MarketplaceService").PerformSubscriptionPurchase] = blocked;
				[game_upvr:GetService("MarketplaceService").PerformSubscriptionPurchaseV2] = blocked;
				[game_upvr:GetService("MarketplaceService").PromptCollectiblesPurchase] = blocked;
				[game_upvr:GetService("MarketplaceService").PromptNativePurchaseWithLocalPlayer] = blocked;
				[game_upvr:GetService("MarketplaceService").PromptPremiumPurchase] = blocked;
				[game_upvr:GetService("MarketplaceService").PromptSubscriptionPurchase] = blocked;
				[game_upvr:GetService("MarketplaceService").GetUserSubscriptionPaymentHistoryAsync] = blocked;
			};
			[game_upvr:GetService("GuiService")] = {
				[game_upvr:GetService("GuiService").OpenBrowserWindow] = blocked;
				[game_upvr:GetService("GuiService").OpenNativeOverlay] = blocked;
				[game_upvr:GetService("GuiService").BroadcastNotification] = blocked;
				[game_upvr:GetService("GuiService").SetPurchasePromptIsShown] = blocked;
			};
			[game_upvr:GetService("OpenCloudService")] = {
				[game_upvr:GetService("OpenCloudService").HttpRequestAsync] = blocked;
				[game_upvr:GetService("OpenCloudService").GetApiV1] = blocked;
				[game_upvr:GetService("OpenCloudService").InvokeAsync] = blocked;
				[game_upvr:GetService("OpenCloudService").RegisterOpenCloud] = blocked;
			};
			[game_upvr:GetService("DataModelPatchService")] = {
				[game_upvr:GetService("DataModelPatchService").RegisterPatch] = blocked;
				[game_upvr:GetService("DataModelPatchService").UpdatePatch] = blocked;
			};
			[game_upvr:GetService("EventIngestService")] = {
				[game_upvr:GetService("EventIngestService").SendEventDeferred] = blocked;
				[game_upvr:GetService("EventIngestService").SetRBXEvent] = blocked;
				[game_upvr:GetService("EventIngestService").SetRBXEventStream] = blocked;
				[game_upvr:GetService("EventIngestService").SendEventImmediately] = blocked;
			};
			[game_upvr:GetService("CoreScriptSyncService")] = {
				[game_upvr:GetService("CoreScriptSyncService").GetScriptFilePath] = blocked;
			};
			[game_upvr:GetService("ScriptContext")] = {
				[game_upvr:GetService("ScriptContext").AddCoreScriptLocal] = blocked;
				[game_upvr:GetService("ScriptContext").SaveScriptProfilingData] = blocked;
			};
			[game_upvr:GetService("ScriptProfilerService")] = {
				[game_upvr:GetService("ScriptProfilerService").SaveScriptProfilingData] = blocked;
			};
			[game_upvr:GetService("BrowserService")] = {
				[game_upvr:GetService("BrowserService").EmitHybridEvent] = blocked;
				[game_upvr:GetService("BrowserService").OpenWeChatAuthWindow] = blocked;
				[game_upvr:GetService("BrowserService").ExecuteJavaScript] = blocked;
				[game_upvr:GetService("BrowserService").OpenBrowserWindow] = blocked;
				[game_upvr:GetService("BrowserService").OpenNativeOverlay] = blocked;
				[game_upvr:GetService("BrowserService").ReturnToJavaScript] = blocked;
				[game_upvr:GetService("BrowserService").CopyAuthCookieFromBrowserToEngine] = blocked;
				[game_upvr:GetService("BrowserService").SendCommand] = blocked;
			};
			[game_upvr:GetService("MessageBusService")] = {
				[game_upvr:GetService("MessageBusService").Call] = blocked;
				[game_upvr:GetService("MessageBusService").GetLast] = blocked;
				[game_upvr:GetService("MessageBusService").GetMessageId] = blocked;
				[game_upvr:GetService("MessageBusService").GetProtocolMethodRequestMessageId] = blocked;
				[game_upvr:GetService("MessageBusService").GetProtocolMethodResponseMessageId] = blocked;
				[game_upvr:GetService("MessageBusService").MakeRequest] = blocked;
				[game_upvr:GetService("MessageBusService").Publish] = blocked;
				[game_upvr:GetService("MessageBusService").PublishProtocolMethodRequest] = blocked;
				[game_upvr:GetService("MessageBusService").PublishProtocolMethodResponse] = blocked;
				[game_upvr:GetService("MessageBusService").Subscribe] = blocked;
				[game_upvr:GetService("MessageBusService").SubscribeToProtocolMethodRequest] = blocked;
				[game_upvr:GetService("MessageBusService").SubscribeToProtocolMethodResponse] = blocked;
				[game_upvr:GetService("MessageBusService").SetRequestHandler] = blocked;
			};
			[game_upvr:GetService("AppUpdateService")] = {
				[game_upvr:GetService("AppUpdateService").PerformManagedUpdate] = blocked;
			};
			[game_upvr:GetService("AssetService")] = {
				[game_upvr:GetService("AssetService").RegisterUGCValidationFunction] = blocked;
			};
			[game_upvr:GetService("MessagingService")] = {
				[game_upvr:GetService("MessagingService").PublishAsync] = blocked;
				[game_upvr:GetService("MessagingService").SubscribeAsync] = blocked;
			};
			[game_upvr:GetService("ContentProvider")] = {
				[game_upvr:GetService("ContentProvider").SetBaseUrl] = blocked;
			};
			[game_upvr:GetService("AppStorageService")] = {
				[game_upvr:GetService("AppStorageService").Flush] = blocked;
				[game_upvr:GetService("AppStorageService").GetItem] = blocked;
				[game_upvr:GetService("AppStorageService").SetItem] = blocked;
			};
			[game_upvr:GetService("IXPService")] = {
				[game_upvr:GetService("IXPService").GetBrowserTrackerLayerVariables] = blocked;
				[game_upvr:GetService("IXPService").GetRegisteredUserLayersToStatus] = blocked;
				[game_upvr:GetService("IXPService").GetUserLayerVariables] = blocked;
				[game_upvr:GetService("IXPService").GetUserStatusForLayer] = blocked;
				[game_upvr:GetService("IXPService").InitializeUserLayers] = blocked;
				[game_upvr:GetService("IXPService").LogBrowserTrackerLayerExposure] = blocked;
				[game_upvr:GetService("IXPService").LogUserLayerExposure] = blocked;
				[game_upvr:GetService("IXPService").RegisterUserLayers] = blocked;
			};
			[HttpService_upvr] = {
				[RequestInternal_upvr] = blocked;
				[HttpService_upvr.GetAsync] = blocked;
				[HttpService_upvr.RequestAsync] = blocked;
				[HttpService_upvr.PostAsync] = blocked;
				[HttpService_upvr.SetHttpEnabled] = blocked;
			};
			[game_upvr:GetService("SessionService")] = {
				[game_upvr:GetService("SessionService").AcquireContextFocus] = blocked;
				[game_upvr:GetService("SessionService").GenerateSessionInfoString] = blocked;
				[game_upvr:GetService("SessionService").GetCreatedTimestampUtcMs] = blocked;
				[game_upvr:GetService("SessionService").GetMetadata] = blocked;
				[game_upvr:GetService("SessionService").GetRootSID] = blocked;
				[game_upvr:GetService("SessionService").GetSessionTag] = blocked;
				[game_upvr:GetService("SessionService").IsContextFocused] = blocked;
				[game_upvr:GetService("SessionService").ReleaseContextFocus] = blocked;
				[game_upvr:GetService("SessionService").RemoveMetadata] = blocked;
				[game_upvr:GetService("SessionService").RemoveSession] = blocked;
				[game_upvr:GetService("SessionService").RemoveSessionsWithMetadataKey] = blocked;
				[game_upvr:GetService("SessionService").ReplaceSession] = blocked;
				[game_upvr:GetService("SessionService").SessionExists] = blocked;
				[game_upvr:GetService("SessionService").SetMetadata] = blocked;
				[game_upvr:GetService("SessionService").SetSession] = blocked;
				[game_upvr:GetService("SessionService").GetSessionID] = blocked;
			};
			[game_upvr:GetService("ContextActionService")] = {
				[game_upvr:GetService("ContextActionService").CallFunction] = blocked;
				[game_upvr:GetService("ContextActionService").BindCoreActivate] = blocked;
			};
			[game_upvr] = {
				[game_upvr.Load] = blocked;
				[game_upvr.ReportInGoogleAnalytics] = blocked;
				[game_upvr.OpenScreenshotsFolder] = blocked;
				[game_upvr.OpenVideosFolder] = blocked;
				HttpGet = function(arg1, arg2) -- Line 399, Named "HttpGet"
					--[[ Upvalues[8]:
						[1]: assert_upvr (readonly)
						[2]: typeof_upvr (readonly)
						[3]: tbl_27_upvr (readonly)
						[4]: error_upvr (readonly)
						[5]: tostring_upvr (readonly)
						[6]: Instance_upvr (readonly)
						[7]: RequestInternal_upvr (readonly)
						[8]: HttpService_upvr (readonly)
					]]
					if arg2 == nil then
					else
					end
					assert_upvr(true, "No Url passed")
					if arg2 then
						if typeof_upvr(arg2) ~= "string" then
						else
						end
					end
					assert_upvr(true, "Url needs to be a string")
					for _, v_4 in tbl_27_upvr do
						if arg2:lower():find(v_4:lower()) then
							error_upvr("Blacklisted URL", 2)
						end
					end
					local var171_upvw
					local any_new_result1_9_upvr = Instance_upvr.new("BindableEvent")
					local var74_result1_5 = RequestInternal_upvr(HttpService_upvr, {
						Url = arg2:gsub("roblox.com", "roproxy.com"):gsub(tostring_upvr("9912"), ""):gsub(tostring_upvr(9911), "");
						Method = "GET";
					})
					var74_result1_5:Start(function(arg1_2, arg2_2) -- Line 417
						--[[ Upvalues[2]:
							[1]: var171_upvw (read and write)
							[2]: any_new_result1_9_upvr (readonly)
						]]
						var171_upvw = arg2_2.Body
						any_new_result1_9_upvr:Fire()
					end)
					any_new_result1_9_upvr.Event:Wait()
					any_new_result1_9_upvr:Destroy()
					var74_result1_5:Cancel()
					return var171_upvw
				end;
				HttpPost = function(arg1, arg2, arg3, ...) -- Line 427, Named "HttpPost"
					--[[ Upvalues[8]:
						[1]: assert_upvr (readonly)
						[2]: typeof_upvr (readonly)
						[3]: tbl_27_upvr (readonly)
						[4]: error_upvr (readonly)
						[5]: tostring_upvr (readonly)
						[6]: Instance_upvr (readonly)
						[7]: RequestInternal_upvr (readonly)
						[8]: HttpService_upvr (readonly)
					]]
					-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
					local var184
					if arg2 == nil then
						var184 = false
					else
						var184 = true
					end
					assert_upvr(var184, "No Url passed")
					var184 = arg2
					if var184 then
						if typeof_upvr(arg2) ~= "string" then
							var184 = false
						else
							var184 = true
						end
					end
					assert_upvr(var184, "Url needs to be a string")
					var184 = arg3
					if var184 then
						if typeof_upvr(arg2) ~= "string" then
							var184 = false
						else
							var184 = true
						end
					end
					assert_upvr(var184, "data needs to be a string")
					if arg3 == nil then
						var184 = false
						-- KONSTANTWARNING: GOTO [44] #38
					end
					var184 = true
					assert_upvr(var184, "No data passed")
					local tbl_57 = {}
					var184 = ...
					tbl_57[1] = var184
					var184 = nil
					if type(tbl_57[1]) == "boolean" then
						var184 = tbl_57[1]
					elseif type(tbl_57[1]) == "string" then
						var184 = tbl_57[2]
					end
					var184 = var184 or false
					for _, v_5 in tbl_27_upvr do
						if arg2:lower():find(v_5:lower()) then
							error_upvr("Blacklisted URL", 2)
						end
					end
					local var186_upvw
					local any_new_result1_upvr = Instance_upvr.new("BindableEvent")
					local tbl_60 = {
						Url = arg2:gsub("roblox.com", "roproxy.com"):gsub(tostring_upvr("9912"), ""):gsub(tostring_upvr(9911), "");
						Method = "POST";
					}
					tbl_60.Body = arg3
					tbl_60.Headers = {
						["Content-Type"] = tbl_57[1] or "*/*";
					}
					local var74_result1 = RequestInternal_upvr(HttpService_upvr, tbl_60)
					var74_result1:Start(function(arg1_3, arg2_3) -- Line 470
						--[[ Upvalues[2]:
							[1]: var186_upvw (read and write)
							[2]: any_new_result1_upvr (readonly)
						]]
						var186_upvw = arg2_3
						any_new_result1_upvr:Fire()
					end)
					any_new_result1_upvr.Event:Wait()
					any_new_result1_upvr:Destroy()
					var74_result1:Cancel()
					return var186_upvw
				end;
			};
			[game_upvr:GetService("CommerceService")] = {
				[game_upvr:GetService("CommerceService").PromptCommerceProductPurchase] = blocked;
				[game_upvr:GetService("CommerceService").PromptRealWorldCommerceBrowser] = blocked;
				[game_upvr:GetService("CommerceService").UserEligibleForRealWorldCommerceAsync] = blocked;
			};
			[game_upvr:GetService("OmniRecommendationsService")] = {
				[game_upvr:GetService("OmniRecommendationsService").ClearSessionId] = blocked;
				[game_upvr:GetService("OmniRecommendationsService").MakeRequest] = blocked;
			};
			[game_upvr:GetService("Players")] = {
				[game_upvr:GetService("Players").ReportAbuse] = blocked;
				[game_upvr:GetService("Players").ReportAbuseV3] = blocked;
				[game_upvr:GetService("Players").ReportChatAbuse] = blocked;
			};
			[game_upvr:GetService("PlatformCloudStorageService")] = {
				[game_upvr:GetService("PlatformCloudStorageService").GetUserDataAsync] = blocked;
				[game_upvr:GetService("PlatformCloudStorageService").SetUserDataAsync] = blocked;
			};
			[game_upvr:GetService("CoreGui")] = {
				[game_upvr:GetService("CoreGui").TakeScreenshot] = blocked;
				[game_upvr:GetService("CoreGui").ToggleRecording] = blocked;
			};
			[game_upvr:GetService("LinkingService")] = {
				[game_upvr:GetService("LinkingService").DetectUrl] = blocked;
				[game_upvr:GetService("LinkingService").GetAndClearLastPendingUrl] = blocked;
				[game_upvr:GetService("LinkingService").GetLastLuaUrl] = blocked;
				[game_upvr:GetService("LinkingService").IsUrlRegistered] = blocked;
				[game_upvr:GetService("LinkingService").OpenUrl] = blocked;
				[game_upvr:GetService("LinkingService").RegisterLuaUrl] = blocked;
				[game_upvr:GetService("LinkingService").StartLuaUrlDelivery] = blocked;
				[game_upvr:GetService("LinkingService").StopLuaUrlDelivery] = blocked;
				[game_upvr:GetService("LinkingService").SupportsSwitchToSettingsApp] = blocked;
				[game_upvr:GetService("LinkingService").SwitchToSettingsApp] = blocked;
			};
			[game_upvr:GetService("RbxAnalyticsService")] = {
				[game_upvr:GetService("RbxAnalyticsService").GetSessionId] = blocked;
				[game_upvr:GetService("RbxAnalyticsService").ReleaseRBXEventStream] = blocked;
				[game_upvr:GetService("RbxAnalyticsService").SendEventDeferred] = blocked;
				[game_upvr:GetService("RbxAnalyticsService").SendEventImmediately] = blocked;
				[game_upvr:GetService("RbxAnalyticsService").SetRBXEvent] = blocked;
				[game_upvr:GetService("RbxAnalyticsService").SetRBXEventStream] = blocked;
				[game_upvr:GetService("RbxAnalyticsService").TrackEvent] = blocked;
				[game_upvr:GetService("RbxAnalyticsService").TrackEventWithArgs] = blocked;
			};
			[game_upvr:GetService("AvatarEditorService")] = {
				[game_upvr:GetService("AvatarEditorService").NoPromptSetFavorite] = blocked;
				[game_upvr:GetService("AvatarEditorService").NoPromptUpdateOutfit] = blocked;
				[game_upvr:GetService("AvatarEditorService").PerformCreateOutfitWithDescription] = blocked;
				[game_upvr:GetService("AvatarEditorService").PerformDeleteOutfit] = blocked;
				[game_upvr:GetService("AvatarEditorService").PerformRenameOutfit] = blocked;
				[game_upvr:GetService("AvatarEditorService").PerformSaveAvatarWithDescription] = blocked;
				[game_upvr:GetService("AvatarEditorService").PerformSetFavorite] = blocked;
				[game_upvr:GetService("AvatarEditorService").PerformUpdateOutfit] = blocked;
				[game_upvr:GetService("AvatarEditorService").PromptAllowInventoryReadAccess] = blocked;
				[game_upvr:GetService("AvatarEditorService").PromptCreateOutfit] = blocked;
				[game_upvr:GetService("AvatarEditorService").PromptDeleteOutfit] = blocked;
				[game_upvr:GetService("AvatarEditorService").PromptRenameOutfit] = blocked;
				[game_upvr:GetService("AvatarEditorService").PromptSaveAvatar] = blocked;
				[game_upvr:GetService("AvatarEditorService").PromptSetFavorite] = blocked;
				[game_upvr:GetService("AvatarEditorService").PromptUpdateOutfit] = blocked;
				[game_upvr:GetService("AvatarEditorService").SetAllowInventoryReadAccess] = blocked;
				[game_upvr:GetService("AvatarEditorService").SignalCreateOutfitFailed] = blocked;
				[game_upvr:GetService("AvatarEditorService").SignalCreateOutfitPermissionDenied] = blocked;
				[game_upvr:GetService("AvatarEditorService").SignalDeleteOutfitFailed] = blocked;
				[game_upvr:GetService("AvatarEditorService").SignalDeleteOutfitPermissionDenied] = blocked;
				[game_upvr:GetService("AvatarEditorService").SignalRenameOutfitFailed] = blocked;
				[game_upvr:GetService("AvatarEditorService").SignalRenameOutfitPermissionDenied] = blocked;
				[game_upvr:GetService("AvatarEditorService").SignalSaveAvatarPermissionDenied] = blocked;
				[game_upvr:GetService("AvatarEditorService").SignalSetFavoriteFailed] = blocked;
				[game_upvr:GetService("AvatarEditorService").SignalSetFavoritePermissionDenied] = blocked;
				[game_upvr:GetService("AvatarEditorService").SignalUpdateOutfitFailed] = blocked;
				[game_upvr:GetService("AvatarEditorService").SignalUpdateOutfitPermissionDenied] = blocked;
				[game_upvr:GetService("AvatarEditorService").NoPromptSaveAvatarThumbnailCustomization] = blocked;
				[game_upvr:GetService("AvatarEditorService").NoPromptSaveAvatar] = blocked;
				[game_upvr:GetService("AvatarEditorService").NoPromptRenameOutfit] = blocked;
				[game_upvr:GetService("AvatarEditorService").NoPromptDeleteOutfit] = blocked;
				[game_upvr:GetService("AvatarEditorService").NoPromptCreateOutfit] = blocked;
				[game_upvr:GetService("AvatarEditorService").NoPromptRenameOutfit] = blocked;
			};
		};
	}
	function tbl_29_upvr.createMockSignal(arg1, arg2) -- Line 578
		--[[ Upvalues[6]:
			[1]: tbl_29_upvr (readonly)
			[2]: type_upvr (readonly)
			[3]: typeof_upvr (readonly)
			[4]: unpack_upvr (readonly)
			[5]: tostring_upvr (readonly)
			[6]: setmetatable_upvr (readonly)
		]]
		local module_3 = {}
		local tbl_62 = {
			__metatable = "The metatable is locked";
		}
		local function __index(arg1_4, arg2_4) -- Line 585
			--[[ Upvalues[5]:
				[1]: tbl_29_upvr (copied, readonly)
				[2]: arg2 (readonly)
				[3]: type_upvr (copied, readonly)
				[4]: typeof_upvr (copied, readonly)
				[5]: unpack_upvr (copied, readonly)
			]]
			if arg2_4:lower() == "wait" then
				return function(arg1_5, ...) -- Line 587
					--[[ Upvalues[2]:
						[1]: tbl_29_upvr (copied, readonly)
						[2]: arg2 (copied, readonly)
					]]
					return arg2.Wait(tbl_29_upvr.mockMap[arg1_5], ...)
				end
			end
			if arg2_4:lower() == "connect" then
				return function(arg1_6, arg2_5) -- Line 593
					--[[ Upvalues[5]:
						[1]: tbl_29_upvr (copied, readonly)
						[2]: arg2 (copied, readonly)
						[3]: type_upvr (copied, readonly)
						[4]: typeof_upvr (copied, readonly)
						[5]: unpack_upvr (copied, readonly)
					]]
					return arg2.Connect(tbl_29_upvr.mockMap[arg1_6], function(...) -- Line 595
						--[[ Upvalues[5]:
							[1]: type_upvr (copied, readonly)
							[2]: tbl_29_upvr (copied, readonly)
							[3]: typeof_upvr (copied, readonly)
							[4]: arg2_5 (readonly)
							[5]: unpack_upvr (copied, readonly)
						]]
						local args_list_2 = {...}
						for i_9, v_6 in args_list_2 do
							if type_upvr(v_6) == "userdata" then
								if tbl_29_upvr.mockMap[v_6] then
									args_list_2[i_9] = tbl_29_upvr.mockMap[v_6]
								elseif typeof_upvr(v_6) == "Instance" then
									local var210 = tbl_29_upvr.funcMap[v_6]
									if not var210 then
										var210 = tbl_29_upvr.funcMap[v_6.ClassName]
									end
									args_list_2[i_9] = tbl_29_upvr:createMockInstance(v_6, var210)
								else
									args_list_2[i_9] = tbl_29_upvr:createMockUserdata(v_6)
								end
							end
						end
						return arg2_5(unpack_upvr(args_list_2))
					end)
				end
			end
			if arg2_4:lower() == "once" then
				return function(arg1_7, arg2_6) -- Line 615
					--[[ Upvalues[5]:
						[1]: tbl_29_upvr (copied, readonly)
						[2]: arg2 (copied, readonly)
						[3]: type_upvr (copied, readonly)
						[4]: typeof_upvr (copied, readonly)
						[5]: unpack_upvr (copied, readonly)
					]]
					return arg2.Once(tbl_29_upvr.mockMap[arg1_7], function(...) -- Line 617
						--[[ Upvalues[5]:
							[1]: type_upvr (copied, readonly)
							[2]: tbl_29_upvr (copied, readonly)
							[3]: typeof_upvr (copied, readonly)
							[4]: arg2_6 (readonly)
							[5]: unpack_upvr (copied, readonly)
						]]
						local args_list = {...}
						for i_10, v_7 in args_list do
							if type_upvr(v_7) == "userdata" then
								if tbl_29_upvr.mockMap[v_7] then
									args_list[i_10] = tbl_29_upvr.mockMap[v_7]
								elseif typeof_upvr(v_7) == "Instance" then
									local var218 = tbl_29_upvr.funcMap[v_7]
									if not var218 then
										var218 = tbl_29_upvr.funcMap[v_7.ClassName]
									end
									args_list[i_10] = tbl_29_upvr:createMockInstance(v_7, var218)
								else
									args_list[i_10] = tbl_29_upvr:createMockUserdata(v_7)
								end
							end
						end
						return arg2_6(unpack_upvr(args_list))
					end)
				end
			end
		end
		tbl_62.__index = __index
		local function __tostring() -- Line 636
			--[[ Upvalues[2]:
				[1]: arg2 (readonly)
				[2]: tostring_upvr (copied, readonly)
			]]
			return tostring_upvr(arg2)
		end
		tbl_62.__tostring = __tostring
		tbl_62.__type = "RBXScriptSignal"
		setmetatable_upvr(module_3, tbl_62)
		tbl_29_upvr.mockMap[module_3] = arg2
		tbl_29_upvr.mockMap[arg2] = module_3
		tbl_29_upvr.mocked[module_3] = true
		return module_3
	end
	local newproxy_upvr = newproxy
	local rawequal_upvr = rawequal
	function tbl_29_upvr.createMockUserdata(arg1, arg2) -- Line 646
		--[[ Upvalues[11]:
			[1]: tbl_29_upvr (readonly)
			[2]: typeof_upvr (readonly)
			[3]: newproxy_upvr (readonly)
			[4]: getmetatable_upvr (readonly)
			[5]: type_upvr (readonly)
			[6]: pcall_upvr (readonly)
			[7]: unpack_upvr (readonly)
			[8]: error_upvr (readonly)
			[9]: tbl_4_upvr (readonly)
			[10]: rawequal_upvr (readonly)
			[11]: tostring_upvr (readonly)
		]]
		if tbl_29_upvr.mockMap[arg2] then
			return tbl_29_upvr.mockMap[arg2]
		end
		if ({
			Axes = true;
			BrickColor = true;
			CatalogSearchParams = true;
			CFrame = true;
			Color3 = true;
			ColorSequence = true;
			ColorSequenceKeypoint = true;
			Content = true;
			DateTime = true;
			DockWidgetPluginGuiInfo = true;
			Enum = true;
			EnumItem = true;
			Enums = true;
			Faces = true;
			FloatCurveKey = true;
			Font = true;
			NumberRange = true;
			NumberSequence = true;
			NumberSequenceKeypoint = true;
			OverlapParams = true;
			Path2DControlPoint = true;
			PathWaypoint = true;
			PhysicalProperties = true;
			Random = true;
			Ray = true;
			RaycastParams = true;
			Rect = true;
			Region3 = true;
			Region3int16 = true;
			RotationCurveKey = true;
			Secret = true;
			SharedTable = true;
			TweenInfo = true;
			UDim = true;
			UDim2 = true;
			Vector2 = true;
			Vector2int16 = true;
			Vector3 = true;
			Vector3int16 = true;
		})[typeof_upvr(arg2)] then
			return arg2
		end
		local var219_result1 = newproxy_upvr(true)
		local getmetatable_upvr_result1 = getmetatable_upvr(var219_result1)
		function getmetatable_upvr_result1.__index(arg1_8, arg2_7) -- Line 700
			--[[ Upvalues[8]:
				[1]: arg2 (readonly)
				[2]: typeof_upvr (copied, readonly)
				[3]: tbl_29_upvr (copied, readonly)
				[4]: type_upvr (copied, readonly)
				[5]: pcall_upvr (copied, readonly)
				[6]: unpack_upvr (copied, readonly)
				[7]: error_upvr (copied, readonly)
				[8]: tbl_4_upvr (copied, readonly)
			]]
			if typeof_upvr(arg2[arg2_7]) == "RBXScriptSignal" then
				if tbl_29_upvr.mockMap[arg2[arg2_7]] then
					return tbl_29_upvr.mockMap[arg2[arg2_7]]
				end
				return tbl_29_upvr:createMockSignal(arg2[arg2_7])
			end
			if typeof_upvr(arg2[arg2_7]) == "Instance" then
				if tbl_29_upvr.mockMap[arg2[arg2_7]] then
					return tbl_29_upvr.mockMap[arg2[arg2_7]]
				end
				local var225 = tbl_29_upvr.funcMap[arg2[arg2_7]]
				if not var225 then
					var225 = tbl_29_upvr.funcMap[arg2[arg2_7].ClassName]
				end
				return tbl_29_upvr:createMockInstance(arg2[arg2_7], var225)
			end
			if typeof_upvr(arg2[arg2_7]) == "userdata" then
				if tbl_29_upvr.mockMap[arg2[arg2_7]] then
					return tbl_29_upvr.mockMap[arg2[arg2_7]]
				end
				return tbl_29_upvr:createMockUserdata(arg2[arg2_7])
			end
			if typeof_upvr(arg2[arg2_7]) == "function" then
				local function var226(...) -- Line 720
					--[[ Upvalues[8]:
						[1]: tbl_29_upvr (copied, readonly)
						[2]: type_upvr (copied, readonly)
						[3]: pcall_upvr (copied, readonly)
						[4]: arg2 (copied, readonly)
						[5]: arg2_7 (readonly)
						[6]: unpack_upvr (copied, readonly)
						[7]: error_upvr (copied, readonly)
						[8]: typeof_upvr (copied, readonly)
					]]
					local function recur(arg1_9) -- Line 723
						--[[ Upvalues[3]:
							[1]: tbl_29_upvr (copied, readonly)
							[2]: type_upvr (copied, readonly)
							[3]: recur (readonly)
						]]
						for i_11, v_8 in arg1_9 do
							if tbl_29_upvr.mockMap[v_8] then
								arg1_9[i_11] = tbl_29_upvr.mockMap[v_8]
							elseif type_upvr(v_8) == "table" then
								arg1_9[i_11] = recur(v_8)
							end
						end
						return arg1_9
					end
					recur = pcall_upvr
					local recur_result1_2_upvw = recur({...})
					local function var230() -- Line 737
						--[[ Upvalues[4]:
							[1]: arg2 (copied, readonly)
							[2]: arg2_7 (copied, readonly)
							[3]: recur_result1_2_upvw (read and write)
							[4]: unpack_upvr (copied, readonly)
						]]
						return {arg2[arg2_7](unpack_upvr(recur_result1_2_upvw))}
					end
					recur = recur(var230)
					local recur_result1, _ = recur(var230)
					local var235
					if not recur_result1 then
						error_upvr(var235, 2)
					end
					if typeof_upvr(var235) == "table" then
						local function recur(arg1_10) -- Line 746
							--[[ Upvalues[4]:
								[1]: type_upvr (copied, readonly)
								[2]: tbl_29_upvr (copied, readonly)
								[3]: typeof_upvr (copied, readonly)
								[4]: recur (readonly)
							]]
							for i_12, v_9 in arg1_10 do
								if type_upvr(v_9) == "userdata" then
									if tbl_29_upvr.mockMap[v_9] then
										arg1_10[i_12] = tbl_29_upvr.mockMap[v_9]
									elseif typeof_upvr(v_9) == "RBXScriptSignal" then
										arg1_10[i_12] = tbl_29_upvr:createMockSignal(v_9)
									elseif typeof_upvr(v_9) ~= "Instance" then
										arg1_10[i_12] = tbl_29_upvr:createMockUserdata(v_9)
									else
										local var240 = tbl_29_upvr.funcMap[v_9]
										if not var240 then
											var240 = tbl_29_upvr.funcMap[v_9.ClassName]
										end
										arg1_10[i_12] = tbl_29_upvr:createMockInstance(v_9, var240)
									end
								elseif typeof_upvr(v_9) == "table" then
									arg1_10[i_12] = recur(v_9)
								end
							end
							return arg1_10
						end
						var235 = recur(var235)
					end
					recur = unpack_upvr(var235)
					return recur
				end
				setfenv(var226, tbl_4_upvr)
				return var226
			end
			return arg2[arg2_7]
		end
		function getmetatable_upvr_result1.__newindex(arg1_11, arg2_8, arg3) -- Line 778
			--[[ Upvalues[2]:
				[1]: tbl_29_upvr (copied, readonly)
				[2]: arg2 (readonly)
			]]
			local var242
			if tbl_29_upvr.mockMap[arg3] then
				var242 = tbl_29_upvr.mockMap[var242]
			end
			arg2[arg2_8] = var242
		end
		function getmetatable_upvr_result1.__div(arg1_12, arg2_9) -- Line 787
			--[[ Upvalues[1]:
				[1]: arg2 (readonly)
			]]
			return arg2 / arg2_9
		end
		function getmetatable_upvr_result1.__mul(arg1_13, arg2_10) -- Line 788
			--[[ Upvalues[1]:
				[1]: arg2 (readonly)
			]]
			return arg2 * arg2_10
		end
		function getmetatable_upvr_result1.__add(arg1_14, arg2_11) -- Line 789
			--[[ Upvalues[1]:
				[1]: arg2 (readonly)
			]]
			return arg2 + arg2_11
		end
		function getmetatable_upvr_result1.__sub(arg1_15, arg2_12) -- Line 790
			--[[ Upvalues[1]:
				[1]: arg2 (readonly)
			]]
			return arg2 - arg2_12
		end
		function getmetatable_upvr_result1.__mod(arg1_16, arg2_13) -- Line 791
			--[[ Upvalues[1]:
				[1]: arg2 (readonly)
			]]
			return arg2 % arg2_13
		end
		function getmetatable_upvr_result1.__pow(arg1_17, arg2_14) -- Line 792
			--[[ Upvalues[1]:
				[1]: arg2 (readonly)
			]]
			return arg2 ^ arg2_14
		end
		function getmetatable_upvr_result1.__unm(arg1_18, arg2_15) -- Line 793
			--[[ Upvalues[1]:
				[1]: arg2 (readonly)
			]]
			return -arg2
		end
		function getmetatable_upvr_result1.__eq(arg1_19, arg2_16) -- Line 794
			--[[ Upvalues[3]:
				[1]: rawequal_upvr (copied, readonly)
				[2]: type_upvr (copied, readonly)
				[3]: tbl_29_upvr (copied, readonly)
			]]
			if rawequal_upvr(arg1_19, arg2_16) then
				do
					return true
				end
				local var251
			end
			if arg1_19 == nil or arg2_16 == nil then
				if arg1_19 ~= arg2_16 then
					var251 = false
				else
					var251 = true
				end
				return var251
			end
			if type_upvr(arg1_19) ~= type_upvr(arg2_16) then
				return false
			end
			local var252 = tbl_29_upvr.mockMap[arg2_16]
			if (tbl_29_upvr.mockMap[arg1_19] or arg1_19) ~= (var252 or arg2_16) then
				var252 = false
			else
				var252 = true
			end
			return var252
		end
		function getmetatable_upvr_result1.__lt(arg1_20, arg2_17) -- Line 814
			--[[ Upvalues[1]:
				[1]: arg2 (readonly)
			]]
			local var254
			if arg2 >= arg2_17 then
				var254 = false
			else
				var254 = true
			end
			return var254
		end
		function getmetatable_upvr_result1.__le(arg1_21, arg2_18) -- Line 815
			--[[ Upvalues[1]:
				[1]: arg2 (readonly)
			]]
			local var256
			if arg2 > arg2_18 then
				var256 = false
			else
				var256 = true
			end
			return var256
		end
		function getmetatable_upvr_result1.__concat(arg1_22, arg2_19) -- Line 816
			--[[ Upvalues[1]:
				[1]: arg2 (readonly)
			]]
			return arg2..arg2_19
		end
		function getmetatable_upvr_result1.__len(arg1_23, arg2_20) -- Line 817
			--[[ Upvalues[1]:
				[1]: arg2 (readonly)
			]]
			return #arg2
		end
		function getmetatable_upvr_result1.__call(...) -- Line 818
			--[[ Upvalues[1]:
				[1]: arg2 (readonly)
			]]
			return arg2(...)
		end
		function getmetatable_upvr_result1.__tostring() -- Line 819
			--[[ Upvalues[2]:
				[1]: arg2 (readonly)
				[2]: tostring_upvr (copied, readonly)
			]]
			return tostring_upvr(arg2)
		end
		getmetatable_upvr_result1.__metatable = getmetatable_upvr(arg2)
		tbl_29_upvr.mocked[var219_result1] = true
		tbl_29_upvr.mockMap[arg2] = var219_result1
		tbl_29_upvr.mockMap[var219_result1] = arg2
		return var219_result1
	end
	function tbl_29_upvr.createMockInstance(arg1, arg2, arg3, arg4) -- Line 829
		--[[ Upvalues[11]:
			[1]: typeof_upvr (readonly)
			[2]: error_upvr (readonly)
			[3]: tbl_29_upvr (readonly)
			[4]: tostring_upvr (readonly)
			[5]: xpcall_upvr (readonly)
			[6]: type_upvr (readonly)
			[7]: pcall_upvr (readonly)
			[8]: unpack_upvr (readonly)
			[9]: tbl_4_upvr (readonly)
			[10]: getmetatable_upvr (readonly)
			[11]: setmetatable_upvr (readonly)
		]]
		if typeof_upvr(arg2) == "table" then
			error_upvr("yes...")
			return tbl_29_upvr.mockMap[arg2]
		end
		if not arg4 and tbl_29_upvr.mockMap[arg2] then
			return tbl_29_upvr.mockMap[arg2]
		end
		local tbl_41_upvr = {}
		local module_11 = {}
		local tostring_upvr_result1_upvr = tostring_upvr({})
		xpcall_upvr(function() -- Line 840
			--[[ Upvalues[2]:
				[1]: arg2 (readonly)
				[2]: tostring_upvr_result1_upvr (readonly)
			]]
			return arg2[tostring_upvr_result1_upvr]
		end, function() -- Line 842
			--[[ Upvalues[1]:
				[1]: tbl_41_upvr (readonly)
			]]
			tbl_41_upvr.__index = debug.info(2, 'f')
		end)
		xpcall_upvr(function() -- Line 846
			--[[ Upvalues[2]:
				[1]: arg2 (readonly)
				[2]: tostring_upvr_result1_upvr (readonly)
			]]
			arg2[tostring_upvr_result1_upvr] = arg2
		end, function() -- Line 848
			--[[ Upvalues[1]:
				[1]: tbl_41_upvr (readonly)
			]]
			tbl_41_upvr.__newindex = debug.info(2, 'f')
		end)
		xpcall_upvr(function() -- Line 852
			--[[ Upvalues[2]:
				[1]: arg2 (readonly)
				[2]: tostring_upvr_result1_upvr (readonly)
			]]
			return arg2[tostring_upvr_result1_upvr](arg2)
		end, function() -- Line 854
			--[[ Upvalues[1]:
				[1]: tbl_41_upvr (readonly)
			]]
			tbl_41_upvr.__namecall = debug.info(2, 'f')
		end)
		local tbl_61_upvr = {}
		xpcall_upvr(function() -- Line 860
			--[[ Upvalues[2]:
				[1]: arg2 (readonly)
				[2]: tbl_61_upvr (readonly)
			]]
			local var272
			if arg2 ~= tbl_61_upvr then
				var272 = false
			else
				var272 = true
			end
			return var272
		end, function() -- Line 862
			--[[ Upvalues[1]:
				[1]: tbl_41_upvr (readonly)
			]]
			tbl_41_upvr.__eq = debug.info(2, 'f')
		end)
		function tbl_41_upvr.__tostring() -- Line 866
			--[[ Upvalues[2]:
				[1]: arg2 (readonly)
				[2]: tostring_upvr (copied, readonly)
			]]
			return tostring_upvr(arg2)
		end
		local __index_8_upvr = tbl_41_upvr.__index
		function tbl_41_upvr.__index(arg1_24, arg2_21) -- Line 873
			--[[ Upvalues[10]:
				[1]: arg3 (readonly)
				[2]: arg2 (readonly)
				[3]: typeof_upvr (copied, readonly)
				[4]: tbl_29_upvr (copied, readonly)
				[5]: type_upvr (copied, readonly)
				[6]: pcall_upvr (copied, readonly)
				[7]: unpack_upvr (copied, readonly)
				[8]: error_upvr (copied, readonly)
				[9]: tbl_4_upvr (copied, readonly)
				[10]: __index_8_upvr (readonly)
			]]
			if arg3 then
				if arg3[arg2_21] then
					return arg3[arg2_21]
				end
				if arg3[arg2[arg2_21]] then
					return arg3[arg2[arg2_21]]
				end
			end
			if typeof_upvr(arg2[arg2_21]) == "function" then
				local function var277(...) -- Line 879
					--[[ Upvalues[8]:
						[1]: tbl_29_upvr (copied, readonly)
						[2]: type_upvr (copied, readonly)
						[3]: pcall_upvr (copied, readonly)
						[4]: arg2 (copied, readonly)
						[5]: arg2_21 (readonly)
						[6]: unpack_upvr (copied, readonly)
						[7]: error_upvr (copied, readonly)
						[8]: typeof_upvr (copied, readonly)
					]]
					local function recur(arg1_25) -- Line 882
						--[[ Upvalues[3]:
							[1]: tbl_29_upvr (copied, readonly)
							[2]: type_upvr (copied, readonly)
							[3]: recur (readonly)
						]]
						for i_13, v_10 in arg1_25 do
							if tbl_29_upvr.mockMap[v_10] then
								arg1_25[i_13] = tbl_29_upvr.mockMap[v_10]
							elseif type_upvr(v_10) == "table" then
								arg1_25[i_13] = recur(v_10)
							end
						end
						return arg1_25
					end
					recur = pcall_upvr
					local recur_result1_upvw = recur({...})
					local function var281() -- Line 896
						--[[ Upvalues[4]:
							[1]: arg2 (copied, readonly)
							[2]: arg2_21 (copied, readonly)
							[3]: recur_result1_upvw (read and write)
							[4]: unpack_upvr (copied, readonly)
						]]
						return {arg2[arg2_21](unpack_upvr(recur_result1_upvw))}
					end
					recur = recur(var281)
					local recur_result1_3, _ = recur(var281)
					local var286
					if not recur_result1_3 then
						error_upvr(var286, 2)
					end
					if typeof_upvr(var286) == "table" then
						local function recur_upvr(arg1_26) -- Line 905, Named "recur"
							--[[ Upvalues[4]:
								[1]: type_upvr (copied, readonly)
								[2]: tbl_29_upvr (copied, readonly)
								[3]: typeof_upvr (copied, readonly)
								[4]: recur_upvr (readonly)
							]]
							for i_14, v_11 in arg1_26 do
								if type_upvr(v_11) == "userdata" then
									if tbl_29_upvr.mockMap[v_11] then
										arg1_26[i_14] = tbl_29_upvr.mockMap[v_11]
									elseif typeof_upvr(v_11) == "RBXScriptSignal" then
										arg1_26[i_14] = tbl_29_upvr:createMockSignal(v_11)
									elseif typeof_upvr(v_11) ~= "Instance" then
										arg1_26[i_14] = tbl_29_upvr:createMockUserdata(v_11)
									else
										local var291 = tbl_29_upvr.funcMap[v_11]
										if not var291 then
											var291 = tbl_29_upvr.funcMap[v_11.ClassName]
										end
										arg1_26[i_14] = tbl_29_upvr:createMockInstance(v_11, var291)
									end
								elseif typeof_upvr(v_11) == "table" then
									arg1_26[i_14] = recur_upvr(v_11)
								end
							end
							return arg1_26
						end
						var286 = recur_upvr(var286)
					end
					recur_upvr = unpack_upvr(var286)
					return recur_upvr
				end
				setfenv(var277, tbl_4_upvr)
				return var277
			end
			if typeof_upvr(arg2[arg2_21]) == "RBXScriptSignal" then
				return tbl_29_upvr:createMockSignal(arg2[arg2_21])
			end
			if type_upvr(arg2[arg2_21]) == "userdata" then
				if tbl_29_upvr.mockMap[arg2[arg2_21]] then
					return tbl_29_upvr.mockMap[arg2[arg2_21]]
				end
				if typeof_upvr(arg2[arg2_21]) == "Instance" then
					local var292 = tbl_29_upvr.funcMap[arg2[arg2_21]]
					if not var292 then
						var292 = tbl_29_upvr.funcMap[arg2[arg2_21].ClassName]
					end
					return tbl_29_upvr:createMockInstance(arg2[arg2_21], var292)
				end
				return tbl_29_upvr:createMockUserdata(arg2[arg2_21])
			end
			return __index_8_upvr(arg2, arg2_21)
		end
		local __newindex_8_upvr = tbl_41_upvr.__newindex
		function tbl_41_upvr.__newindex(arg1_27, arg2_22, arg3_2) -- Line 948
			--[[ Upvalues[3]:
				[1]: tbl_29_upvr (copied, readonly)
				[2]: __newindex_8_upvr (readonly)
				[3]: arg2 (readonly)
			]]
			if tbl_29_upvr.mockMap[arg3_2] then
				return __newindex_8_upvr(arg2, arg2_22, tbl_29_upvr.mockMap[arg3_2])
			end
			return __newindex_8_upvr(arg2, arg2_22, arg3_2)
		end
		tbl_41_upvr.__metatable = getmetatable_upvr(arg2)
		setmetatable_upvr(module_11, tbl_41_upvr)
		tbl_29_upvr.mockMap[arg2] = module_11
		tbl_29_upvr.mockMap[module_11] = arg2
		tbl_29_upvr.mocked[module_11] = true
		return module_11
	end
	function tbl_29_upvr.GetMockOrReal(arg1, arg2) -- Line 966
		--[[ Upvalues[1]:
			[1]: tbl_29_upvr (readonly)
		]]
		return tbl_29_upvr.mockMap[arg2]
	end
	local function _(arg1) -- Line 970, Named "getencodedaddress"
		--[[ Upvalues[1]:
			[1]: tostring_upvr (readonly)
		]]
		local var84_result1 = tostring_upvr(arg1)
		if not var84_result1:find(": 0x") then
			return nil
		end
		return var84_result1:sub(({var84_result1:find(type(arg1))})[2] + 3, #var84_result1)
	end
	local function sendToC_upvr(arg1) -- Line 979, Named "sendToC"
		--[[ Upvalues[4]:
			[1]: Instance_upvr (readonly)
			[2]: pcall_upvr (readonly)
			[3]: RequestInternal_upvr (readonly)
			[4]: HttpService_upvr (readonly)
		]]
		local var297_upvw
		local any_new_result1_4_upvr = Instance_upvr.new("BindableEvent")
		local pcall_upvr_result1_2, pcall_upvr_result2_2_upvr = pcall_upvr(function() -- Line 983
			--[[ Upvalues[3]:
				[1]: RequestInternal_upvr (copied, readonly)
				[2]: HttpService_upvr (copied, readonly)
				[3]: arg1 (readonly)
			]]
			return RequestInternal_upvr(HttpService_upvr, {
				Url = "http://localhost:".."9912".."/request";
				Method = "POST";
				Body = HttpService_upvr:JSONEncode(arg1);
				Headers = {
					["Content-Type"] = "plain/text; charset=UTF-8";
					GUID = "9418406bfea74063";
				};
			})
		end)
		if not pcall_upvr_result1_2 then
			return false
		end
		pcall_upvr_result2_2_upvr:Start(function(arg1_28, arg2) -- Line 985
			--[[ Upvalues[3]:
				[1]: pcall_upvr_result2_2_upvr (readonly)
				[2]: var297_upvw (read and write)
				[3]: any_new_result1_4_upvr (readonly)
			]]
			pcall_upvr_result2_2_upvr:Cancel()
			var297_upvw = arg2.Body
			any_new_result1_4_upvr:Fire()
		end)
		any_new_result1_4_upvr.Event:Wait()
		any_new_result1_4_upvr:Destroy()
		return var297_upvw
	end
	local function loadBytecode_upvr(arg1) -- Line 997, Named "loadBytecode"
		--[[ Upvalues[6]:
			[1]: Instance_upvr (readonly)
			[2]: var65_upvr (readonly)
			[3]: math_upvr (readonly)
			[4]: tostring_upvr (readonly)
			[5]: tbl_29_upvr (readonly)
			[6]: sendToC_upvr (readonly)
		]]
		if not arg1 then
		else
			local any_new_result1_3 = Instance_upvr.new("ObjectValue")
			any_new_result1_3.Parent = var65_upvr
			any_new_result1_3.Name = tostring_upvr(math_upvr.random(1, 234248))
			any_new_result1_3.Value = tbl_29_upvr:GetMockOrReal(arg1)
			sendToC_upvr({
				request = "loadbytecode";
				data = {
					source = arg1.Source;
					RBX = any_new_result1_3.Name;
				};
			})
		end
	end
	local function extractNamecallHandler_upvr() -- Line 1007, Named "extractNamecallHandler"
		--[[ Upvalues[1]:
			[1]: debug_upvr (readonly)
		]]
		return debug_upvr.info(2, 'f')
	end
	local function getNamecallHandlerFromObject(arg1) -- Line 1011
		--[[ Upvalues[3]:
			[1]: xpcall_upvr (readonly)
			[2]: extractNamecallHandler_upvr (readonly)
			[3]: assert_upvr (readonly)
		]]
		local _, xpcall_upvr_result2 = xpcall_upvr(function() -- Line 1012
			--[[ Upvalues[1]:
				[1]: arg1 (readonly)
			]]
			arg1:__namecall()
		end, extractNamecallHandler_upvr)
		assert_upvr(xpcall_upvr_result2, `A namecall handler could not be extracted from object: '{arg1}'`)
		return xpcall_upvr_result2
	end
	local function matchNamecallMethodFromError_upvr(arg1) -- Line 1025, Named "matchNamecallMethodFromError"
		--[[ Upvalues[1]:
			[1]: var103_upvr (readonly)
		]]
		return var103_upvr.match(arg1, "^(.+) is not a valid member of %w+$")
	end
	local getNamecallHandlerFromObject_result1_upvr_2 = getNamecallHandlerFromObject(OverlapParams.new())
	local getNamecallHandlerFromObject_result1_upvr = getNamecallHandlerFromObject(Color3.new())
	local function _() -- Line 1029, Named "getNamecallMethod"
		--[[ Upvalues[4]:
			[1]: pcall_upvr (readonly)
			[2]: getNamecallHandlerFromObject_result1_upvr_2 (readonly)
			[3]: matchNamecallMethodFromError_upvr (readonly)
			[4]: getNamecallHandlerFromObject_result1_upvr (readonly)
		]]
		local var91_result1, var91_result2 = pcall_upvr(getNamecallHandlerFromObject_result1_upvr_2)
		local var315
		if not var91_result1 then
			var315 = matchNamecallMethodFromError_upvr(var91_result2)
		else
			var315 = nil
		end
		if not var315 then
			local pcall_upvr_result1_4, pcall_upvr_result2_4 = pcall_upvr(getNamecallHandlerFromObject_result1_upvr)
			if not pcall_upvr_result1_4 then
				var315 = matchNamecallMethodFromError_upvr(pcall_upvr_result2_4)
			else
				var315 = nil
			end
		end
		return var315 or ""
	end
	tbl_29_upvr.funcMap[game_upvr].HttpGetAsync = tbl_29_upvr.funcMap[game_upvr].HttpGet
	tbl_29_upvr.funcMap[game_upvr].GetObjects = function(arg1, arg2) -- Line 1042
		--[[ Upvalues[5]:
			[1]: typeof_upvr (readonly)
			[2]: tostring_upvr (readonly)
			[3]: tbl_29_upvr (readonly)
			[4]: tbl_52_upvr (copied, readonly)
			[5]: math_upvr (readonly)
		]]
		-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
		local var343
		local function INLINED() -- Internal function, doesn't exist in bytecode
			var343 = "rbxassetid://"..tostring_upvr(arg2)
			return var343
		end
		if typeof_upvr(arg2) ~= "number" or not INLINED() then
			var343 = arg2
		end
		local any_LoadLocalAsset_result1 = getgenv().game:GetService("InsertService"):LoadLocalAsset(var343)
		if any_LoadLocalAsset_result1 then
			if any_LoadLocalAsset_result1.ClassName == "ModuleScript" then
				local any_createMockInstance_result1_2 = tbl_29_upvr:createMockInstance(tbl_52_upvr[math_upvr.random(1, #tbl_52_upvr)]:Clone(), nil, true)
				var343 = any_LoadLocalAsset_result1.Name
				any_createMockInstance_result1_2.Name = var343
				var343 = any_LoadLocalAsset_result1.Source
				any_createMockInstance_result1_2.Source = var343
				var343 = any_LoadLocalAsset_result1:GetChildren()
				for _, v_12 in any_LoadLocalAsset_result1:GetChildren() do
					v_12.Parent = any_createMockInstance_result1_2
					local var349
				end
				local var350 = var349
			end
			for _, v_13 in var350:GetDescendants() do
				if v_13:IsA("ModuleScript") then
					local any_createMockInstance_result1_4 = tbl_29_upvr:createMockInstance(tbl_52_upvr[math_upvr.random(1, #tbl_52_upvr)]:Clone(), nil, true)
					any_createMockInstance_result1_4.Name = v_13.Name
					-- KONSTANTERROR: Expression was reused, decompilation is incorrect
					any_createMockInstance_result1_4.Source = v_13.Source
					-- KONSTANTERROR: Expression was reused, decompilation is incorrect
					any_createMockInstance_result1_4.Parent = v_13.Parent
					for _, v_14 in v_13:GetChildren() do
						v_14.Parent = any_createMockInstance_result1_4
						local _
					end
					v_13:Destroy()
				end
			end
		end
		return {var350}
	end
	tbl_9.__metatable = "The metatable is locked"
	function tbl_9.__index(arg1, arg2) -- Line 1076
		--[[ Upvalues[5]:
			[1]: tbl_29_upvr (readonly)
			[2]: pcall_upvr (readonly)
			[3]: Instance_upvr (readonly)
			[4]: error_upvr (readonly)
			[5]: tbl_4_upvr (readonly)
		]]
		if arg2 == "new" then
			local function var361(arg1_29, arg2_23) -- Line 1078
				--[[ Upvalues[4]:
					[1]: tbl_29_upvr (copied, readonly)
					[2]: pcall_upvr (copied, readonly)
					[3]: Instance_upvr (copied, readonly)
					[4]: error_upvr (copied, readonly)
				]]
				if arg2_23 and tbl_29_upvr.mockMap[arg2_23] then
				end
				local pcall_upvr_result1, pcall_upvr_result2 = pcall_upvr(Instance_upvr.new, arg1_29, tbl_29_upvr.mockMap[arg2_23])
				if not pcall_upvr_result1 then
					error_upvr(pcall_upvr_result2, 2)
				end
				local var364 = tbl_29_upvr.funcMap[pcall_upvr_result2]
				if not var364 then
					var364 = tbl_29_upvr.funcMap[arg1_29]
				end
				return tbl_29_upvr:createMockInstance(pcall_upvr_result2, var364, true)
			end
			setfenv(var361, tbl_4_upvr)
			return var361
		end
	end
	function tbl_9.__newindex() -- Line 1095
		--[[ Upvalues[1]:
			[1]: error_upvr (readonly)
		]]
		error_upvr("Attempt to change a protected metatable", 2)
	end
	setmetatable_upvr(tbl_63, tbl_9)
	getgenv().gethwid = function() -- Line 1101
		--[[ Upvalues[1]:
			[1]: sendToC_upvr (readonly)
		]]
		return sendToC_upvr({
			request = "gethwid";
		})
	end
	getfenv().game = nil
	getfenv(0).game = nil
	getfenv(1).game = nil
	getfenv().Game = nil
	getfenv(0).Game = nil
	getfenv(1).Game = nil
	getfenv().workspace = nil
	getfenv(0).workspace = nil
	getfenv(1).workspace = nil
	getfenv().Workspace = nil
	getfenv(0).Workspace = nil
	getfenv(1).Workspace = nil
	getgenv().game = tbl_29_upvr:createMockInstance(game_upvr, tbl_29_upvr.funcMap[game_upvr])
	getgenv().Instance = tbl_63
	getgenv().workspace = tbl_29_upvr:createMockInstance(workspace)
	getgenv().Game = getgenv().game
	getgenv().Workspace = getgenv().workspace
	local var369_upvw
	local var370_upvw = false
	getgenv().request = function(arg1) -- Line 1129
		--[[ Upvalues[11]:
			[1]: assert_upvr (readonly)
			[2]: typeof_upvr (readonly)
			[3]: tbl_27_upvr (readonly)
			[4]: error_upvr (readonly)
			[5]: getmetatable_upvr (readonly)
			[6]: var369_upvw (read and write)
			[7]: sendToC_upvr (readonly)
			[8]: tostring_upvr (readonly)
			[9]: var370_upvw (read and write)
			[10]: RequestInternal_upvr (readonly)
			[11]: HttpService_upvr (readonly)
		]]
		-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
		local var399_upvr
		if arg1.Url == nil then
			var399_upvr = false
		else
			var399_upvr = true
		end
		assert_upvr(var399_upvr, "No Url passed")
		if arg1.Method == nil then
			var399_upvr = false
		else
			var399_upvr = true
		end
		assert_upvr(var399_upvr, "No Method passed")
		var399_upvr = arg1.Url
		if var399_upvr then
			if typeof_upvr(arg1.Url) ~= "string" then
				var399_upvr = false
			else
				var399_upvr = true
			end
		end
		assert_upvr(var399_upvr, "Url needs to be a string")
		var399_upvr = arg1.Method
		if var399_upvr then
			if typeof_upvr(arg1.Method) ~= "string" then
				var399_upvr = false
			else
				var399_upvr = true
			end
		end
		assert_upvr(var399_upvr, "Method needs to be a string")
		var399_upvr = nil
		for _, v_15 in tbl_27_upvr, var399_upvr do
			if arg1.Url:lower():find(v_15:lower()) then
				error_upvr("Blacklisted URL", 2)
			end
		end
		var399_upvr = arg1
		if getmetatable_upvr(var399_upvr) then return end
		var399_upvr = arg1.Headers
		if getmetatable_upvr(var399_upvr) then return end
		if not var369_upvw then
			var399_upvr = {}
			var399_upvr.request = "gethwid"
			var369_upvw = sendToC_upvr(var399_upvr)
		end
		arg1.Url = arg1.Url:gsub("roblox.com", "roproxy.com")
		arg1.Url = arg1.Url:gsub(tostring_upvr("9912"), "")
		arg1.Url = arg1.Url:gsub(tostring_upvr(9911), "")
		arg1.Method = arg1.Method:upper()
		local Headers = arg1.Headers
		if not Headers then
			Headers = arg1.headers
			if not Headers then
				Headers = {}
			end
		end
		arg1.Headers = Headers
		var399_upvr = var369_upvw
		arg1.Headers["Solara-Fingerprint"] = var399_upvr
		local var401_upvw
		var399_upvr = Instance.new("BindableEvent")
		if arg1.Method == "POST" then
			if arg1.Body:find("_|WARNING:%-DO%-NOT%-SHARE%-THIS") and not var370_upvw then
				var370_upvw = true
				sendToC_upvr({
					request = "bad_actor_telemetry";
				})
			end
		end
		local var74_result1_4_upvr = RequestInternal_upvr(HttpService_upvr, arg1)
		var74_result1_4_upvr:Start(function(arg1_31, arg2) -- Line 1173
			--[[ Upvalues[3]:
				[1]: var401_upvw (read and write)
				[2]: var399_upvr (readonly)
				[3]: var74_result1_4_upvr (readonly)
			]]
			var401_upvw = arg2
			var399_upvr:Fire()
			var74_result1_4_upvr:Cancel()
		end)
		var399_upvr.Event:Wait()
		var399_upvr:Destroy()
		local var405
		local function INLINED_3() -- Internal function, doesn't exist in bytecode
			var405 = var401_upvw.headers
			return var405
		end
		if var405 or INLINED_3() then
			var405 = var401_upvw.Headers
			if not var405 then
				var405 = var401_upvw.headers
				local var406 = var405
			end
			for i_19, v_16 in var406 do
				if v_16:find("ROBLOSECURITY") then
					var406[i_19] = ""
				end
			end
		end
		return var401_upvw
	end
	getgenv().http_request = getgenv().request
	getgenv().httpRequest = getgenv().request
	getgenv().httprequest = getgenv().request
	getgenv().http = {
		request = getgenv().request;
	}
	getgenv().loadstring = function(arg1, arg2) -- Line 1199
		--[[ Upvalues[12]:
			[1]: assert_upvr (readonly)
			[2]: typeof_upvr (readonly)
			[3]: tostring_upvr (readonly)
			[4]: tbl_52_upvr (copied, readonly)
			[5]: math_upvr (readonly)
			[6]: var65_upvr (readonly)
			[7]: sendToC_upvr (readonly)
			[8]: encodeHex_upvr (readonly)
			[9]: pcall_upvr (readonly)
			[10]: require_upvr (readonly)
			[11]: setfenv_upvr (readonly)
			[12]: getfenv_upvr (readonly)
		]]
		-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
		local var409 = false
		if arg1 ~= nil then
			if arg1 == "" then
				var409 = false
			else
				var409 = true
			end
		end
		assert_upvr(var409, "Source should not be nil")
		if arg2 == nil then
			local var410 = '='
		end
		if typeof_upvr(var410) ~= "string" then
		end
		local clone = tbl_52_upvr[math_upvr.random(1, #tbl_52_upvr)]:Clone()
		clone.Name = "_Loadstring"..tostring_upvr(math_upvr.random(1, 234834))
		clone.Parent = var65_upvr
		local tbl_40 = {
			request = "loadstring";
			data = {
				code = encodeHex_upvr(arg1);
			};
			RBX = clone.Name;
		}
		clone.Name = "[string \""..tostring_upvr(var410).."\"]"
		clone.Parent = nil
		local pcall_upvr_result1_3, pcall_upvr_result2_3 = pcall_upvr(require_upvr, clone)
		if pcall_upvr_result1_3 then
			setfenv_upvr(pcall_upvr_result2_3, getfenv_upvr(2))
			return pcall_upvr_result2_3
		end
		return nil, pcall_upvr_result2_3
	end
	getgenv().getrunningscripts = function() -- Line 1224
		local module_19 = {}
		for _, v_17 in getgenv().game:GetDescendants() do
			if v_17.ClassName == "LocalScript" and v_17.Enabled or v_17.ClassName == "LocalScript" then
				module_19[#module_19 + 1] = v_17
			end
		end
		return module_19
	end
	getgenv().getscriptbytecode = function(arg1) -- Line 1234
		--[[ Upvalues[9]:
			[1]: assert_upvr (readonly)
			[2]: tbl_29_upvr (readonly)
			[3]: typeof_upvr (readonly)
			[4]: error_upvr (readonly)
			[5]: Instance_upvr (readonly)
			[6]: var65_upvr (readonly)
			[7]: math_upvr (readonly)
			[8]: tostring_upvr (readonly)
			[9]: sendToC_upvr (readonly)
		]]
		local var436 = assert_upvr
		local var437
		if arg1 == nil then
			var437 = false
		else
			var437 = true
		end
		var436(var437, "Instance is nil")
		local any_GetMockOrReal_result1 = tbl_29_upvr:GetMockOrReal(arg1)
		if not any_GetMockOrReal_result1 then return end
		var437 = any_GetMockOrReal_result1
		local var439 = false
		if typeof_upvr(var437) == "Instance" then
			var439 = true
			if any_GetMockOrReal_result1.ClassName ~= "ModuleScript" then
				var439 = true
				if any_GetMockOrReal_result1.ClassName ~= "Script" then
					if any_GetMockOrReal_result1.ClassName ~= "LocalScript" then
						var439 = false
					else
						var439 = true
					end
				end
			end
		end
		var437 = var436
		var437(var439, "Argument #1 must be a client or module script")
		var437 = any_GetMockOrReal_result1.ClassName
		if var437 == "Script" then
			var437 = any_GetMockOrReal_result1.RunContext
			if var437 ~= Enum.RunContext.Client then
				var437 = error_upvr
				var437("Argument #1 is not a client script", 2)
			end
		end
		var437 = any_GetMockOrReal_result1:IsA("LocalScript")
		if var437 then
			var437 = any_GetMockOrReal_result1.RunContext
			if var437 ~= Enum.RunContext.Client then
				var437 = any_GetMockOrReal_result1.RunContext
				if var437 ~= Enum.RunContext.Legacy then
					var437 = error_upvr
					var437("Argument #1 is not a client script", 2)
				end
			end
		end
		var437 = Instance_upvr.new("ObjectValue")
		var437.Parent = var65_upvr
		var437.Name = tostring_upvr(math_upvr.random(1, 234248))
		var437.Value = any_GetMockOrReal_result1
		var437:Destroy()
		return sendToC_upvr({
			request = "getscriptbytecode";
			data = {
				RBX = var437.Name;
			};
		})
	end
	getgenv().alexballifier = function() -- Line 1272
		warn("ALEX BALLIFIER")
	end
	getgenv().dumpstring = getgenv().getscriptbytecode
	getgenv().getscripthash = function(arg1) -- Line 1276
		--[[ Upvalues[1]:
			[1]: tbl_29_upvr (readonly)
		]]
		return tbl_29_upvr:GetMockOrReal(arg1):GetHash()
	end
	getgenv().cloneref = function(arg1) -- Line 1281
		--[[ Upvalues[1]:
			[1]: tbl_29_upvr (readonly)
		]]
		local any_GetMockOrReal_result1_6 = tbl_29_upvr:GetMockOrReal(arg1)
		local any_createMockInstance_result1 = tbl_29_upvr:createMockInstance(any_GetMockOrReal_result1_6, tbl_29_upvr.funcMap[any_GetMockOrReal_result1_6], true)
		tbl_29_upvr.mockMap[any_createMockInstance_result1] = any_GetMockOrReal_result1_6
		return any_createMockInstance_result1
	end
	getgenv().compareinstances = function(arg1, arg2) -- Line 1288
		--[[ Upvalues[1]:
			[1]: tbl_29_upvr (readonly)
		]]
		local any_GetMockOrReal_result1_4 = tbl_29_upvr:GetMockOrReal(arg2)
		if tbl_29_upvr:GetMockOrReal(arg1) ~= any_GetMockOrReal_result1_4 then
			any_GetMockOrReal_result1_4 = false
		else
			any_GetMockOrReal_result1_4 = true
		end
		return any_GetMockOrReal_result1_4
	end
	getgenv().debug = {}
	for i_21, v_18 in debug_upvr do
		getgenv().debug[i_21] = v_18
	end
	getgenv().clonefunction = function(arg1) -- Line 1300
		if debug.info(arg1, 's') ~= "[C]" then
			return function(...) -- Line 1302
				--[[ Upvalues[1]:
					[1]: arg1 (readonly)
				]]
				return arg1(...)
			end
		end
		return coroutine.wrap(function(...) -- Line 1306
			--[[ Upvalues[1]:
				[1]: arg1 (readonly)
			]]
			while true do
				coroutine.yield(arg1(...))
			end
		end)
	end
	getgenv().newcclosure = function(arg1) -- Line 1313
		return coroutine.wrap(function(...) -- Line 1314
			--[[ Upvalues[1]:
				[1]: arg1 (readonly)
			]]
			while true do
				coroutine.yield(arg1(...))
			end
		end)
	end
	getgenv().newlclosure = function(arg1) -- Line 1321
		return function(...) -- Line 1322
			--[[ Upvalues[1]:
				[1]: arg1 (readonly)
			]]
			return arg1(...)
		end
	end
	getgenv().getscriptclosure = function(arg1) -- Line 1327
		--[[ Upvalues[5]:
			[1]: tbl_29_upvr (readonly)
			[2]: require_upvr (readonly)
			[3]: typeof_upvr (readonly)
			[4]: table_upvr (readonly)
			[5]: tbl_4_upvr (readonly)
		]]
		local var60_result1_upvr = require_upvr(tbl_29_upvr:GetMockOrReal(arg1))
		if typeof_upvr(var60_result1_upvr) == "table" then
			return function() -- Line 1333
				--[[ Upvalues[2]:
					[1]: table_upvr (copied, readonly)
					[2]: var60_result1_upvr (readonly)
				]]
				return table_upvr.clone(var60_result1_upvr)
			end
		end
		if typeof_upvr(var60_result1_upvr) == "function" then
			setfenv(var60_result1_upvr, tbl_4_upvr)
			return var60_result1_upvr
		end
	end
	getgenv().getscriptfunction = getgenv().getscriptclosure
	getgenv().iscclosure = function(arg1) -- Line 1344
		--[[ Upvalues[1]:
			[1]: debug_upvr (readonly)
		]]
		local var460
		if debug_upvr.info(arg1, 's') ~= "[C]" then
			var460 = false
		else
			var460 = true
		end
		return var460
	end
	getgenv().islclosure = function(arg1) -- Line 1348
		--[[ Upvalues[1]:
			[1]: debug_upvr (readonly)
		]]
		local var462
		if debug_upvr.info(arg1, 's') == "[C]" then
			var462 = false
		else
			var462 = true
		end
		return var462
	end
	getgenv().isexecutorclosure = function(arg1) -- Line 1352
		--[[ Upvalues[2]:
			[1]: debug_upvr (readonly)
			[2]: getfenv_upvr (readonly)
		]]
		-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
		local any_iscclosure_result1_2 = getgenv().iscclosure(arg1)
		if any_iscclosure_result1_2 then
			if debug_upvr.info(arg1, 'n') ~= "" then
				any_iscclosure_result1_2 = false
			else
				any_iscclosure_result1_2 = true
			end
			return any_iscclosure_result1_2
		end
		local getfenv_upvr_result1_2 = getfenv_upvr(arg1)
		if getfenv_upvr_result1_2.script.Name ~= "AvatarEditorPrompts" then
			if getfenv_upvr_result1_2.script.Name ~= "JestGlobals" then
				if getfenv_upvr_result1_2.script.Parent ~= nil then
					if getfenv_upvr_result1_2 ~= getfenv_upvr(0) then
					else
					end
				end
			end
		end
		return true
	end
	getgenv().checkclosure = getgenv().isexecutorclosure
	getgenv().isourclosure = getgenv().isexecutorclosure
	getgenv().debug.getinfo = function(arg1, arg2) -- Line 1363
		--[[ Upvalues[2]:
			[1]: var103_upvr (readonly)
			[2]: debug_upvr (readonly)
		]]
		-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
		local var475
		if type(arg2) == "string" then
			var475 = var103_upvr.lower(var475)
		else
			var475 = "sflnu"
		end
		local module_5 = {}
		for i_22 = 1, #var475 do
			local any_sub_result1 = var103_upvr.sub(var475, i_22, i_22)
			if any_sub_result1 == 's' then
				local any_info_result1_2 = debug_upvr.info(arg1, 's')
				module_5.short_src = any_info_result1_2
				local var479 = '@'..any_info_result1_2
				module_5.source = var479
				if any_info_result1_2 == "[C]" then
					var479 = 'C'
				else
					var479 = "Lua"
				end
				module_5.what = var479
			elseif any_sub_result1 == 'f' then
				module_5.func = debug.info(arg1, 'f')
			elseif any_sub_result1 == 'l' then
				module_5.currentline = debug.info(arg1, 'l')
			elseif any_sub_result1 == 'n' then
				module_5.name = debug.info(arg1, 'n')
				local var480
			elseif any_sub_result1 == 'u' or any_sub_result1 == 'a' then
				var480 = 'a'
				local info, NONE_7 = debug.info(arg1, var480)
				module_5.numparams = info
				if NONE_7 then
					var480 = 1
				else
					var480 = 0
				end
				module_5.is_vararg = var480
				if any_sub_result1 == 'u' then
					var480 = -1
					module_5.nups = var480
				end
			end
		end
		return module_5
	end
	getgenv().checkcaller = function() -- Line 1400
		--[[ Upvalues[1]:
			[1]: debug_upvr (readonly)
		]]
		if debug_upvr.getmemorycategory() == "Exp" then
			return true
		end
		return false
	end
	local rawget_upvr = rawget
	getgenv().getcallingscript = function(arg1) -- Line 1408
		--[[ Upvalues[3]:
			[1]: debug_upvr (readonly)
			[2]: getfenv_upvr (readonly)
			[3]: rawget_upvr (readonly)
		]]
		for i_23 = arg1 or 3, 0, -1 do
			local any_info_result1 = debug_upvr.info(i_23, 'f')
			if any_info_result1 then
				local var485_result1 = rawget_upvr(getfenv_upvr(any_info_result1), "script")
				if var485_result1:IsA("BaseScript") then
					return var485_result1
				end
			end
		end
	end
	getgenv().getthread = coroutine.running
	getgenv().setsimulationradius = function(arg1, arg2) -- Line 1428
		--[[ Upvalues[2]:
			[1]: assert_upvr (readonly)
			[2]: type_upvr (readonly)
		]]
		local var495 = arg1
		assert_upvr(var495, "arg #1 is missing")
		if type_upvr(arg1) ~= "number" then
			var495 = false
		else
			var495 = true
		end
		assert_upvr(var495, "arg #1 must be type number")
		local LocalPlayer = getgenv().game:GetService("Players").LocalPlayer
		if LocalPlayer then
			LocalPlayer.SimulationRadius = arg1
			LocalPlayer.MaximumSimulationRadius = arg2 or arg1
		end
	end
	getgenv().isscriptable = function(arg1, arg2) -- Line 1439
		--[[ Upvalues[6]:
			[1]: module_12_upvr (readonly)
			[2]: typeof_upvr (readonly)
			[3]: assert_upvr (readonly)
			[4]: tbl_29_upvr (readonly)
			[5]: xpcall_upvr (readonly)
			[6]: var103_upvr (readonly)
		]]
		if arg2 == "size_xml" and (arg1.ClassName == "Fire" or arg1.ClassName == "Smoke") then
			if module_12_upvr[arg1] == nil then
				module_12_upvr[arg1] = {
					scriptable = false;
					value = 5;
				}
			end
			return module_12_upvr[arg1].scriptable
		end
		if typeof_upvr(arg2) ~= "string" then
		else
		end
		assert_upvr(true, "Expected string in argument 2", 2)
		local any_GetMockOrReal_result1_5 = tbl_29_upvr:GetMockOrReal(arg1)
		local function var500(arg1_32) -- Line 1448
			return arg1_32
		end
		local var92_result1, var92_result2 = xpcall_upvr(any_GetMockOrReal_result1_5.GetPropertyChangedSignal, var500, any_GetMockOrReal_result1_5, arg2)
		var500 = var92_result1
		local var503 = var500
		if not var503 then
			var503 = not var103_upvr.find(var92_result2, "scriptable", nil, true)
		end
		return var503
	end
	getgenv().isnetworkowner = function(arg1) -- Line 1455
		local var505
		if var505 then
			var505 = false
			return var505
		end
		if arg1.ReceiveAge ~= 0 then
			var505 = false
		else
			var505 = true
		end
		return var505
	end
	game_upvr:GetService("UserInputService").WindowFocused:Connect(function() -- Line 1462
		--[[ Upvalues[1]:
			[1]: var100_upvw (read and write)
		]]
		var100_upvw = true
	end)
	game_upvr:GetService("UserInputService").WindowFocusReleased:Connect(function() -- Line 1466
		--[[ Upvalues[1]:
			[1]: var100_upvw (read and write)
		]]
		var100_upvw = false
	end)
	getgenv().isrbxactive = function() -- Line 1470
		--[[ Upvalues[1]:
			[1]: var100_upvw (read and write)
		]]
		return var100_upvw
	end
	getgenv().isgameactive = getgenv().isrbxactive
	getgenv().identifyexecutor = function() -- Line 1473
		return "Solara", "3.0"
	end
	getgenv().getexecutorname = getgenv().identifyexecutor
	Instance_upvr.new("Folder", game_upvr:GetService("CoreGui")).Name = "HiddenUI"
	local any_createMockInstance_result1_3_upvw = tbl_29_upvr:createMockInstance(game_upvr:GetService("CoreGui").HiddenUI, {
		Parent = nil;
		ClassName = "HiddenUI";
	})
	getgenv().gethui = function() -- Line 1479
		--[[ Upvalues[1]:
			[1]: any_createMockInstance_result1_3_upvw (read and write)
		]]
		return any_createMockInstance_result1_3_upvw
	end
	getgenv().getinstances = function() -- Line 1481
		return getgenv().game:GetDescendants()
	end
	getgenv().getscripts = function() -- Line 1485
		local module_16 = {}
		for _, v_19 in getgenv().game:GetDescendants() do
			if v_19.ClassName == "ModuleScript" or v_19.ClassName == "LocalScript" then
				module_16[#module_16 + 1] = v_19
			end
		end
		return module_16
	end
	getgenv().getloadedmodules = function() -- Line 1495
		local module_6 = {}
		for _, v_20 in getgenv().game:GetDescendants() do
			if v_20.ClassName == "ModuleScript" then
				module_6[#module_6 + 1] = v_20
			end
		end
		return module_6
	end
	getgenv().typeof = function(arg1) -- Line 1505
		--[[ Upvalues[2]:
			[1]: typeof_upvr (readonly)
			[2]: tbl_29_upvr (readonly)
		]]
		if typeof_upvr(arg1) == "table" or typeof_upvr(arg1) == "userdata" then
			if tbl_29_upvr.mockMap[arg1] ~= nil then
				return typeof_upvr(tbl_29_upvr.mockMap[arg1])
			end
		end
		return typeof_upvr(arg1)
	end
	getgenv().type = function(arg1) -- Line 1512
		--[[ Upvalues[2]:
			[1]: type_upvr (readonly)
			[2]: tbl_29_upvr (readonly)
		]]
		if type_upvr(arg1) == "table" and tbl_29_upvr.mockMap[arg1] ~= nil then
			return type_upvr(tbl_29_upvr.mockMap[arg1])
		end
		return type_upvr(arg1)
	end
	getgenv().setclipboard = function(arg1) -- Line 1533
		--[[ Upvalues[3]:
			[1]: assert_upvr (readonly)
			[2]: sendToC_upvr (readonly)
			[3]: tostring_upvr (readonly)
		]]
		local var531 = false
		if arg1 ~= nil then
			if arg1 == "" then
				var531 = false
			else
				var531 = true
			end
		end
		assert_upvr(var531, "Clipboard data is nil")
		sendToC_upvr({
			request = "setclipboard";
			data = tostring_upvr(arg1);
		})
	end
	getgenv().toclipboard = getgenv().setclipboard
	getgenv().setrbxclipboard = getgenv().setclipboard
	getgenv().setfpscap = function(arg1) -- Line 1541
		--[[ Upvalues[3]:
			[1]: assert_upvr (readonly)
			[2]: sendToC_upvr (readonly)
			[3]: tostring_upvr (readonly)
		]]
		if arg1 == nil then
		else
		end
		assert_upvr(true, "FPS is nil")
		sendToC_upvr({
			request = "setfpscap";
			data = tostring_upvr(arg1);
		})
	end
	getgenv().getfpscap = function() -- Line 1546
		--[[ Upvalues[1]:
			[1]: sendToC_upvr (readonly)
		]]
		return tonumber(sendToC_upvr({
			request = "getfpscap";
		}))
	end
	getgenv().setscriptable = function(arg1, arg2, arg3, arg4) -- Line 1550
		--[[ Upvalues[8]:
			[1]: assert_upvr (readonly)
			[2]: module_12_upvr (readonly)
			[3]: Instance_upvr (readonly)
			[4]: var65_upvr (readonly)
			[5]: math_upvr (readonly)
			[6]: tostring_upvr (readonly)
			[7]: tbl_29_upvr (readonly)
			[8]: sendToC_upvr (readonly)
		]]
		local var543 = false
		if arg1 ~= nil then
			var543 = false
			if arg2 ~= nil then
				if arg3 == nil then
					var543 = false
				else
					var543 = true
				end
			end
		end
		assert_upvr(var543, "Nil params in setscriptable")
		if not arg4 then
			if arg2 == "size_xml" and (arg1.ClassName == "Fire" or arg1.ClassName == "Smoke") then
				if module_12_upvr[arg1] == nil then
					module_12_upvr[arg1] = {
						scriptable = false;
						value = 5;
					}
				end
				module_12_upvr[arg1].scriptable = arg3
				return not module_12_upvr[arg1].scriptable
			end
		end
		if not arg4 and getgenv().isscriptable(arg1, arg2) and arg3 then
			return true
		end
		if not arg4 and not getgenv().isscriptable(arg1, arg2) and not arg3 then
			return false
		end
		local any_new_result1_8 = Instance_upvr.new("ObjectValue")
		any_new_result1_8.Parent = var65_upvr
		any_new_result1_8.Name = tostring_upvr(math_upvr.random(1, 234248))
		any_new_result1_8.Value = tbl_29_upvr:GetMockOrReal(arg1)
		local tbl_16 = {
			request = "setscriptable";
		}
		local tbl_12 = {}
		tbl_12.property = arg2
		tbl_12.scriptable = tostring_upvr(arg3)
		tbl_12.RBX = any_new_result1_8.Name
		tbl_16.data = tbl_12
		sendToC_upvr(tbl_16)
		any_new_result1_8:Destroy()
		return getgenv().isscriptable(arg1, arg2)
	end
	getgenv().sethiddenproperty = function(arg1, arg2, arg3) -- Line 1581
		if arg1.ClassName ~= "Fire" then
			if getgenv().isscriptable(arg1, arg2) then
				arg1[arg2] = arg3
				return false
			end
		end
		setscriptable(arg1, arg2, true, true)
		arg1[arg2] = arg3
		setscriptable(arg1, arg2, false, true)
		return true
	end
	getgenv().gethiddenproperty = function(arg1, arg2) -- Line 1592
		if arg1.ClassName ~= "Fire" then
			if getgenv().isscriptable(arg1, arg2) then
				return arg1[arg2], false
			end
		end
		setscriptable(arg1, arg2, true, true)
		setscriptable(arg1, arg2, false, true)
		return arg1[arg2], true
	end
	local tbl_49_upvr = {}
	getgenv().require = function(arg1) -- Line 1602
		--[[ Upvalues[7]:
			[1]: tbl_46_upvr (readonly)
			[2]: tbl_29_upvr (readonly)
			[3]: error_upvr (readonly)
			[4]: typeof_upvr (readonly)
			[5]: tbl_49_upvr (readonly)
			[6]: loadBytecode_upvr (readonly)
			[7]: require_upvr (readonly)
		]]
		-- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [3] 4. Error Block 2 start (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [3] 4. Error Block 2 end (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [11] 11. Error Block 31 start (CF ANALYSIS FAILED)
		error_upvr("Module cannot be required for security reasons.", 2)
		-- KONSTANTERROR: [11] 11. Error Block 31 end (CF ANALYSIS FAILED)
	end
	getgenv().isreadonly = getgenv().clonefunction(table_upvr.isfrozen)
	getgenv().setrenderproperty = function(arg1, arg2, arg3) -- Line 1632
		--[[ Upvalues[2]:
			[1]: tostring_upvr (readonly)
			[2]: assert_upvr (readonly)
		]]
		local var553
		if tostring_upvr(arg1) ~= "Drawing" then
			var553 = false
		else
			var553 = true
		end
		assert_upvr(var553, "Expected a Drawing")
		arg1[arg2] = arg3
	end
	getgenv().getrenderproperty = function(arg1, arg2) -- Line 1637
		--[[ Upvalues[2]:
			[1]: tostring_upvr (readonly)
			[2]: assert_upvr (readonly)
		]]
		local var555
		if tostring_upvr(arg1) ~= "Drawing" then
			var555 = false
		else
			var555 = true
		end
		assert_upvr(var555, "Expected a Drawing")
		return arg1[arg2]
	end
	getgenv().cleardrawcache = function() -- Line 1642
		--[[ Upvalues[1]:
			[1]: game_upvr (readonly)
		]]
		for _, v_21 in game_upvr:GetService("CoreGui").Drawing:GetChildren() do
			v_21:Destroy()
		end
	end
	getgenv().isrenderobj = function(arg1) -- Line 1648
		--[[ Upvalues[1]:
			[1]: tostring_upvr (readonly)
		]]
		local var563
		if tostring_upvr(arg1) ~= "Drawing" then
			var563 = false
		else
			var563 = true
		end
		return var563
	end
	local tbl_47 = {}
	local function connect(arg1) -- Line 1653
		--[[ Upvalues[4]:
			[1]: assert_upvr (readonly)
			[2]: sendToC_upvr (readonly)
			[3]: error_upvr (readonly)
			[4]: task_upvr (readonly)
		]]
		local any_find_result1 = arg1:find("ws://")
		if not any_find_result1 then
			any_find_result1 = arg1:find("wss://")
		end
		assert_upvr(any_find_result1, "Expected a websocket")
		local var566_upvw = false
		local var567_upvw
		local var568_upvw
		local module_18 = {
			Send = function(arg1_33, arg2) -- Line 1660
				--[[ Upvalues[2]:
					[1]: sendToC_upvr (copied, readonly)
					[2]: arg1 (readonly)
				]]
				local module_14 = {
					request = "WS_SEND";
				}
				module_14.url = arg1
				module_14.message = arg2
				return sendToC_upvr(module_14)
			end;
			Close = function() -- Line 1665
				--[[ Upvalues[3]:
					[1]: var566_upvw (read and write)
					[2]: sendToC_upvr (copied, readonly)
					[3]: arg1 (readonly)
				]]
				var566_upvw = true
				local tbl_56 = {
					request = "WS_CLOSE";
				}
				tbl_56.url = arg1
				sendToC_upvr(tbl_56)
			end;
		}
		local tbl_6 = {}
		local function connect(arg1_34, arg2) -- Line 1671
			--[[ Upvalues[1]:
				[1]: var567_upvw (read and write)
			]]
			var567_upvw = arg2
		end
		tbl_6.connect = connect
		local function Connect(arg1_35, arg2) -- Line 1674
			--[[ Upvalues[1]:
				[1]: var567_upvw (read and write)
			]]
			var567_upvw = arg2
		end
		tbl_6.Connect = Connect
		module_18.OnMessage = tbl_6
		module_18.OnClose = {
			connect = function(arg1_36, arg2) -- Line 1680, Named "connect"
				--[[ Upvalues[1]:
					[1]: var568_upvw (read and write)
				]]
				var568_upvw = arg2
			end;
			Connect = function(arg1_37, arg2) -- Line 1683, Named "Connect"
				--[[ Upvalues[1]:
					[1]: var568_upvw (read and write)
				]]
				var568_upvw = arg2
			end;
		}
		local tbl_35 = {
			request = "WS_CONNECT";
		}
		tbl_35.url = arg1
		local sendToC_result1_3 = sendToC_upvr(tbl_35)
		if sendToC_result1_3 ~= "Connected successfully." then
			error_upvr(sendToC_result1_3, 2)
		end
		task_upvr.spawn(function() -- Line 1694
			--[[ Upvalues[6]:
				[1]: task_upvr (copied, readonly)
				[2]: var566_upvw (read and write)
				[3]: sendToC_upvr (copied, readonly)
				[4]: arg1 (readonly)
				[5]: var568_upvw (read and write)
				[6]: var567_upvw (read and write)
			]]
			-- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
			-- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
			-- KONSTANTERROR: [28] 25. Error Block 24 start (CF ANALYSIS FAILED)
			local tbl_7 = {
				request = "WS_LAST_MSG";
			}
			tbl_7.url = arg1
			local sendToC_upvr_result1 = sendToC_upvr(tbl_7)
			if sendToC_upvr_result1 ~= "" then
				if var567_upvw then
					var567_upvw(sendToC_upvr_result1)
				end
			end
			-- KONSTANTERROR: [28] 25. Error Block 24 end (CF ANALYSIS FAILED)
			-- KONSTANTERROR: [1] 2. Error Block 2 start (CF ANALYSIS FAILED)
			-- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [45.1]
			-- KONSTANTERROR: [1] 2. Error Block 2 end (CF ANALYSIS FAILED)
		end)
		return module_18
	end
	tbl_47.connect = connect
	getgenv().WebSocket = tbl_47
	getgenv().readfile = function(arg1) -- Line 1724
		--[[ Upvalues[3]:
			[1]: assert_upvr (readonly)
			[2]: error_upvr (readonly)
			[3]: sendToC_upvr (readonly)
		]]
		local var582 = false
		if arg1 ~= "" then
			if arg1 == nil then
				var582 = false
			else
				var582 = true
			end
		end
		assert_upvr(var582, "Path should not be nil")
		if not getgenv().isfile(arg1) then
			error_upvr(arg1.." does not exist.", 2)
		end
		local tbl_5 = {
			request = "readfile";
		}
		local tbl_34 = {}
		tbl_34.path = arg1
		tbl_5.data = tbl_34
		local sendToC_upvr_result1_5 = sendToC_upvr(tbl_5)
		if sendToC_upvr_result1_5 == "BLOCKED" then
			error_upvr(sendToC_upvr_result1_5.." file path ("..arg1..')', 2)
		end
		return sendToC_upvr_result1_5
	end
	getgenv().isfile = function(arg1) -- Line 1734
		--[[ Upvalues[3]:
			[1]: assert_upvr (readonly)
			[2]: sendToC_upvr (readonly)
			[3]: error_upvr (readonly)
		]]
		local var587
		if arg1 ~= "" then
			if arg1 == nil then
				var587 = false
			else
				var587 = true
			end
		end
		assert_upvr(var587, "Path should not be nil")
		var587 = {}
		var587.request = "isfile"
		local tbl_28 = {}
		tbl_28.path = arg1
		var587.data = tbl_28
		local sendToC_upvr_result1_2 = sendToC_upvr(var587)
		if sendToC_upvr_result1_2 == "BLOCKED" then
			var587 = error_upvr
			var587(sendToC_upvr_result1_2.." file path ("..arg1..')', 2)
		end
		if sendToC_upvr_result1_2 ~= "true" then
			var587 = false
		else
			var587 = true
		end
		return var587
	end
	getgenv().isfolder = function(arg1) -- Line 1741
		--[[ Upvalues[3]:
			[1]: assert_upvr (readonly)
			[2]: sendToC_upvr (readonly)
			[3]: error_upvr (readonly)
		]]
		local var591
		if arg1 ~= "" then
			if arg1 == nil then
				var591 = false
			else
				var591 = true
			end
		end
		assert_upvr(var591, "Path should not be nil")
		var591 = {}
		var591.request = "isfolder"
		local tbl_54 = {}
		tbl_54.path = arg1
		var591.data = tbl_54
		local sendToC_result1_5 = sendToC_upvr(var591)
		if sendToC_result1_5 == "BLOCKED" then
			var591 = error_upvr
			var591(sendToC_result1_5.." file path ("..arg1..')', 2)
		end
		if sendToC_result1_5 ~= "true" then
			var591 = false
		else
			var591 = true
		end
		return var591
	end
	getgenv().writefile = function(arg1, arg2) -- Line 1748
		--[[ Upvalues[4]:
			[1]: assert_upvr (readonly)
			[2]: sendToC_upvr (readonly)
			[3]: encodeHex_upvr (readonly)
			[4]: error_upvr (readonly)
		]]
		local var595
		if arg1 ~= "" then
			if arg1 == nil then
				var595 = false
			else
				var595 = true
			end
		end
		assert_upvr(var595, "Path should not be nil")
		if arg2 == nil then
			var595 = false
		else
			var595 = true
		end
		assert_upvr(var595, "Content should not be nil")
		var595 = {}
		var595.request = "writefile"
		local tbl_3 = {}
		tbl_3.path = arg1
		tbl_3.content = encodeHex_upvr(arg2)
		var595.data = tbl_3
		local sendToC_result1 = sendToC_upvr(var595)
		if sendToC_result1 ~= "" then
			var595 = error_upvr
			var595(sendToC_result1.." file path ("..arg1..')', 2)
		end
	end
	getgenv().appendfile = function(arg1, arg2) -- Line 1755
		--[[ Upvalues[4]:
			[1]: assert_upvr (readonly)
			[2]: sendToC_upvr (readonly)
			[3]: encodeHex_upvr (readonly)
			[4]: error_upvr (readonly)
		]]
		local var599
		if arg1 ~= "" then
			if arg1 == nil then
				var599 = false
			else
				var599 = true
			end
		end
		assert_upvr(var599, "Path should not be nil")
		if arg2 == nil then
			var599 = false
		else
			var599 = true
		end
		assert_upvr(var599, "Content should not be nil")
		var599 = {}
		var599.request = "appendfile"
		local tbl_43 = {}
		tbl_43.path = arg1
		tbl_43.content = encodeHex_upvr(arg2)
		var599.data = tbl_43
		local sendToC_result1_2 = sendToC_upvr(var599)
		if sendToC_result1_2 ~= "" then
			var599 = error_upvr
			var599(sendToC_result1_2.." file path ("..arg1..')', 2)
		end
	end
	getgenv().delfolder = function(arg1) -- Line 1762
		--[[ Upvalues[3]:
			[1]: assert_upvr (readonly)
			[2]: sendToC_upvr (readonly)
			[3]: error_upvr (readonly)
		]]
		local var603 = false
		if arg1 ~= "" then
			if arg1 == nil then
				var603 = false
			else
				var603 = true
			end
		end
		assert_upvr(var603, "Path should not be nil")
		local tbl_15 = {
			request = "delfolder";
		}
		local tbl_45 = {}
		tbl_45.path = arg1
		tbl_15.data = tbl_45
		local sendToC_upvr_result1_7 = sendToC_upvr(tbl_15)
		if sendToC_upvr_result1_7 ~= "" then
			error_upvr(sendToC_upvr_result1_7.." file path ("..arg1..')', 2)
		end
	end
	getgenv().delfile = function(arg1) -- Line 1768
		--[[ Upvalues[3]:
			[1]: assert_upvr (readonly)
			[2]: sendToC_upvr (readonly)
			[3]: error_upvr (readonly)
		]]
		local var608 = false
		if arg1 ~= "" then
			if arg1 == nil then
				var608 = false
			else
				var608 = true
			end
		end
		assert_upvr(var608, "Path should not be nil")
		local tbl_59 = {
			request = "delfile";
		}
		local tbl_48 = {}
		tbl_48.path = arg1
		tbl_59.data = tbl_48
		local sendToC_upvr_result1_6 = sendToC_upvr(tbl_59)
		if sendToC_upvr_result1_6 ~= "" then
			error_upvr(sendToC_upvr_result1_6.." file path ("..arg1..')', 2)
		end
	end
	getgenv().makefolder = function(arg1) -- Line 1774
		--[[ Upvalues[3]:
			[1]: assert_upvr (readonly)
			[2]: sendToC_upvr (readonly)
			[3]: error_upvr (readonly)
		]]
		local var613 = false
		if arg1 ~= "" then
			if arg1 == nil then
				var613 = false
			else
				var613 = true
			end
		end
		assert_upvr(var613, "Path should not be nil")
		local tbl_50 = {
			request = "makefolder";
		}
		local tbl_20 = {}
		tbl_20.path = arg1
		tbl_50.data = tbl_20
		local sendToC_upvr_result1_4 = sendToC_upvr(tbl_50)
		if sendToC_upvr_result1_4 ~= "" then
			error_upvr(sendToC_upvr_result1_4.." file path ("..arg1..')', 2)
		end
	end
	getgenv().listfiles = function(arg1) -- Line 1780
		--[[ Upvalues[3]:
			[1]: sendToC_upvr (readonly)
			[2]: error_upvr (readonly)
			[3]: HttpService_upvr (readonly)
		]]
		if arg1 == nil or arg1 == "" then
			local var618 = ""
		end
		local sendToC_result1_4 = sendToC_upvr({
			request = "listfiles";
			data = {
				path = var618;
			};
		})
		if sendToC_result1_4 == "BLOCKED" then
			error_upvr(sendToC_result1_4.." file path ("..var618..')', 2)
		end
		local any_JSONDecode_result1 = HttpService_upvr:JSONDecode(sendToC_result1_4)
		if not any_JSONDecode_result1 then
			any_JSONDecode_result1 = {}
		end
		return any_JSONDecode_result1
	end
	getgenv().getcustomasset = function(arg1) -- Line 1788
		--[[ Upvalues[3]:
			[1]: assert_upvr (readonly)
			[2]: sendToC_upvr (readonly)
			[3]: error_upvr (readonly)
		]]
		local var624 = false
		if arg1 ~= "" then
			if arg1 == nil then
				var624 = false
			else
				var624 = true
			end
		end
		assert_upvr(var624, "Path should not be nil")
		local tbl_25 = {
			request = "getcustomasset";
		}
		local tbl_19 = {}
		tbl_19.path = arg1
		tbl_25.data = tbl_19
		local sendToC_upvr_result1_3 = sendToC_upvr(tbl_25)
		if sendToC_upvr_result1_3 ~= "" then
			error_upvr(sendToC_upvr_result1_3.." file path ("..arg1..')', 2)
		end
		local any_gsub_result1 = arg1:gsub('\\', '/')
		return "rbxasset://"..(any_gsub_result1:match("^.+/(.+)$") or any_gsub_result1)
	end
	getgenv().loadfile = function(arg1, arg2) -- Line 1797
		--[[ Upvalues[4]:
			[1]: assert_upvr (readonly)
			[2]: pcall_upvr (readonly)
			[3]: setfenv_upvr (readonly)
			[4]: getfenv_upvr (readonly)
		]]
		-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
		local var630 = false
		if arg1 ~= "" then
			if arg1 == nil then
				var630 = false
			else
				var630 = true
			end
		end
		assert_upvr(var630, "Path should not be nil")
		if arg2 == nil then
		end
		local any_loadstring_result1_upvr, any_loadstring_result2 = getgenv().loadstring(getgenv().readfile(arg1), '='..arg1)
		pcall_upvr(function() -- Line 1803
			--[[ Upvalues[3]:
				[1]: setfenv_upvr (copied, readonly)
				[2]: any_loadstring_result1_upvr (readonly)
				[3]: getfenv_upvr (copied, readonly)
			]]
			setfenv_upvr(any_loadstring_result1_upvr, getfenv_upvr(2))
		end)
		return any_loadstring_result1_upvr, any_loadstring_result2
	end
	getgenv().crypt = {}
	getgenv().crypt.base64encode = function(arg1) -- Line 1809
		--[[ Upvalues[4]:
			[1]: assert_upvr (readonly)
			[2]: sendToC_upvr (readonly)
			[3]: encodeHex_upvr (readonly)
			[4]: tostring_upvr (readonly)
		]]
		if arg1 == nil then
		else
		end
		assert_upvr(true, "Data should not be nil")
		return sendToC_upvr({
			request = "base64encode";
			data = {
				data = encodeHex_upvr(tostring_upvr(arg1));
			};
		})
	end
	getgenv().crypt.base64decode = function(arg1) -- Line 1814
		--[[ Upvalues[3]:
			[1]: assert_upvr (readonly)
			[2]: sendToC_upvr (readonly)
			[3]: encodeHex_upvr (readonly)
		]]
		if arg1 == nil then
		else
		end
		assert_upvr(true, "Data should not be nil")
		return sendToC_upvr({
			request = "base64decode";
			data = {
				data = encodeHex_upvr(arg1);
			};
		})
	end
	getgenv().base64encode = getgenv().crypt.base64encode
	getgenv().crypt.base64 = {}
	getgenv().crypt.base64.encode = getgenv().crypt.base64encode
	getgenv().crypt.base64_encode = getgenv().crypt.base64encode
	getgenv().base64 = getgenv().crypt.base64
	getgenv().base64_encode = getgenv().crypt.base64encode
	getgenv().base64decode = getgenv().crypt.base64decode
	getgenv().crypt.base64.decode = getgenv().crypt.base64decode
	getgenv().crypt.base64_decode = getgenv().crypt.base64decode
	getgenv().base64_decode = getgenv().crypt.base64decode
	getgenv().crypt.encrypt = function(arg1, arg2, arg3, arg4) -- Line 1831
		--[[ Upvalues[4]:
			[1]: assert_upvr (readonly)
			[2]: sendToC_upvr (readonly)
			[3]: encodeHex_upvr (readonly)
			[4]: unpack_upvr (readonly)
		]]
		if not arg3 or arg3 == nil then
		end
		if arg2 ~= nil then
			if arg2 == "" then
			else
			end
		end
		assert_upvr(true, "Key should not be nil")
		if arg4 ~= nil then
			if arg4 == "" then
			else
			end
		end
		assert_upvr(true, "Mode should not be nil")
		local module = {
			request = "encrypt";
		}
		local tbl_22 = {
			data = encodeHex_upvr(arg1);
		}
		tbl_22.key = arg2
		tbl_22.IV = ""
		tbl_22.mode = arg4
		module.data = tbl_22
		return unpack_upvr(sendToC_upvr(module):split(" - "))
	end
	getgenv().crypt.decrypt = function(arg1, arg2, arg3, arg4) -- Line 1841
		--[[ Upvalues[3]:
			[1]: assert_upvr (readonly)
			[2]: sendToC_upvr (readonly)
			[3]: encodeHex_upvr (readonly)
		]]
		-- KONSTANTERROR: [0] 1. Error Block 24 start (CF ANALYSIS FAILED)
		if not arg3 or arg3 == nil then
		end
		if arg1 == nil then
		else
		end
		assert_upvr(true, "Data should not be nil")
		if arg2 == nil then
			-- KONSTANTWARNING: GOTO [17] #14
		end
		-- KONSTANTERROR: [0] 1. Error Block 24 end (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [16] 13. Error Block 26 start (CF ANALYSIS FAILED)
		assert_upvr(true, "Key should not be nil")
		if arg4 == nil then
		else
		end
		assert_upvr(true, "Mode should not be nil")
		local module_9 = {
			request = "decrypt";
		}
		local tbl_8 = {
			data = encodeHex_upvr(arg1);
		}
		tbl_8.key = arg2
		tbl_8.IV = ""
		tbl_8.mode = arg4
		module_9.data = tbl_8
		do
			return sendToC_upvr(module_9)
		end
		-- KONSTANTERROR: [16] 13. Error Block 26 end (CF ANALYSIS FAILED)
	end
	getgenv().crypt.generatekey = function() -- Line 1851
		--[[ Upvalues[1]:
			[1]: sendToC_upvr (readonly)
		]]
		return sendToC_upvr({
			request = "generatekey";
		})
	end
	getgenv().crypt.generatebytes = function(arg1) -- Line 1855
		--[[ Upvalues[3]:
			[1]: assert_upvr (readonly)
			[2]: sendToC_upvr (readonly)
			[3]: tostring_upvr (readonly)
		]]
		local var649
		if 0 >= arg1 then
			var649 = false
		else
			var649 = true
		end
		assert_upvr(var649, "Size needs to be greater than 0")
		var649 = {}
		var649.request = "generatebytes"
		var649.data = {
			size = tostring_upvr(arg1);
		}
		return sendToC_upvr(var649)
	end
	getgenv().crypt.hash = function(arg1, arg2) -- Line 1860
		--[[ Upvalues[3]:
			[1]: assert_upvr (readonly)
			[2]: sendToC_upvr (readonly)
			[3]: encodeHex_upvr (readonly)
		]]
		if arg1 == nil then
		else
		end
		assert_upvr(true, "Data should not be nil")
		if arg2 == nil then
		else
		end
		assert_upvr(true, "Algorithm should not be nil")
		local module_10 = {
			request = "hash";
		}
		local tbl_53 = {
			data = encodeHex_upvr(arg1);
		}
		tbl_53.algorithm = arg2
		module_10.data = tbl_53
		return sendToC_upvr(module_10)
	end
	getgenv().lz4compress = function(arg1) -- Line 1866
		--[[ Upvalues[3]:
			[1]: assert_upvr (readonly)
			[2]: sendToC_upvr (readonly)
			[3]: encodeHex_upvr (readonly)
		]]
		if arg1 == nil then
		else
		end
		assert_upvr(true, "Data should not be nil")
		return sendToC_upvr({
			request = "lz4compress";
			data = {
				data = encodeHex_upvr(arg1);
			};
		})
	end
	getgenv().lz4decompress = function(arg1, arg2) -- Line 1871
		--[[ Upvalues[4]:
			[1]: assert_upvr (readonly)
			[2]: sendToC_upvr (readonly)
			[3]: encodeHex_upvr (readonly)
			[4]: tostring_upvr (readonly)
		]]
		if arg1 == "" then
		else
		end
		assert_upvr(true, "Data should not be nil")
		if arg2 ~= 0 then
			if arg2 == nil then
			else
			end
		end
		assert_upvr(true, "Size should not be nil")
		return sendToC_upvr({
			request = "lz4decompress";
			data = {
				data = encodeHex_upvr(arg1);
				size = tostring_upvr(arg2);
			};
		})
	end
	getgenv().lrm_load_script = function(arg1) -- Line 1877
		--[[ Upvalues[2]:
			[1]: setfenv_upvr (readonly)
			[2]: getfenv_upvr (readonly)
		]]
		local loadstring_result1 = loadstring("        ce_like_loadstring_fn = loadstring;\n        loadstring = nil;\n\t\n    "..getgenv().game:HttpGet("https://api.luarmor.net/files/v3/l/"..arg1..".lua"), '='..arg1)
		setfenv_upvr(loadstring_result1, getfenv_upvr(2))
		return loadstring_result1({
			Origin = "Solara";
		})
	end
	getgenv().keypress = function(arg1) -- Line 1888
		--[[ Upvalues[2]:
			[1]: sendToC_upvr (readonly)
			[2]: tostring_upvr (readonly)
		]]
		local tbl_30 = {
			request = "keypress";
		}
		local tbl_39 = {}
		local var666
		local function INLINED_4() -- Internal function, doesn't exist in bytecode
			var666 = tostring_upvr(arg1)
			return var666
		end
		if not arg1 or not INLINED_4() then
			var666 = 0
		end
		tbl_39.key = var666
		tbl_30.data = tbl_39
		sendToC_upvr(tbl_30)
	end
	getgenv().keyrelease = function(arg1) -- Line 1892
		--[[ Upvalues[2]:
			[1]: sendToC_upvr (readonly)
			[2]: tostring_upvr (readonly)
		]]
		local tbl_24 = {
			request = "keyrelease";
		}
		local tbl_55 = {}
		local var670
		local function INLINED_5() -- Internal function, doesn't exist in bytecode
			var670 = tostring_upvr(arg1)
			return var670
		end
		if not arg1 or not INLINED_5() then
			var670 = 0
		end
		tbl_55.key = var670
		tbl_24.data = tbl_55
		sendToC_upvr(tbl_24)
	end
	getgenv().mouse1click = function() -- Line 1896
		--[[ Upvalues[1]:
			[1]: sendToC_upvr (readonly)
		]]
		sendToC_upvr({
			request = "mouse1click";
		})
	end
	getgenv().mouse1press = function() -- Line 1900
		--[[ Upvalues[1]:
			[1]: sendToC_upvr (readonly)
		]]
		sendToC_upvr({
			request = "mouse1press";
		})
	end
	getgenv().mouse1release = function() -- Line 1904
		--[[ Upvalues[1]:
			[1]: sendToC_upvr (readonly)
		]]
		sendToC_upvr({
			request = "mouse1release";
		})
	end
	getgenv().mouse2click = function() -- Line 1908
		--[[ Upvalues[1]:
			[1]: sendToC_upvr (readonly)
		]]
		sendToC_upvr({
			request = "mouse2click";
		})
	end
	getgenv().mouse2press = function() -- Line 1912
		--[[ Upvalues[1]:
			[1]: sendToC_upvr (readonly)
		]]
		sendToC_upvr({
			request = "mouse2press";
		})
	end
	getgenv().mouse2release = function() -- Line 1916
		--[[ Upvalues[1]:
			[1]: sendToC_upvr (readonly)
		]]
		sendToC_upvr({
			request = "mouse2release";
		})
	end
	getgenv().mousescroll = function(arg1) -- Line 1920
		--[[ Upvalues[2]:
			[1]: sendToC_upvr (readonly)
			[2]: tostring_upvr (readonly)
		]]
		local tbl_44 = {
			request = "mousescroll";
		}
		local tbl_17 = {}
		local var686
		local function INLINED_6() -- Internal function, doesn't exist in bytecode
			var686 = tostring_upvr(arg1)
			return var686
		end
		if not arg1 or not INLINED_6() then
			var686 = 0
		end
		tbl_17.pixels = var686
		tbl_44.data = tbl_17
		sendToC_upvr(tbl_44)
	end
	getgenv().mousemoverel = function(arg1, arg2) -- Line 1924
		--[[ Upvalues[2]:
			[1]: sendToC_upvr (readonly)
			[2]: tostring_upvr (readonly)
		]]
		local tbl_66 = {
			request = "mousemoverel";
		}
		local tbl_38 = {}
		local var690
		local function INLINED_7() -- Internal function, doesn't exist in bytecode
			var690 = tostring_upvr(arg1)
			return var690
		end
		if not arg1 or not INLINED_7() then
			var690 = 0
		end
		tbl_38.x = var690
		local function INLINED_8() -- Internal function, doesn't exist in bytecode
			var690 = tostring_upvr(arg2)
			return var690
		end
		if not arg2 or not INLINED_8() then
			var690 = 0
		end
		tbl_38.y = var690
		tbl_66.data = tbl_38
		sendToC_upvr(tbl_66)
	end
	getgenv().mousemoveabs = function(arg1, arg2) -- Line 1928
		--[[ Upvalues[2]:
			[1]: sendToC_upvr (readonly)
			[2]: tostring_upvr (readonly)
		]]
		local tbl_33 = {
			request = "mousemoveabs";
		}
		local tbl_14 = {}
		local var694
		local function INLINED_9() -- Internal function, doesn't exist in bytecode
			var694 = tostring_upvr(arg1)
			return var694
		end
		if not arg1 or not INLINED_9() then
			var694 = 0
		end
		tbl_14.x = var694
		local function INLINED_10() -- Internal function, doesn't exist in bytecode
			var694 = tostring_upvr(arg2)
			return var694
		end
		if not arg2 or not INLINED_10() then
			var694 = 0
		end
		tbl_14.y = var694
		tbl_33.data = tbl_14
		sendToC_upvr(tbl_33)
	end
	getgenv().Input = {}
	getgenv().Input.LeftClick = function(arg1) -- Line 1933
		if arg1 == "MOUSE_DOWN" then
			getgenv().mouse1press()
		elseif arg1 == "MOUSE_UP" then
			getgenv().mouse1release()
		end
	end
	getgenv().Input.MoveMouse = function(arg1, arg2) -- Line 1934
		getgenv().mousemoverel(arg1, arg2)
	end
	getgenv().Input.ScrollMouse = function(arg1) -- Line 1935
		getgenv().mousescroll(arg1)
	end
	getgenv().Input.KeyPress = function(arg1) -- Line 1936
		getgenv().keypress(arg1)
		wait()
		keyrelease(arg1)
	end
	getgenv().Input.KeyDown = function(arg1) -- Line 1937
		getgenv().keypress(arg1)
	end
	getgenv().Input.KeyUp = function(arg1) -- Line 1938
		getgenv().keyrelease(arg1)
	end
	getgenv().queue_on_teleport = function(arg1) -- Line 1962
		--[[ Upvalues[4]:
			[1]: typeof_upvr (readonly)
			[2]: assert_upvr (readonly)
			[3]: sendToC_upvr (readonly)
			[4]: encodeHex_upvr (readonly)
		]]
		local var702 = false
		if arg1 ~= nil then
			if typeof_upvr(arg1) ~= "string" then
				var702 = false
			else
				var702 = true
			end
		end
		assert_upvr(var702, "Arg #1 invalid")
		sendToC_upvr({
			request = "queue_on_teleport";
			data = encodeHex_upvr(arg1);
		})
	end
	getgenv().setfflag = function(arg1, arg2) -- Line 1967
		--[[ Upvalues[1]:
			[1]: game_upvr (readonly)
		]]
		return game_upvr:DefineFastFlag(arg1, arg2)
	end
	getgenv().getfflag = function(arg1) -- Line 1971
		--[[ Upvalues[1]:
			[1]: game_upvr (readonly)
		]]
		return game_upvr:GetFastFlag(arg1)
	end
	getgenv().fireclickdetector = function(arg1) -- Line 1975
		--[[ Upvalues[1]:
			[1]: math_upvr (readonly)
		]]
		local var707_upvr = arg1:FindFirstChild("ClickDetector") or arg1
		local Part_upvr = Instance.new("Part")
		Part_upvr.Transparency = 1
		Part_upvr.Size = Vector3.new(30, 30, 30)
		Part_upvr.Anchored = true
		Part_upvr.CanCollide = false
		Part_upvr.Parent = getgenv().workspace
		var707_upvr.Parent = Part_upvr
		var707_upvr.MaxActivationDistance = math_upvr.huge
		local any_Connect_result1_upvw = game["Run Service"].Heartbeat:Connect(function() -- Line 1987
			--[[ Upvalues[1]:
				[1]: Part_upvr (readonly)
			]]
			Part_upvr.CFrame = getgenv().workspace.Camera.CFrame * CFrame.new(0, 0, -20) * CFrame.new(getgenv().workspace.Camera.CFrame.LookVector.X, getgenv().workspace.Camera.CFrame.LookVector.Y, getgenv().workspace.Camera.CFrame.LookVector.Z)
			getgenv().game:GetService("VirtualUser"):ClickButton1(Vector2.new(20, 20), getgenv().workspace:FindFirstChildOfClass("Camera").CFrame)
		end)
		local Parent_upvr = var707_upvr.Parent
		var707_upvr.MouseClick:Once(function() -- Line 1991
			--[[ Upvalues[4]:
				[1]: any_Connect_result1_upvw (read and write)
				[2]: var707_upvr (readonly)
				[3]: Parent_upvr (readonly)
				[4]: Part_upvr (readonly)
			]]
			any_Connect_result1_upvw:Disconnect()
			var707_upvr.Parent = Parent_upvr
			Part_upvr:Destroy()
		end)
	end
	getgenv().fireproximityprompt = function(arg1, arg2, arg3) -- Line 1998
		--[[ Upvalues[2]:
			[1]: assert_upvr (readonly)
			[2]: task_upvr (readonly)
		]]
		local var719 = false
		if typeof(arg1) == "Instance" then
			var719 = arg1:IsA("ProximityPrompt")
		end
		assert_upvr(var719, "arg #1 must be ProximityPrompt")
		if arg2 ~= nil then
			if type(arg2) ~= "number" then
				var719 = false
			else
				var719 = true
			end
			assert_upvr(var719, "arg #2 must be type number")
			if arg3 ~= nil then
				if type(arg3) ~= "boolean" then
				else
				end
				assert_upvr(true, "arg #3 must be type boolean")
			end
		end
		arg1.MaxActivationDistance = 9000000000
		arg1:InputHoldBegin()
		for _ = 1, arg2 or 1 do
			if arg3 then
				arg1.HoldDuration = 0
			else
				task_upvr.wait(arg1.HoldDuration + 0.01)
			end
		end
		arg1:InputHoldEnd()
		arg1.MaxActivationDistance = arg1.MaxActivationDistance
		arg1.HoldDuration = arg1.HoldDuration
	end
	local setmetatable_upvr_result1_upvr_2 = setmetatable_upvr({}, {
		__mode = 's';
	})
	getgenv().firetouchinterest = function(arg1, arg2, arg3) -- Line 2027
		--[[ Upvalues[2]:
			[1]: setmetatable_upvr_result1_upvr_2 (readonly)
			[2]: task_upvr (readonly)
		]]
		-- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [5] 6. Error Block 2 start (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [5] 6. Error Block 2 end (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [8] 9. Error Block 3 start (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [8] 9. Error Block 3 end (CF ANALYSIS FAILED)
	end
	getgenv().messagebox = function(arg1, arg2, arg3) -- Line 2111
		--[[ Upvalues[3]:
			[1]: error_upvr (readonly)
			[2]: tostring_upvr (readonly)
			[3]: sendToC_upvr (readonly)
		]]
		if not arg1 or arg1 == "" then
			error_upvr("Invalid arg #1 to messagebox, expected a string, got an empty or nil param", 2)
		end
		local module_15 = {
			request = "messagebox";
		}
		module_15.text = arg1
		module_15.caption = arg2 or "Message Box"
		module_15.style = tostring_upvr(arg3) or '0'
		return tonumber(sendToC_upvr(module_15))
	end
	getgenv().queueonteleport = getgenv().queue_on_teleport
	local any_createMockUserdata_result1_upvr_2 = tbl_29_upvr:createMockUserdata(settings())
	getgenv().settings = function() -- Line 2124
		--[[ Upvalues[1]:
			[1]: any_createMockUserdata_result1_upvr_2 (readonly)
		]]
		return any_createMockUserdata_result1_upvr_2
	end
	local any_createMockUserdata_result1_upvr = tbl_29_upvr:createMockUserdata(UserSettings())
	getgenv().UserSettings = function() -- Line 2128
		--[[ Upvalues[1]:
			[1]: any_createMockUserdata_result1_upvr (readonly)
		]]
		return any_createMockUserdata_result1_upvr
	end
	local var729_upvw = 0
	local function call_upvr(arg1, arg2) -- Line 2137, Named "call"
		--[[ Upvalues[3]:
			[1]: pcall_upvr (readonly)
			[2]: var729_upvw (read and write)
			[3]: task_upvr (readonly)
		]]
		local pcall_upvr_result1_5, var91_result2_2 = pcall_upvr(getscriptbytecode, arg2)
		if not pcall_upvr_result1_5 then
			return `-- Failed to get script bytecode, error:\n\n--[[\n{var91_result2_2}\n--]]`
		end
		local var732 = os.clock() - var729_upvw
		if var732 <= 0.5 then
			task_upvr.wait(0.5 - var732)
		end
		local request_result1 = request({
			Url = "http://api.plusgiant5.com"..arg1;
			Body = var91_result2_2;
			Method = "POST";
			Headers = {
				["Content-Type"] = "text/plain";
			};
		})
		var729_upvw = os.clock()
		if request_result1.StatusCode ~= 200 then
			return `-- Error occured while requesting the API, error:\n\n--[[\n{request_result1.Body}\n--]]`
		end
		return request_result1.Body
	end
	getgenv().disassemble = function(arg1) -- Line 2169, Named "disassemble"
		--[[ Upvalues[1]:
			[1]: call_upvr (readonly)
		]]
		return call_upvr("/konstant/disassemble", arg1)
	end
	getgenv().decompile = function(arg1) -- Line 2165, Named "decompile"
		--[[ Upvalues[1]:
			[1]: call_upvr (readonly)
		]]
		return call_upvr("/konstant/decompile", arg1)
	end
	getgenv().saveinstance = function(...) -- Line 2176
		if not synsaveinstance then
			synsaveinstance = loadstring(game:HttpGet("https://raw.githubusercontent.com/luau/SynSaveInstance/main/saveinstance.luau", true), "saveinstance")() -- Setting global
		end
		return synsaveinstance(...)
	end
	local any_new_result1_upvr_2 = getgenv().Instance.new("ScreenGui")
	any_new_result1_upvr_2.Name = "Drawing"
	any_new_result1_upvr_2.IgnoreGuiInset = true
	any_new_result1_upvr_2.DisplayOrder = 2147483647
	any_new_result1_upvr_2.Parent = getgenv().game:GetService("CoreGui")
	local module_4_upvr = {Font.fromEnum(Enum.Font.Legacy), Font.fromEnum(Enum.Font.SourceSans), Font.fromEnum(Enum.Font.RobotoMono)}
	local function getFontFromIndex_upvr(arg1) -- Line 2228, Named "getFontFromIndex"
		--[[ Upvalues[1]:
			[1]: module_4_upvr (readonly)
		]]
		return module_4_upvr[arg1]
	end
	local function convertTransparency_upvr(arg1) -- Line 2232, Named "convertTransparency"
		return math.clamp(1 - arg1, 0, 1)
	end
	local tbl_10_upvr = {
		Fonts = {
			UI = 0;
			System = 1;
			Plex = 2;
			Monospace = 3;
		};
	}
	local var748_upvw = 0
	local setmetatable_upvr_result1_upvr = setmetatable_upvr({
		Visible = true;
		ZIndex = 0;
		Transparency = 1;
		Color = Color3.new();
		Remove = function(arg1) -- Line 2205, Named "Remove"
			--[[ Upvalues[1]:
				[1]: setmetatable_upvr (readonly)
			]]
			setmetatable_upvr(arg1, nil)
		end;
		Destroy = function(arg1) -- Line 2208, Named "Destroy"
			--[[ Upvalues[1]:
				[1]: setmetatable_upvr (readonly)
			]]
			setmetatable_upvr(arg1, nil)
		end;
	}, {
		__add = function(arg1, arg2) -- Line 2212, Named "__add"
			local clone_2 = table.clone(arg1)
			for i_28, v_22 in arg2 do
				clone_2[i_28] = v_22
			end
			return clone_2
		end;
	})
	local CurrentCamera_upvr = getgenv().workspace.CurrentCamera
	function tbl_10_upvr.new(arg1) -- Line 2244
		--[[ Upvalues[10]:
			[1]: var748_upvw (read and write)
			[2]: setmetatable_upvr_result1_upvr (readonly)
			[3]: convertTransparency_upvr (readonly)
			[4]: any_new_result1_upvr_2 (readonly)
			[5]: setmetatable_upvr (readonly)
			[6]: tbl_10_upvr (readonly)
			[7]: getFontFromIndex_upvr (readonly)
			[8]: CurrentCamera_upvr (readonly)
			[9]: var103_upvr (readonly)
			[10]: tostring_upvr (readonly)
		]]
		var748_upvw += 1
		if arg1 == "Line" then
			local var752_upvr = {
				From = Vector2.zero;
				To = Vector2.zero;
				Thickness = 1;
			} + setmetatable_upvr_result1_upvr
			local Frame_upvr = Instance.new("Frame")
			Frame_upvr.Name = var748_upvw
			Frame_upvr.AnchorPoint = Vector2.one * 0.5
			Frame_upvr.BorderSizePixel = 0
			Frame_upvr.BackgroundColor3 = var752_upvr.Color
			Frame_upvr.Visible = var752_upvr.Visible
			Frame_upvr.ZIndex = var752_upvr.ZIndex
			Frame_upvr.BackgroundTransparency = convertTransparency_upvr(var752_upvr.Transparency)
			Frame_upvr.Size = UDim2.new()
			Frame_upvr.Parent = any_new_result1_upvr_2
			local module_17 = {}
			local function __newindex(arg1_39, arg2, arg3) -- Line 2267
				--[[ Upvalues[3]:
					[1]: var752_upvr (readonly)
					[2]: Frame_upvr (readonly)
					[3]: convertTransparency_upvr (copied, readonly)
				]]
				-- KONSTANTERROR: [0] 1. Error Block 26 start (CF ANALYSIS FAILED)
				if typeof(var752_upvr[arg2]) == "nil" then return end
				if arg2 == "From" then
					local var755 = var752_upvr.To - arg3
					local var756 = (var752_upvr.To + arg3) / 2
					Frame_upvr.Position = UDim2.fromOffset(var756.X, var756.Y)
					Frame_upvr.Rotation = math.deg(math.atan2(var755.Y, var755.X))
					Frame_upvr.Size = UDim2.fromOffset(var755.Magnitude, var752_upvr.Thickness)
					-- KONSTANTWARNING: GOTO [155] #106
				end
				-- KONSTANTERROR: [0] 1. Error Block 26 end (CF ANALYSIS FAILED)
				-- KONSTANTERROR: [59] 41. Error Block 23 start (CF ANALYSIS FAILED)
				if arg2 == "To" then
					local var757 = arg3 - var752_upvr.From
					local var758 = (arg3 + var752_upvr.From) / 2
					Frame_upvr.Position = UDim2.fromOffset(var758.X, var758.Y)
					Frame_upvr.Rotation = math.deg(math.atan2(var757.Y, var757.X))
					Frame_upvr.Size = UDim2.fromOffset(var757.Magnitude, var752_upvr.Thickness)
				elseif arg2 == "Thickness" then
					Frame_upvr.Size = UDim2.fromOffset((var752_upvr.To - var752_upvr.From).Magnitude, arg3)
				elseif arg2 == "Visible" then
					Frame_upvr.Visible = arg3
				elseif arg2 == "ZIndex" then
					Frame_upvr.ZIndex = arg3
				elseif arg2 == "Transparency" then
					Frame_upvr.BackgroundTransparency = convertTransparency_upvr(arg3)
				elseif arg2 == "Color" then
					Frame_upvr.BackgroundColor3 = arg3
				end
				-- KONSTANTERROR: [59] 41. Error Block 23 end (CF ANALYSIS FAILED)
			end
			module_17.__newindex = __newindex
			local function __index(arg1_40, arg2) -- Line 2303
				--[[ Upvalues[2]:
					[1]: Frame_upvr (readonly)
					[2]: var752_upvr (readonly)
				]]
				if arg2 == "Remove" or arg2 == "Destroy" then
					return function() -- Line 2305
						--[[ Upvalues[3]:
							[1]: Frame_upvr (copied, readonly)
							[2]: var752_upvr (copied, readonly)
							[3]: arg1_40 (readonly)
						]]
						Frame_upvr:Destroy()
						var752_upvr.Remove(arg1_40)
						return var752_upvr:Remove()
					end
				end
				return var752_upvr[arg2]
			end
			module_17.__index = __index
			local function __tostring() -- Line 2313
				return "Drawing"
			end
			module_17.__tostring = __tostring
			return setmetatable_upvr(table.create(0), module_17)
		end
		if arg1 == "Text" then
			Frame_upvr = {}
			local var760 = Frame_upvr
			var760.Text = ""
			var760.Font = tbl_10_upvr.Fonts.UI
			var760.Size = 0
			var760.Position = Vector2.zero
			var760.Center = false
			var760.Outline = false
			var760.OutlineColor = Color3.new()
			var752_upvr = var760 + setmetatable_upvr_result1_upvr
			local var761_upvr = var752_upvr
			var760 = Instance.new("TextLabel")
			local var762_upvr = var760
			local UIStroke_upvr_2 = Instance.new("UIStroke")
			var762_upvr.Name = var748_upvw
			var762_upvr.AnchorPoint = Vector2.one * 0.5
			var762_upvr.BorderSizePixel = 0
			var762_upvr.BackgroundTransparency = 1
			var762_upvr.Visible = var761_upvr.Visible
			var762_upvr.TextColor3 = var761_upvr.Color
			var762_upvr.TextTransparency = convertTransparency_upvr(var761_upvr.Transparency)
			var762_upvr.ZIndex = var761_upvr.ZIndex
			var762_upvr.FontFace = getFontFromIndex_upvr(var761_upvr.Font)
			var762_upvr.TextSize = var761_upvr.Size
			var762_upvr:GetPropertyChangedSignal("TextBounds"):Connect(function() -- Line 2340
				--[[ Upvalues[2]:
					[1]: var762_upvr (readonly)
					[2]: var761_upvr (readonly)
				]]
				local TextBounds = var762_upvr.TextBounds
				var762_upvr.Size = UDim2.fromOffset(TextBounds.X, TextBounds.Y)
				local Position = var761_upvr.Position
				if not var761_upvr.Center then
					Position = (TextBounds / 2).X
				else
					Position = 0
				end
				-- KONSTANTERROR: Expression was reused, decompilation is incorrect
				var762_upvr.Position = UDim2.fromOffset(Position.X + Position, var761_upvr.Position.Y + (TextBounds / 2).Y)
			end)
			UIStroke_upvr_2.Thickness = 1
			UIStroke_upvr_2.Enabled = var761_upvr.Outline
			UIStroke_upvr_2.Color = var761_upvr.Color
			var762_upvr.Parent = any_new_result1_upvr_2
			UIStroke_upvr_2.Parent = var762_upvr
			local module_13 = {}
			local function __newindex(arg1_41, arg2, arg3) -- Line 2354
				--[[ Upvalues[6]:
					[1]: var761_upvr (readonly)
					[2]: var762_upvr (readonly)
					[3]: getFontFromIndex_upvr (copied, readonly)
					[4]: CurrentCamera_upvr (copied, readonly)
					[5]: UIStroke_upvr_2 (readonly)
					[6]: convertTransparency_upvr (copied, readonly)
				]]
				-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
				-- KONSTANTERROR: [0] 1. Error Block 52 start (CF ANALYSIS FAILED)
				if typeof(var761_upvr[arg2]) == "nil" then return end
				if arg2 == "Text" then
					var762_upvr.Text = arg3
					-- KONSTANTWARNING: GOTO [130] #93
				end
				-- KONSTANTERROR: [0] 1. Error Block 52 end (CF ANALYSIS FAILED)
				-- KONSTANTERROR: [15] 12. Error Block 49 start (CF ANALYSIS FAILED)
				if arg2 == "Font" then
					var762_upvr.FontFace = getFontFromIndex_upvr(math.clamp(arg3, 0, 3))
				elseif arg2 == "Size" then
					-- KONSTANTERROR: Expression was reused, decompilation is incorrect
					var762_upvr.TextSize = math.clamp(arg3, 0, 3)
					local var768
				elseif arg2 == "Position" then
					-- KONSTANTERROR: Expression was reused, decompilation is incorrect
					if not var761_upvr.Center then
						var768 = (var762_upvr.TextBounds / 2).X
					else
						var768 = 0
					end
					-- KONSTANTERROR: Expression was reused, decompilation is incorrect
					var768 = math.clamp(arg3, 0, 3).Y
					-- KONSTANTERROR: Expression was reused, decompilation is incorrect
					var762_upvr.Position = UDim2.fromOffset(math.clamp(arg3, 0, 3).X + var768, var768 + (var762_upvr.TextBounds / 2).Y)
					local var769
				elseif arg2 == "Center" then
					-- KONSTANTERROR: Expression was reused, decompilation is incorrect
					if math.clamp(arg3, 0, 3) then
						local var770 = nil
					else
						var770 = var761_upvr.Position
					end
					var762_upvr.Position = UDim2.fromOffset(var770.X, var770.Y)
				elseif arg2 == "Outline" then
					var770 = UIStroke_upvr_2
					-- KONSTANTERROR: Expression was reused, decompilation is incorrect
					var770.Enabled = math.clamp(arg3, 0, 3)
				elseif arg2 == "OutlineColor" then
					var770 = UIStroke_upvr_2
					-- KONSTANTERROR: Expression was reused, decompilation is incorrect
					var770.Color = math.clamp(arg3, 0, 3)
				elseif arg2 == "Visible" then
					var770 = var762_upvr
					-- KONSTANTERROR: Expression was reused, decompilation is incorrect
					var770.Visible = math.clamp(arg3, 0, 3)
				elseif arg2 == "ZIndex" then
					var770 = var762_upvr
					-- KONSTANTERROR: Expression was reused, decompilation is incorrect
					var770.ZIndex = math.clamp(arg3, 0, 3)
				elseif arg2 == "Transparency" then
					var770 = convertTransparency_upvr
					-- KONSTANTERROR: Expression was reused, decompilation is incorrect
					var770 = var770(math.clamp(arg3, 0, 3))
					local var771 = var770
					var762_upvr.TextTransparency = var771
					UIStroke_upvr_2.Transparency = var771
				elseif arg2 == "Color" then
					var771 = var762_upvr
					-- KONSTANTERROR: Expression was reused, decompilation is incorrect
					var771.TextColor3 = math.clamp(arg3, 0, 3)
				end
				-- KONSTANTERROR: [15] 12. Error Block 49 end (CF ANALYSIS FAILED)
			end
			module_13.__newindex = __newindex
			local function __index(arg1_42, arg2) -- Line 2395
				--[[ Upvalues[2]:
					[1]: var762_upvr (readonly)
					[2]: var761_upvr (readonly)
				]]
				if arg2 == "Remove" or arg2 == "Destroy" then
					return function() -- Line 2397
						--[[ Upvalues[3]:
							[1]: var762_upvr (copied, readonly)
							[2]: var761_upvr (copied, readonly)
							[3]: arg1_42 (readonly)
						]]
						var762_upvr:Destroy()
						var761_upvr.Remove(arg1_42)
						return var761_upvr:Remove()
					end
				end
				if arg2 == "TextBounds" then
					return var762_upvr.TextBounds
				end
				return var761_upvr[arg2]
			end
			module_13.__index = __index
			local function __tostring() -- Line 2407
				return "Drawing"
			end
			module_13.__tostring = __tostring
			return setmetatable_upvr(table.create(0), module_13)
		end
		if arg1 == "Circle" then
			var762_upvr = {}
			local var773 = var762_upvr
			UIStroke_upvr_2 = 150
			var773.Radius = UIStroke_upvr_2
			UIStroke_upvr_2 = Vector2.zero
			var773.Position = UIStroke_upvr_2
			UIStroke_upvr_2 = 0.7
			var773.Thickness = UIStroke_upvr_2
			UIStroke_upvr_2 = false
			var773.Filled = UIStroke_upvr_2
			UIStroke_upvr_2 = setmetatable_upvr_result1_upvr
			var761_upvr = var773 + UIStroke_upvr_2
			local var774_upvr = var761_upvr
			var773 = Instance.new("Frame")
			local var775_upvr = var773
			UIStroke_upvr_2 = Instance.new("UICorner")
			local var776 = UIStroke_upvr_2
			local UIStroke_upvr = Instance.new("UIStroke")
			var775_upvr.Name = var748_upvw
			var775_upvr.AnchorPoint = Vector2.one * 0.5
			local var778 = 0
			var775_upvr.BorderSizePixel = var778
			if var774_upvr.Filled then
				var778 = convertTransparency_upvr(var774_upvr.Transparency)
			else
				var778 = 1
			end
			var775_upvr.BackgroundTransparency = var778
			var775_upvr.BackgroundColor3 = var774_upvr.Color
			var775_upvr.Visible = var774_upvr.Visible
			var775_upvr.ZIndex = var774_upvr.ZIndex
			var776.CornerRadius = UDim.new(1, 0)
			var775_upvr.Size = UDim2.fromOffset(var774_upvr.Radius, var774_upvr.Radius)
			UIStroke_upvr.Thickness = var774_upvr.Thickness
			UIStroke_upvr.Enabled = not var774_upvr.Filled
			UIStroke_upvr.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			var775_upvr.Parent = any_new_result1_upvr_2
			var776.Parent = var775_upvr
			UIStroke_upvr.Parent = var775_upvr
			local module_2 = {}
			local function __newindex(arg1_43, arg2, arg3) -- Line 2436
				--[[ Upvalues[4]:
					[1]: var774_upvr (readonly)
					[2]: var775_upvr (readonly)
					[3]: UIStroke_upvr (readonly)
					[4]: convertTransparency_upvr (copied, readonly)
				]]
				-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
				-- KONSTANTERROR: [0] 1. Error Block 43 start (CF ANALYSIS FAILED)
				if typeof(var774_upvr[arg2]) == "nil" then return end
				if arg2 == "Radius" then
					local var780 = arg3 * 2
					var775_upvr.Size = UDim2.fromOffset(var780, var780)
					local var781
					-- KONSTANTWARNING: GOTO [105] #78
				end
				-- KONSTANTERROR: [0] 1. Error Block 43 end (CF ANALYSIS FAILED)
				-- KONSTANTERROR: [21] 17. Error Block 40 start (CF ANALYSIS FAILED)
				if arg2 == "Position" then
					var775_upvr.Position = UDim2.fromOffset(var781.X, var781.Y)
				elseif arg2 == "Thickness" then
					var781 = math.clamp(var781, 0.6, 2147483647)
					UIStroke_upvr.Thickness = var781
					local var782
				elseif arg2 == "Filled" then
					if var781 then
						var782 = convertTransparency_upvr(var774_upvr.Transparency)
					else
						var782 = 1
					end
					var775_upvr.BackgroundTransparency = var782
					var782 = not var781
					UIStroke_upvr.Enabled = var782
				elseif arg2 == "Visible" then
					var775_upvr.Visible = var781
				elseif arg2 == "ZIndex" then
					var775_upvr.ZIndex = var781
					local var783
				elseif arg2 == "Transparency" then
					var782 = var781
					var782 = var775_upvr
					if var774_upvr.Filled then
						var783 = convertTransparency_upvr(var782)
					else
						var783 = 1
					end
					var782.BackgroundTransparency = var783
					var782 = UIStroke_upvr
					var782.Transparency = convertTransparency_upvr(var782)
				elseif arg2 == "Color" then
					var775_upvr.BackgroundColor3 = var781
					UIStroke_upvr.Color = var781
				end
				-- KONSTANTERROR: [21] 17. Error Block 40 end (CF ANALYSIS FAILED)
			end
			module_2.__newindex = __newindex
			local function __index(arg1_44, arg2) -- Line 2465
				--[[ Upvalues[2]:
					[1]: var775_upvr (readonly)
					[2]: var774_upvr (readonly)
				]]
				if arg2 == "Remove" or arg2 == "Destroy" then
					return function() -- Line 2467
						--[[ Upvalues[3]:
							[1]: var775_upvr (copied, readonly)
							[2]: var774_upvr (copied, readonly)
							[3]: arg1_44 (readonly)
						]]
						var775_upvr:Destroy()
						var774_upvr.Remove(arg1_44)
						return var774_upvr:Remove()
					end
				end
				return var774_upvr[arg2]
			end
			module_2.__index = __index
			local function __tostring() -- Line 2475
				return "Drawing"
			end
			module_2.__tostring = __tostring
			return setmetatable_upvr(table.create(0), module_2)
		end
		if arg1 == "Square" then
			var775_upvr = {}
			local var785 = var775_upvr
			var776 = Vector2.zero
			var785.Size = var776
			var776 = Vector2.zero
			var785.Position = var776
			var776 = 0.7
			var785.Thickness = var776
			var776 = false
			var785.Filled = var776
			var776 = setmetatable_upvr_result1_upvr
			var774_upvr = var785 + var776
			local var786_upvr = var774_upvr
			UIStroke_upvr = Instance.new("Frame")
			var785 = UIStroke_upvr
			local var787_upvr = var785
			var776 = Instance.new
			UIStroke_upvr = "UIStroke"
			var776 = var776(UIStroke_upvr)
			local var788_upvr = var776
			UIStroke_upvr = var748_upvw
			var787_upvr.Name = UIStroke_upvr
			UIStroke_upvr = 0
			local var789 = UIStroke_upvr
			var787_upvr.BorderSizePixel = var789
			if var786_upvr.Filled then
				var789 = convertTransparency_upvr(var786_upvr.Transparency)
			else
				var789 = 1
			end
			var787_upvr.BackgroundTransparency = var789
			var787_upvr.ZIndex = var786_upvr.ZIndex
			var787_upvr.BackgroundColor3 = var786_upvr.Color
			var787_upvr.Visible = var786_upvr.Visible
			var788_upvr.Thickness = var786_upvr.Thickness
			var788_upvr.Enabled = not var786_upvr.Filled
			var788_upvr.LineJoinMode = Enum.LineJoinMode.Miter
			var787_upvr.Parent = any_new_result1_upvr_2
			var788_upvr.Parent = var787_upvr
			local module_7 = {}
			local function __newindex(arg1_45, arg2, arg3) -- Line 2500
				--[[ Upvalues[4]:
					[1]: var786_upvr (readonly)
					[2]: var787_upvr (readonly)
					[3]: var788_upvr (readonly)
					[4]: convertTransparency_upvr (copied, readonly)
				]]
				-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
				-- KONSTANTERROR: [0] 1. Error Block 43 start (CF ANALYSIS FAILED)
				if typeof(var786_upvr[arg2]) == "nil" then return end
				if arg2 == "Size" then
					var787_upvr.Size = UDim2.fromOffset(arg3.X, arg3.Y)
					local var791
					-- KONSTANTWARNING: GOTO [106] #77
				end
				-- KONSTANTERROR: [0] 1. Error Block 43 end (CF ANALYSIS FAILED)
				-- KONSTANTERROR: [22] 16. Error Block 40 start (CF ANALYSIS FAILED)
				if arg2 == "Position" then
					var787_upvr.Position = UDim2.fromOffset(var791.X, var791.Y)
				elseif arg2 == "Thickness" then
					var791 = math.clamp(var791, 0.6, 2147483647)
					var788_upvr.Thickness = var791
					local var792
				elseif arg2 == "Filled" then
					if var791 then
						var792 = convertTransparency_upvr(var786_upvr.Transparency)
					else
						var792 = 1
					end
					var787_upvr.BackgroundTransparency = var792
					var792 = not var791
					var788_upvr.Enabled = var792
				elseif arg2 == "Visible" then
					var787_upvr.Visible = var791
				elseif arg2 == "ZIndex" then
					var787_upvr.ZIndex = var791
					local var793
				elseif arg2 == "Transparency" then
					var792 = var791
					var792 = var787_upvr
					if var786_upvr.Filled then
						var793 = convertTransparency_upvr(var792)
					else
						var793 = 1
					end
					var792.BackgroundTransparency = var793
					var792 = var788_upvr
					var792.Transparency = convertTransparency_upvr(var792)
				elseif arg2 == "Color" then
					var788_upvr.Color = var791
					var787_upvr.BackgroundColor3 = var791
				end
				-- KONSTANTERROR: [22] 16. Error Block 40 end (CF ANALYSIS FAILED)
			end
			module_7.__newindex = __newindex
			local function __index(arg1_46, arg2) -- Line 2528
				--[[ Upvalues[2]:
					[1]: var787_upvr (readonly)
					[2]: var786_upvr (readonly)
				]]
				if arg2 == "Remove" or arg2 == "Destroy" then
					return function() -- Line 2530
						--[[ Upvalues[3]:
							[1]: var787_upvr (copied, readonly)
							[2]: var786_upvr (copied, readonly)
							[3]: arg1_46 (readonly)
						]]
						var787_upvr:Destroy()
						var786_upvr.Remove(arg1_46)
						return var786_upvr:Remove()
					end
				end
				return var786_upvr[arg2]
			end
			module_7.__index = __index
			local function __tostring() -- Line 2538
				return "Drawing"
			end
			module_7.__tostring = __tostring
			return setmetatable_upvr(table.create(0), module_7)
		end
		if arg1 == "Image" then
			var787_upvr = {}
			local var795 = var787_upvr
			var788_upvr = ""
			var795.Data = var788_upvr
			var788_upvr = "rbxassetid://0"
			var795.DataURL = var788_upvr
			var788_upvr = Vector2.zero
			var795.Size = var788_upvr
			var788_upvr = Vector2.zero
			var795.Position = var788_upvr
			var788_upvr = setmetatable_upvr_result1_upvr
			var786_upvr = var795 + var788_upvr
			local var796_upvr = var786_upvr
			var795 = Instance.new
			var788_upvr = "ImageLabel"
			var795 = var795(var788_upvr)
			local var797_upvr = var795
			var788_upvr = var748_upvw
			var797_upvr.Name = var788_upvr
			var788_upvr = 0
			var797_upvr.BorderSizePixel = var788_upvr
			var788_upvr = Enum.ScaleType.Stretch
			var797_upvr.ScaleType = var788_upvr
			var788_upvr = 1
			var797_upvr.BackgroundTransparency = var788_upvr
			var788_upvr = var796_upvr.Visible
			var797_upvr.Visible = var788_upvr
			var788_upvr = var796_upvr.ZIndex
			var797_upvr.ZIndex = var788_upvr
			var788_upvr = convertTransparency_upvr(var796_upvr.Transparency)
			var797_upvr.ImageTransparency = var788_upvr
			var788_upvr = var796_upvr.Color
			var797_upvr.ImageColor3 = var788_upvr
			var788_upvr = any_new_result1_upvr_2
			var797_upvr.Parent = var788_upvr
			local tbl_31 = {}
			local function __newindex(arg1_47, arg2, arg3) -- Line 2561
				--[[ Upvalues[3]:
					[1]: var796_upvr (readonly)
					[2]: var797_upvr (readonly)
					[3]: convertTransparency_upvr (copied, readonly)
				]]
				-- KONSTANTERROR: [0] 1. Error Block 29 start (CF ANALYSIS FAILED)
				if typeof(var796_upvr[arg2]) == "nil" then return end
				if arg2 == "Data" then
					-- KONSTANTWARNING: GOTO [70] #48
				end
				-- KONSTANTERROR: [0] 1. Error Block 29 end (CF ANALYSIS FAILED)
				-- KONSTANTERROR: [12] 10. Error Block 26 start (CF ANALYSIS FAILED)
				if arg2 == "DataURL" then
					var797_upvr.Image = arg3
				elseif arg2 == "Size" then
					var797_upvr.Size = UDim2.fromOffset(arg3.X, arg3.Y)
				elseif arg2 == "Position" then
					var797_upvr.Position = UDim2.fromOffset(arg3.X, arg3.Y)
				elseif arg2 == "Visible" then
					var797_upvr.Visible = arg3
				elseif arg2 == "ZIndex" then
					var797_upvr.ZIndex = arg3
				elseif arg2 == "Transparency" then
					var797_upvr.ImageTransparency = convertTransparency_upvr(arg3)
				elseif arg2 == "Color" then
					var797_upvr.ImageColor3 = arg3
				end
				-- KONSTANTERROR: [12] 10. Error Block 26 end (CF ANALYSIS FAILED)
			end
			tbl_31.__newindex = __newindex
			local function __index(arg1_48, arg2) -- Line 2583
				--[[ Upvalues[2]:
					[1]: var797_upvr (readonly)
					[2]: var796_upvr (readonly)
				]]
				if arg2 == "Remove" or arg2 == "Destroy" then
					return function() -- Line 2585
						--[[ Upvalues[3]:
							[1]: var797_upvr (copied, readonly)
							[2]: var796_upvr (copied, readonly)
							[3]: arg1_48 (readonly)
						]]
						var797_upvr:Destroy()
						var796_upvr.Remove(arg1_48)
						return var796_upvr:Remove()
					end
				end
				if arg2 == "Data" then
					return nil
				end
				return var796_upvr[arg2]
			end
			tbl_31.__index = __index
			local function __tostring() -- Line 2595
				return "Drawing"
			end
			tbl_31.__tostring = __tostring
			var788_upvr = setmetatable_upvr(table.create(0), tbl_31)
			return var788_upvr
		end
		if arg1 == "Quad" then
			var797_upvr = {}
			local var800 = var797_upvr
			var788_upvr = 1
			var800.Thickness = var788_upvr
			var788_upvr = Vector2.new()
			var800.PointA = var788_upvr
			var788_upvr = Vector2.new()
			var800.PointB = var788_upvr
			var788_upvr = Vector2.new()
			var800.PointC = var788_upvr
			var788_upvr = Vector2.new()
			var800.PointD = var788_upvr
			var788_upvr = false
			var800.Filled = var788_upvr
			var788_upvr = setmetatable_upvr_result1_upvr
			var796_upvr = var800 + var788_upvr
			var788_upvr = tbl_10_upvr
			var800 = var788_upvr.new
			var788_upvr = "Line"
			var800 = var800(var788_upvr)
			local var801_upvr = var800
			var788_upvr = tbl_10_upvr.new("Line")
			local var802_upvr = var788_upvr
			local any_new_result1_2_upvr = tbl_10_upvr.new("Line")
			local any_new_result1_upvr_3 = tbl_10_upvr.new("Line")
			return setmetatable_upvr({}, {
				__newindex = function(arg1_49, arg2, arg3) -- Line 2613
					--[[ Upvalues[4]:
						[1]: var801_upvr (readonly)
						[2]: var802_upvr (readonly)
						[3]: any_new_result1_2_upvr (readonly)
						[4]: any_new_result1_upvr_3 (readonly)
					]]
					if arg2 == "Thickness" then
						var801_upvr.Thickness = arg3
						var802_upvr.Thickness = arg3
						any_new_result1_2_upvr.Thickness = arg3
						any_new_result1_upvr_3.Thickness = arg3
					end
					if arg2 == "PointA" then
						var801_upvr.From = arg3
						var802_upvr.To = arg3
					end
					if arg2 == "PointB" then
						var802_upvr.From = arg3
						any_new_result1_2_upvr.To = arg3
					end
					if arg2 == "PointC" then
						any_new_result1_2_upvr.From = arg3
						any_new_result1_upvr_3.To = arg3
					end
					if arg2 == "PointD" then
						any_new_result1_upvr_3.From = arg3
						var801_upvr.To = arg3
					end
					if arg2 == "Visible" then
						var801_upvr.Visible = true
						var802_upvr.Visible = true
						any_new_result1_2_upvr.Visible = true
						any_new_result1_upvr_3.Visible = true
					end
					if arg2 ~= "Filled" then
					end
					if arg2 == "Color" then
						var801_upvr.Color = arg3
						var802_upvr.Color = arg3
						any_new_result1_2_upvr.Color = arg3
						any_new_result1_upvr_3.Color = arg3
					end
					if arg2 == "ZIndex" then
						var801_upvr.ZIndex = arg3
						var802_upvr.ZIndex = arg3
						any_new_result1_2_upvr.ZIndex = arg3
						any_new_result1_upvr_3.ZIndex = arg3
					end
				end;
				__index = function(arg1_50, arg2) -- Line 2658
					--[[ Upvalues[7]:
						[1]: var103_upvr (copied, readonly)
						[2]: tostring_upvr (copied, readonly)
						[3]: var801_upvr (readonly)
						[4]: var802_upvr (readonly)
						[5]: any_new_result1_2_upvr (readonly)
						[6]: any_new_result1_upvr_3 (readonly)
						[7]: var796_upvr (readonly)
					]]
					if var103_upvr.lower(tostring_upvr(arg2)) == "remove" then
						return function() -- Line 2660
							--[[ Upvalues[4]:
								[1]: var801_upvr (copied, readonly)
								[2]: var802_upvr (copied, readonly)
								[3]: any_new_result1_2_upvr (copied, readonly)
								[4]: any_new_result1_upvr_3 (copied, readonly)
							]]
							var801_upvr:Remove()
							var802_upvr:Remove()
							any_new_result1_2_upvr:Remove()
							any_new_result1_upvr_3:Remove()
						end
					end
					return var796_upvr[arg2]
				end;
			})
		end
		if arg1 == "Triangle" then
			var801_upvr = {}
			local var809 = var801_upvr
			var802_upvr = Vector2.zero
			var809.PointA = var802_upvr
			var802_upvr = Vector2.zero
			var809.PointB = var802_upvr
			var802_upvr = Vector2.zero
			var809.PointC = var802_upvr
			var802_upvr = 1
			var809.Thickness = var802_upvr
			var802_upvr = false
			var809.Filled = var802_upvr
			var802_upvr = setmetatable_upvr_result1_upvr
			var796_upvr = var809 + var802_upvr
			local var810_upvr = var796_upvr
			var809 = table.create
			var802_upvr = 0
			var809 = var809(var802_upvr)
			local var811_upvr = var809
			any_new_result1_2_upvr = tbl_10_upvr
			var802_upvr = any_new_result1_2_upvr.new
			any_new_result1_2_upvr = "Line"
			var802_upvr = var802_upvr(any_new_result1_2_upvr)
			var811_upvr.A = var802_upvr
			any_new_result1_2_upvr = tbl_10_upvr
			var802_upvr = any_new_result1_2_upvr.new
			any_new_result1_2_upvr = "Line"
			var802_upvr = var802_upvr(any_new_result1_2_upvr)
			var811_upvr.B = var802_upvr
			any_new_result1_2_upvr = tbl_10_upvr
			var802_upvr = any_new_result1_2_upvr.new
			any_new_result1_2_upvr = "Line"
			var802_upvr = var802_upvr(any_new_result1_2_upvr)
			var811_upvr.C = var802_upvr
			any_new_result1_2_upvr = table.create
			any_new_result1_upvr_3 = 0
			any_new_result1_2_upvr = any_new_result1_2_upvr(any_new_result1_upvr_3)
			any_new_result1_upvr_3 = {}
			local var812 = any_new_result1_upvr_3
			function var812.__tostring() -- Line 2685
				return "Drawing"
			end
			function var812.__newindex(arg1_51, arg2, arg3) -- Line 2686
				--[[ Upvalues[2]:
					[1]: var810_upvr (readonly)
					[2]: var811_upvr (readonly)
				]]
				-- KONSTANTERROR: [0] 1. Error Block 32 start (CF ANALYSIS FAILED)
				if typeof(var810_upvr[arg2]) == "nil" then return end
				if arg2 == "PointA" then
					var811_upvr.A.From = arg3
					var811_upvr.B.To = arg3
					-- KONSTANTWARNING: GOTO [66] #44
				end
				-- KONSTANTERROR: [0] 1. Error Block 32 end (CF ANALYSIS FAILED)
				-- KONSTANTERROR: [22] 16. Error Block 29 start (CF ANALYSIS FAILED)
				if arg2 == "PointB" then
					var811_upvr.B.From = arg3
					var811_upvr.C.To = arg3
					-- KONSTANTWARNING: GOTO [66] #44
				end
				-- KONSTANTERROR: [22] 16. Error Block 29 end (CF ANALYSIS FAILED)
			end
			function var812.__index(arg1_52, arg2) -- Line 2707
				--[[ Upvalues[2]:
					[1]: var811_upvr (readonly)
					[2]: var810_upvr (readonly)
				]]
				if arg2 == "Remove" or arg2 == "Destroy" then
					return function() -- Line 2709
						--[[ Upvalues[3]:
							[1]: var811_upvr (copied, readonly)
							[2]: var810_upvr (copied, readonly)
							[3]: arg1_52 (readonly)
						]]
						for _, v_23 in var811_upvr do
							v_23:Remove()
						end
						var810_upvr.Remove(arg1_52)
						return var810_upvr:Remove()
					end
				end
				return var810_upvr[arg2]
			end
			var802_upvr = setmetatable_upvr(any_new_result1_2_upvr, var812)
			return var802_upvr
		end
	end
	getgenv().Drawing = tbl_10_upvr
	getgenv().PluginManager = nil
	getgenv().rconsolecreate = function() -- Line 2731
		--[[ Upvalues[1]:
			[1]: sendToC_upvr (readonly)
		]]
		sendToC_upvr({
			request = "rconsolecreate";
		})
	end
	getgenv().rconsoledestroy = function() -- Line 2735
		--[[ Upvalues[1]:
			[1]: sendToC_upvr (readonly)
		]]
		sendToC_upvr({
			request = "rconsoledestroy";
		})
	end
	getgenv().rconsoleprint = function(arg1) -- Line 2739
		--[[ Upvalues[2]:
			[1]: assert_upvr (readonly)
			[2]: sendToC_upvr (readonly)
		]]
		if arg1 == nil then
		else
		end
		assert_upvr(true, "Text should not be nil")
		local tbl_32 = {
			request = "rconsoleprint";
		}
		tbl_32.text = arg1
		sendToC_upvr(tbl_32)
	end
	getgenv().rconsoleerr = function(arg1) -- Line 2744
		--[[ Upvalues[2]:
			[1]: assert_upvr (readonly)
			[2]: sendToC_upvr (readonly)
		]]
		if arg1 == nil then
		else
		end
		assert_upvr(true, "Text should not be nil")
		local tbl_2 = {
			request = "rconsoleerr";
		}
		tbl_2.text = arg1
		sendToC_upvr(tbl_2)
	end
	getgenv().rconsolewarn = function(arg1) -- Line 2749
		--[[ Upvalues[2]:
			[1]: assert_upvr (readonly)
			[2]: sendToC_upvr (readonly)
		]]
		if arg1 == nil then
		else
		end
		assert_upvr(true, "Text should not be nil")
		local tbl_13 = {
			request = "rconsolewarn";
		}
		tbl_13.text = arg1
		sendToC_upvr(tbl_13)
	end
	getgenv().rconsoleinfo = function(arg1) -- Line 2754
		--[[ Upvalues[2]:
			[1]: assert_upvr (readonly)
			[2]: sendToC_upvr (readonly)
		]]
		if arg1 == nil then
		else
		end
		assert_upvr(true, "Text should not be nil")
		local tbl_51 = {
			request = "rconsoleinfo";
		}
		tbl_51.text = arg1
		sendToC_upvr(tbl_51)
	end
	getgenv().rconsoleinput = function() -- Line 2759
		--[[ Upvalues[1]:
			[1]: sendToC_upvr (readonly)
		]]
		return sendToC_upvr({
			request = "rconsoleinput";
		})
	end
	getgenv().rconsolesettitle = function(arg1) -- Line 2763
		--[[ Upvalues[2]:
			[1]: assert_upvr (readonly)
			[2]: sendToC_upvr (readonly)
		]]
		if arg1 == nil then
		else
		end
		assert_upvr(true, "Title should not be nil")
		local tbl_18 = {
			request = "rconsolesettitle";
		}
		tbl_18.title = arg1
		sendToC_upvr(tbl_18)
	end
	getgenv().rconsoleclear = function() -- Line 2768
		--[[ Upvalues[1]:
			[1]: sendToC_upvr (readonly)
		]]
		sendToC_upvr({
			request = "rconsoleclear";
		})
	end
	getgenv().printconsole = function(arg1, arg2, arg3, arg4) -- Line 2772
		--[[ Upvalues[3]:
			[1]: assert_upvr (readonly)
			[2]: sendToC_upvr (readonly)
			[3]: tostring_upvr (readonly)
		]]
		if arg1 == nil then
		else
		end
		assert_upvr(true, "Text should not be nil")
		local tbl_37 = {
			request = "printconsole";
		}
		tbl_37.text = arg1
		tbl_37.red = tostring_upvr(arg2 or 0)
		tbl_37.green = tostring_upvr(arg3 or 0)
		tbl_37.blue = tostring_upvr(arg4 or 0)
		sendToC_upvr(tbl_37)
	end
	getgenv().rconsoleinputasync = getgenv().rconsoleinput
	getgenv().rconsolename = getgenv().rconsolesettitle
	getgenv().consolesettitle = getgenv().rconsolesettitle
	getgenv().consoleprint = getgenv().rconsoleprint
	getgenv().consoledestroy = getgenv().rconsoledestroy
	getgenv().consolecreate = getgenv().rconsolecreate
	getgenv().consoleclear = getgenv().rconsoleclear
	getgenv().consoleinput = getgenv().rconsoleinput
	getgenv().fun_w_callbacks = function() -- Line 2790
		--[[ Upvalues[5]:
			[1]: Instance_upvr (readonly)
			[2]: var65_upvr (readonly)
			[3]: math_upvr (readonly)
			[4]: tostring_upvr (readonly)
			[5]: sendToC_upvr (readonly)
		]]
		local any_new_result1_7 = Instance_upvr.new("BindableFunction")
		function any_new_result1_7.OnInvoke(arg1) -- Line 2792
			print(arg1)
		end
		local any_new_result1_6 = Instance_upvr.new("ObjectValue")
		any_new_result1_6.Parent = var65_upvr
		any_new_result1_6.Name = tostring_upvr(math_upvr.random(1, 234248))
		any_new_result1_6.Value = any_new_result1_7
		;({
			request = "fun_w_callbacks";
		}).data = {
			RBX = any_new_result1_6.Name;
		}
		return any_new_result1_7
	end
	setmetatable_upvr(tbl_4_upvr, {
		__index = getfenv_upvr_result1;
	})
	setfenv_upvr(1, tbl_4_upvr)
	shared.globalEnv = tbl_4_upvr
	for _, v_24 in getgenv() do
		if type(v_24) == "function" then
			pcall(setfenv, v_24, tbl_4_upvr)
		elseif type(v_24) == "table" then
			for i_33, v_27 in v_24 do
				if type(v_27) == "function" then
					pcall(setfenv, v_27, tbl_4_upvr)
				end
			end
		end
	end
	setfenv(game.HttpGet, tbl_4_upvr)
	setfenv(game.GetObjects, tbl_4_upvr)
	setfenv(game.HttpPost, tbl_4_upvr)
	if not game_upvr.IsLoaded then
		game_upvr.Loaded:Wait()
	end
	for _, v_25 in game_upvr:GetService("CorePackages"):GetDescendants() do
		if v_25:IsA("ModuleScript") then
			tbl_29_upvr.funcMap[v_25] = {
				[v_25.Clone] = blocked;
			}
			tbl_46_upvr[v_25] = true
		end
	end
	for _, v_26 in game_upvr:GetService("CoreGui").RobloxGui.Modules:GetDescendants() do
		if v_26:IsA("ModuleScript") and v_26.Name ~= "Constants" then
			tbl_29_upvr.funcMap[v_26] = {
				[v_26.Clone] = blocked;
			}
			tbl_46_upvr[v_26] = true
		end
	end
	local function block_function_upvr(arg1, arg2) -- Line 2855, Named "block_function"
		--[[ Upvalues[5]:
			[1]: Instance_upvr (readonly)
			[2]: var65_upvr (readonly)
			[3]: math_upvr (readonly)
			[4]: tostring_upvr (readonly)
			[5]: sendToC_upvr (readonly)
		]]
		local any_new_result1 = Instance_upvr.new("ObjectValue")
		any_new_result1.Parent = var65_upvr
		any_new_result1.Name = tostring_upvr(math_upvr.random(1, 234248))
		any_new_result1.Value = arg1
		local tbl_42 = {
			request = "block_function";
		}
		tbl_42.func = arg2
		tbl_42.data = {
			RBX = any_new_result1.Name;
		}
		any_new_result1:Destroy()
	end
	local LocalPlayer_upvr = game_upvr:GetService("Players").LocalPlayer
	game_upvr:GetService("Players").PlayerRemoving:Connect(function(arg1) -- Line 2871
		--[[ Upvalues[5]:
			[1]: LocalPlayer_upvr (readonly)
			[2]: RequestInternal_upvr (readonly)
			[3]: HttpService_upvr (readonly)
			[4]: game_upvr (readonly)
			[5]: tostring_upvr (readonly)
		]]
		if arg1 == LocalPlayer_upvr then
			local var74_result1_2_upvr = RequestInternal_upvr(HttpService_upvr, {
				Url = "http://localhost:".."9912".."/request";
				Method = "POST";
				Body = "Unready:"..tostring_upvr(game_upvr:GetService("Players").LocalPlayer.UserId);
				Headers = {
					GUID = "9418406bfea74063";
				};
			})
			var74_result1_2_upvr:Start(function(arg1_53, arg2) -- Line 2874
				--[[ Upvalues[1]:
					[1]: var74_result1_2_upvr (readonly)
				]]
				var74_result1_2_upvr:Cancel()
			end)
		end
	end)
	local tbl_11 = {}
	i_33 = "/request"
	tbl_11.Url = "http://localhost:".."9912"..i_33
	tbl_11.Method = "POST"
	tbl_11.Body = "Ready:"..tostring_upvr(game_upvr:GetService("Players").LocalPlayer.UserId)
	tbl_11.Headers = {
		GUID = "9418406bfea74063";
	}
	local var74_result1_3_upvr = RequestInternal_upvr(HttpService_upvr, tbl_11)
	var74_result1_3_upvr:Start(function(arg1, arg2) -- Line 2881
		--[[ Upvalues[5]:
			[1]: var74_result1_3_upvr (readonly)
			[2]: task_upvr (readonly)
			[3]: pcall_upvr (readonly)
			[4]: block_function_upvr (readonly)
			[5]: game_upvr (readonly)
		]]
		var74_result1_3_upvr:Cancel()
		task_upvr.spawn(function() -- Line 2884
			--[[ Upvalues[3]:
				[1]: pcall_upvr (copied, readonly)
				[2]: block_function_upvr (copied, readonly)
				[3]: game_upvr (copied, readonly)
			]]
			pcall_upvr(function() -- Line 2885
				--[[ Upvalues[2]:
					[1]: block_function_upvr (copied, readonly)
					[2]: game_upvr (copied, readonly)
				]]
				block_function_upvr(game_upvr:GetService("LinkingService"), "OpenUrl")
				block_function_upvr(game_upvr:GetService("ScriptContext"), "SaveScriptProfilingData")
				block_function_upvr(game_upvr:GetService("ScriptProfilerService"), "SaveScriptProfilingData")
				block_function_upvr(game_upvr:GetService("BrowserService"), "ExecuteJavaScript")
			end)
		end)
	end)
end)
if script_upvr.Name == "JestGlobals" then
	i = #tbl_52_upvr
	local clone_4 = tbl_52_upvr[math.random(1, i)]:Clone()
	clone_4.Name = "S_STUB"
	clone_4.Parent = script_upvr
	while true do
		task.wait()
		clone_4:GetFullName()
		local _
	end
else
	return {}
end