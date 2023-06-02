_G["BotPath"] = "D:/Creative Stuff/RDifacts/RDifacts BOT/RDifacts/" -- NOTE: PLEASE CHANGE BotPath AND ["path"] WHEN THE BOTS FILE PLACEMENT IS TAMPERED WITH

-----------------------------------------------------------------------------------------LIBS+STUFF---
_G["discordia"] = require("discordia") require("discordia-components") require("discordia-interactions")--lua discord powers
_G["Components"] = discordia.Components
discordia.extensions()
_G["fs"] = require("fs")
_G["client"] = discordia.Client()
_G["json"] = require("libraries/json") --json powers
_G["imagevips"] = require("deps/vips")
_G["prefix"] = "r$" --prefix
_G["scandir"] = function (PATH)
return fs.readdirSync(PATH) end

_G["Cmd"] = {}

dofile("libraries/secondstoclock.lua")
dofile("libraries/messagecheck.lua")
dofile("libraries/profileshenanigans.lua")

print("essentials loaded!")
------------------------------------------------------------------------------------ARTIFACT SYSTEM---
_G["JSONITEMLIST"] = io.open(BotPath.."ITEMLIST.json","r")
_G["JSONITEMS"] = json.decode(io.input(JSONITEMLIST):read("*a"))
_G["KEYNAMETABLE"] = {} --turn the entire ITEMLIST.json into a readable table

for k,v in pairs(JSONITEMS) do
    KEYNAMETABLE[#KEYNAMETABLE+1] = k; --lua is NOT 0-indexed, meaning it counts from 1 instead of 0
    --print(k,v)
end
table.sort(KEYNAMETABLE, function(a, b) return JSONITEMS[a][4] < JSONITEMS[b][4] end) --numerically sorts the entire jsonitemlist in order by id    

JSONITEMLIST:close()

print("artifact system loaded!")

-- KEYNAMES is just the table full of the artifacts table keynames, they do not contain actual info inside
--ex: JSONITEMS[KEYNAMES[1]]["Worn Dagger", <emoji>, id, grade, desc]
--[1] is the first index number of ITEMLIST, which brings up WornDagger

--------------------------------------------------------------------------------------COOLDOWNS-------
_G["ADVCOOLDOWN"] = 1000 -- adventure cooldown
_G["DKCOOLDOWN"] = 60 -- daily key cooldown
_G["GKCOOLDOWN"] = 30 -- gift key cooldown

print("cooldowns loaded!")
----------------------------------------------------------------------------------------EMOJIS--------
--stats
_G["MenuCAPSULE"] = "<:Capsule:1099963484004950046>"
_G["MenuKEY"] = "<:Key:1099963487125520414>"
_G["MenuEMBLEM"] = "<:Emblem:1099963488908103760>"
_G["MenuMARBLE"] = "<:Marble:1099963706114330705>"
_G["MenuMATERIAL"] = "<:Material:1099963709364903956>"
_G["MenuINGREDIENT"] = "<:Ingredient:1099963711298482288>"
_G["MenuSTARTONIC"] = "<:StarTonic:1099964149972353034>"
_G["MenuGIFTKEY"] = "<:GiftKey:1099964153382326272>"
--actions
_G["MenuC"] = "<:Cook:1099964254880288781>"
_G["MenuADV"] = "<:Adventure:1099964256801263628>"
_G["MenuI"] = "<:Inspect:1099964689829593099>"
_G["MenuMINE"] = "<:Mine:1099964693734494308>"
_G["MenuCD"] = "<:Cooldowns:1099964695466745947>"
_G["MenuM"] = "<:Museum:1099964724151582750>"
_G["MenuHELP"] = "<:Help:1099964727725142078>"
_G["MenuSH"] = "<:Shop:1099964730673729599>"
_G["MenuTALK"] = "<:Talk:1099964785669439528>"
--origin
_G["MenuOr1"] = "<:OriginalOrigin:1099964838853214268>"
_G["MenuOr2"] = "<:CustomLevelOrigin:1099964958814511114>"
_G["MenuOr3"] = "<:GameOrigin:1099964791155605554>"
_G["MenuOr4"] = "<:MemoryOrigin:1099964834851868742>"
_G["MenuOr5"] = "<:MediaOrigin:1099964840602259477>"
----------------------------------------------------------------------------------------READY---------
client:on("ready", function() 
    print("Logged in as ".. client.user.username)
end)

client:on("messageCreate", function(message) --handles message
    if message.author.bot then
        return
    else
        MessageCheck(message, message.content)
    end
end
)

-----------------------------------------------------------------------------
local testimage = imagevips.Image.text("Hello <i>World!</i>", { dpi = 300 })
print("writing to test.png ...")
testimage:write_to_file("test.png")
-----------------------------------------------------------------------------
print("running!!!!")
client:run("Bot OTYzNzA2NjQwOTk2MTIyNjU0.GsYDjs.EPtWkBP2XfHuwT1w_6PU40P-6xM4lbKZccw2BI")
-----------------------------------------------------------------------------

--guilds are servers, nothing else.
--unix time = a second [1], a minute [60], an hour[3600]
--if you ever change computers change profile pathing immediately

--main.lua is the root. every file within it is able to be reached without being specified of the pathing

--ipairs goes through an indexed table, i stands for iteration, works for tables of data that does not have keys related for each data piece
--for i, v in ipairs

--pairs goes through a non indexed table, works for data that already has keys attached to each data piece
--for k, v in pairs

--dofile executes all the code inside a directed file!
--you can input another variables data in a new variable! ex: apron[foods]
--using return ends the function

--returns seem to break if you dont give it an end when theres more lines of code after

--discordia button styles = 
-- primary = blue, secondary = gray, success = green, danger = red, 5 = link, 6 = emoji