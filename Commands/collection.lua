local prevb = discordia.Button {type = "button", style = "primary", id = "col-previous", label = "<<", disabled = false}
local nextb = discordia.Button {type = "button", style = "primary", id = "col-next", label = ">>", disabled = false}
----JCI THANK YOU THANK YOU THANK YOU YOURE SO HANDSOME MWUAH MWUAH MWUAH
local command = {}
function command.run(message) --lets go again
    print("collection")
    local profileID = message.author.id
    local pname = message.author.username
    local iconurl = message.author.avatarURL
    local check = io.open(path..profileID..".json","r")
    --==--
    if not message.mentionedUsers[1] then --if pinged friend
        if not check then
            local profile = io.open(path..profileID..".json","w")
            noprofile(message)
            check = makeprofile(profile, profileID)
        end
    else
        profileID = message.mentionedUsers[1][1]
        pname = message.guild:getMember(profileID).user.username
        iconurl = message.guild:getMember(profileID).user.avatarURL
        check = io.open(path..profileID..".json","r")
        if not check then
            print("no profile detected")
            return
        end
    end
    --==-- 
    local jsonstats = json.decode(io.input(check):read("*a"))
    local iteminv = jsonstats.inv

    --------------------------------------------------------------------o
    if #iteminv == 0 then --if you have nothing
        message.channel:send{
            embed = {
                color = 0x000000, title = "It's Empty.",
                author = {
                    name = pname.. "'s Artifacts",
                    icon_url = iconurl
                }, --

                description = "You don't have any artifacts!",
                footer = {
                    text = "Page 0/0"
                } --
            },
        }

        check:close()

    return
    end
    --------------------------------------------------------------------o ELSE
    --else, do system
    local currentPage = 1
    local Length = 2 --amount of artifacts shown per page --will be 16
    local Buttonlimit = math.ceil((#iteminv / Length))

    --==--
    local sortedinv = Collectioninv(iteminv)
    --==--

    local function createMessage()
        if currentPage == 1 then prevb:disable() else prevb:enable() end
        if currentPage == Buttonlimit then nextb:disable() else nextb:enable() end

         --[]--
        local embedList = ""
        for entryIndex = (currentPage - 1) * Length + 1, currentPage * Length, 1 do  --sort all the artifacts
            if JSONITEMS[sortedinv[entryIndex]] == nil then
                break
            end
            embedList = embedList.."**["..JSONITEMS[sortedinv[entryIndex]][4].."]** "..JSONITEMS[sortedinv[entryIndex]][1].." "..JSONITEMS[sortedinv[entryIndex]][2].."\n"
        end
        --[]--

        --===TEXT===--
        return {
            embed = {
                color = 0x000000, title = "Artifact Progress ["..(#iteminv).."/256]",
                author = {
                    name = pname.. "'s Artifacts",
                    icon_url = iconurl
                }, --

                description = embedList,
                footer = {
                    text = "Page "..currentPage.."/"..Buttonlimit,
                } --
            },
            components = discordia.Components {prevb, nextb}
        }
    end

    local colmenu = message.channel:sendComponents(createMessage())

-------------------------------------------
            --BUTTON CODE--
-------------------------------------------

        while true do
            local pressed, interaction = colmenu:waitComponent("button", nil, 1000 * 60 * 5, function(interaction)
                if interaction.user.id ~= profileID then
                    interaction:reply("You can't use this button!", true)
                    return false
                end

                return true
            end)

            if pressed then
                if interaction.data.custom_id == "col-next" then
                    currentPage = currentPage + 1
                elseif interaction.data.custom_id == "col-previous" then
                    currentPage = currentPage - 1
                end

                interaction:update(createMessage())
            else
                -- Timeout
                break
            end
        end

        --local pressed, interaction = colmenu:waitComponent("button", nil, 1000 * 10, function(interaction)
        --end)
        --colmenu:update { components = discordia.Components { nextb:disable(), prevb:disable() } } return
    --------------------------------------------------------------------o
end



------DO NOT TOUCH THIS------

function Collectioninv(iteminv) --sorts artifacts by id
    local tablecloneofinv = {}

    for i, v in pairs(iteminv) do -- clones the users inv
        tablecloneofinv[i] = v;
    end

    table.sort(tablecloneofinv, function (a, b) -- sorts it by id
        --print(JSONITEMS[a][1])
        if (JSONITEMS[a][4] < JSONITEMS[b][4]) then
            return (JSONITEMS[a][4] < JSONITEMS[b][4])
        end
    end)
    --print(tablecloneofinv[1])
    --print(tablecloneofinv[2])
    --print(tablecloneofinv)
    return tablecloneofinv
end

------DO NOT TOUCH THIS------

return command