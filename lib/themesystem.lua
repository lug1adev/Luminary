--[[
    ##:::::::'##::::'##:'##::::'##:'####:'##::: ##::::'###::::'########::'##:::'##:
    ##::::::: ##:::: ##: ###::'###:. ##:: ###:: ##:::'## ##::: ##.... ##:. ##:'##::
    ##::::::: ##:::: ##: ####'####:: ##:: ####: ##::'##:. ##:: ##:::: ##::. ####:::
    ##::::::: ##:::: ##: ## ### ##:: ##:: ## ## ##:'##:::. ##: ########::::. ##::::
    ##::::::: ##:::: ##: ##. #: ##:: ##:: ##. ####: #########: ##.. ##:::::: ##::::
    ##::::::: ##:::: ##: ##:.:: ##:: ##:: ##:. ###: ##.... ##: ##::. ##::::: ##::::
    ########:. #######:: ##:::: ##:'####: ##::. ##: ##:::: ##: ##:::. ##:::: ##::::
    ........:::.......:::..:::::..::....::..::::..::..:::::..::..:::::..:::::..::::

    written by lug1a#0001
]]

-- // Additional Library
local fileSys = loadstring(game:HttpGet("https://raw.githubusercontent.com/lug1adev/Luminary/main/lib/filesystem.lua"))("lug1a#0001")
local utils = loadstring(game:HttpGet("https://raw.githubusercontent.com/lug1adev/Luminary/main/lib/utils.lua"))("lug1a#0001")

-- // Module Library
local lib = {
    hub = "Luminary",
    themes = {},
    currentTheme = nil,
    object = {
        frame = {},
        textlabel = {},
        imagelabel = {}
    },

    EasingSpeed = 0.25,
    EasingStyle = Enum.EasingStyle.Exponential,
    EasingDirection = Enum.EasingDirection.InOut
}

function endsWith(str, suffix)
    return str:sub(-#suffix) == suffix
end

function splitPath(path)
    local parts = {}
    for part in string.gmatch(path, "[^\\]+") do
        parts[#parts + 1] = part
    end

    local lastPart = parts[#parts]
    return lastPart
end

function getThemes()
    if isfolder(fileSys.makepath(lib.hub, "themes")) then
        local themes = listfiles(fileSys.makepath(lib.hub, "themes"))

        for i, v in pairs(themes) do
            if endsWith(v, ".json") then
                local succ, err = pcall(function()
                    return game:GetService("HttpService"):JSONDecode(v)                    
                end)

                if succ then
                    themes[splitPath(v)] = succ
                end
            end
        end
    end
end

function saveTheme()
    local currentTheme = lib.currentTheme
    local json, err
    if currentTheme then
        json, err = pcall(function()
            return game:GetService("HttpService"):JSONEncode(currentTheme)
        end)

        fileSys.writefile(fileSys.makepath(lib.hub, "themes", ".json"), json)
        getThemes()
    end
end

function updateTheme()
    local currentTheme = lib.currentTheme
    if currentTheme then
        for i, v in pairs(lib.object.frame) do
            utils.tween(i, {lib.EasingSpeed, lib.EasingStyle, lib.EasingDirection}, {
                BackgroundColor3 = v
            })
        end

        for i, v in pairs(lib.object.textlabel) do
            utils.tween(i, {lib.EasingSpeed, lib.EasingStyle, lib.EasingDirection}, {
                TextColor3 = v
            })
        end

        for i, v in pairs(lib.object.imagelabel) do
            utils.tween(i, {lib.EasingSpeed, lib.EasingStyle, lib.EasingDirection}, {
                ImageColor3 = v
            })
        end
    end
end

function setTheme(themeName) 
    local theme = lib.themes[themeName]
    if theme then
        lib.currentTheme = theme
    end
end

function registryObject(object : GuiObject, color)
    if object:IsA("Frame") then
        lib.object.frame[object] = color
    elseif object:IsA("TextLabel") then
        lib.object.textlabel[object] = color
    elseif object:IsA("ImageButton") or object:IsA("ImageLabel") then
        lib.object.imagelabel[object] = color
    end
end

return lib