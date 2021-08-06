local module = {
    Commands = {
        test = {
            aliases = {"testcmd"},
            func = function()
                return pcall(function()
                    print("Hello")
                end)
            end
        }
    }
}

module.findintable = function(tbl,value)
    for _,v in pairs(tbl) do
        if v == value then
            return true
        end
    end
    return false
end

module.listcommands = function()
    local list = ""
    for i,v in pairs(module.Commands) do
        list = list .. tostring(i) .. " | aliases: " .. table.concat(v.alises,", ") .. "\n"
    end
    rconsoleprint("Commands:\n")
    rconsoleprint(list)
    rconsoleprint("\n")
end

module.Commands.cmds = {
    aliases = {"commands"},
    func = module.listcommands
}

module.handle = function(command,args)
    command = tostring(command)
    local cmd = nil 
    for i,v in pairs(module.Commands) do
        if i == command or module.findintable(v.aliases,command) then
            cmd = v.func
        end
    end

    if cmd then
        local suc,err = cmd(args)

        if not suc and err then
            rconsoleprint(string.format("Error happened whilst running command %s | Error: %s",command,err))
            return "error"
        end
    else
        rconsoleprint(string.format("The command %s does not exist!",command))
        return "error"
    end
end

return module