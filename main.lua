--[[
    Admin Commands with Console
    daily#3014
--]]

local player = game:GetService("Players").LocalPlayer
local executor = (syn and not is_sirhurt_closure and not pebc_execute and "Synapse") or (getexecutorname and identifyexecutor and import and "ScriptWare")
local settings = {}
local commands = nil
local functions = {}
local strings = {
    Color = nil,
    Colors = {
        ScriptWare = {
            Green = "green",
            Normal = "white",
        },
        Synapse = {
            Green = "@@GREEN@@",
            Normal = "@@LIGHT_GRAY@@",
        },
    }
}

local function getfile(filename)
    return game:HttpGet(string.format("https://raw.githubusercontent.com/DailyRBLX/CC/main/%s",filename))
end

local function consolesay(text,color)
    if executor == "Synapse" then
        rconsoleprint(color)
        rconsoleprint(text)
    elseif executor == "ScriptWare" then
        rconsoleprint(text,color)
    end
end

local function getinput()
    local args = {}
    local command = nil

    local message = rconsoleinput()
    local split = string.split(message," ")
    command = split[1]
    for i,v in pairs(split) do
        if i > 1 then
            table.insert(args,v)
        end
    end
    
    return command,args
end

local function consoleprefix()
    --consolesay("<",strings.Color.Green)
    --consolesay(player.Name,strings.Color.Green)
    consolesay(">",strings.Color.Normal)
    consolesay(" ",strings.Color.Normal)
end

--/ strings
if executor == "Synapse" then
    strings.Color = strings.Colors.Synapse
elseif executor == "ScriptWare" then
    strings.Color = strings.Colors.ScriptWare
else
    error("Your Exploit is not supported, sorry!")
end

--/ commands
if not isfolder("CC") then
    warn("CC folder does not exist! creating..")
    makefolder("CC")
end

if not isfile("CC/commands.lua") then
    warn("CC/commands.lua does not exist! creating..")
    writefile("CC/commands.lua",getfile("commands.lua"))
end

commands = loadfile("CC/commands.lua")()


--/ functions

local function newinput()
    local command,args = nil,nil

    consoleprefix()
    command,args = getinput()


    local result = commands.handle(command,args)
    if result and result == "error" then
        rconsoleprint("\n")
    end
    
    newinput()
end

--/ console
if executor == "ScriptWare" then
    rconsolecreate()
end
rconsoleprint("Script by daily#3014\n")
rconsoleprint("Type cmds for a list of commands!\n")
rconsoleprint("\n")
newinput()