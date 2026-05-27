--[[ 
    PREMIUM CYBERPUNK KEY SYSTEM 2026 - TEAL GREEN / CYAN EDITION
    Cấu hình Script: ĐÃ THAY ĐỔI SCRIPT CHÍNH (BUILD-A-RING-FARM)
]]

local Config_URL = "https://raw.githubusercontent.com/Bubu2k/config.txt/refs/heads/main/config.txt" 
local File_Name = "EclipseKeyCache.txt" -- Tên file lưu trữ key trong thư mục workspace
local New_Get_Key_Link = "https://neptunehub.shop/getkey" -- Link get key tự động sao chép khi kích hoạt thành công

---------------------------------------------------------
-- HỆ THỐNG TỰ ĐỘNG TẢI DỮ LIỆU CHỦ
---------------------------------------------------------
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local fetchedLink = "https://funlink.io/Pu_s2wc" -- Dự phòng cho nút GET KEY LINK ngoài giao diện
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
-- HÀM KÍCH HOẠT SCRIPT CHÍNH (ĐÃ ĐỔI SANG BUILD-A-RING-FARM)
---------------------------------------------------------
local function ExecuteMainScript()
    local loadSuccess, err = pcall(function()
        -- Thay thế script cũ bằng script mới của bạn tại đây
        loadstring(game:HttpGet("https://raw.githubusercontent.com/lamduck2005/RobloxScript/master/build-a-ring-farm.lua", true))()
    end)
    
    if not loadSuccess then
        warn("Lỗi Script Chính: " .. tostring(err))
    end
end

---------------------------------------------------------
-- HÀM HIỂN THỊ THÔNG BÁO TÙY CHỈNH (ĐÃ SỬA LỖI HIỂN THỊ CHỮ)
---------------------------------------------------------
local function AdvancedNotify(msg, color)
    local NotifyGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
    NotifyGui.Name = "EclipseNotification"
    NotifyGui.IgnoreGuiInset = true
    
    local Box = Instance.new("Frame", NotifyGui)
    local Text = Instance.new("TextLabel", Box)
    
    -- Khung thông báo tối ưu tỉ lệ mượt mà
    Box.Size = UDim2.new(0, 280, 0, 60)
    Box.Position = UDim2.new(0.5, -140, 0, -80)
    Box.BackgroundColor3 = Color3.fromRGB(8, 16, 20)
    Box.BackgroundTransparency = 0.1
    Box.ZIndex = 10
    
    local BC = Instance.new("UICorner", Box) BC.CornerRadius = UDim.new(0, 12)
    local S = Instance.new("UIStroke", Box) S.Color = color S.Thickness = 2.5
    
    -- Cấu hình chữ chống lỗi hiển thị trên điện thoại
    Text.Size = UDim2.new(1, -20, 1, -10)
    Text.Position = UDim2.new(0, 10, 0, 5)
    Text.BackgroundTransparency = 1
    Text.Text = msg
    Text.TextColor3 = Color3.fromRGB(255, 255, 255)
    
    -- SỬA LỖI TẠI ĐÂY: Dùng Font hệ thống cơ bản và tự động căn chỉnh kích thước chữ
    Text.Font = Enum.Font.SourceSansBold 
    Text.TextScaled = true -- Tự động co giãn chữ vừa khít màn hình điện thoại
    Text.ZIndex = 12 -- Đảm bảo chữ luôn nằm đè lên trên khung nền
    
    -- Thêm hiệu ứng bo viền nhẹ cho chữ nét hơn
    local TextStroke = Instance.new("UIStroke", Text)
    TextStroke.Thickness = 1
    TextStroke.Color = Color3.fromRGB(0, 0, 0)
    
    -- HIỆU ỨNG TRƯỢT XUỐNG CÁCH ĐỈNH 110 PIXEL (Tránh hoàn toàn tai thỏ)
    TweenService:Create(Box, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, -140, 0, 110)}):Play()
    
    task.wait(50) -- Hiển thị trong 50 giây
    
    -- HIỆU ỨNG ẨN
    TweenService:Create(Box, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(0.5, -140, 0, -80)}):Play()
    task.wait(0.4)
    NotifyGui:Destroy()
end

---------------------------------------------------------
-- KIỂM TRA CHỨC NĂNG LƯU KEY TỰ ĐỘNG (AUTO LOGIN)
---------------------------------------------------------
if readfile and isfile and isfile(File_Name) then
    local savedKey = readfile(File_Name)
    if savedKey == fetchedKey then
        if setclipboard then
            setclipboard(New_Get_Key_Link)
        end
        
        task.spawn(function()
            AdvancedNotify("Đã tự động kích hoạt script! Link key của script đã sao chép.", Color3.fromRGB(0, 255, 150))
        end)
        
        ExecuteMainScript()
        return 
    end
end

---------------------------------------------------------
-- KHỞI TẠO GIAO DIỆN CHUẨN (MÀU XANH NEON / TEAL)
---------------------------------------------------------
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "EclipseKeySystem_v3"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(6, 11, 15)
MainFrame.BackgroundTransparency = 0.08
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = UDim2.new(0, 350, 0, 230)

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 24)
UICorner.Parent = MainFrame

