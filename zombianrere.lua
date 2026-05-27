--[[ 
    PREMIUM CYBERPUNK KEY SYSTEM 2026 - PINK NEON EDITION
    Cấu hình Script: Survive Zombie Arena | Giao diện: Pink Neon Style
]]

local Config_URL = "https://raw.githubusercontent.com/Bubu2k/config.txt/refs/heads/main/config.txt" 
local File_Name = "EclipseKeyCache.txt" -- Tên file lưu trữ key trong thư mục workspace

---------------------------------------------------------
-- HỆ THỐNG TỰ ĐỘNG TẢI DỮ LIỆU CHỦ
---------------------------------------------------------
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local fetchedLink = "https://funlink.io/Pu_s2wc" -- Dự phòng
local fetchedKey = "vietnam76" -- Dự phòng

local success, response = pcall(function()
    return game:HttpGet(Config_URL)
end)

if success and response then
    local lines = {}
    for line in string.gmatch(response, "[^\r\n]+") do
        table.insert(lines, line)
    end
    if lines[1] then fetchedLink = string.gsub(lines[1], "%s+", "") end
    if lines[2] then fetchedKey = string.gsub(lines[2], "%s+", "") end
end

---------------------------------------------------------
-- HÀM KÍCH HOẠT SCRIPT CHÍNH CỦA BẠN
---------------------------------------------------------
local function ExecuteMainScript()
    local loadSuccess, err = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/SharkCreepy/Survive-Zombie-Arena/refs/heads/main/script.luao"))()
    end)
    
    if not loadSuccess then
        warn("Lỗi Script Survive Zombie Arena: " .. tostring(err))
    end
end

---------------------------------------------------------
-- KIỂM TRA CHỨC NĂNG LƯU KEY TỰ ĐỘNG (AUTO LOGIN)
---------------------------------------------------------
if readfile and isfile and isfile(File_Name) then
    local savedKey = readfile(File_Name)
    if savedKey == fetchedKey then
        -- Nếu key đã lưu trùng khớp với key server, tự động chạy luôn không hiện UI
        ExecuteMainScript()
        return 
    end
end

---------------------------------------------------------
-- KHỞI TẠO GIAO DIỆN CHUẨN (TONE HỒNG NEON CYBERPUNK)
---------------------------------------------------------
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "EclipseKeySystem_v3"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 8, 12) -- Nền tối ánh tím hồng
MainFrame.BackgroundTransparency = 0.08
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 350, 0, 230)

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 24)
UICorner.Parent = MainFrame

-- Đổ bóng Hồng Neon rực rỡ
local DropShadow = Instance.new("ImageLabel")
DropShadow.Name = "DropShadow"
DropShadow.Parent = MainFrame
DropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
DropShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
DropShadow.Size = UDim2.new(1, 60, 1, 60)
DropShadow.BackgroundTransparency = 1
DropShadow.Image = "rbxassetid://6015897843"
DropShadow.ImageColor3 = Color3.fromRGB(255, 20, 147) -- Deep Pink Neon
DropShadow.ImageTransparency = 0.4
DropShadow.ZIndex = MainFrame.ZIndex - 1

local UIStroke = Instance.new("UIStroke")
UIStroke.Parent = MainFrame
UIStroke.Thickness = 3
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke.Color = Color3.fromRGB(255, 255, 255)

-- Gradient viền Hồng Neon chuyển sắc
local UIGradient = Instance.new("UIGradient")
UIGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 127)),   -- Hồng Neon
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(40, 0, 20)),   -- Tím Hồng Tối
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 105, 180))  -- Hot Pink
}
UIGradient.Parent = UIStroke

local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Text = "SECURE ACCESS"
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 20
Title.Size = UDim2.new(1, 0, 0, 60)
Title.BackgroundTransparency = 1

local KeyInput = Instance.new("TextBox")
KeyInput.Parent = MainFrame
KeyInput.PlaceholderText = "Nhập mã key truy cập..."
KeyInput.Text = ""
KeyInput.BackgroundColor3 = Color3.fromRGB(22, 16, 22)
KeyInput.BackgroundTransparency = 0.2
KeyInput.Position = UDim2.new(0.08, 0, 0.33, 0)
KeyInput.Size = UDim2.new(0.84, 0, 0, 45)
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.Font = Enum.Font.GothamSemibold
KeyInput.TextSize = 14

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 12)
InputCorner.Parent = KeyInput

local InputStroke = Instance.new("UIStroke")
InputStroke.Parent = KeyInput
InputStroke.Thickness = 1.5
InputStroke.Color = Color3.fromRGB(255, 0, 127)
InputStroke.Transparency = 0.6

local CopyBtn = Instance.new("TextButton")
CopyBtn.Parent = MainFrame
CopyBtn.Text = "GET KEY LINK"
CopyBtn.Font = Enum.Font.GothamBold
CopyBtn.TextSize = 12
CopyBtn.BackgroundColor3 = Color3.fromRGB(24, 14, 20)
CopyBtn.TextColor3 = Color3.fromRGB(255, 105, 180)
CopyBtn.Position = UDim2.new(0.08, 0, 0.60, 5)
CopyBtn.Size = UDim2.new(0.84, 0, 0, 32)

