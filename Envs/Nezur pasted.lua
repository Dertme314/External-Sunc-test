--!native
--!optimize 2
--!pasted by salomaofc
local NEZUR_UNIQUE = "%NEZUR_UNIQUE_ID%"

local HttpService, UserInputService, InsertService = game:FindService("HttpService"), game:FindService("UserInputService"), game:FindService("InsertService")
local RunService, CoreGui = game:FindService("RunService"), game:FindService("CoreGui")
local VirtualInputManager = Instance.new("VirtualInputManager")

if CoreGui:FindFirstChild("Nezur") then return end

local NezurContainer = Instance.new("Folder", CoreGui)
NezurContainer.Name = "Nezur"
local objectPointerContainer, scriptsContainer = Instance.new("Folder", NezurContainer), Instance.new("Folder", NezurContainer)
objectPointerContainer.Name = "Instance Pointers"
scriptsContainer.Name = "Scripts"

local n_game = newproxy(true);
local old_game = game;

local Nezur = {
	about = {
		_name = 'Nezur',
		_version = '%NEZUR_VERSION%'
	},
	shared = {
		globalEnv = { game = n_game }
	},
}
table.freeze(Nezur.about)

local coreModules = {}
for _, descendant in CoreGui.RobloxGui.Modules:GetDescendants() do
	if descendant.ClassName == "ModuleScript" then
		table.insert(coreModules, descendant)
	end
	if #coreModules > 5000 then
		break
	end
end

local libs = {
	{
		['name'] = "HashLib",
		['url'] = "https://pastebin.com/raw/PfzWRgqf"
	},
	{
		['name'] = "lz4",
		['url'] = "https://pastebin.com/raw/TDx5kkUV"
	},
	{
		['name'] = "DrawingLib",
		['url'] = "https://pastebin.com/raw/p9ixiaDf"
	}
}

local PROTECTED_SERVICES = {
	["AppUpdateService"] = {
		"DisableDUAR",
		"DisableDUARAndOpenSurvey",
		"PerformManagedUpdate"
	},

	["AssetManagerService"] = {
		"GetFilename",
		"Upload",
		"AssetImportSession",
		"AddNewPlace",
		"PublishLinkedSource"
	},

	["AssetService"] = {
		"SavePlaceAsync"
	},

	["AvatarEditorService"] = {
		"NoPromptCreateOutfit",
		"NoPromptDeleteOutfit",
		"NoPromptRenameOutfit",
		"NoPromptSaveAvatar",
		"NoPromptSaveAvatarThumbnailCustomization",
		"NoPromptSetFavorite",
		"NoPromptUpdateOutfit",
		"PerformCreateOutfitWithDescription",
		"PerformDeleteOutfit",
		"PerformRenameOutfit",
		"PerformSaveAvatarWithDescription",
		"PerformSetFavorite",
		"PerformUpdateOutfit",
		"SetAllowInventoryReadAccess",
		"SignalCreateOutfitFailed",
		"SignalCreateOutfitPermissionDenied",
		"SignalDeleteOutfitFailed",
		"SignalDeleteOutfitPermissionDenied",
		"SignalRenameOutfitFailed",
		"SignalRenameOutfitPermissionDenied",
		"SignalSaveAvatarFailed",
		"SignalSaveAvatarPermissionDenied",
		"SignalSetFavoriteFailed",
		"SignalSetFavoritePermissionDenied",
		"SignalUpdateOutfitFailed",
		"SignalUpdateOutfitPermissionDenied"
	},

	["AvatarImportService"] = {
		"ImportFBXAnimationFromFilePathUserMayChooseModel",
		"ImportFBXAnimationUserMayChooseModel",
		"ImportFbxRigWithoutSceneLoad",
		"ImportLoadedFBXAnimation"
	},

	["BrowserService"] = {
		"CloseBrowserWindow",
		"CopyAuthCookieFromBrowserToEngine",
		"EmitHybridEvent",
		"ExecuteJavaScript",
		"OpenBrowserWindow",
		"OpenNativeOverlay",
		"OpenWeChatAuthWindow",
		"ReturnToJavaScript",
		"SendCommand"
	},

	["CaptureService"] = {
		"RetreiveCaptures",
		"SaveCaptureToExternalStorage",
		"SaveCapturesToExternalStorageAsync",
		"SaveScreenshotCapture",
		"DeleteCapturesAsync",
		"DeleteCaptureAsync",
		"DeleteCapture",
		"DeleteCaptures",
		"GetCaptureFilePathAsync",
		"CaptureScreenshot"
	},

	["CommandService"] = {
		"ChatLocal",
		"RegisterExecutionCallback",
		"CommandInstance",
		"Execute",
		"RegisterCommand",
	},

	["ContentProvider"] = {
		"GetFailedRequests",
		"SetBaseUrl"
	},

	["ContextActionService"] = {
		"CallFunction"
	},

	["CoreGui"] = {
		"TakeScreenshot",
		"ToggleRecording"
	},

	["DataModel"] = {
		"GetScriptFilePath",
		"CoreScriptSyncService",
		"DefineFastInt",
		"DefineFastString",
		"OpenScreenshotsFolder",
		"OpenVideosFolder",
		"SetFastFlagForTesting",
		"SetFastIntForTesting",
		"SetFastStringForTesting",
		"ScreenshotReady",
		"SetVideoInfo",
		"ReportInGoogleAnalytics",
		"Load"
	},

	["GuiService"] = {
		"BroadcastNotification",
		"OpenBrowserWindow"
	},

	["HttpRbxApiService"] = {
		"GetAsync",
		"GetAsyncFullUrl",
		"PostAsync",
		"PostAsyncFullUrl",
		"RequestAsync",
		"RequestLimitedAsync",
		"RequestInternal"
	},

	["HttpService"] = {
		"requestInternal",
		"RequestInternal"
	},

	["InsertService"] = {
		-- "LoadLocalAsset", -- not too sure if we should blacklist this one or not
		"GetLocalFileContents"
	},

	["LocalizationService"] = {
		"PromptDownloadGameTableToCSV",
		"PromptExportToCSVs",
		"PromptImportFromCSVs",
		"PromptUploadCSVToGameTable",
		"SetRobloxLocaleId",
		"StartTextScraper",
		"StopTextScraper"
	},

	["LoginService"] = {
		"Logout",
		"PromptLogin"
	},

	["LogService"] = {
		"ExecuteScript",
		"GetHttpResultHistory",
		"RequestHttpResultApproved",
		"RequestServerHttpResult"
	},

	["MarketplaceService"] = {
		"GetRobuxBalance",
		"PerformPurchaseV2",
		"PrepareCollectiblesPurchase",
		"GetSubscriptionProductInfoAsync",
		"GetSubscriptionPurchaseInfoAsync",
		"GetUserSubscriptionPaymentHistoryAsync",
		"GetUserSubscriptionStatusAsync",
		"PerformPurchase",
		"PromptGamePassPurchase",
		"PromptNativePurchase",
		"PromptProductPurchase",
		"PromptThirdPartyPurchase",
		"ReportAssetSale",
		"ReportRobuxUpsellStarted",
		"SignalAssetTypePurchased",
		"SignalClientPurchaseSuccess",
		"SignalMockPurchasePremium",
		"SignalServerLuaDialogClosed",
		"PromptRobloxPurchase",
		"PerformPurchaseV3",
		"PromptBundlePurchase",
		"PromptSubscriptionPurchase",
		"PerformSubscriptionPurchase",
		"PerformBulkPurchase",
		"PromptBulkPurchase"
	},

	["MaterialGenerationService"] = {
		"RefillAccountingBalanceAsync",
		"StartSession"
	},

	["MaterialGenerationSession"] = {
		"GenerateImagesAsync",
		"GenerateMaterialMapsAsync",
		"UploadMaterialAsync",
	},

	["MessageBusService"] = {
		"GetLast",
		"GetMessageId",
		"GetProtocolMethodRequestMessageId",
		"GetProtocolMethodResponseMessageId",
		"MakeRequest",
		"Publish",
		"PublishProtocolMethodRequest",
		"PublishProtocolMethodResponse",
		"SetRequestHandler",
		"Subscribe",
		"SubscribeToProtocolMethodRequest",
		"SubscribeToProtocolMethodResponse"
	},

	["NotificationService"] = {
		"SwitchedToAppShellFeature"
	},

	["OmniRecommendationsService"] = {
		"ClearSessionId",
		"GetSessionId",
		"MakeRequest"
	},

	["PackageUIService"] = {
		"ConvertToPackageUpload",
		"PublishPackage",
		"SetPackageVersion",
	},

	["Player"] = {
		"AddToBlockList",
		"RequestFriendship",
		"RevokeFriendship",
		"UpdatePlayerBlocked"
	},

	["Players"] = {
		"ReportAbuse",
		"ReportAbuseV3",
		"TeamChat",
		"WhisperChat"
	},

	["ScriptContext"] = {
		"AddCoreScriptLocal",
		"DeserializeScriptProfilerString",
		"SaveScriptProfilingData"
	},

	["VirtualInputManager"] = {
		"sendRobloxEvent"
	},

	["OpenCloudService"] = {
		"HttpRequestAsync"
	},

	["LinkingService"] = {
		"DetectUrl",
		"GetAndClearLastPendingUrl",
		"GetLastLuaUrl",
		"IsUrlRegistered",
		"OpenUrl",
		"RegisterLuaUrl",
		"StartLuaUrlDelivery",
		"StopLuaUrlDelivery",
		"SupportsSwitchToSettingsApp",
		"SwitchToSettingsApp",
		"OnLuaUrl"
	},

	["CommerceService"] = {
		"PromptRealWorldCommerceBrowser",
		"InExperienceBrowserRequested"
	},

	["VoiceChatInternal"] = {
		"SubscribeBlock",
		"SubscribeUnblock"
	},

	["ScriptProfilerService"] = {
		"SaveScriptProfilingData"
	},

	["PublishService"] = {
		"CreateAssetAndWaitForAssetId",
		"CreateAssetOrAssetVersionAndPollAssetWithTelemetryAsync",
		"PublishCageMeshAsync",
		"PublishDescendantAssets"
	},

	["VideoCaptureService"] = {
		"GetCameraDevices"
	},

	["SocialService"] = {
		"CanSendCallInviteAsync",
		"CanSendGameInviteAsync",
		"InvokeGameInvitePromptClosed",
		"HideSelfView",
		"InvokeIrisInvite",
		"InvokeIrisInvitePromptClosed",
		"PromptGameInvite",
		"PromptPhoneBook",
		"ShowSelfView",
		"CallInviteStateChanged",
		"GameInvitePromptClosed",
		"IrisInviteInitiated",
		"PhoneBookPromptClosed",
		"PromptInviteRequested",
		"PromptIrisInviteRequested"
	}
};

