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
    using Scraper's Proxy - https://rapidapi.com/scapers-proxy-scapers-proxy-default/api/scrapers-proxy2
]]

local lib = {
    api = "",
    key = "", 
    host = "",
    country = "",
    device = "",
}

function greatTable(tbl)
    for key, value in pairs(tbl) do
        if type(value) ~= "function" and value == "" or value == nil then
            return false 
        end
    end
    return true 
end

function proxyMask(url)
    if greatTable(lib) then
        local api = lib.api
        url = url or nil
        local key = lib.key
        local host = lib.host
        local country = lib.country
        local device = lib.device

        local params = "?url=%s&country=%s&device=%s"
        api = string.format(api .. params, url, country, device)

        local req = http.request({
            Url = api,
            Method = "GET",
            Headers = {
                ["X-RapidAPI-Key"] = key,
                ["X-RapidAPI-Host"] = host
            },
        })

        if not req.Success == false and req.StatusMessage == "Too Many Requests" then
            print("Retrying...")
            spawn(function()
                repeat
                    wait(1)
                    req = request({
                        Url = api,
                        Method = "GET",
                        Headers = {
                            ["X-RapidAPI-Key"] = key,
                            ["X-RapidAPI-Host"] = host
                        },
                    })
                until req.Success and not req.StatusMessage == "Too Many Requests"
            end) 
        end

        repeat wait() until req.Success
        return req.Body
    end

    return false
end

lib.request = proxyMask

return lib
