local GuiParent = Instance.new("ScreenGui", game.CoreGui)
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local GuiInset = game:GetService("GuiService"):GetGuiInset()

local TweenInformation = TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
local MoveTweenInformation = TweenInfo.new(0.07, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)

local Preferences = {Debug = true}
local Lib = {}

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
	local Vars = loadstring(game:HttpGet("https://raw.githubusercontent.com/AtheriumMark/Rui/main/Configuration.lua"))()
	Preferences = Vars.Preferences
	CurrentTheme = Vars.Theme
end)

GuiParent.IgnoreGuiInset = true

local FontSize = 20


function Lib.CreateListNode(TitleText)
	local Offset = Vector2.new(0, 0)
	local MouseDownInside = false
	local MouseIn = false
	local BarTweens = {}
	local Open = false
	local Tweens = {}

	local Background = Instance.new("Frame", GuiParent)
	Background.Size = UDim2.fromScale(0.1, 0.04)
	Background.BackgroundColor3 = CurrentTheme.Background0
	Background.BorderSizePixel = 0

	local Title = Instance.new("TextLabel", Background)
	Title.Size = UDim2.fromScale(1.0, 1.0)
	Title.TextColor3 = CurrentTheme.Text0
	Title.BackgroundTransparency = 1
	Title.Font = Enum.Font.Ubuntu
	Title.BorderSizePixel = 0
	Title.Text = TitleText
	Title.TextSize = FontSize

	local ContentMaskFrame = Instance.new("Frame", Background)
	ContentMaskFrame.Size = UDim2.fromScale(1.0, 7.0)
	ContentMaskFrame.Position = UDim2.fromScale(0.0, 1.0)
	ContentMaskFrame.BackgroundTransparency = 1
	ContentMaskFrame.ClipsDescendants = true

	Background.MouseEnter:Connect(function() MouseIn = true end)
	Background.MouseLeave:Connect(function() MouseIn = false end)

	UIS.InputBegan:Connect(function(Input) 
		if Input.UserInputType == Enum.UserInputType.MouseButton1 and MouseIn then
			local Mouse = UIS:GetMouseLocation()

			Offset = Vector2.new(Mouse.X - Background.AbsolutePosition.X, Mouse.Y - Background.AbsolutePosition.Y - GuiInset.Y)
			MouseDownInside = true
		end

		if Input.UserInputType == Enum.UserInputType.MouseButton2 and MouseIn then
			if Open then
				for i,v in pairs(BarTweens) do
					v:Cancel()
				end
				table.clear(BarTweens)

				local Tween = TweenService:Create(ContentMaskFrame, TweenInformation, {Size = UDim2.fromScale(1.0, 0.0)})
				Tween:Play()


				BarTweens[#BarTweens + 1] = Tween
			else
				for i,v in pairs(BarTweens) do
					v:Cancel()
				end
				table.clear(BarTweens)

				local Tween = TweenService:Create(ContentMaskFrame, TweenInformation, {Size = UDim2.fromScale(1.0, 7.0)})
				Tween:Play()


				BarTweens[#BarTweens + 1] = Tween
			end
			Open = not Open
		end
	end)

	UIS.InputEnded:Connect(function(Input) 
		if Input.UserInputType == Enum.UserInputType.MouseButton1 then
			MouseDownInside = false
		end
	end)

	game["Run Service"].RenderStepped:Connect(function()
		if MouseDownInside then
			local Position = UIS:GetMouseLocation() - Offset
			for i,v in pairs(Tweens) do
				v:Cancel()
			end
			table.clear(Tweens)

			local Tween = TweenService:Create(Background, MoveTweenInformation, {Position = UDim2.fromOffset(Position.X, Position.Y)})
			Tween:Play()


			Tweens[#Tweens + 1] = Tween


		end

		--Background.Position = UDim2.fromOffset(math.clamp(Background.Position.X.Offset, 0, GuiParent.AbsolutePosition.X + GuiParent.AbsoluteSize.X), math.clamp(Background.Position.Y.Offset, 0, GuiParent.AbsolutePosition.Y + GuiParent.AbsoluteSize.Y + ContentMaskFrame.AbsoluteSize.Y))
	end)



	local ContentFrame = Instance.new("ScrollingFrame", ContentMaskFrame)
	ContentFrame.BackgroundColor3 = CurrentTheme.Background2
	ContentFrame.Size = UDim2.fromScale(1.0, 1.0)
	ContentFrame.ScrollBarThickness = 0
	ContentFrame.BorderSizePixel = 0


	local List = Instance.new("UIListLayout", ContentFrame)
	List.SortOrder = Enum.SortOrder.Name
	List.HorizontalAlignment = Enum.HorizontalAlignment.Center
	List.VerticalAlignment = Enum.VerticalAlignment.Top
	List.FillDirection = Enum.FillDirection.Vertical

	ContentFrame.ChildAdded:Connect(function()
		ContentFrame.CanvasSize = UDim2.fromOffset(0, List.AbsoluteContentSize.Y + 5)
	end)

	return {
		AddButtonChild = function(TitleText: string, Callback)
			local ChildFrame = Instance.new("Frame", ContentFrame)

			ChildFrame.Size = UDim2.new(1.0, 0, 0, 30)
			ChildFrame.BackgroundColor3 = CurrentTheme.Background2
			ChildFrame.BorderSizePixel = 0
			ChildFrame.BackgroundColor3 = CurrentTheme.Background1
			ChildFrame.BackgroundTransparency = 1

			local Title = Instance.new("TextLabel", ChildFrame)

			Title.BackgroundTransparency = 1
			Title.Text = TitleText
			Title.Size = UDim2.fromScale(1.0, 1.0)
			Title.TextSize = FontSize
			Title.TextColor3 = CurrentTheme.Text0
			Title.Font = Enum.Font.Ubuntu
			local MouseInS = false

			ChildFrame.MouseEnter:Connect(function()
				ChildFrame.BackgroundTransparency = 0
				MouseInS = true
			end)

			ChildFrame.MouseLeave:Connect(function()
				ChildFrame.BackgroundTransparency = 1
				MouseInS = false
			end)

			UIS.InputBegan:Connect(function(Input) 
				if Input.UserInputType == Enum.UserInputType.MouseButton1 and MouseInS then
					Callback()
				end
			end)


		end,

		AddToggleChild = function(TitleText: string, Callback, DefaultValue: boolean)
			local ChildFrame = Instance.new("Frame", ContentFrame)
			local Tweens = {}
			local On = false



			ChildFrame.Size = UDim2.new(1.0, 0, 0, 30)
			ChildFrame.BackgroundColor3 = CurrentTheme.Background2
			ChildFrame.BorderSizePixel = 0
			ChildFrame.BackgroundColor3 = CurrentTheme.Background1
			ChildFrame.BackgroundTransparency = 1

			local Title = Instance.new("TextLabel", ChildFrame)

			Title.BackgroundTransparency = 1
			Title.Text = TitleText
			Title.Size = UDim2.fromScale(1.0, 1.0)
			Title.Font = Enum.Font.Ubuntu
			Title.TextSize = FontSize
			Title.TextColor3 = CurrentTheme.Text0

			local Indicator = Instance.new("Frame", ChildFrame)

			Indicator.Size = UDim2.fromScale(1.0, 0.1)
			Indicator.Position = UDim2.fromScale(0.0, 1.0)
			Indicator.AnchorPoint = Vector2.new(0, 1)

			if DefaultValue then
				Indicator.BackgroundColor3 = Color3.fromRGB(38, 255, 0)
			else
				Indicator.BackgroundColor3 = Color3.fromRGB(255, 0, 34)
			end

			local MouseInS = false

			ChildFrame.MouseEnter:Connect(function()
				ChildFrame.BackgroundTransparency = 0
				MouseInS = true
			end)

			ChildFrame.MouseLeave:Connect(function()
				ChildFrame.BackgroundTransparency = 1
				MouseInS = false
			end)

			UIS.InputBegan:Connect(function(Input) 
				if Input.UserInputType == Enum.UserInputType.MouseButton1 and MouseInS then
					On = not On
					Callback(On)
				end

				if On then
					for i,v in pairs(Tweens) do
						v:Cancel()
					end
					table.clear(Tweens)

					local Tween = TweenService:Create(Indicator, TweenInformation, {BackgroundColor3 = Color3.fromRGB(38, 255, 0)})
					Tween:Play()


					Tweens[#Tweens + 1] = Tween
				else
					for i,v in pairs(Tweens) do
						v:Cancel()
					end
					table.clear(Tweens)

					local Tween = TweenService:Create(Indicator, TweenInformation, {BackgroundColor3 = Color3.fromRGB(255, 0, 34)})
					Tween:Play()


					Tweens[#Tweens + 1] = Tween
				end
			end)

			return {
				GetValue = function()
					return On
				end,
			}
		end,
	}
end
return Lib