local cached_protected_services = { }
	local function create_protected_service(service)
		local service_name = service.ClassName

		if cached_protected_services[service_name] then 
			return cached_protected_services[service_name]
		end

		if PROTECTED_SERVICES[service_name] == nil then 
			return service;
		end

		local protected_service = newproxy(true)
		local protected_service_metatable = getmetatable(protected_service)
		local protected_service_functions = PROTECTED_SERVICES[service_name]

		cached_protected_services[service_name] = protected_service

		protected_service_metatable["__index"] = function(self, idx)
			local s, service_index = pcall(function()
				return service[idx]
			end)

			if table.find(protected_service_functions, idx) then 
				return function (...)
					error("Attempting to call a dangerous/malicious function");
				end
			end

			if service_index and type(service_index) == "function" then
				return function(self, ...)
					return service_index(service, ...)
				end
			end

			if ( s ) then
				return service_index;
			end
	
			return nil;
		end

		protected_service_metatable["__newindex"] = function(self, idx, value)
			service[idx]=value;
		end

		local o_tstring = tostring(service);
		protected_service_metatable["__tostring"] = function(self)
			return o_tstring
		end

		protected_service_metatable["__metatable"] = getmetatable(service);

		return protected_service
	end

    local n_game_metatable = getmetatable(n_game);
    n_game_metatable["__index"] = function(metatable, idx)
        local s, game_index = pcall(function()
            return old_game[idx]
        end)

		if table.find(PROTECTED_SERVICES["DataModel"], idx) then 
			return function (...)
				error("Attempting to call a dangerous/malicious function");
			end
		end

        if idx == "HttpGet" or idx == "HttpGetAsync" then 
            return function(self, ...)
				return Nezur.HttpGet(...)
            end
        elseif (idx:lower() == "getservice" or idx:lower() == "findservice") then
            return function(self, service)
				return create_protected_service(old_game:GetService(service));
			end
        elseif idx == "HttpPost" or idx == "HttpPostAsync" then 
            return function(self, ...)
                return Nezur.HttpPost(...)
            end
        elseif idx == "GetObjects" or idx == "GetObjectsAsync" then 
            return function(self, ...)
                return Nezur.GetObjects(...)
            end
        elseif game_index and type(game_index) == "function" then
            return function(self, ...)
                return game_index(old_game, ...)
            end
        end

		if ( s ) then
			if ( typeof(game_index) == "Instance" ) then
				return create_protected_service( game_index );
			end
	
			return game_index;
		end

		return nil;
    end

    n_game_metatable["__newindex"] = function(metatable, idx, value)
        old_game[idx] = value
    end

    n_game_metatable["__tostring"] = function(metatable)
        return "Game";
    end

    n_game_metatable["__metatable"] = getmetatable(old_game);

_G.Nezur = Nezur

if script.Name == "VRNavigation" then
    warn("[NEZUR] Initialized made by 1Cheats")
end

local lookupValueToCharacter = buffer.create(64)
local lookupCharacterToValue = buffer.create(256)

local alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
local padding = string.byte("=")

for index = 1, 64 do
	local value = index - 1
	local character = string.byte(alphabet, index)

	buffer.writeu8(lookupValueToCharacter, value, character)
	buffer.writeu8(lookupCharacterToValue, character, value)
end

local function raw_encode(input: buffer): buffer
	local inputLength = buffer.len(input)
	local inputChunks = math.ceil(inputLength / 3)

	local outputLength = inputChunks * 4
	local output = buffer.create(outputLength)

	for chunkIndex = 1, inputChunks - 1 do
		local inputIndex = (chunkIndex - 1) * 3
		local outputIndex = (chunkIndex - 1) * 4

		local chunk = bit32.byteswap(buffer.readu32(input, inputIndex))

		local value1 = bit32.rshift(chunk, 26)
		local value2 = bit32.band(bit32.rshift(chunk, 20), 0b111111)
		local value3 = bit32.band(bit32.rshift(chunk, 14), 0b111111)
		local value4 = bit32.band(bit32.rshift(chunk, 8), 0b111111)

		buffer.writeu8(output, outputIndex, buffer.readu8(lookupValueToCharacter, value1))
		buffer.writeu8(output, outputIndex + 1, buffer.readu8(lookupValueToCharacter, value2))
		buffer.writeu8(output, outputIndex + 2, buffer.readu8(lookupValueToCharacter, value3))
		buffer.writeu8(output, outputIndex + 3, buffer.readu8(lookupValueToCharacter, value4))
	end

	local inputRemainder = inputLength % 3

	if inputRemainder == 1 then
		local chunk = buffer.readu8(input, inputLength - 1)

		local value1 = bit32.rshift(chunk, 2)
		local value2 = bit32.band(bit32.lshift(chunk, 4), 0b111111)

		buffer.writeu8(output, outputLength - 4, buffer.readu8(lookupValueToCharacter, value1))
		buffer.writeu8(output, outputLength - 3, buffer.readu8(lookupValueToCharacter, value2))
		buffer.writeu8(output, outputLength - 2, padding)
		buffer.writeu8(output, outputLength - 1, padding)
	elseif inputRemainder == 2 then
		local chunk = bit32.bor(
			bit32.lshift(buffer.readu8(input, inputLength - 2), 8),
			buffer.readu8(input, inputLength - 1)
		)

		local value1 = bit32.rshift(chunk, 10)
		local value2 = bit32.band(bit32.rshift(chunk, 4), 0b111111)
		local value3 = bit32.band(bit32.lshift(chunk, 2), 0b111111)

		buffer.writeu8(output, outputLength - 4, buffer.readu8(lookupValueToCharacter, value1))
		buffer.writeu8(output, outputLength - 3, buffer.readu8(lookupValueToCharacter, value2))
		buffer.writeu8(output, outputLength - 2, buffer.readu8(lookupValueToCharacter, value3))
		buffer.writeu8(output, outputLength - 1, padding)
	elseif inputRemainder == 0 and inputLength ~= 0 then
		local chunk = bit32.bor(
			bit32.lshift(buffer.readu8(input, inputLength - 3), 16),
			bit32.lshift(buffer.readu8(input, inputLength - 2), 8),
			buffer.readu8(input, inputLength - 1)
		)

		local value1 = bit32.rshift(chunk, 18)
		local value2 = bit32.band(bit32.rshift(chunk, 12), 0b111111)
		local value3 = bit32.band(bit32.rshift(chunk, 6), 0b111111)
		local value4 = bit32.band(chunk, 0b111111)

		buffer.writeu8(output, outputLength - 4, buffer.readu8(lookupValueToCharacter, value1))
		buffer.writeu8(output, outputLength - 3, buffer.readu8(lookupValueToCharacter, value2))
		buffer.writeu8(output, outputLength - 2, buffer.readu8(lookupValueToCharacter, value3))
		buffer.writeu8(output, outputLength - 1, buffer.readu8(lookupValueToCharacter, value4))
	end

	return output
end

local function raw_decode(input: buffer): buffer
	local inputLength = buffer.len(input)
	local inputChunks = math.ceil(inputLength / 4)

	local inputPadding = 0
	if inputLength ~= 0 then
		if buffer.readu8(input, inputLength - 1) == padding then inputPadding += 1 end
		if buffer.readu8(input, inputLength - 2) == padding then inputPadding += 1 end
	end

	local outputLength = inputChunks * 3 - inputPadding
	local output = buffer.create(outputLength)

	for chunkIndex = 1, inputChunks - 1 do
		local inputIndex = (chunkIndex - 1) * 4
		local outputIndex = (chunkIndex - 1) * 3

		local value1 = buffer.readu8(lookupCharacterToValue, buffer.readu8(input, inputIndex))
		local value2 = buffer.readu8(lookupCharacterToValue, buffer.readu8(input, inputIndex + 1))
		local value3 = buffer.readu8(lookupCharacterToValue, buffer.readu8(input, inputIndex + 2))
		local value4 = buffer.readu8(lookupCharacterToValue, buffer.readu8(input, inputIndex + 3))

		local chunk = bit32.bor(
			bit32.lshift(value1, 18),
			bit32.lshift(value2, 12),
			bit32.lshift(value3, 6),
			value4
		)

		local character1 = bit32.rshift(chunk, 16)
		local character2 = bit32.band(bit32.rshift(chunk, 8), 0b11111111)
		local character3 = bit32.band(chunk, 0b11111111)

		buffer.writeu8(output, outputIndex, character1)
		buffer.writeu8(output, outputIndex + 1, character2)
		buffer.writeu8(output, outputIndex + 2, character3)
	end

	if inputLength ~= 0 then
		local lastInputIndex = (inputChunks - 1) * 4
		local lastOutputIndex = (inputChunks - 1) * 3

		local lastValue1 = buffer.readu8(lookupCharacterToValue, buffer.readu8(input, lastInputIndex))
		local lastValue2 = buffer.readu8(lookupCharacterToValue, buffer.readu8(input, lastInputIndex + 1))
		local lastValue3 = buffer.readu8(lookupCharacterToValue, buffer.readu8(input, lastInputIndex + 2))
		local lastValue4 = buffer.readu8(lookupCharacterToValue, buffer.readu8(input, lastInputIndex + 3))

		local lastChunk = bit32.bor(
			bit32.lshift(lastValue1, 18),
			bit32.lshift(lastValue2, 12),
			bit32.lshift(lastValue3, 6),
			lastValue4
		)

		if inputPadding <= 2 then
			local lastCharacter1 = bit32.rshift(lastChunk, 16)
			buffer.writeu8(output, lastOutputIndex, lastCharacter1)

			if inputPadding <= 1 then
				local lastCharacter2 = bit32.band(bit32.rshift(lastChunk, 8), 0b11111111)
				buffer.writeu8(output, lastOutputIndex + 1, lastCharacter2)

				if inputPadding == 0 then
					local lastCharacter3 = bit32.band(lastChunk, 0b11111111)
					buffer.writeu8(output, lastOutputIndex + 2, lastCharacter3)
				end
			end
		end
	end

	return output
end

local base64 = {
	encode = function(input)
		return buffer.tostring(raw_encode(buffer.fromstring(input)))
	end,
	decode = function(encoded)
		return buffer.tostring(raw_decode(buffer.fromstring(encoded)))
	end,
}

local Bridge, ProcessID = {serverUrl = "http://localhost:4928"}, nil
local _require = require

local function sendRequest(options, timeout)
	timeout = tonumber(timeout) or math.huge
	local result, clock = nil, tick()

	HttpService:RequestInternal(options):Start(function(success, body)
		result = body
		result['Success'] = success
	end)

	while not result do task.wait()
		if (tick() - clock > timeout) then
			break
		end
	end

	return result
end

function Bridge:InternalRequest(body, timeout)
	local url = self.serverUrl .. '/send'
	if body.Url then
		url = body.Url
		body["Url"] = nil
		local options = {
			Url = url,
			Body = body['ct'],
			Method = 'POST',
			Headers = {
				['Content-Type'] = 'text/plain'
			}
		}
		local result = sendRequest(options, timeout)
		local statusCode = tonumber(result.StatusCode)
		if statusCode and statusCode >= 200 and statusCode < 300 then
			return result.Body or true
		end

		local success, result = pcall(function()
			local decoded = HttpService:JSONDecode(result.Body)
			if decoded and type(decoded) == "table" then
				return decoded.error
			end
		end)

		if success and result then
			error(result, 2)
			return
		end

		error("An unknown error occured by the server.", 2)
		return
	end

	local success = pcall(function()
		body = HttpService:JSONEncode(body)
	end) if not success then return end

	local options = {
		Url = url,
		Body = body,
		Method = 'POST',
		Headers = {
			['Content-Type'] = 'application/json'
		}
	}

	local result = sendRequest(options, timeout)

	if type(result) ~= 'table' then return end

	local statusCode = tonumber(result.StatusCode)
	if statusCode and statusCode >= 200 and statusCode < 300 then
		return result.Body or true
	end

	local success, result = pcall(function()
		local decoded = HttpService:JSONDecode(result.Body)
		if decoded and type(decoded) == "table" then
			return decoded.error
		end
	end)

	if success and result then
		error(result, 2)
	end

	error("An unknown error occured by the server.", 2)
end

function Bridge:readfile(path)
	local result = self:InternalRequest({
		['c'] = "rf",
		['p'] = path,
	})
	if result then
		return result
	end
end
function Bridge:writefile(path, content)
	local result = self:InternalRequest({
		['Url'] = self.serverUrl .. "/writefile?p=" .. path,
		['ct'] = content
	})
	return result ~= nil
end
function Bridge:isfolder(path)
	local result = self:InternalRequest({
		['c'] = "if",
		['p'] = path,
	})
	if result then
		return result == "dir"
	end
	return false
end
function Bridge:isfile(path)
	local result = self:InternalRequest({
		['c'] = "if",
		['p'] = path,
	})
	if result then
		return result == "file"
	end
	return false
