local HttpService = game:GetService("HttpService")
local IsSynapse = syn ~= nil

local Preferences = {
	NotificationTransparency = 0.1;
	NotificationTime = 3;
	Theme = "Red";
}

local CurrentTheme = {
	Background0 = Color3.fromRGB(60, 60, 70);
	Background1 = Color3.fromRGB(41, 41, 51);
	Background2 = Color3.fromRGB(26, 26, 33);
	
	Text0 = Color3.fromRGB(197, 197, 197);
	Text1 = Color3.fromRGB(139, 139, 139);
	Text2 = Color3.fromRGB(91, 91, 91);
	Text3 = Color3.fromRGB(56, 56, 56);
	Text4 = Color3.fromRGB(0, 0, 0);
}

local Themes = {
	Dark = {
		Background0 = Color3.fromRGB(60, 60, 70);
		Background1 = Color3.fromRGB(41, 41, 51);
		Background2 = Color3.fromRGB(26, 26, 33);
		
		Text0 = Color3.fromRGB(197, 197, 197);
		Text1 = Color3.fromRGB(139, 139, 139);
		Text2 = Color3.fromRGB(91, 91, 91);
		Text3 = Color3.fromRGB(56, 56, 56);
		Text4 = Color3.fromRGB(0, 0, 0);
	}
}


if IsSynapse then
    pcall(function() 
	    Themes = loadstring(game:HttpGet("https://raw.githubusercontent.com/AtheriumMark/Rui/main/Themes.lua", true))()
    end)
    
	if isfile("config.ather") then
		local Data = readfile("config.ather")
		local UnpackedData = {}
		
		Unable = pcall(function() 	
			UnpackedData = HttpService:JSONDecode(Data)
		end)
		
		if not Unable then
			warn("Invalid Configuration File!")
			writefile("config.ather", HttpService:JSONEncode(Preferences))
		end
		
		Preferences.Theme = UnpackedData.Theme
		Preferences.NotificationTime = UnpackedData.NotificationTime
		Preferences.NotificationTransparency = UnpackedData.NotificationTransparency
		
	else
		writefile("config.ather", HttpService:JSONEncode(Preferences))
	end
end

pcall(function() 
	if Themes[Preferences.Theme] ~= nil then
		CurrentTheme = Themes[Preferences.Theme]
	end
end)

return {Preferences = Preferences, Theme = CurrentTheme}
