-- =============================================================================
-- BINN HUB: MAIN LOADER (BOOTSTRAPPER) - CRE: DANG NGUYEN THIEN PHUC
-- BRAND COLOR: DARK GREEN / EMERALD EDITION (OPTIMIZED & FIXED)
-- =============================================================================

local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- Tự động dọn dẹp bản cũ nếu sếp chạy lại Loader
if CoreGui:FindFirstChild("BinnHub-MainLoader") then
    CoreGui["BinnHub-MainLoader"]:Destroy()
end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "BinnHub-MainLoader"
ScreenGui.ResetOnSpawn = false

-- TÔNG MÀU THƯƠNG HIỆU MỚI (XANH LÁ ĐẬM & XANH NEON)
local BrandColor = Color3.fromRGB(0, 180, 70) 
local DarkGreen = Color3.fromRGB(0, 100, 35)   

-- [1. KHUNG CHÍNH - MAIN FRAME]
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.fromOffset(360, 280)
Main.Position = UDim2.new(0.5, -180, 0.5, -140)
Main.BackgroundColor3 = Color3.fromRGB(12, 16, 13) 
Main.Active = true
Main.ClipsDescendants = true

local MainCorner = Instance.new("UICorner", Main)
MainCorner.CornerRadius = UDim.new(0, 10)

local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Color = DarkGreen
MainStroke.Thickness = 2

-- HÀM KÉO THẢ MƯỢT MÀ CHUYÊN NGHIỆP (THAY THẾ DRAGGABLE)
local dragStart, startPos
local function updateInput(input)
    local delta = input.Position - dragStart
    Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end
Main.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragStart = input.Position
        startPos = Main.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragStart = nil end
        end)
    end
end)
Main.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        if dragStart then updateInput(input) end
    end
end)

-- [2. TIÊU ĐỀ LOADER]
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 45)
Title.Text = "BINN HUB | SYSTEM LOADER"
Title.TextColor3 = BrandColor
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.BackgroundTransparency = 1
Title.TextXAlignment = Enum.TextXAlignment.Center

local SubTitle = Instance.new("TextLabel", Main)
SubTitle.Size = UDim2.new(1, 0, 0, 20)
SubTitle.Position = UDim2.new(0, 0, 0, 35)
SubTitle.Text = "Welcome back, Boss! Choose your script:"
SubTitle.TextColor3 = Color3.fromRGB(150, 165, 155)
SubTitle.Font = Enum.Font.GothamItalic
SubTitle.TextSize = 11
SubTitle.BackgroundTransparency = 1

-- Nút gạch ngang để thu nhỏ
local MinimizeBtn = Instance.new("TextButton", Main)
MinimizeBtn.Name = "MinimizeBtn"
MinimizeBtn.BackgroundTransparency = 1
MinimizeBtn.Position = UDim2.new(1, -30, 0, 10)
MinimizeBtn.Size = UDim2.fromOffset(20, 20)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.Text = "—"
MinimizeBtn.TextColor3 = BrandColor
MinimizeBtn.TextSize = 12

-- NÚT THU NHỎ TRÒN (TOGGLE BUTTON)
local ToggleButton = Instance.new("TextButton", ScreenGui)
ToggleButton.Name = "ToggleButton"
ToggleButton.BackgroundColor3 = Color3.fromRGB(15, 22, 17)
ToggleButton.Position = UDim2.new(0.02, 0, 0.2, 0)
ToggleButton.Size = UDim2.fromOffset(50, 50)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.Text = "BINN"
ToggleButton.TextColor3 = BrandColor
ToggleButton.TextSize = 12
ToggleButton.Visible = false

local ToggleCorner = Instance.new("UICorner", ToggleButton)
ToggleCorner.CornerRadius = UDim.new(1, 0)

local ToggleStroke = Instance.new("UIStroke", ToggleButton)
ToggleStroke.Color = BrandColor
ToggleStroke.Thickness = 1.5

local isTweening = false
MinimizeBtn.MouseButton1Click:Connect(function()
    if isTweening then return end
    isTweening = true
    Main:TweenSize(UDim2.fromOffset(360, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.3, true, function()
        Main.Visible = false
        ToggleButton.Visible = true
        isTweening = false
    end)
end)

ToggleButton.MouseButton1Click:Connect(function()
    if isTweening then return end
    isTweening = true
    ToggleButton.Visible = false
    Main.Visible = true
    Main:TweenSize(UDim2.fromOffset(360, 280), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.3, true, function()
        isTweening = false
    end)
end)

-- Kéo thả nút tròn
local dragToggle, dragStartToggle, startPosToggle
ToggleButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragToggle = true dragStartToggle = input.Position startPosToggle = ToggleButton.Position
        input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragToggle = false end end)
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragToggle and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStartToggle
        ToggleButton.Position = UDim2.new(startPosToggle.X.Scale, startPosToggle.X.Offset + delta.X, startPosToggle.Y.Scale, startPosToggle.Y.Offset + delta.Y)
    end
