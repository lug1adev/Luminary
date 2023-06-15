--[[
    ##:::::::'##::::'##:'##::::'##:'####::::'###::::'########::'##:::'##:
    ##::::::: ##:::: ##: ###::'###:. ##::::'## ##::: ##.... ##:. ##:'##::
    ##::::::: ##:::: ##: ####'####:: ##:::'##:. ##:: ##:::: ##::. ####:::
    ##::::::: ##:::: ##: ## ### ##:: ##::'##:::. ##: ########::::. ##::::
    ##::::::: ##:::: ##: ##. #: ##:: ##:: #########: ##.. ##:::::: ##::::
    ##::::::: ##:::: ##: ##:.:: ##:: ##:: ##.... ##: ##::. ##::::: ##::::
    ########:. #######:: ##:::: ##:'####: ##:::: ##: ##:::. ##:::: ##::::
    ........:::.......:::..:::::..::....::..:::::..::..:::::..:::::..::::

    written by lug1a#0001
]]

local lib = {}

lib.makefolder = function(path)
    if not isfolder(path) then
        makefolder(path)
    end
end

lib.writefile = function(path, content)
    if not isfile(path) then
        writefile(path, content)
    else
        delfile(path)
    end
end

lib.listfiles = function(path)
    if isfolder(path) then
        return listfiles(path)
    else
        return false
    end
end

lib.delfolder = function(path)
    if isfolder(path) then
        delfolder(path)
    end
end

lib.delfile = function(path)
    if isfile(path) then
        delfile(path)
    end
end

lib.makepath = function(...)
    local args = ...;
    local path = ""

    table.foreach(args, function(i, v)
        path = (path == "") and v or (path .. "/" .. v)
    end)

    return path
end

return lib