local DropShadow = Instance.new("ImageLabel")
DropShadow.Name = "DropShadow"
DropShadow.Parent = MainFrame
DropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
DropShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
DropShadow.Size = UDim2.new(1, 60, 1, 60)
DropShadow.BackgroundTransparency = 1
DropShadow.Image = "rbxassetid://6015897843"
DropShadow.ImageColor3 = Color3.fromRGB(0, 230, 180)
DropShadow.ImageTransparency = 0.5
DropShadow.ZIndex = MainFrame.ZIndex - 1

local UIStroke = Instance.new("UIStroke")
UIStroke.Parent = MainFrame
UIStroke.Thickness = 3
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke.Color = Color3.fromRGB(255, 255, 255)

local UIGradient = Instance.new("UIGradient")
UIGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 200)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 40, 50)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 180, 255))
}
UIGradient.Parent = UIStroke

local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Text = "SECURE ACCESS"
Title.Font = Enum.Font.SourceSansBold
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 20
Title.Size = UDim2.new(1, 0, 0, 60)
Title.BackgroundTransparency = 1

local KeyInput = Instance.new("TextBox")
KeyInput.Parent = MainFrame
KeyInput.PlaceholderText = "Nhập mã key truy cập..."
KeyInput.Text = ""
KeyInput.BackgroundColor3 = Color3.fromRGB(11, 20, 26)
KeyInput.BackgroundTransparency = 0.2
KeyInput.Position = UDim2.new(0.08, 0, 0.33, 0)
KeyInput.Size = UDim2.new(0.84, 0, 0, 45)
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.Font = Enum.Font.SourceSansBold
KeyInput.TextSize = 14

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 12)
InputCorner.Parent = KeyInput

local InputStroke = Instance.new("UIStroke")
InputStroke.Parent = KeyInput
InputStroke.Thickness = 1.5
InputStroke.Color = Color3.fromRGB(0, 240, 200)
InputStroke.Transparency = 0.6

local CopyBtn = Instance.new("TextButton")
CopyBtn.Parent = MainFrame
CopyBtn.Text = "GET KEY LINK"
CopyBtn.Font = Enum.Font.SourceSansBold
CopyBtn.TextSize = 12
CopyBtn.BackgroundColor3 = Color3.fromRGB(12, 24, 26)
CopyBtn.TextColor3 = Color3.fromRGB(100, 255, 220)
CopyBtn.Position = UDim2.new(0.08, 0, 0.60, 5)
CopyBtn.Size = UDim2.new(0.84, 0, 0, 32)

local CopyCorner = Instance.new("UICorner")
CopyCorner.CornerRadius = UDim.new(0, 10)
CopyCorner.Parent = CopyBtn

local SubmitBtn = Instance.new("TextButton")
SubmitBtn.Parent = MainFrame
SubmitBtn.Text = "ACTIVATE SCRIPT"
SubmitBtn.Font = Enum.Font.SourceSansBold
SubmitBtn.TextSize = 14
SubmitBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 160)
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
-- HIỆU ỨNG HOVER NÚT BẤM
---------------------------------------------------------
local function PlayHover(button, colorIn, sizeIn, colorOut, sizeOut)
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = colorIn, Size = sizeIn}):Play()
    end)
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = colorOut, Size = sizeOut}):Play()
    end)
end

PlayHover(CopyBtn, Color3.fromRGB(18, 38, 40), UDim2.new(0.86, 0, 0, 34), Color3.fromRGB(12, 24, 26), UDim2.new(0.84, 0, 0, 32))
PlayHover(SubmitBtn, Color3.fromRGB(0, 210, 180), UDim2.new(0.86, 0, 0, 42), Color3.fromRGB(0, 180, 160), UDim2.new(0.84, 0, 0, 40))

---------------------------------------------------------
-- LOGIC TƯƠNG TÁC KHI NHẬP KEY THỦ CÔNG
---------------------------------------------------------
CopyBtn.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(fetchedLink)
        CopyBtn.Text = "COPIED URL!"
        AdvancedNotify("Đã sao chép link get key cấu hình!", Color3.fromRGB(0, 240, 200))
    else
        AdvancedNotify("Executor không hỗ trợ sao chép nhanh!", Color3.fromRGB(220, 50, 50))
    end
    task.wait(2)
    CopyBtn.Text = "GET KEY LINK"
end)

SubmitBtn.MouseButton1Click:Connect(function()
    local userKey = KeyInput.Text
    
    if userKey == fetchedKey then
        SubmitBtn.Text = "ACCESS GRANTED!"
        SubmitBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 150)
        SubmitBtn.TextColor3 = Color3.fromRGB(6, 11, 15)
        
        if writefile then
            pcall(function()
                writefile(File_Name, userKey)
            end)
        end
        
        if setclipboard then
            setclipboard(New_Get_Key_Link)
        end
        
        task.spawn(function()
            AdvancedNotify("Đã kích hoạt script! Link key của script đã sao chép.", Color3.fromRGB(0, 255, 150))
        end)
        
        TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1}):Play()
        TweenService:Create(DropShadow, TweenInfo.new(0.3), {ImageTransparency = 1}):Play()
        task.wait(0.4)
        ScreenGui:Destroy()
        
        ExecuteMainScript()
    else
        SubmitBtn.Text = "ACCESS DENIED!"
        SubmitBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
        AdvancedNotify("Mã khóa không chính xác hoặc đã hết hạn!", Color3.fromRGB(220, 50, 50))
        task.wait(2)
        SubmitBtn.Text = "ACTIVATE SCRIPT"
        SubmitBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 160)
    end
end)
