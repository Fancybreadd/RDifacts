local BotPath = "D:/artte/Heartifacts bot/"

_G['scandir'] = function (PATH)
    return fs.readdirSync(PATH)
end


---LIBS+STUFF---
_G["discordia"] = require('discordia-with-buttons')
_G["client"] = discordia.Client()
_G["json"] = require('libraries/json') --json powers
_G["unixseconds"] = require('libraries/secondstoclock')
_G["messagechecker"] = require('libraries/messagecheck')
_G['path'] = "D:/artte/Heartifacts bot/PROFILES/"
_G["prefix"] = "h$"

print('essentials loaded!')

---ARTIFACT SYSTEM---
_G['JSONITEMLIST'] = io.open(BotPath.."ITEMLIST.json","r")
_G['JSONITEMS'] = json.decode(io.input(JSONITEMLIST):read("*a"))
_G['KEYNAMETABLE'] = {} --turn the entire ITEMLIST.json into a readable table
            --ex: KEYNAMES["WornDagger":{}]
            -- KEYNAMES are just the table full of the artifacts table keynames, they do not contain actual info inside
              --ex: JSONITEMS[KEYNAMES[1]]["Worn Dagger", <emoji>, 1]
              --[1] is the first index number of ITEMLIST, which brings up WornDagger
              
            for k,v in pairs(JSONITEMS) do
                KEYNAMETABLE[#KEYNAMETABLE+1] = k; --lua is NOT 0-indexed, meaning it counts from 1 instead of 0
                --print(k,v)
            end

            table.sort(KEYNAMETABLE, function(a, b) return JSONITEMS[a][3] < JSONITEMS[b][3] end) --numerically sorts the entire jsonitemlist in order by id    

JSONITEMLIST:close()

print('artifact system loaded!')

---ADVENTURING SYSTEM---
_G['SCENARIOLIST'] = io.open(BotPath.."AdventureSummary.json","r")
_G['SCENARIOS'] = json.decode(io.input(SCENARIOLIST):read("*a"))
_G['SCENARIOKEYNAMES'] = {}

            for k,v in pairs(SCENARIOS) do
                SCENARIOKEYNAMES[#SCENARIOKEYNAMES+1] = k;
                print(k,v)
            end
SCENARIOLIST:close()

print('adventuring system loaded!')

---COOKING SYSTEM---
_G['COOKSCENARIOLIST'] = io.open(BotPath.."CookingSummary.json","r")
_G['COOKRESULTS'] = json.decode(io.input(COOKSCENARIOLIST):read("*a"))
_G['COOKRESULTKEYNAMES'] = {}
            
            for k,v in pairs(COOKRESULTS) do
                COOKRESULTKEYNAMES[#COOKRESULTKEYNAMES+1] = k;
                print(k,v)
            end
COOKSCENARIOLIST:close()

print('cooking system loaded!')

---COOLDOWNS---
_G['ADVCOOLDOWN'] = 3600 -- adventure cooldown 
_G['DKCOOLDOWN'] = 3600 -- daily key cooldown

print('cooldowns loaded!')
---COMMANDS---

--for i, v in ipairs(scandir("Commands")) do
    --local filename = string.sub(v,1,-5)
    --Command[filename] = dofile('Commands/'.. v)
--end

print ('all commands loaded!')

require ('Commands/ping')
----
require ('Commands/help')
----
require ('Commands/signup')
----
require ('Commands/profile')
----
require ('Commands/keys')
----
require ('Commands/boxes')
----
require ('Commands/dailykey')
----
require ('Commands/cooldowns')
----
require ('Commands/open')
----
require ('Commands/collection')
----
require ('Commands/collectionshort')
----
require ('Commands/adventure')
----
require ('Commands/cook')

client:on('ready', function()
    print('Logged in as '.. client.user.username)
end)
client:on('messageCreate', function(message) --this currently breaks the bot
    MessageCheck(message)
    print("--")
end
)
client:run('Bot OTYzNzA2NjQwOTk2MTIyNjU0.YlZ_wA.UjoXxszkTIiGUn0Xthv6fk-rdNQ')


----------------------------

--notetoself: guilds are servers, nothing else.
--note, unix time = a second [1], a minute [60], an hour[3600]
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