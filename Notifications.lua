local UIParent = game.CoreGui
local ScreenGui = nil
local Library = {}


local Preferences = {}
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
pcall(function ()
	local Vars = loadstring(game:HttpGet("https://raw.githubusercontent.com/AtheriumMark/hax/main/Configuration.lua"))
	Preferences = Vars.Preferences
	CurrentTheme = Vars.Theme
end)



function Library.Notification(Title, Text, GUIParent)
	if Title == nil then
		Text = "unset"
		Title = "unset"
	elseif Text == nil then
		Text = "unset"
	end

	if GUIParent == nil then
		if ScreenGui == nil then
			ScreenGui = Instance.new("ScreenGui", GUIParent)
			ScreenGui.ResetOnSpawn = false
			ScreenGui.IgnoreGuiInset = true
			ScreenGui.Name = "Parent"
		end
		GUIParent = ScreenGui
	end
	
	local Frame = Instance.new("Frame", GUIParent)
	Frame.BackgroundColor3 = CurrentTheme.Background0
	Frame.Position = UDim2.fromScale(1, 1.1)
	Frame.Size = UDim2.fromScale(0.2, 0.1)
	Frame.AnchorPoint = Vector2.new(1, 1)
	Frame.BackgroundTransparency = Preferences.NotificationTransparency
	Frame.Name = "Notification"
	Frame.BorderSizePixel = 0
	
	local Corner = Instance.new("UICorner", Frame)
	Corner.Name = "Corner"
	Corner.CornerRadius = UDim.new(0.1, 0)
	
	local TitleFrame = Instance.new("TextLabel", Frame)
	TitleFrame.TextColor3 = CurrentTheme.Text0
	TitleFrame.Position = UDim2.fromScale(0.05, 0.05)
	TitleFrame.Size = UDim2.fromScale(0.9, 0.2)
	TitleFrame.BackgroundTransparency = 1
	TitleFrame.Font = Enum.Font.ArialBold
	TitleFrame.TextScaled = true
	TitleFrame.Name = "Title"
	TitleFrame.Text = Title
	
	local SubtitleFrame = Instance.new("TextLabel", Frame)
	SubtitleFrame.TextColor3 = CurrentTheme.Text1
	SubtitleFrame.Position = UDim2.fromScale(0.05, 0.3)
	SubtitleFrame.Size = UDim2.fromScale(0.9, 0.65)
	SubtitleFrame.BackgroundTransparency = 1
	SubtitleFrame.Font = Enum.Font.ArialBold
	SubtitleFrame.Name = "Text"
	SubtitleFrame.TextScaled = true
	SubtitleFrame.Text = Text
	
	Frame:TweenPosition(UDim2.fromScale(0.97, 0.97), Enum.EasingDirection.InOut, Enum.EasingStyle.Sine, 0.5)
	wait(Preferences.NotificationTime)
	Frame:TweenPosition(UDim2.fromScale(0.97, 1.17), Enum.EasingDirection.InOut, Enum.EasingStyle.Sine, 0.5, false, function() Frame:Destroy() end)
end

-- Test, uncomment next line for testing.
-- Library.Notification("kill me", "kill me")

return Library