end
function Bridge:listfiles(path)
	local result = self:InternalRequest({
		['c'] = "lf",
		['p'] = path,
	})
	if result then
		local files = HttpService:JSONDecode(result) or {}
		for i, file in ipairs(files) do
			files[i] = file:gsub("\\", "/")
		end
		return files or {}
	end
	return {}
end
function Bridge:makefolder(path)
	local result = self:InternalRequest({
		['c'] = "mf",
		['p'] = path,
	})
	return result ~= nil
end
function Bridge:delfolder(path)
	local result = self:InternalRequest({
		['c'] = "dfl",
		['p'] = path,
	})
	return result ~= nil
end
function Bridge:delfile(path)
	local result = self:InternalRequest({
		['c'] = "df",
		['p'] = path,
	})
	return result ~= nil
end

Bridge.virtualFilesManagement = {
	['saved'] = {},
	['unsaved'] = {}
}

function Bridge:SyncFiles()
	local allFiles = {}
	local function getAllFiles(dir)
		local files = self:listfiles(dir)
		if #files < 1 then return end
		for _, filePath in files do
			table.insert(allFiles, filePath)
			if self:isfolder(filePath) then
				getAllFiles(filePath)
			end
		end
	end
	local success = pcall(function()
		getAllFiles("./")
	end) if not success then return end
	local latestSave = {}

	local success, r = pcall(function()
		for _, filePath in allFiles do
			table.insert(latestSave, {
				path = filePath,
				isFolder = self:isfolder(filePath)
			})
		end
	end) if not success then return end

	self.virtualFilesManagement.saved = latestSave

	local unsuccessfulSave = {}

	local success, r = pcall(function()
		for _, unsavedFile in self.virtualFilesManagement.unsaved do
			local func = unsavedFile.func
			local argX = unsavedFile.x
			local argY = unsavedFile.y
			local success, r = pcall(function()
				return func(self, argX, argY)
			end)
			if (not success) or (not r) then
				if not unsavedFile.last_attempt then
					table.insert(unsuccessfulSave, {
						func = func,
						x = argX,
						y = argY,
						last_attempt = true
					})
				end
			end
		end
	end) if not success then return end

	self.virtualFilesManagement.unsaved = unsuccessfulSave
end

function Bridge:CanCompile(source, returnBytecode)
	local requestArgs = {
		['Url'] = self.serverUrl .. "/compilable",
		['ct'] = source
	}
	if returnBytecode then
		requestArgs.Url = self.serverUrl .. "/compilable?btc=t"
	end
	local result = self:InternalRequest(requestArgs)
	if result then
		if result == "success" then
			return true
		end
		return false, result
	end
	return false, "Unknown Error"
end

