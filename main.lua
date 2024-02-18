_G["BotPath"] = "D:/Creative Stuff/RDifacts/RDifacts BOT/RDifacts/"

-----------------------------------------------------------------------------------------LIBS+STUFF---
_G["discordia"] = require("discordia") require("discordia-components") require("discordia-interactions") require("discordia-slash").util.tools()--lua discord powers
_G["Components"] = discordia.Components

Key = io.open("Key.txt","r"):read("a")
print(Key)

discordia.extensions()

_G["fs"] = require("fs")
_G["client"] = discordia.Client():useApplicationCommands()
_G["json"] = require("libraries/json")
_G["imagevips"] = require("deps/vips")

_G["scandir"] = function (PATH)
return fs.readdirSync(PATH) end

_G["Cmd"] = {}

dofile("libraries/messagecheck.lua")
dofile("libraries/profileshenanigans.lua")
dofile("libraries/settings.lua")

print("essentials loaded!")

--------------------------------------------------------------------ARTIFACT DATA---
local ArtifactJson = io.open(BotPath.."ITEMLIST.json","r")
local ArtifactData = json.decode(io.input(ArtifactJson):read("*a"))
_G["ArtifactTable"] = {}

for i,v in ipairs(ArtifactData.Artifacts) do

    ArtifactTable[#ArtifactTable+1] = v;
    --print(i,v)
end

ArtifactJson:close()
_G["ArtifactPool"] = #ArtifactTable
----------------------------------------------------------------------------------------READY---------

client:on("ready", function() 
    print("Logged in as ".. client.user.username)
end)

---------------------------------------------------------------------MESSAGE HANDLER---------
client:on("messageCreate", function(message)
    if message.author.bot then
        return
    else
        MessageCheck(message, message.content)
    end
end
)

-----------------------------------------------------------------------------
--local testimage = imagevips.Image.text("Hello <i>World!</i>", { dpi = 300 })
--print("writing to test.png ...")
--testimage:write_to_file("test.png")


-----------------------------------------------------------------------------
print("running!!!!")
client:run(Key)
-----------------------------------------------------------------------------
