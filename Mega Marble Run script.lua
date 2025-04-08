-- made by MemorySofts team
local plr = game:GetService("Players").LocalPlayer
local GC = getconnections or get_signal_cons
if GC then
    for _,v in pairs(GC(plr.Idled)) do
        if v["Disable"] then
            v["Disable"](v)
        elseif v["Disconnect"] then
            v["Disconnect"](v)
        end
    end
else
    plr.Idled:Connect(function()
        local VirtualUser = game:GetService("VirtualUser")
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
end

for _,v in pairs(game.Workspace:GetChildren()) do
    if v.Name == "Anti-Block" then
        v:Destroy()
    end
end

function getRoot(char) return char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso') end

local g = {}
local defaults = {autofarm = false}
if getgenv then
    getgenv().n7 = defaults
    g = getgenv()
else
    g.n7 = defaults
    task.spawn(function()
        local m = Instance.new("Message", workspace)
        local txt = "MemorySofts | ВНИМАНИЕ\n\nВаш эксплоит НЕ поддерживает функцию getgenv!\nЭто может привести к обнаружению и возможному бану (не в этой игре и не с этим скриптом)\nMemorySofts будет загружен.\n\n"
        m.Text = txt
        for i = 15, 0, -1 do
            m.Text = txt .. i
            task.wait(1)
        end
        m:Destroy()
    end)
end

local Fluent = loadstring(game:HttpGet("https://twix.cyou/Fluent.txt", true))()

local Window = Fluent:CreateWindow({
    Title = "MemorySofts",
    SubTitle = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name,
    TabWidth = 30,
    Size = UDim2.fromOffset(370, 280),
    Acrylic = false,
    Theme = "Dark"
})

local Tabs = {
    Main = Window:AddTab({ Title = "Главная", Icon = "factory" }),
    Settings = Window:AddTab({ Title = "Настройки", Icon = "settings" }),
    Credits = Window:AddTab({ Title = "Кредиты", Icon = "person-standing" })
}

local autofarm = Tabs.Main:AddToggle("Автофарм", { Title = "Начать автофарм", Default = false })

autofarm:OnChanged(function(Value)
    g.n7.autofarm = Value
    
    while g.n7.autofarm do
        local char = plr.Character

        if char and getRoot(char) then
            getRoot(char).CFrame = workspace.Movers.Begining["Touch Me To Go to Spawn Area"].Head.CFrame
        end

        task.wait()
    end
end)

local UISection = Tabs.Settings:AddSection("Интерфейс")
UISection:AddDropdown("InterfaceTheme", {
    Title = "Тема",
    Values = Fluent.Themes,
    Default = Fluent.Theme,
    Callback = function(Value)
        Fluent:SetTheme(Value)
    end
})

UISection:AddToggle("TransparentToggle", {
    Title = "Прозрачность",
    Description = "Делает интерфейс прозрачным",
    Default = Fluent.Transparency,
    Callback = function(Value)
        Fluent:ToggleTransparency(Value)
    end
})

UISection:AddKeybind("MinimizeKeybind", { Title = "Клавиша минимизации", Description = "Изменить клавишу для минимизации", Default = "RightShift"})
Fluent.MinimizeKeybind = Fluent.Options.MinimizeKeybind

Tabs.Credits:AddParagraph({
    Title = "MemorySofts",
    Content = "Основной скрипт создан zepuxl"
})
if setclipboard then
    Tabs.Credits:AddButton({
        Title = "Скопировать ссылку на телеграм канал",
        Description = "Сообщество MemorySofts",
        Callback = function()
            setclipboard("https://t.me/MemorySofts")
        end
    })
else
    Tabs.Credits:AddButton({
        Title = "Уведомить о приглашении в Telegram",
        Description = "Сообщество MemorySofts",
        Callback = function()
            Fluent:Notify({
                Title = "https://t.me/MemorySofts",
                Content = "Приглашение в Telegram канал MemorySofts",
                Duration = 20
            })
        end
    })
end

Window:SelectTab(1)

Fluent:Notify({
    Title = "MemorySofts",
    Content = "Скрипт был запущен.",
    Duration = 8
})

repeat task.wait(0.5) until Fluent.Unloaded
g.n7 = nil