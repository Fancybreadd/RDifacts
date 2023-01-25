local BotPath = "D:/artte/Heartifacts REPOSITORY/Heartifacts/" -- NOTE: PLEASE CHANGE BotPath AND ["path"] WHEN THE BOTS FILE PLACEMENT IS TAMPERED WITH

-----------------------------------------------------------------------------------------LIBS+STUFF---
_G["discordia"] = require("discordia") require("discordia-components") require("discordia-interactions")--lua discord powers
_G["Components"] = discordia.Components
_G["fs"] = require("fs")
_G["client"] = discordia.Client()
_G["json"] = require("libraries/json") --json powers
_G["path"] = "D:/artte/Heartifacts REPOSITORY/Heartifacts/PROFILES/" --file path to savefiles
_G["imagevips"] = require("deps/vips")
_G["prefix"] = "h$" --prefix
_G["scandir"] = function (PATH)
return fs.readdirSync(PATH) end

discordia.extensions()

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
table.sort(KEYNAMETABLE, function(a, b) return JSONITEMS[a][3] < JSONITEMS[b][3] end) --numerically sorts the entire jsonitemlist in order by id    

JSONITEMLIST:close()

print("artifact system loaded!")

--ex: KEYNAMES["WornDagger":{}]
-- KEYNAMES are just the table full of the artifacts table keynames, they do not contain actual info inside
--ex: JSONITEMS[KEYNAMES[1]]["Worn Dagger", <emoji>, id, grade, desc]
--[1] is the first index number of ITEMLIST, which brings up WornDagger

---------------------------------------------------------------------------------ADVENTURING SYSTEM---
_G["SCENARIOLIST"] = io.open(BotPath.."AdventureSummary.json","r")
_G["SCENARIOS"] = json.decode(io.input(SCENARIOLIST):read("*a"))
_G["SCENARIOKEYNAMES"] = {}

    for k,v in pairs(SCENARIOS) do
        SCENARIOKEYNAMES[#SCENARIOKEYNAMES+1] = k;
        --print(k,v)
    end
SCENARIOLIST:close()

print("adventuring system loaded!")

-----------------------------------------------------------------------------------COOKING SYSTEM-----
_G["COOKSCENARIOLIST"] = io.open(BotPath.."CookingSummary.json","r")
_G["COOKRESULTS"] = json.decode(io.input(COOKSCENARIOLIST):read("*a"))
_G["COOKRESULTKEYNAMES"] = {}

    for k,v in pairs(COOKRESULTS) do
        COOKRESULTKEYNAMES[#COOKRESULTKEYNAMES+1] = k;
        --print(k,v)
    end
COOKSCENARIOLIST:close()

print("cooking system loaded!")


--------------------------------------------------------------------------------------COOLDOWNS-------
_G["ADVCOOLDOWN"] = 20 -- adventure cooldown (3600)
_G["DKCOOLDOWN"] = 10 -- daily key cooldown (3600)
_G["GKCOOLDOWN"] = 30 -- gift key cooldown (3600)

print("cooldowns loaded!")
----------------------------------------------------------------------------------------EMOJIS--------

_G["MENUCAPSULE"] = "<:test:1029983264997376031>"
_G["MENUKEY"] = "<:boxkey:974300640178221106>"
_G["MENUMARBLE"] = "<:marble:974315328106549248>"
_G["MENUMATERIAL"] = "n"
_G["MENUINGREDIENT"] = "n"
_G["MENUADV"] = "<:adventuring:974300665436340235>"
_G["MENUCOOK"] = "<:cookingknife:974357840359735296>"

client:on("ready", function() --READY UP
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
client:run("Bot OTYzNzA2NjQwOTk2MTIyNjU0.YlZ_wA.UjoXxszkTIiGUn0Xthv6fk-rdNQ")
-----------------------------------------------------------------------------

--guilds are servers, nothing else.
--unix time = a second [1], a minute [60], an hour[3600]
--if you ever change computers change profile pathing immediately

--message.author.mentionstring pings yourself! good to know.
--for empty brackets like function(), you can put any name in the brackets. It just serves as a placeholder for data
--main.lua is the root. every file within it is able to be reached without being specified of the pathing

--ipairs goes through an indexed table, i stands for iteration, works for tables of data that does not have keys related for each data piece
--for i, v in ipairs

--pairs goes through a non indexed table, works for data that already has kets attached to each data
--for k, v in pairs

--dofile executes all the code inside a directed file!
--you can input another variables data in a new variable! ex: apron[foods]
--using return ends the function

--returns seem to break if you dont give it an end when theres more lines of code after

--discordia button styles = 
-- 1 = blue 2 = gray 3 = green 4 = red 5 = link 6 = emoji