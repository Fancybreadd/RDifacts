local BotPath = "D:/artte/Heartifacts bot/"
---LIBS+STUFF---
_G["discordia"] = require('discordia-with-buttons')
_G["client"] = discordia.Client()
_G["json"] = require('libraries/json') --json powers
_G["unixseconds"] = require('libraries/secondstoclock')
_G["messagechecker"] = require('libraries/messagecheck')
_G['path'] = "D:/artte/Heartifacts bot/PROFILES/"
_G["prefix"] = "h$"
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
---ADVENTURING SYSTEM---
_G['SCENARIOLIST'] = io.open(BotPath.."AdventureSummary.json","r")
_G['SCENARIOS'] = json.decode(io.input(SCENARIOLIST):read("*a"))
_G['SCENARIOKEYNAMES'] = {}

            for k,v in pairs(SCENARIOS) do
                SCENARIOKEYNAMES[#SCENARIOKEYNAMES+1] = k;
                print(k,v)
            end
SCENARIOLIST:close()
---COOKING SYSTEM---
_G['COOKSCENARIOLIST'] = io.open(BotPath.."CookingSummary.json","r")
_G['COOKRESULTS'] = json.decode(io.input(COOKSCENARIOLIST):read("*a"))
_G['COOKRESULTKEYNAMES'] = {}
            
            for k,v in pairs(COOKRESULTS) do
                COOKRESULTKEYNAMES[#COOKRESULTKEYNAMES+1] = k;
                print(k,v)
            end
COOKSCENARIOLIST:close()
---COOLDOWNS---
_G['ADVCOOLDOWN'] = 3600 -- adventure cooldown 
_G['DKCOOLDOWN'] = 3600 -- daily key cooldown

--notetoself: guilds are servers, nothing else.
--note, unix time = a second [1], a minute [60], an hour[3600]
--if you ever change computers change profile pathing immediately

--message.author.mentionstring pings yourself! good to know.

---COMMANDS---
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
client:on('messageCreate', function(message)
    MessageCheck(message.content)
    --print("a")
end)
client:run('Bot OTYzNzA2NjQwOTk2MTIyNjU0.YlZ_wA.UjoXxszkTIiGUn0Xthv6fk-rdNQ')
