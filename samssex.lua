-- Khởi chạy thư viện Rayfield UI
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Dịch vụ Roblox
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Tạo cửa sổ chính
local Window = Rayfield:CreateWindow({
    Name = "⚡ Cảnh Báo séx Sớm (Cứu Cây)",
    LoadingTitle = "Đang tải Script...",
    LoadingSubtitle = "Ultra-Early Detection System",
    ConfigurationSaving = {
        Enabled = false
    }
})

-- Tạo Tab chức năng
local MainTab = Window:CreateTab("Trạng Thái & Cảnh Báo", 4483363465)

-- Biến quản lý trạng thái & kết nối
local isEnabled = false
local sweepConnection = nil
local loopConnection = nil
local lastAlertTime = 0

-- Nhãn hiển thị trạng thái
local StatusLabel = MainTab:CreateLabel("⏱️ Trạng thái: Chưa kích hoạt")

-- Hàm phát cảnh báo siêu sớm (Trước 1-2 giây khi thông báo chính xuất hiện)
local function triggerEarlyLightningAlert(customMsg)
    local currentTime = tick()
    if currentTime - lastAlertTime < 3.5 then return end -- Cooldown 3.5 giây tránh spam
    lastAlertTime = currentTime

    -- Cập nhật trạng thái ngay lập tức
    StatusLabel:Set("⚠️ BÁO ĐỘNG SỚM: SÉT SẮP ĐÁNH TRONG 1-2 GIÂY TỚI!")
    
    -- Thông báo Rayfield khẩn cấp
    Rayfield:Notify({
        Title = "⚡ BÁO ĐỘNG ĐỎ (CẢNH BÁO SỚM 1-2S)!",
        Content = customMsg or "Thu hoạch ngay! Tín hiệu sét đã xuất hiện trước 1-2 giây!",
        Duration = 3,
        Image = 4483362458,
    })

    -- Trở lại trạng thái canh chừng sau 3 giây
    task.delay(3, function()
        if isEnabled then
            StatusLabel:Set("⏱️ Trạng thái: Đang canh chừng vòng tiếp theo...")
        end
    end)
end

-- Hàm kiểm tra vị trí xem có ở gần nhân vật/vườn cây không (Bán kính 85 studs)
local function isNearPlayer(object, maxDistance)
    maxDistance = maxDistance or 85
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then 
        return true 
    end

    local playerPos = LocalPlayer.Character.HumanoidRootPart.Position
    local objPos = nil

    if object:IsA("BasePart") then
        objPos = object.Position
    elseif object:IsA("Model") then
        objPos = object.PrimaryPart and object.PrimaryPart.Position or object:GetPivot().Position
    elseif object:IsA("Attachment") then
        objPos = object.WorldPosition
    end

    if objPos then
        return (playerPos - objPos).Magnitude <= maxDistance
    end
    return true
end

-- Bắt các mầm hiệu ứng sinh ra TRƯỚC khi tia sét hoặc thông báo chính xuất hiện
local function isEarlyLightningSignal(object)
    local name = string.lower(object.Name)
    local keywords = {
        "lightning", "strike", "warning", "thunder", "spark", "cloud", 
        "indicator", "redcircle", "danger", "target", "charge", "aura", 
        "flash", "electric", "pre_strike", "spawn"
    }
    
    for _, word in ipairs(keywords) do
        if string.find(name, word) then
            return true
        end
    end

    -- Kiểm tra cả các hạt Particle, Beam, Sound xuất hiện trước
    if object:IsA("ParticleEmitter") or object:IsA("Beam") or object:IsA("Highlight") or object:IsA("Sound") then
        local parentName = string.lower(object.Parent and object.Parent.Name or "")
        for _, word in ipairs(keywords) do
            if string.find(parentName, word) then
                return true
            end
        end
    end

    return false
end

-- Bắt đầu hệ thống theo dõi & đón đầu
local function startMonitoring()
    if sweepConnection then sweepConnection:Disconnect() end
    if loopConnection then task.cancel(loopConnection) end

    -- 1. Sử dụng DescendantAdded để bắt ngay mầm hiệu ứng nhỏ nhất vừa sinh ra trong Workspace
    sweepConnection = Workspace.DescendantAdded:Connect(function(child)
        if not isEnabled then return end
        
        if isEarlyLightningSignal(child) and isNearPlayer(child) then
            triggerEarlyLightningAlert("Sét sắp đánh xuống vùng cây gần bạn! Thu hoạch ngay trong 1-2 giây tới!")
        end
    end)

    -- 2. Quét liên tục với chu kỳ siêu nhanh (0.05 giây)
    loopConnection = task.spawn(function()
        while isEnabled do
            task.wait(0.05)
            
            for _, obj in ipairs(Workspace:GetChildren()) do
                if isEarlyLightningSignal(obj) and isNearPlayer(obj) then
                    triggerEarlyLightningAlert("Sét sắp đánh xuống vùng cây gần bạn! Thu hoạch ngay trong 1-2 giây tới!")
                    break
                end
            end
        end
    end)
end

-- Nút bật/tắt chế độ canh chừng
local Toggle = MainTab:CreateToggle({
    Name = "Kích hoạt cảnh báo sét",
    CurrentValue = false,
    Flag = "LightningAlertToggle",
    Callback = function(Value)
        isEnabled = Value
        if isEnabled then
            StatusLabel:Set("⏱️ Trạng thái: Đang canh chừng vòng tiếp theo...")
            startMonitoring()
        else
            StatusLabel:Set("⏱️ Trạng thái: Đã tắt canh chừng")
            if sweepConnection then
                sweepConnection:Disconnect()
                sweepConnection = nil
            end
            if loopConnection then
                task.cancel(loopConnection)
                loopConnection = nil
            end
        end
    end,
})