end)

-- [3. HÀM LOGIC KHI BẤM NÚT (KHỞI CHẠY SCRIPT)]
local function LaunchScript(name, link)
    Main.Visible = false -- Ẩn giao diện đi trước để tạo cảm giác mượt mà
    ToggleButton.Visible = false
    
    task.spawn(function()
        local delayTime = math.random(1, 2) -- Giảm bớt delay cho sếp đỡ đợi lâu
        print("[BINN LOADER] Đang kích hoạt " .. name .. "...")
        task.wait(delayTime)
        
        -- Chạy script chính thành công
        local success, err = pcall(function()
            loadstring(game:HttpGet(link))()
        end)
        
        if success then
            ScreenGui:Destroy() -- Chỉ hủy Loader Mẹ sau khi script con đã được kích hoạt thành công!
        else
            warn("[BINN LOADER] Lỗi khi tải script: " .. tostring(err))
            Main.Visible = true -- Nếu lỗi thì hiện lại bảng để chọn bản khác
        end
    end)
end

-- [4. HÀM TẠO NÚT CHỌN BẢN SCRIPT]
local ButtonContainer = Instance.new("Frame", Main)
ButtonContainer.Size = UDim2.new(1, 0, 1, -70)
ButtonContainer.Position = UDim2.new(0, 0, 0, 70)
ButtonContainer.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout", ButtonContainer)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Padding = UDim.new(0, 12)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local function CreateMenuButton(text, subText, order, callback)
    local btn = Instance.new("TextButton", ButtonContainer)
    btn.Size = UDim2.new(0.88, 0, 0, 45)
    btn.BackgroundColor3 = Color3.fromRGB(22, 28, 24) 
    btn.Text = ""
    btn.LayoutOrder = order
    
    local btnCorner = Instance.new("UICorner", btn)
    btnCorner.CornerRadius = UDim.new(0, 6)
    
    local mainText = Instance.new("TextLabel", btn)
    mainText.Size = UDim2.new(1, 0, 0.6, 0)
    mainText.Position = UDim2.new(0, 0, 0.1, 0)
    mainText.Text = text
    mainText.TextColor3 = Color3.new(1, 1, 1)
    mainText.Font = Enum.Font.GothamBold
    mainText.TextSize = 14
    mainText.BackgroundTransparency = 1
    
    local detailText = Instance.new("TextLabel", btn)
    detailText.Size = UDim2.new(1, 0, 0.4, 0)
    detailText.Position = UDim2.new(0, 0, 0.55, 0)
    detailText.Text = subText
    detailText.TextColor3 = Color3.fromRGB(120, 135, 125)
    detailText.Font = Enum.Font.Gotham
    detailText.TextSize = 10
    detailText.BackgroundTransparency = 1

    -- Hiệu ứng Hover chuột
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = DarkGreen}):Play()
        TweenService:Create(mainText, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(150, 255, 180)}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(22, 28, 24)}):Play()
        TweenService:Create(mainText, TweenInfo.new(0.2), {TextColor3 = Color3.new(1, 1, 1)}):Play()
    end)
    
    btn.MouseButton1Click:Connect(callback)
end

-- =============================================================================
-- // CẤU HÌNH ĐƯỜNG DẪN 3 BẢN SCRIPT CỦA SẾP
-- =============================================================================

CreateMenuButton("🍀 BINN TỔNG HỢP (V2.1)", "Multi-Games Menu (Blox Fruits, Garden, 99 Night...)", 1, function()
    LaunchScript("Binn Tổng Hợp", "https://raw.githubusercontent.com/Binn-nguyen/Binn-TongHop/refs/heads/main/TongHop-V2.1.lua")
end)

CreateMenuButton("🍌 BINN BANANA HUB", "Custom Edition - Specialized for Blox Fruits", 2, function()
    LaunchScript("Binn Banana Hub", "https://raw.githubusercontent.com/Binn-nguyen/Banana-Hub/refs/heads/main/Phucdepzai-Banana.lua")
end)

CreateMenuButton("👑 BINN Redz remake", "Advanced Features & Ultimate Optimization", 3, function()
    LaunchScript("Binn Premium", "https://raw.githubusercontent.com/Binn-nguyen/Binn-redz/refs/heads/main/LuaCrack.lua")
end)