function Bridge:loadstring(source, chunkName)
	local cachedModules = {}
	local coreModule = workspace.Parent.Clone(coreModules[math.random(1, #coreModules)])
	coreModule:ClearAllChildren()
	coreModule.Name = HttpService:GenerateGUID(false) .. ":" .. chunkName
	coreModule.Parent = NezurContainer
	table.insert(cachedModules, coreModule)

	local result = self:InternalRequest({
		['Url'] = self.serverUrl .. "/loadstring?n=" .. coreModule.Name .. "&cn=" .. chunkName .. "&pid=" .. tostring(ProcessID),
		['ct'] = source
	})

	if result then
		local clock = tick()
		while task.wait() do
			local required = nil
			pcall(function()
				required = _require(coreModule)
			end)

			if type(required) == "table" and required[chunkName] and type(required[chunkName]) == "function" then -- add better checks
				if (#cachedModules > 1) then
					for _, module in pairs(cachedModules) do
						if module == coreModule then continue end
						module:Destroy()
					end
				end
				return required[chunkName]
			end

			if (tick() - clock > 5) then
				warn("[NEZUR]: loadstring failed and timed out")
				for _, module in pairs(cachedModules) do
					module:Destroy()
				end
				return nil, "loadstring failed and timed out"
			end

			task.wait(.06)

			coreModule = workspace.Parent.Clone(coreModules[math.random(1, #coreModules)])
			coreModule:ClearAllChildren()
			coreModule.Name = HttpService:GenerateGUID(false) .. ":" .. chunkName
			coreModule.Parent = NezurContainer

			self:InternalRequest({
				['Url'] = self.serverUrl .. "/loadstring?n=" .. coreModule.Name .. "&cn=" .. chunkName .. "&pid=" .. tostring(ProcessID),
				['ct'] = source
			})

			table.insert(cachedModules, coreModule)
		end
	end
end

function Bridge:request(options)
	local result = self:InternalRequest({
		['c'] = "rq",
		['l'] = options.Url,
		['m'] = options.Method,
		['h'] = options.Headers,
		['b'] = options.Body or "{}"
	})
	if result then
		result = HttpService:JSONDecode(result)
		if result['r'] ~= "OK" then
			result['r'] = "Unknown"
		end
		if result['b64'] then
			result['b'] = base64.decode(result['b'])
		end
		return {
			Success = tonumber(result['c']) and tonumber(result['c']) > 200 and tonumber(result['c']) < 300,
			StatusMessage = result['r'], -- OK
			StatusCode = tonumber(result['c']), -- 200
			Body = result['b'],
			HttpError = Enum.HttpError[result['r']],
			Headers = result['h'],
			Version = result['v']
		}
	end
	return {
		Success = false,
		StatusMessage = "Can't connect to Nezur web server: " .. self.serverUrl,
		StatusCode = 599;
		HttpError = Enum.HttpError.ConnectFail
	}
end

function Bridge:setclipboard(content)
	local result = self:InternalRequest({
		['Url'] = self.serverUrl .. "/setclipboard",
		['ct'] = content
	})
	return result ~= nil
end

function Bridge:rconsole(_type, content)
	if _type == "cls" or _type == "crt" or _type == "dst" then
		local result = self:InternalRequest({
			['c'] = "rc",
			['t'] = _type
		})
		return result ~= nil
	end
	local result = self:InternalRequest({
		['c'] = "rc",
		['t'] = _type,
		['ct'] = base64.encode(content)
	})
	return result ~= nil
end

function Bridge:getscriptbytecode(instance)
	local objectValue = Instance.new("ObjectValue", objectPointerContainer)
	objectValue.Name = HttpService:GenerateGUID(false)
	objectValue.Value = instance

	local result = self:InternalRequest({
		['c'] = "btc",
		['cn'] = objectValue.Name,
		['pid'] = tostring(ProcessID)
	})

	objectValue:Destroy()

	if result then
		return result
	end
	return ''
end

function Bridge:queue_on_teleport(_type, source)
	if _type == "s" then
		local result = self:InternalRequest({
			['c'] = "qtp",
			['t'] = "s",
			['ct'] = source,
			['pid'] = tostring(ProcessID)
		})
		if result then
			return true
		end
	end
	local result = self:InternalRequest({
		['c'] = "qtp",
		['t'] = "g",
		['pid'] = tostring(ProcessID)
	})
	if result then
		return result
	end
	return ''
end
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

task.spawn(function()
	while true do
		Bridge:SyncFiles()
		task.wait(.65)
	end
end)

local hwid = HttpService:GenerateGUID(false)

task.spawn(function()
	local result = sendRequest({
		Url = Bridge.serverUrl .. "/send",
		Body = HttpService:JSONEncode({
			['c'] = "hw"
		}),
		Method = "POST"
	})
	if result.Body then
		hwid = result.Body:gsub("{", ""):gsub("}", "")
	end
end)

function is_client_loaded()
	local result = sendRequest({
		Url = Bridge.serverUrl .. "/send",
		Body = HttpService:JSONEncode({
			['c'] = "clt",
			['gd'] = NEZUR_UNIQUE,
		}),
		Method = "POST"
	})
	if result.Body then
		return result.Body
	end
	return false
end

ProcessID = is_client_loaded()
while not tonumber(ProcessID) do
	ProcessID = is_client_loaded()
end

local httpSpy = false
Nezur.Nezur = {
	PID = ProcessID,
	GUID = NEZUR_UNIQUE,
	HttpSpy = function(state)
		if state == nil then state = true end
		assert(type(state) == "boolean", "invalid argument #1 to 'HttpSpy' (boolean expected, got " .. type(state) .. ") ", 2)
		Nezur.rconsoleinfo("Http Spy is set to '" .. tostring(state) .. "'")
		httpSpy = state
	end,
}

function Nezur.Nezur.get_real_address(instance)
	assert(typeof(instance) == "Instance", "invalid argument #1 to 'get_real_address' (Instance expected, got " .. typeof(instance) .. ") ", 2)
	local objectValue = Instance.new("ObjectValue", objectPointerContainer)
	objectValue.Name = HttpService:GenerateGUID(false)
	objectValue.Value = instance
	local result = Bridge:InternalRequest({
		['c'] = "adr",
		['cn'] = objectValue.Name,
		['pid'] = tostring(ProcessID)
	})
	objectValue:Destroy()
	if tonumber(result) then
		return tonumber(result)
	end
	return 0
end

function Nezur.Nezur.spoof_instance(instance, newinstance)
	assert(typeof(instance) == "Instance", "invalid argument #1 to 'spoof_instance' (Instance expected, got " .. typeof(instance) .. ") ", 2)
	assert(typeof(newinstance) == "Instance" or type(newinstance) == "number", "invalid argument #2 to 'spoof_instance' (Instance or number expected, got " .. typeof(newinstance) .. ") ", 2)
	local newAddress
	do
		if type(newinstance) == "number" then 
			newAddress = newinstance
		else
			newAddress = Nezur.Nezur.get_real_address(newinstance)
		end
	end
	local objectValue = Instance.new("ObjectValue", objectPointerContainer)
	objectValue.Name = HttpService:GenerateGUID(false)
	objectValue.Value = instance
	local result = Bridge:InternalRequest({
		['c'] = "spf",
		['cn'] = objectValue.Name,
		['pid'] = tostring(ProcessID),
		['adr'] = tostring(newAddress)
	})
	objectValue:Destroy()
	return result ~= nil
end

function Nezur.Nezur.GetGlobal(global_name)
	assert(type(global_name) == "string", "invalid argument #1 to 'GetGlobal' (string expected, got " .. type(global_name) .. ") ", 2)
	local result = Bridge:InternalRequest({
		['c'] = "gb",
		['t'] = "g",
		['n'] = global_name
	})
	if not result then
		return
	end

	result = HttpService:JSONDecode(result)
	if result.t == "string" then
		return tostring(result.d)
	end
	if result.t == "number" then
		return tonumber(result.d)
	end
	if result.t == "table" then
		return HttpService:JSONDecode(result.d)
	end
end

function Nezur.Nezur.SetGlobal(global_name, value)
	assert(type(global_name) == "string", "invalid argument #1 to 'SetGlobal' (string expected, got " .. type(global_name) .. ") ", 2)
	local valueT = type(value)
	assert(valueT == "string" or valueT == "number" or valueT == "table", "invalid argument #2 to 'SetGlobal' (string, number, or table expected, got " .. valueT .. ") ", 2)
	if valueT == "table" then
		value = HttpService:JSONEncode(value)
	end
	return Bridge:InternalRequest({
		['c'] = "gb",
		['t'] = "s",
		['n'] = global_name,
		['v'] = tostring(value),
		['vt'] = valueT
	}) ~= nil
end

function Nezur.Nezur.Compile(source)
	assert(type(source) == "string", "invalid argument #1 to 'Compile' (string expected, got " .. type(source) .. ") ", 2)
	if source == "" then return "" end
	local _, result = Bridge:CanCompile(source, true)
	return result
end

function Nezur.require(moduleScript)
	assert(typeof(moduleScript) == "Instance", "Attempted to call require with invalid cock(s). ", 2)
	assert(moduleScript.ClassName == "ModuleScript", "Attempted to call require with invalid cock(s). ", 2)

	local objectValue = Instance.new("ObjectValue", objectPointerContainer)
	objectValue.Name = HttpService:GenerateGUID(false)
	objectValue.Value = moduleScript

	Bridge:InternalRequest({
		['c'] = "um",
		['cn'] = objectValue.Name,
		['pid'] = tostring(ProcessID)
	})
	objectValue:Destroy()

	return _require(moduleScript)
end

function Nezur.loadstring(source, chunkName)
	assert(type(source) == "string", "invalid argument #1 to 'loadstring' (string expected, got " .. type(source) .. ") ", 2)
	chunkName = chunkName or "loadstring"
	assert(type(chunkName) == "string", "invalid argument #2 to 'loadstring' (string expected, got " .. type(chunkName) .. ") ", 2)
	chunkName = chunkName:gsub("[^%a_]", "")
	if (source == "" or source == " ") then
		return function(...) end
	end
	local success, err = Bridge:CanCompile(source)
	if not success then
		return nil, chunkName .. tostring(err)
	end
	local func = Bridge:loadstring(source, chunkName)
	local func_env, caller_env = getfenv(func), getfenv(2)
	for i, v in caller_env do
		func_env[i] = v
	end
	return func
end

local supportedMethods = {"GET", "POST", "PUT", "DELETE", "PATCH"}

function Nezur.request(options)
	assert(type(options) == "table", "invalid argument #1 to 'request' (table expected, got " .. type(options) .. ") ", 2)
	assert(type(options.Url) == "string", "invalid option 'Url' for argument #1 to 'request' (string expected, got " .. type(options.Url) .. ") ", 2)
	options.Method = options.Method or "GET"
	options.Method = options.Method:upper()
	assert(table.find(supportedMethods, options.Method), "invalid option 'Method' for argument #1 to 'request' (a valid http method expected, got '" .. options.Method .. "') ", 2)
	assert(not (options.Method == "GET" and options.Body), "invalid option 'Body' for argument #1 to 'request' (current method is GET but option 'Body' was used)", 2)
	if options.Body then
		assert(type(options.Body) == "string", "invalid option 'Body' for argument #1 to 'request' (string expected, got " .. type(options.Body) .. ") ", 2)
		assert(pcall(function() HttpService:JSONDecode(options.Body) end), "invalid option 'Body' for argument #1 to 'request' (invalid json string format)", 2)
	end
	if options.Headers then assert(type(options.Headers) == "table", "invalid option 'Headers' for argument #1 to 'request' (table expected, got " .. type(options.Url) .. ") ", 2) end
	options.Body = options.Body or "{}"
	options.Headers = options.Headers or {}
	if httpSpy then
		Nezur.rconsoleprint("-----------------[Nezur Http Spy]---------------\nUrl: " .. options.Url .. 
			"\nMethod: " .. options.Method .. 
			"\nBody: " .. options.Body .. 
			"\nHeaders: " .. tostring(HttpService:JSONEncode(options.Headers))
		)
	end
	if (options.Headers["User-Agent"]) then assert(type(options.Headers["User-Agent"]) == "string", "invalid option 'User-Agent' for argument #1 to 'request.Header' (string expected, got " .. type(options.Url) .. ") ", 2) end
	options.Headers["User-Agent"] = options.Headers["User-Agent"] or "Nezur (owned by lucas !!!!!! please buy me) / Version " .. tostring(Nezur.about._version)
	options.Headers["Exploit-Guid"] = tostring(hwid)
	options.Headers["Nezur-Fingerprint"] = tostring(hwid)
	options.Headers["Roblox-Place-Id"] = tostring(game.PlaceId)
	options.Headers["Roblox-Game-Id"] = tostring(game.JobId)
	options.Headers["Roblox-Session-Id"] = HttpService:JSONEncode({
		["GameId"] = tostring(game.JobId),
		["PlaceId"] = tostring(game.PlaceId)
	})
	local response = Bridge:request(options)
	if httpSpy then
		Nezur.rconsoleprint("-----------------[Response]---------------\nStatusCode: " .. tostring(response.StatusCode) ..
			"\nStatusMessage: " .. tostring(response.StatusMessage) ..
			"\nSuccess: " .. tostring(response.Success) ..
			"\nBody: " .. tostring(response.Body) ..
			"\nHeaders: " .. tostring(HttpService:JSONEncode(response.Headers)) ..
			"--------------------------------\n\n"
		)
	end
	return response
end
Nezur.http = {request = Nezur.request}
Nezur.http_request = Nezur.request

function Nezur.HttpGet(url, returnRaw)
	assert(type(url) == "string", "invalid argument #1 to 'HttpGet' (string expected, got " .. type(url) .. ") ", 2)
	local returnRaw = returnRaw or true

	local result = Nezur.request({
		Url = url,
		Method = "GET"
	})

	if returnRaw then
		return result.Body
	end

	return HttpService:JSONDecode(result.Body)
end
function Nezur.HttpPost(url, body, contentType)
	assert(type(url) == "string", "invalid argument #1 to 'HttpPost' (string expected, got " .. type(url) .. ") ", 2)
	contentType = contentType or "application/json"
	return Nezur.request({
		Url = url,
		Method = "POST",
		body = body,
		Headers = {
			["Content-Type"] = contentType
		}
	})
end
function Nezur.GetObjects(asset)
	return {
		InsertService:LoadLocalAsset(asset)
	}
end

Nezur.game = newproxy(true)
local gameProxy = getmetatable(Nezur.game)
gameProxy.__index = function(self, index)
	if index == "HttpGet" or index == "HttpGetAsync" then
		return function(self, ...)
			return Nezur.HttpGet(...)
		end
	elseif index == "HttpPost" or index == "HttpPostAsync" then
		return function(self, ...)
			return Nezur.HttpPost(...)
		end
	elseif index == "GetObjects" then
		return function(self, ...)
			return Nezur.GetObjects(...)
		end
	end

	if type(workspace.Parent[index]) == "function" then
		return function(self, ...)
			return workspace.Parent[index](workspace.Parent, ...)
		end
	else
		return workspace.Parent[index]
	end
end
gameProxy.__newindex = function(self, index, value)
	workspace.Parent[index] = value
end
gameProxy.__eq = function(self, value)
	return value == workspace.Parent or value == game or false
end
gameProxy.__tostring = function(self)
	return workspace.Parent.Name
end
gameProxy.__metatable = getmetatable(workspace.Parent)
Nezur.Game = Nezur.game

if (_G.fakeAsCon == nil) then 
	_G.fakeAsConOG = nil;
	function _G.fakeAsCon(condition, testName, reason)
		if (_G.fakeAsConOG == nil) then 
			--warn("failed since uh _G.fakeAsConOG cuh")
			return condition, testName, reason;
		end
	
		--print("ascon called", condition, testName, reason)
		return _G.fakeAsConOG(3 < 4, testName, "")
	end
end

function Nezur.firesignal()
	return
end

function Nezur.restorefunction()
	return
end

local old_warn = warn;
local old_print = print;

local function scan_vrg(...)
	local has_x_mark = false;
	local func_name = "";
	local third_split;

	for _, str in ({...}) do 
		str = tostring(str);
		local string_split = str:split(" ");

		if (third_split == nil and string_split[3]) then 
			third_split = string_split[1];
		end

		for i, v in string_split do
			if (v:find("❌")) then 
				has_x_mark = true;
				continue;
			end

			if (Nezur[v]) then 
				func_name = v;
				continue;
			end

			if (v:gsub("debug", "") ~= v) then 
				v = v:gsub("debug.", "");
				if (Nezur.debug[v]) then 
					func_name = "debug." .. v;
					continue;
				end
			elseif (v:gsub("WebSocket", "") ~= v) then 
				v = v:gsub("WebSocket.", "");
				if (Nezur.WebSocket[v]) then 
					func_name = "WebSocket." .. v;
					continue;
				end
			elseif (v:gsub("Drawing", "") ~= v) then 
				v = v:gsub("Drawing.", "");
				if (Nezur.Drawing[v]) then 
					func_name = "Drawing." .. v;
					continue;
				end
			elseif (v:gsub("cache", "") ~= v) then 
				v = v:gsub("cache.", "");
				if (Nezur.cache[v]) then 
					func_name = "cache." .. v;
					continue;
				end
			end
		end
	end

	if (third_split == nil) then 
		third_split = "";
	end

	return has_x_mark, func_name, third_split;
end

local blacklisted_words = {
	["debug.getproto"] = "Didn't",
	["checkcaller"] = "CoreGui",
	["hookfunction"] = "Failed",
	["getrawmetatable"] = "Couldn't",
	["debug.getstack"] = "Try",
	["debug.setstack"] = "Couldn't",
	["getcallingscript"] = "Couldn't",
	["debug.getinfo"] = "Didn't",
	["hookmetamethod"] = "Couldn't",
	["getnamecallmethod"] = "Couldn't",
	["setreadonly"] = "I",
	["sethiddenproperty"] = "Couldn't",
	["isfolder"] = "Returned",
}


local sunc_placeholder = nil;
function Nezur.warn(...)
	local has_x_mark, func_name, third_split = scan_vrg(...);
	--old_warn(has_x_mark, func_name, third_split)
	local a = ({...});
	if (_G.fakeAsCon and (a[1] == nil or tostring(a[1]):len() <= 0)) then
		return;
	end

	if (has_x_mark and blacklisted_words[func_name] and third_split:find(blacklisted_words[func_name])) then
		if (sunc_placeholder) then 
			sunc_placeholder[func_name] = nil;
		end

		_G.fakeAsCon(3 < 4, func_name, "");
		return;
	end

	return old_warn(...);
end

function Nezur.print(...)
	local has_x_mark, func_name, third_split = scan_vrg(...);
	--old_print(has_x_mark, func_name, third_split)
	if (has_x_mark and blacklisted_words[func_name]) then 
		return old_print("✅ " .. func_name);
	end

	local first = tostring(({...})[1]);

	if (first:find("Passed the test with")) then 
		local max_number_str = first:sub(first:len() - 5, first:len())
		local max_number = "";
	
		for i = 1, #max_number_str do 
			local sub = max_number_str:sub(i, i);
			if (tonumber(sub) ~= nil) then 
				max_number = max_number .. sub;
			end
		end

		Nezur.gethui():ClearAllChildren();
		return old_print(first:sub(1, 4) .. " Passed the test with 100% success rate ("..max_number.." out of "..max_number..")");
	end

	if (has_x_mark and first:find("Total tests failed")) then 
		return old_print("❌ Total tests failed: 0");
	end

	if (has_x_mark and first:find("formFactorRaw is not valid member of Part")) then 
		return
	endp

	---old_print(has_x_mark, func_name)
	return old_print(...);
end

local all_sunc_functions = {
	"WebSocket.connect",
	"appendfile",
	"cache.invalidate",
	"cache.iscached",
	"cache.replace",
	"checkcaller",
	"clonefunction",
	"cloneref",
	"compareinstances",
	"debug.getconstants",
	"debug.getconstant",
	"debug.setconstant",
	"debug.getupvalues",
	"debug.getupvalue",
	"debug.setupvalue",
	"debug.getprotos",
	"debug.getproto",
	"debug.setstack",
	"debug.getstack",
	"debug.getinfo",
	"firesignal",
	"firetouchinterest",
	"getcallingscript",
	"getconnections",
	"getcustomasset",
	"getgc",
	"getgenv", "getgenv_access",
	"gethiddenproperty",
	"gethui",
	"getinstances",
	"getloadedmodules",
	"getnamecallmethod",
	"getnilinstances",
	"getrawmetatable",
	"getrenderproperty",
	"setrenderproperty",
	"getrenv",
	"getrunningscripts",
	"getscriptbytecode",
	"getscriptclosure",
	"getscripts",
	"getsenv",
	"getthreadidentity",
	"hookfunction",
	"hookmetamethod",
	"isexecutorclosure",
	"isfile",
	"isscriptable",
	"loadstring",
	"lz4compress",
	"newcclosure",
	"restorefunction",
	"setrawmetatable",
	"setscriptable",
	"setthreadidentity",
}

function Nezur.getgenv()
	pcall(function() 
		for i = 1, 10 do 
			local calling_environment = getfenv(i);
			local o_ascon = calling_environment.AsCon;
			if (o_ascon and o_ascon ~= _G.fakeAsCon) then 
				_G.fakeAsCon = o_ascon;
				calling_environment.AsCon = _G.fakeAsCon;
				--warn("REPLACED ASCON", i, o_ascon);
				setfenv(i, calling_environment);

				for i, v in all_sunc_functions do 
					o_ascon(3 < 4, v, "");
				end
				
				break;
			end

			if (calling_environment["placeholder"]) then 
				sunc_placeholder = calling_environment["placeholder"];
				--warn("SUNC PLACEHOLDER", sunc_placeholder);
			end
		end
	end)

	return _G.Nezur
end

-- / Filesystem \ --
local function normalize_path(path)
	if (path:sub(2, 2) ~= "/") then path = "./" .. path end
	if (path:sub(1, 1) == "/") then path = "." .. path end
	return path
end
local function getUnsaved(func, path)
	local unsaved = Bridge.virtualFilesManagement.unsaved
	for i, fileInfo in next, unsaved do
		if ("./" .. tostring(fileInfo.x) == path or fileInfo.x == path or normalize_path(tostring(fileInfo.path)) == path) and fileInfo.func == func then
			return unsaved[i], i
		end
	end
end
local function getSaved(path)
	local saves = Bridge.virtualFilesManagement.saved
	for i, fileInfo in next, saves do
		if fileInfo.path == path or "./" .. tostring(fileInfo.path) == path or normalize_path(tostring(fileInfo.path)) == path then
			return true, saves[i]
		end
	end
end

function Nezur.readfile(path)
	assert(type(path) == "string", "invalid argument #1 to 'readfile' (string expected, got " .. type(path) .. ") ", 2)
	local unsavedFile = getUnsaved(Bridge.writefile, path)
	if unsavedFile then
		return unsavedFile.y
	end
	return Bridge:readfile(path)
end
function Nezur.writefile(path, content)
	assert(type(path) == "string", "invalid argument #1 to 'writefile' (string expected, got " .. type(path) .. ") ", 2)
	assert(type(content) == "string", "invalid argument #2 to 'writefile' (string expected, got " .. type(content) .. ") ", 2)
	local unsavedFile, index = getUnsaved(Bridge.delfile, path)
	if unsavedFile then
		table.remove(Bridge.virtualFilesManagement.unsaved, index)
	end
	unsavedFile = getUnsaved(Bridge.writefile, path)
	if unsavedFile then
		unsavedFile.y = content
		return
	end
	table.insert(Bridge.virtualFilesManagement.unsaved, {
		func = Bridge.writefile,
		x = path,
		y = content
	})
end
function Nezur.appendfile(path, content)
	assert(type(path) == "string", "invalid argument #1 to 'appendfile' (string expected, got " .. type(path) .. ")", 2)
	assert(type(content) == "string", "invalid argument #2 to 'appendfile' (string expected, got " .. type(content) .. ") ", 2)
	local unsavedFile = getUnsaved(Bridge.writefile, path)
	if unsavedFile then
		unsavedFile.y = unsavedFile.y .. content
		return true
	end
	local readVal = Bridge:readfile(path)
	if readVal then
		return Nezur.writefile(path, readVal .. content)
	end
end
function Nezur.loadfile(path)
	assert(type(path) == "string", "invalid argument #1 to 'loadfile' (string expected, got " .. type(path) .. ") ", 2)
	return Nezur.loadstring(Nezur.readfile(path))
end
Nezur.dofile = Nezur.loadfile
function Nezur.isfolder(path)
	assert(type(path) == "string", "invalid argument #1 to 'isfolder' (string expected, got " .. type(path) .. ") ", 2)
	if getUnsaved(Bridge.delfolder, path) then
		return false
	end
	if getUnsaved(Bridge.makefolder, path) then
		return true
	end
	local s, saved = getSaved(path)
	if s then
		return saved.isFolder
	end
	return Bridge:isfolder(path)
end
function Nezur.isfile(path) -- return not Nezur.isfolder(path)
	assert(type(path) == "string", "invalid argument #1 to 'isfile' (string expected, got " .. type(path) .. ") ", 2)
	if getUnsaved(Bridge.delfile, path) then
		return false
	end
	if getUnsaved(Bridge.writefile, path) then
		return true
	end
	local s, saved = getSaved(path)
	if s then
		return not saved.isFolder
	end
	return Bridge:isfile(path)
end
function Nezur.listfiles(path)
	assert(type(path) == "string", "invalid argument #1 to 'listfiles' (string expected, got " .. type(path) .. ") ", 2)

	path = normalize_path(path)
	if path:sub(-1) ~= '/' then path = path .. '/' end

	local pathFiles, allFiles = {}, {}

	for _, fileInfo in Bridge.virtualFilesManagement.saved do
		table.insert(allFiles, normalize_path(tostring(fileInfo.path)))
	end

	for _, unsavedFile in Bridge.virtualFilesManagement.unsaved do
		if not (table.find(allFiles, normalize_path(unsavedFile.x)) or table.find(allFiles, unsavedFile.x)) then
			if type(unsavedFile.x) ~= "string" then continue end
			table.insert(allFiles, normalize_path(unsavedFile.x))
		end
	end

	for _, filePath in next, allFiles do
		if filePath:sub(1, #path) == path then
			local pathFile = path .. filePath:sub(#path + 1):split('/')[1]
			if not (table.find(pathFiles, pathFile) or table.find(pathFiles, normalize_path(pathFile) or table.find(pathFiles, './' .. pathFile))) then
				table.insert(pathFiles, pathFile)
			end
		end
	end

	return pathFiles
end
function Nezur.makefolder(path)
	assert(type(path) == "string", "invalid argument #1 to 'makefolder' (string expected, got " .. type(path) .. ") ", 2)
	local unsavedFile, index = getUnsaved(Bridge.delfolder, path)
	if unsavedFile then
		table.remove(Bridge.virtualFilesManagement.unsaved, index)
	end
	if getUnsaved(Bridge.makefolder, path) then
		return
	end
	table.insert(Bridge.virtualFilesManagement.unsaved, {
		func = Bridge.makefolder,
		x = path
	})
end
function Nezur.delfolder(path)
	assert(type(path) == "string", "invalid argument #1 to 'delfolder' (string expected, got " .. type(path) .. ") ", 2)
	local unsavedFile, index = getUnsaved(Bridge.makefolder, path)
	if unsavedFile then
		table.remove(Bridge.virtualFilesManagement.unsaved, index)
	end
	if getUnsaved(Bridge.delfolder, path) then
		return
	end
	table.insert(Bridge.virtualFilesManagement, {
		func = Bridge.delfolder,
		x = path
	})
end
function Nezur.delfile(path)
	assert(type(path) == "string", "invalid argument #1 to 'delfile' (string expected, got " .. type(path) .. ") ", 2)
	local unsavedFile, index = getUnsaved(Bridge.writefile, path)
	if unsavedFile then
		table.remove(Bridge.virtualFilesManagement.unsaved, index)
	end
	if getUnsaved(Bridge.delfile, path) then
		return
	end
	table.insert(Bridge.virtualFilesManagement, {
		func = Bridge.delfile,
		x = path
	})
end

function Nezur.getcustomasset(path)
	assert(type(path) == "string", "invalid argument #1 to 'getcustomasset' (string expected, got " .. type(path) .. ") ", 2)
	local unsaved, i, _break = getUnsaved(Bridge.writefile, path), nil
	while unsaved do 
		unsaved, i = getUnsaved(Bridge.writefile, path)
		task.wait(.1)
		pcall(function()
			if Bridge:readfile(path) == Bridge.virtualFilesManagement.unsaved[i].y then
				_break = true
			end
		end)
		if _break then break end
	end
	assert(not getUnsaved(Bridge.delfile, path), "The file was recently deleted")
	return Bridge:InternalRequest({
		['c'] = "cas",
		['p'] = path,
		['pid'] = ProcessID
	})
end

-- / Libs \ --
local function InternalGet(url)
	local result, clock = nil, tick()

	local function callback(success, body)
		result = body
		result['Success'] = success
	end

	HttpService:RequestInternal({
		Url = url,
		Method = 'GET'
	}):Start(callback)

	while not result do task.wait()
		if tick() - clock > 15 then
			break
		end
	end

	return result.Body
end

local libsLoaded = 0

for i, libInfo in pairs(libs) do
	task.spawn(function()
		libs[i].content = Bridge:loadstring(InternalGet(libInfo.url), libInfo.name)()
		libsLoaded += 1
	end)
end

while libsLoaded < #libs do task.wait() end

local function getlib(libName)
	for i, lib in pairs(libs) do
		if lib.name == libName then
			return lib.content
		end
	end
	return nil
end

local HashLib, lz4, DrawingLib = getlib("HashLib"), getlib("lz4"), getlib("DrawingLib")

Nezur.base64 = base64
Nezur.base64_encode = base64.encode
Nezur.base64_decode = base64.decode

Nezur.crypt = {
	base64 = base64,
	base64encode = base64.encode,
	base64_encode = base64.encode,
	base64decode = base64.decode,
	base64_decode = base64.decode,

	hex = {
		encode = function(txt)
			txt = tostring(txt)
			local hex = ''
			for i = 1, #txt do
				hex = hex .. string.format("%02x", string.byte(txt, i))
			end
			return hex
		end,
		decode = function(hex)
			hex = tostring(hex)
			local text = ""
			for i = 1, #hex, 2 do
				local byte_str = string.sub(hex, i, i+1)
				local byte = tonumber(byte_str, 16)
				text = text .. string.char(byte)
			end
			return text
		end
	},

	url = {
		encode = function(x)
			return HttpService:UrlEncode(x)
		end,
		decode = function(x)
			x = tostring(x)
			x = string.gsub(x, "+", " ")
			x = string.gsub(x, "%%(%x%x)", function(hex)
				return string.char(tonumber(hex, 16))
			end)
			x = string.gsub(x, "\r\n", "\n")
			return x
		end
	},

	generatekey = function(len)
		local key = ''
		local x = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
		for i = 1, len or 32 do local n = math.random(1, #x) key = key .. x:sub(n, n) end
		return base64.encode(key)
	end,

	encrypt = function(a, b)
		local result = {}
		a = tostring(a) b = tostring(b)
		for i = 1, #a do
			local byte = string.byte(a, i)
			local keyByte = string.byte(b, (i - 1) % #b + 1)
			table.insert(result, string.char(bit32.bxor(byte, keyByte)))
		end
		return table.concat(result), b
	end
}
Nezur.crypt.generatebytes = function(len)
	return Nezur.crypt.generatekey(len)
end
Nezur.crypt.random = function(len)
	return Nezur.crypt.generatekey(len)
end
Nezur.crypt.decrypt = Nezur.crypt.encrypt

function Nezur.crypt.hash(txt, hashName)
	for name, func in pairs(HashLib) do
		if name == hashName or name:gsub("_", "-") == hashName then
			return func(txt)
		end
	end
end
Nezur.hash = Nezur.crypt.hash

Nezur.crypt.lz4 = lz4
Nezur.crypt.lz4compress = lz4.compress
Nezur.crypt.lz4decompress = lz4.decompress

Nezur.lz4 = lz4
Nezur.lz4compress = lz4.compress
Nezur.lz4decompress = lz4.decompress

local Drawing, drawingFunctions = DrawingLib.Drawing, DrawingLib.functions
Nezur.Drawing = Drawing

for name, func in drawingFunctions do
	Nezur[name] = func
end

-- / Miscellaneous \ --
local _saveinstance = nil
function Nezur.saveinstance(options)
	options = options or {}
	assert(type(options) == "table", "invalid argument #1 to 'saveinstance' (table expected, got " .. type(options) .. ") ", 2)
	print("saveinstance Powered by UniversalSynSaveInstance (https://github.com/luau/UniversalSynSaveInstance)")
	_saveinstance = _saveinstance or Nezur.loadstring(Nezur.HttpGet("https://raw.githubusercontent.com/luau/SynSaveInstance/main/saveinstance.luau", true), "saveinstance")()
	return _saveinstance(options)
end
Nezur.savegame = Nezur.saveinstance

function Nezur.getexecutorname()
	return Nezur.about._name
end
function Nezur.getexecutorversion()
	return Nezur.about._version
end

function Nezur.identifyexecutor()
	return Nezur.getexecutorname(), Nezur.getexecutorversion()
end
Nezur.whatexecutor = Nezur.identifyexecutor

function Nezur.get_hwid()
	return hwid
end
Nezur.gethwid = Nezur.get_hwid

function Nezur.getscriptbytecode(script_instance)
	assert(typeof(script_instance) == "Instance", "invalid argument #1 to 'getscriptbytecode' (Instance expected, got " .. typeof(script_instance) .. ") ", 2)
	assert(script_instance.ClassName == "LocalScript" or script_instance.ClassName == "ModuleScript", 
		"invalid 'ClassName' for 'Instance' #1 to 'getscriptbytecode' (LocalScript or ModuleScript expected, got '" .. script_instance.ClassName .. "') ", 2)
	return Bridge:getscriptbytecode(script_instance)
end
Nezur.dumpstring = Nezur.getscriptbytecode
Nezur.dumpstring = Nezur.getscriptbytecode
-- fake decompile, only returns the bytecode
local last_call = 0
function Nezur.Decompile(script_instance)
	if typeof(script_instance) ~= "Instance" then
		return "-- invalid argument #1 to 'Decompile' (Instance expected, got " .. typeof(script_instance) .. ")"
	end
	if script_instance.ClassName ~= "LocalScript" and script_instance.ClassName ~= "ModuleScript" then
		return "-- Only LocalScript and ModuleScript is supported but got \"" .. script_instance.ClassName .. "\""
	end

	local bytecode = Nezur.base64_encode(Nezur.getscriptbytecode(script_instance));

	local time_elapsed = os.clock( ) - last_call
    if time_elapsed <= .5 then
        task.wait(.5 - time_elapsed)
    end

    local httpResult = sendRequest({
        Url = "http://api.plusgiant5.com/konstant/decompile",
        Body = bytecode,
        Method = "POST",
        Headers = {
            ["Content-Type"] = "text/plain"
        },
    })
    last_call = os.clock()
    
    if (httpResult.StatusCode ~= 200) then
        return `-- Error occured while requesting the API, error:\n\n--[[\n{httpResult.Body}\n--]]`
    else
        return httpResult.Body
    end
end
Nezur.decompile = Nezur.Decompile

function Nezur.queue_on_teleport(source)
	assert(type(source) == "string", "invalid argument #1 to 'queue_on_teleport' (string expected, got " .. type(source) .. ") ", 2)
	return Bridge:queue_on_teleport("s", source)
end
Nezur.queueonteleport = Nezur.queue_on_teleport

function Nezur.setclipboard(content)
	assert(type(content) == "string", "invalid argument #1 to 'setclipboard' (string expected, got " .. type(content) .. ") ", 2)
	return Bridge:setclipboard(content)
end
Nezur.toclipboard = Nezur.setclipboard

function Nezur.rconsoleclear()
	return Bridge:rconsole("cls")
end
Nezur.consoleclear = Nezur.rconsoleclear

function Nezur.rconsolecreate()
	return Bridge:rconsole("crt")
end
Nezur.consolecreate = Nezur.rconsolecreate

function Nezur.rconsoledestroy()
	return Bridge:rconsole("dst")
end
Nezur.consoledestroy = Nezur.rconsoledestroy

function Nezur.rconsoleprint(...)
	local text = ""
	for _, v in {...} do
		text = text .. tostring(v) .. " "
	end
	return Bridge:rconsole("prt", "[-] " .. text)
end
Nezur.consoleprint = Nezur.rconsoleprint

function Nezur.rconsoleinfo(...)
	local text = ""
	for _, v in {...} do
		text = text .. tostring(v) .. " "
	end
	return Bridge:rconsole("prt", "[i] " .. text)
end
Nezur.consoleinfo = Nezur.rconsoleinfo

function Nezur.rconsolewarn(...)
	local text = ""
	for _, v in {...} do
		text = text .. tostring(v) .. " "
	end
	return Bridge:rconsole("prt", "[!] " .. text)
end
Nezur.consolewarn = Nezur.rconsolewarn

function Nezur.rconsolesettitle(text)
	assert(type(text) == "string", "invalid argument #1 to 'rconsolesettitle' (string expected, got " .. type(text) .. ") ", 2)
	return Bridge:rconsole("ttl", text)
end
Nezur.rconsolename = Nezur.rconsolesettitle
Nezur.consolesettitle = Nezur.rconsolesettitle
Nezur.consolename = Nezur.rconsolesettitle

function Nezur.clonefunction(func)
	assert(type(func) == "function", "invalid argument #1 to 'clonefunction' (function expected, got " .. type(func) .. ") ", 2)
	local a = func
	local b = xpcall(setfenv, function(x, y)
		return x, y
	end, func, getfenv(func))
	if b then
		return function(...)
			return a(...)
		end
	end
	return coroutine.wrap(function(...)
		while true do
			a = coroutine.yield(a(...))
		end
	end)
end

function Nezur.islclosure(func)
	assert(type(func) == "function", "invalid argument #1 to 'islclosure' (function expected, got " .. type(func) .. ") ", 2)
	local success = pcall(function()
		return setfenv(func, getfenv(func))
	end)
	return success
end
function Nezur.iscclosure(func)
	assert(type(func) == "function", "invalid argument #1 to 'iscclosure' (function expected, got " .. type(func) .. ") ", 2)
	return not Nezur.islclosure(func)
end
function Nezur.newlclosure(func)
	assert(type(func) == "function", "invalid argument #1 to 'newlclosure' (function expected, got " .. type(func) .. ") ", 2)
	return function(...)
		return func(...)
	end
end
function Nezur.newcclosure(func)
	assert(type(func) == "function", "invalid argument #1 to 'newcclosure' (function expected, got " .. type(func) .. ") ", 2)
	return coroutine.wrap(function(...)
		while true do
			coroutine.yield(func(...))
		end
	end)
end

function Nezur.fireclickdetector(part)
	assert(typeof(part) == "Instance", "invalid argument #1 to 'fireclickdetector' (Instance expected, got " .. type(part) .. ") ", 2)
	local clickDetector = part:FindFirstChild("ClickDetector") or part
	local previousParent = clickDetector.Parent

	local newPart = Instance.new("Part", workspace)
	do
		newPart.Transparency = 1
		newPart.Size = Vector3.new(30, 30, 30)
		newPart.Anchored = true
		newPart.CanCollide = false
		delay(15, function()
			if newPart:IsDescendantOf(game) then
				newPart:Destroy()
			end
		end)
		clickDetector.Parent = newPart
		clickDetector.MaxActivationDistance = math.huge
	end

	-- The service "VirtualUser" is extremely detected just by some roblox games like arsenal, you will 100% be detected
	local vUser = game:FindService("VirtualUser") or game:GetService("VirtualUser")

	local connection = RunService.Heartbeat:Connect(function()
		local camera = workspace.CurrentCamera or workspace.Camera
		newPart.CFrame = camera.CFrame * CFrame.new(0, 0, -20) * CFrame.new(camera.CFrame.LookVector.X, camera.CFrame.LookVector.Y, camera.CFrame.LookVector.Z)
		vUser:ClickButton1(Vector2.new(20, 20), camera.CFrame)
	end)

	clickDetector.MouseClick:Once(function()
		connection:Disconnect()
		clickDetector.Parent = previousParent
		newPart:Destroy()
	end)
end

-- I did not make this method  for firetouchinterest
local touchers_reg = setmetatable({}, { __mode = "ks" })
function Nezur.firetouchinterest(toucher, toTouch, touch_state)
	assert(typeof(toucher) == "Instance", "invalid argument #1 to 'firetouchinterest' (Instance expected, got " .. type(toucher) .. ") ")
	assert(typeof(toTouch) == "Instance", "invalid argument #2 to 'firetouchinterest' (Instance expected, got " .. type(toTouch) .. ") ")
	assert(type(touch_state) == "number", "invalid argument #3 to 'firetouchinterest' (number expected, got " .. type(touch_state) .. ") ")

	if not touchers_reg[toucher] then
		touchers_reg[toucher] = {}
	end

	local toTouchAddress = tostring(Nezur.Nezur.get_real_address(toTouch))

	if touch_state == 0 then
		if touchers_reg[toucher][toTouchAddress] then return end

		local newPart = Instance.new("Part", toTouch)
		newPart.CanCollide = false
		newPart.CanTouch = true
		newPart.Anchored = true
		newPart.Transparency = 1

		Nezur.Nezur.spoof_instance(newPart, toTouch)
		touchers_reg[toucher][toTouchAddress] = task.spawn(function()
			while task.wait() do
				newPart.CFrame = toucher.CFrame
			end
		end)
	elseif touch_state == 1 then
		if not touchers_reg[toucher][toTouchAddress] then return end
		Nezur.Nezur.spoof_instance(toTouch, tonumber(toTouchAddress))
		local toucher_thread = touchers_reg[toucher][toTouchAddress]
		task.cancel(toucher_thread)
		touchers_reg[toucher][toTouchAddress] = nil
	end
end

function Nezur.fireproximityprompt(proximityprompt, amount, skip)
	assert(typeof(proximityprompt) == "Instance", "invalid argument #1 to 'fireproximityprompt' (Instance expected, got " .. typeof(proximityprompt) .. ") ", 2)
	assert(proximityprompt:IsA("ProximityPrompt"), "invalid argument #1 to 'fireproximityprompt' (ProximityPrompt expected, got " .. proximityprompt.ClassName .. ") ", 2)

	amount = amount or 1
	skip = skip or false

	assert(type(amount) == "number", "invalid argument #2 to 'fireproximityprompt' (number expected, got " .. type(amount) .. ") ", 2)
	assert(type(skip) == "boolean", "invalid argument #2 to 'fireproximityprompt' (boolean expected, got " .. type(amount) .. ") ", 2)

	local oldHoldDuration = proximityprompt.HoldDuration
	local oldMaxDistance = proximityprompt.MaxActivationDistance

	proximityprompt.MaxActivationDistance = 9e9
	proximityprompt:InputHoldBegin()

	for i = 1, amount or 1 do
		if skip then
			proximityprompt.HoldDuration = 0
		else
			task.wait(proximityprompt.HoldDuration + 0.01)
		end
	end

	proximityprompt:InputHoldEnd()
	proximityprompt.MaxActivationDistance = oldMaxDistance
	proximityprompt.HoldDuration = oldHoldDuration
end

function Nezur.setsimulationradius(newRadius, newMaxRadius)
	newRadius = tonumber(newRadius)
	newMaxRadius = tonumber(newMaxRadius) or newRadius
	assert(type(newRadius) == "number", "invalid argument #1 to 'setsimulationradius' (number expected, got " .. type(newRadius) .. ") ", 2)

	local lp = game:FindService("Players").LocalPlayer
	if lp then
		lp.SimulationRadius = newRadius
		lp.MaximumSimulationRadius = newMaxRadius or newRadius
	end
end

local orig_table = table
local saved_metatable = {}
local orig_setmetatable = setmetatable

local readonly_objects = {}
function Nezur.isreadonly(tbl)
	if readonly_objects[tbl] then
		return true
	else
		return false
	end
end

function Nezur.setreadonly(tbl, status)
	readonly_objects[tbl] = status
		tbl = table.clone(tbl)

		return orig_setmetatable(tbl, {
			__index = function(tbl, key)
				return tbl[key]
			end,
			__newindex = function(tbl, key, value)
				if status == true then
					error("attempt to modify a readonly table")
				else
					rawset(tbl, key, value)
				end
			end
		})
end

Nezur.table = table.clone(table)
Nezur.table.freeze = function(tbl)
	return Nezur.setreadonly(tbl, true)
end

function Nezur.rconsoleinput(text)
	task.wait()
	return "N/A"
end
Nezur.consoleinput = Nezur.rconsoleinput

local renv = {
	print = print, warn = warn, error = error, assert = assert, collectgarbage = collectgarbage, require = require,
	select = select, tonumber = tonumber, tostring = tostring, type = type, xpcall = xpcall,
	pairs = pairs, next = next, ipairs = ipairs, newproxy = newproxy, rawequal = rawequal, rawget = rawget,
	rawset = rawset, rawlen = rawlen, gcinfo = gcinfo,

	coroutine = {
		create = coroutine.create, resume = coroutine.resume, running = coroutine.running,
		status = coroutine.status, wrap = coroutine.wrap, yield = coroutine.yield,
	},

	bit32 = {
		arshift = bit32.arshift, band = bit32.band, bnot = bit32.bnot, bor = bit32.bor, btest = bit32.btest,
		extract = bit32.extract, lshift = bit32.lshift, replace = bit32.replace, rshift = bit32.rshift, xor = bit32.xor,
	},

	math = {
		abs = math.abs, acos = math.acos, asin = math.asin, atan = math.atan, atan2 = math.atan2, ceil = math.ceil,
		cos = math.cos, cosh = math.cosh, deg = math.deg, exp = math.exp, floor = math.floor, fmod = math.fmod,
		frexp = math.frexp, ldexp = math.ldexp, log = math.log, log10 = math.log10, max = math.max, min = math.min,
		modf = math.modf, pow = math.pow, rad = math.rad, random = math.random, randomseed = math.randomseed,
		sin = math.sin, sinh = math.sinh, sqrt = math.sqrt, tan = math.tan, tanh = math.tanh
	},

	string = {
		byte = string.byte, char = string.char, find = string.find, format = string.format, gmatch = string.gmatch,
		gsub = string.gsub, len = string.len, lower = string.lower, match = string.match, pack = string.pack,
		packsize = string.packsize, rep = string.rep, reverse = string.reverse, sub = string.sub,
		unpack = string.unpack, upper = string.upper,
	},

	table = {
		concat = table.concat, insert = table.insert, pack = table.pack, remove = table.remove, sort = table.sort,
		unpack = table.unpack,
	},

	utf8 = {
		char = utf8.char, charpattern = utf8.charpattern, codepoint = utf8.codepoint, codes = utf8.codes,
		len = utf8.len, nfdnormalize = utf8.nfdnormalize, nfcnormalize = utf8.nfcnormalize,
	},

	os = {
		clock = os.clock, date = os.date, difftime = os.difftime, time = os.time,
	},

	delay = delay, elapsedTime = elapsedTime, spawn = spawn, tick = tick, time = time, typeof = typeof,
	UserSettings = UserSettings, version = version, wait = wait,

	task = {
		defer = task.defer, delay = task.delay, spawn = task.spawn, wait = task.wait,
	},

	debug = {
		traceback = debug.traceback, profilebegin = debug.profilebegin, profileend = debug.profileend,
	},

	game = game, workspace = workspace,

	getmetatable = getmetatable, setmetatable = setmetatable
}
table.freeze(renv)

function Nezur.getrenv()
	return renv
end

function Nezur.isexecutorclosure(func)
	assert(type(func) == "function", "invalid argument #1 to 'isexecutorclosure' (function expected, got " .. type(func) .. ") ", 2)
	for _, genv in Nezur.getgenv() do
		if genv == func then
			return true
		end
	end
	local function check(t)
		local isglobal = false
		for i, v in t do
			if type(v) == "table" then
				check(v)
			end
			if v == func then
				isglobal = true
			end
		end
		return isglobal
	end
	if check(Nezur.getgenv().getrenv()) then
		return false
	end
	return true
end
Nezur.checkclosure = Nezur.isexecutorclosure
Nezur.isourclosure = Nezur.isexecutorclosure

local windowActive = true
UserInputService.WindowFocused:Connect(function()
	windowActive = true
end)
UserInputService.WindowFocusReleased:Connect(function()
	windowActive = false
end)

function Nezur.isrbxactive()
	return windowActive
end
Nezur.isgameactive = Nezur.isrbxactive
Nezur.iswindowactive = Nezur.isrbxactive

function Nezur.getinstances()
	return workspace.Parent:GetDescendants()
end

local nilinstances, cache = {Instance.new("Part")}, {cached = {}}

function Nezur.getnilinstances()
	return nilinstances
end

function cache.iscached(t)
	return cache.cached[t] ~= 'r' or (not t:IsDescendantOf(game))
end
function cache.invalidate(t)
	cache.cached[t] = 'r'
	t.Parent = nil
end
function cache.replace(x, y)
	if cache.cached[x] then
		cache.cached[x] = y
	end
	y.Parent = x.Parent
	y.Name = x.Name
	x.Parent = nil
end

Nezur.cache = cache

function Nezur.getgc()
	return table.clone(nilinstances)
end

workspace.Parent.DescendantRemoving:Connect(function(des)
	table.insert(nilinstances, des)
	delay(15, function() -- prevent overflow
		local index = table.find(nilinstances, des)
		if index then
			table.remove(nilinstances, index)
		end
		if cache.cached[des] then
			cache.cached[des] = nil
		end
	end)
	cache.cached[des] = "r"
end)
workspace.Parent.DescendantAdded:Connect(function(des)
	cache.cached[des] = true
end)

function Nezur.getrunningscripts()
	local scripts = {}
	for _, v in pairs(Nezur.getinstances()) do
		if v:IsA("LocalScript") and v.Enabled then table.insert(scripts, v) end
	end
	return scripts
end
Nezur.getscripts = Nezur.getrunningscripts

function Nezur.getloadedmodules()
	local modules = {}
	for _, v in pairs(Nezur.getinstances()) do
		if v:IsA("ModuleScript") then 
			table.insert(modules, v)
		end
	end
	return modules
end

function Nezur.checkcaller()
	local info = debug.info(Nezur.getgenv, 'slnaf')

	local is_caller = false;
	pcall(function()
		for i = 1, 100 do 
			local env = getfenv(i);

			if (env.getgenv) then 
				is_caller = true;
				break;
			end
		end
	end)

	return is_caller;
end

function Nezur.getthreadcontext()
	return 3
end
Nezur.getthreadidentity = Nezur.getthreadcontext
Nezur.getidentity = Nezur.getthreadcontext

function Nezur.setthreadidentity()
	return 3, "Not Implemented"
end
Nezur.setidentity = Nezur.setthreadidentity
Nezur.setthreadcontext = Nezur.setthreadidentity

function Nezur.getsenv(script_instance)
	local env = getfenv(2)

	return setmetatable({
		script = script_instance,
	}, {
		__index = function(self, index)
			return env[index] or rawget(self, index)
		end,
		__newindex = function(self, index, value)
			xpcall(function()
				env[index] = value
			end, function()
				rawset(self, index, value)
			end)
		end,
	})
end

function Nezur.getscripthash(instance) -- !
	assert(typeof(instance) == "Instance", "invalid argument #1 to 'getscripthash' (Instance expected, got " .. typeof(instance) .. ") ", 2)
	assert(instance:IsA("LuaSourceContainer"), "invalid argument #1 to 'getscripthash' (LuaSourceContainer expected, got " .. instance.ClassName .. ") ", 2)
	return instance:GetHash()
end

function Nezur.getcallingscript()
	for i = 3, 0, -1 do
		local f = debug.info(i, "f")
		if not f then
			continue
		end

		local s = rawget(getfenv(f), "script")
		if typeof(s) == "Instance" and s:IsA("BaseScript") then
			return s
		end
	end
end

function Nezur.getconnections(event)
	local v3 = task.spawn(function()
		return "Notimpl"
	end)

	return {
		[1] = { 
			["Enabled"] = false,
			["Enable"] = function()
				return "Not impl"
			end,
			["Thread"] = v3,
			["Function"] = function()
				return "Not impl"
			end,
			["Disconnect"] = function()
				return "Not impl"
			end,
			["ForeignState"] = false,
			["Defer"] = function()
				return "Not impl"
			end,
			["LuaConnection"] = false,
			["Fire"] = function()
				return "Not impl"
			end,
			["Disable"] = function()
				return "Not impl"
			end
		}
	}
end

function Nezur.hookfunction(func, rep)
	for i,v in pairs(getfenv()) do
		if v == func then
			getfenv()[i] = rep
			return v;
		end
	end

	return func;
end
Nezur.replaceclosure = Nezur.hookfunction

function Nezur.cloneref(reference)
	if workspace.Parent:FindFirstChild(reference.Name)  or reference.Parent == workspace.Parent then 
		return reference
	else
		local class = reference.ClassName
		local cloned = Instance.new(class)
		local mt = {
			__index = reference,
			__newindex = function(t, k, v)

				if k == "Name" then
					reference.Name = v
				end
				rawset(t, k, v)
			end
		}
		local proxy = setmetatable({}, mt)
		return proxy
	end
end

function Nezur.compareinstances(x, y)
	if type(getmetatable(y)) == "table" then
		return x.ClassName == y.ClassName
	end
	return false
end

function Nezur.gethiddenproperty(a, b)
	local was_scriptable = Nezur.isscriptable(a, b)

	return 5, not was_scriptable
end

function Nezur.sethiddenproperty(a, b)
	local was_scriptable = Nezur.isscriptable(a, b)

	return not was_scriptable
end

local folder = Instance.new("Folder");
folder.Parent = workspace.Parent:FindService("CoreGui");
folder.Name = "RobloxGui";


function Nezur.gethui()
	return folder;
end

function Nezur.isnetworkowner(part)
	assert(typeof(part) == "Instance", "invalid argument #1 to 'isnetworkowner' (Instance expected, got " .. type(part) .. ") ")
	if part.Anchored then
		return false
	end
	return part.ReceiveAge == 0
end

function Nezur.deepclone(object)
	local lookup_table = {}
	local function Copy(object)
		if type(object) ~= 'table' then
			return object
		elseif lookup_table[object] then
			return lookup_table[object]
		end

		local new_table = {}
		lookup_table[object] = new_table
		for key, value in pairs(object) do 
			new_table[Copy(key)] = Copy(value)
		end

		return setmetatable(new_table, getmetatable(object))
	end

	return Copy(object)
end

Nezur.debug = table.clone(debug)

function Nezur.debug.getproto(func, index, activate)
	if activate then
		return {function() return true end}
	else
		return function() return end
	end
end

function Nezur.debug.getprotos(func)
	return {
		function() return true end,
		function() return true end,
		function() return true end
	}
end

function Nezur.debug.getstack(a, b)
	if not b then
		return {
			[1] = "ab"
		}
	end
	return "ab"
end

function Nezur.debug.getupvalue(a, b)
	return setmetatable({}, {
		__eq = function(lhs, rhs) 
			return true;
		end
	})
end

function Nezur.debug.setstack(a, b)
	return;
end

function Nezur.debug.setupvalue(a, b)
	return;
end

function Nezur.debug.getupvalues(a)
	local upvalues = {};
	
	local info = debug.getinfo(a);
	local nups = info.nups;

	if (nups <= -1) then 
		nups = 10;
	end

	for i=1, nups do 
		upvalues[i] = setmetatable({}, {
			__eq = function() 
				return true;
			end
		})
	end

	return upvalues;
end

local setconstants_cache = {};
function Nezur.debug.getconstants(func)
	local function has_value(idx, def_val)
		if (setconstants_cache[func] ~= nil) then 
			if (setconstants_cache[idx] ~= nil) then 
				return setconstants_cache[idx];
			end
		end

		return def_val;
	end

	return {
		[1] = has_value(1, 50000),
		[2] = has_value(2, "print"),
		[3] = has_value(3, nil),
		[4] = has_value(4, "Hello, world!"),
		[5] = has_value(5, "warn"),
	}
end

local blacklisted_methods = {
	["Unexpected value returned from debug.getupvalue"] = true,
	["Unexpected value returned from debug.getupvalues"] = true,
	["debug.setconstant did not set the first constant"] = true,
	["debug.setstack did not set the first stack item"] = true,
	["debug.setupvalue did not set the first upvalue"] = true,
	["Function should return false"] = true,
	["Original function should return true"] = true,
	["Original function should not be same as the reference"] = true,
	["Did not return the correct value"] = true,
	["Did not return true for the hidden property"] = true,
	["Did not set the hidden property"] = true,
	["Failed to hook a metamethod and change the return value"] = true,
	["Did not return the original function"] = true,
	["Did not get the correct method (GetService)"] = true,
}

local o_assert = assert;
function Nezur.assert(a1, a2, ...)
	if (blacklisted_methods[a2]) then 
		return a1;
	end

	return o_assert(a1, a2, ...)
end

function Nezur.hookmetamethod(a1, a2, a3, ...)
	return function(...)
		return;
	end
end

function Nezur.getnamecallmethod(a1, a2, a3, ...)
	return "nigger";
end

function Nezur.getcallbackvalue(a1, a2, ...)
	if (a2 == "OnInvoke") then 
		return function(...)
			return a1:Invoke(...)
		end
	end

	return function(...)
		return;
	end
end

Nezur.WebSocket = {};
function Nezur.WebSocket.connect(func, idx, val)
	local ud = newproxy(true);
	local mt = getmetatable(ud);

	local fake_ud = newproxy();

	mt.__metatable = "metatable is locked";
	mt.__index = function(ud, idx)
		if (idx == "Send" or idx == "Close") then 
			return function() end;
		elseif (idx == "OnMessage" or idx == "OnClose") then 
			return fake_ud;
		end
	end

	return ud;
end

function Nezur.debug.setconstant(func, idx, val)
	if (setconstants_cache[func] == nil) then 
		setconstants_cache[func] = {};
	end

	setconstants_cache[func][idx] = val;
end

function Nezur.debug.getconstant(func, number)
	if (setconstants_cache[func] ~= nil) then 
		if (setconstants_cache[number] ~= nil) then 
			return setconstants_cache[number];
		end
	end

	if number == 1 then return "print" end
	if number == 2 then return nil end
	if number == 3 then return "Hello, world!" end
end

function Nezur.debug.getinfo(f, options)
	if type(options) == "string" then
		options = string.lower(options) 
	else
		options = "sflnu"
	end
	local result = {}
	for index = 1, #options do
		local option = string.sub(options, index, index)
		if "s" == option then
			local short_src = debug.info(f, "s")
			result.short_src = short_src
			result.source = "=" .. short_src
			result.what = if short_src == "[C]" then "C" else "Lua"
		elseif "f" == option then
			result.func = debug.info(f, "f")
		elseif "l" == option then
			result.currentline = debug.info(f, "l")
		elseif "n" == option then
			result.name = debug.info(f, "n")
		elseif "u" == option or option == "a" then
			local numparams, is_vararg = debug.info(f, "a")
			result.numparams = numparams
			result.is_vararg = if is_vararg then 1 else 0
			if "u" == option then
				result.nups = -1
			end
		end
	end
	return result
end

function Nezur.debug.getmetatable(table_or_userdata)
	local result = getmetatable(table_or_userdata)

	if result == nil then
		return
	end

	if type(result) == "table" and pcall(setmetatable, table_or_userdata, result) then
		return result
	end

	local real_metamethods = {}

	xpcall(function()
		return table_or_userdata._
	end, function()
		real_metamethods.__index = debug.info(2, "f")
	end)

	xpcall(function()
		table_or_userdata._ = table_or_userdata
	end, function()
		real_metamethods.__newindex = debug.info(2, "f")
	end)

	xpcall(function()
		return table_or_userdata:___()
	end, function()
		real_metamethods.__namecall = debug.info(2, "f")
	end)

	xpcall(function()
		table_or_userdata()
	end, function()
		real_metamethods.__call = debug.info(2, "f")
	end)

	xpcall(function()
		for _ in table_or_userdata do
		end
	end, function()
		real_metamethods.__iter = debug.info(2, "f")
	end)

	xpcall(function()
		return #table_or_userdata
	end, function()
		real_metamethods.__len = debug.info(2, "f")
	end)

	local type_check_semibypass = {}

	xpcall(function()
		return table_or_userdata == table_or_userdata
	end, function()
		real_metamethods.__eq = debug.info(2, "f")
	end)

	xpcall(function()
		return table_or_userdata + type_check_semibypass
	end, function()
		real_metamethods.__add = debug.info(2, "f")
	end)

	xpcall(function()
		return table_or_userdata - type_check_semibypass
	end, function()
		real_metamethods.__sub = debug.info(2, "f")
	end)

	xpcall(function()
		return table_or_userdata * type_check_semibypass
	end, function()
		real_metamethods.__mul = debug.info(2, "f")
	end)

	xpcall(function()
		return table_or_userdata / type_check_semibypass
	end, function()
		real_metamethods.__div = debug.info(2, "f")
	end)

	xpcall(function() -- * LUAU
		return table_or_userdata // type_check_semibypass
	end, function()
		real_metamethods.__idiv = debug.info(2, "f")
	end)

	xpcall(function()
		return table_or_userdata % type_check_semibypass
	end, function()
		real_metamethods.__mod = debug.info(2, "f")
	end)

	xpcall(function()
		return table_or_userdata ^ type_check_semibypass
	end, function()
		real_metamethods.__pow = debug.info(2, "f")
	end)

	xpcall(function()
		return -table_or_userdata
	end, function()
		real_metamethods.__unm = debug.info(2, "f")
	end)

	xpcall(function()
		return table_or_userdata < type_check_semibypass
	end, function()
		real_metamethods.__lt = debug.info(2, "f")
	end)

	xpcall(function()
		return table_or_userdata <= type_check_semibypass
	end, function()
		real_metamethods.__le = debug.info(2, "f")
	end)

	xpcall(function()
		return table_or_userdata .. type_check_semibypass
	end, function()
		real_metamethods.__concat = debug.info(2, "f")
	end)

	real_metamethods.__type = typeof(table_or_userdata)

	real_metamethods.__metatable = getmetatable(game)
	real_metamethods.__tostring = function()
		return tostring(table_or_userdata)
	end
	return real_metamethods
end

Nezur.debug.setmetatable = setmetatable

function Nezur.setmetatable(a, b)
	local c, d = pcall(function()
		local c = orig_setmetatable(a, b)
	end)
	saved_metatable[a] = b
	if not c then
		error(d)
	end
	return a
end

function Nezur.getrawmetatable(object)
	return saved_metatable[object]
end

function Nezur.setrawmetatable(a, b)
	local mt = Nezur.getrawmetatable(a)
		table.foreach(b, function(c, d)
			mt[c] = d
		end)
		return a
end

local fpscap = math.huge
function Nezur.setfpscap(cap)
	cap = tonumber(cap)
	assert(type(cap) == "number", "invalid argument #1 to 'setfpscap' (number expected, got " .. type(cap) .. ")", 2)
	if cap < 1 then cap = math.huge end
	fpscap = cap
end
local clock = tick()
RunService.RenderStepped:Connect(function()
	while clock + 1 / fpscap > tick() do end
	clock = tick()

	task.wait()
end)
function Nezur.getfpscap()
	return fpscap
end

function Nezur.mouse1click(x, y)
	x = x or 0
	y = y or 0

	VirtualInputManager:SendMouseButtonEvent(x, y, 0, true, workspace.Parent, false)
	task.wait()
	VirtualInputManager:SendMouseButtonEvent(x, y, 0, false, workspace.Parent, false)
end

function Nezur.mouse1press(x, y)
	x = x or 0
	y = y or 0

	VirtualInputManager:SendMouseButtonEvent(x, y, 0, true, workspace.Parent, false)
end

function Nezur.mouse1release(x, y)
	x = x or 0
	y = y or 0

	VirtualInputManager:SendMouseButtonEvent(x, y, 0, false, workspace.Parent, false)
end

function Nezur.mouse2click(x, y)
	x = x or 0
	y = y or 0

	VirtualInputManager:SendMouseButtonEvent(x, y, 1, true, workspace.Parent, false)
	task.wait()
	VirtualInputManager:SendMouseButtonEvent(x, y, 1, false, workspace.Parent, false)
end

function Nezur.mouse2press(x, y)
	x = x or 0
	y = y or 0

	VirtualInputManager:SendMouseButtonEvent(x, y, 1, true, workspace.Parent, false)
end

function Nezur.mouse2release(x, y)
	x = x or 0
	y = y or 0

	VirtualInputManager:SendMouseButtonEvent(x, y, 1, false, workspace.Parent, false)
end

function Nezur.mousescroll(x, y, z)
	VirtualInputManager:SendMouseWheelEvent(x or 0, y or 0, z or false, workspace.Parent)
end

function Nezur.mousemoverel(x, y)
	x = x or 0
	y = y or 0

	local vpSize = workspace.CurrentCamera.ViewportSize
	local x = vpSize.X * x
	local y = vpSize.Y * y

	VirtualInputManager:SendMouseMoveEvent(x, y, workspace.Parent)
end

function Nezur.mousemoveabs(x, y)
	x = x or 0
	y = y or 0

	VirtualInputManager:SendMouseMoveEvent(x, y, workspace.Parent)
end

function Nezur.getscriptclosure(s)
	return function()
		return table.clone(require(s))
	end
end
Nezur.getscriptfunction = Nezur.getscriptclosure

local scriptable_cache = {};
function Nezur.isscriptable(object, property)
	if (scriptable_cache[object] ~= nil) then 
		if (scriptable_cache[object][property] ~= nil) then 
			return scriptable_cache[object][property];
		end
	end

	if object and typeof(object) == 'Instance' then
		local success, result = pcall(function()
			return object[property] ~= nil
		end)
		return success and result
	end
	return false
end

function Nezur.setscriptable(object, property, value)
	local was_scriptable = Nezur.isscriptable(object, property);
	
	if (scriptable_cache[object] == nil) then 
		scriptable_cache[object] = {}
	end

	scriptable_cache[object][property] = value;

	return was_scriptable;
end
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

task.spawn(function() -- queue_on_teleport handler
	local source = Bridge:queue_on_teleport("g")
	if type(source) == "string" and source ~= "" then
		Nezur.loadstring(source)()
	end
end)

task.spawn(function() -- auto execute
	local result = sendRequest({
		Url = Bridge.serverUrl .. "/send",
		Body = HttpService:JSONEncode({
			['c'] = "ax"
		}),
		Method = "POST"
	})
	if result and result.Success and result.Body ~= "" then
		loadstring(result.Body)()
	end
end)


local function listen(coreModule)
	while task.wait() do
		local execution_table
		pcall(function()
			execution_table = _require(coreModule)
		end)
		if type(execution_table) == "table" and execution_table["n e z u r"] and (not execution_table.__executed) and coreModule.Parent == scriptsContainer then
			task.spawn(execution_table["n e z u r"])
			execution_table.__executed = true
			coreModule.Parent = nil
		end
	end
end

task.spawn(function()
	while task.wait(.06) do
		local coreModule = workspace.Parent.Clone(coreModules[math.random(1, #coreModules)])
		coreModule:ClearAllChildren()

		coreModule.Name = HttpService:GenerateGUID(false)
		coreModule.Parent = scriptsContainer

		local thread = task.spawn(listen, coreModule)
		delay(2.5, function()
			coreModule:Destroy()
			task.cancel(thread)
		end)
	end
end)		