local CopyCorner = Instance.new("UICorner")
CopyCorner.CornerRadius = UDim.new(0, 10)
CopyCorner.Parent = CopyBtn

local SubmitBtn = Instance.new("TextButton")
SubmitBtn.Parent = MainFrame
SubmitBtn.Text = "ACTIVATE SCRIPT"
SubmitBtn.Font = Enum.Font.GothamBold
SubmitBtn.TextSize = 14
SubmitBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 127)
SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitBtn.Position = UDim2.new(0.08, 0, 0.79, 10)
SubmitBtn.Size = UDim2.new(0.84, 0, 0, 40)

local SubmitCorner = Instance.new("UICorner")
SubmitCorner.CornerRadius = UDim.new(0, 14)
SubmitCorner.Parent = SubmitBtn

---------------------------------------------------------
-- HỆ THỐNG KÉO THẢ MƯỢT MÀ
---------------------------------------------------------
local dragging, dragInput, dragStart, startPos
local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then update(input) end
end)

---------------------------------------------------------
-- HIỆU ỨNG THÔNG BÁO & HOVER MÀU HỒNG
---------------------------------------------------------
local function PlayHover(button, colorIn, sizeIn, colorOut, sizeOut)
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = colorIn, Size = sizeIn}):Play()
    end)
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = colorOut, Size = sizeOut}):Play()
    end)
end

PlayHover(CopyBtn, Color3.fromRGB(45, 20, 35), UDim2.new(0.86, 0, 0, 34), Color3.fromRGB(24, 14, 20), UDim2.new(0.84, 0, 0, 32))
PlayHover(SubmitBtn, Color3.fromRGB(190, 0, 95), UDim2.new(0.86, 0, 0, 42), Color3.fromRGB(255, 0, 127), UDim2.new(0.84, 0, 0, 40))

local function AdvancedNotify(msg, color)
    local NotifyGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
    local Box = Instance.new("Frame", NotifyGui)
    local Text = Instance.new("TextLabel", Box)
    
    Box.Size = UDim2.new(0, 280, 0, 45)
    Box.Position = UDim2.new(0.5, -140, 0, -50)
    Box.BackgroundColor3 = Color3.fromRGB(16, 12, 16)
    Box.BackgroundTransparency = 0.1
    
    local BC = Instance.new("UICorner", Box) BC.CornerRadius = UDim.new(0, 12)
    local S = Instance.new("UIStroke", Box) S.Color = color S.Thickness = 2
    
    Text.Size = UDim2.new(1, 0, 1, 0)
    Text.BackgroundTransparency = 1
    Text.Text = msg
    Text.TextColor3 = Color3.fromRGB(255, 255, 255)
    Text.Font = Enum.Font.GothamBold
    Text.TextSize = 13
    
    TweenService:Create(Box, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, -140, 0, 40)}):Play()
    task.wait(2.5)
    TweenService:Create(Box, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(0.5, -140, 0, -50)}):Play()
    task.wait(0.4)
    NotifyGui:Destroy()
end

---------------------------------------------------------
-- LOGIC TƯƠNG TÁC NÚT BẤM
---------------------------------------------------------
CopyBtn.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(fetchedLink)
        CopyBtn.Text = "COPIED URL!"
        AdvancedNotify("Đã sao chép link get key mới nhất!", Color3.fromRGB(255, 0, 127))
    else
        AdvancedNotify("Executor không hỗ trợ sao chép nhanh!", Color3.fromRGB(255, 0, 127))
    end
    task.wait(2)
    CopyBtn.Text = "GET KEY LINK"
end)

SubmitBtn.MouseButton1Click:Connect(function()
    local userKey = KeyInput.Text
    
    if userKey == fetchedKey then
        SubmitBtn.Text = "ACCESS GRANTED!"
        SubmitBtn.BackgroundColor3 = Color3.fromRGB(0, 220, 110)
        SubmitBtn.TextColor3 = Color3.fromRGB(8, 8, 12)
        
        -- TIẾN HÀNH LƯU KEY CHO LẦN SAU
        if writefile then
            pcall(function()
                writefile(File_Name, userKey)
            end)
        end
        
        -- Hiệu ứng ẩn UI mượt mà
        TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1}):Play()
        TweenService:Create(DropShadow, TweenInfo.new(0.3), {ImageTransparency = 1}):Play()
        task.wait(0.4)
        ScreenGui:Destroy()
        
        -- Chạy script chính Survive Zombie Arena
        ExecuteMainScript()
    else
        SubmitBtn.Text = "ACCESS DENIED!"
        SubmitBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 20)
        AdvancedNotify("Mã khóa không chính xác hoặc đã hết hạn!", Color3.fromRGB(255, 0, 127))
        task.wait(2)
        SubmitBtn.Text = "ACTIVATE SCRIPT"
        SubmitBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 127)
    end
end)
