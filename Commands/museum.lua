local command = {}
function command.run(message, arg, arg2)
    print("museum")
    --------------------------------------------------------------------FILESELECT
    local profileID = message.author.id
    local pname = message.author.username
    local iconurl = message.author.avatarURL
    local check = io.open(BotPath.."PROFILES/"..profileID..".json","r")

    --==--
    if not message.mentionedUsers[1] then --if pinged friend
        if not check then
            local profile = io.open(BotPath.."PROFILES/"..profileID..".json","w")
            noprofile(message)
            check = makeprofile(profile, profileID)
        end
        --skip
    else
        profileID = message.mentionedUsers[1][1]
        pname = message.guild:getMember(profileID).user.username
        iconurl = message.guild:getMember(profileID).user.avatarURL
        check = io.open(BotPath.."PROFILES/"..profileID..".json","r")
        if not check then
            nofriendprofile(message, pname, iconurl)
            print("no profile detected")
            return
        end
    end
    --==--

    --------------------------------------------------------------------INFO
    local jsonstats = json.decode(io.input(check):read("*a"))
    local favinv = jsonstats.favinv
    local favhave = false
    local iteminv = jsonstats.inv
    local favid = tonumber(arg) local pedid = tonumber(arg2)

    --------------------------------------------------------------------COMMAND
    --ARGUMENT (GUIDE)
    if arg == "guide" then
        local guideroom = imagevips.Image.new_from_file("assets/displayguide.png")
        guideroom = guideroom:resize(3, {kernel = "nearest"})
        message.channel:send{
            file = {"guide.png", guideroom:cast("uchar"):write_to_buffer(".png")}
        }
        return
    end

    --ARGUMENT (REMOVE)
    if arg == "remove" and pedid then print("remove")
        for i,v in ipairs(favinv) do --loops until it finds the same item already displayed
            if v == favinv[pedid] and favinv[pedid] ~= -1 then print("removing...")-- if you have it already favorited
                favhave = true
                favinv[pedid] = -1
                break
            end
        end
        updatesave(profileID,jsonstats,check)
        if favhave == false then print("no item") end
        return

    elseif arg == "remove" then print("no pedestal id") return
    end

    --ARGUMENT (DISPLAY)
    if favid and pedid then --if message has two args
        local ifhave local copy

        if pedid > 16 then print("no pedestal!")
            check:close() return
        elseif favid > 256 then print("no artifact!")
            check:close() return 
        end

        for i,v in ipairs (jsonstats.inv) do --INVENTORY dupe check
            if v == KEYNAMETABLE[favid] then --if detected!
                ifhave = true --turn this to true
                break
            end --print(i,v.."inv")
        end
        if not ifhave then print("dont have it") return end

        for i,v in ipairs(favinv) do --FAVORITES dupe check
            if v == favid then -- if you have it already favorited
                copy = true -- flip the removed boolean
                break
            end
        end

        if copy then print("you have it favorited already") return end
        favinv[pedid] = favid updatesave(profileID,jsonstats,check) --(S)
        message.channel:send{
            content = "put "..JSONITEMS[KEYNAMETABLE[favid]][1]..JSONITEMS[KEYNAMETABLE[favid]][2].." in pedestal "..pedid
        }
        return

    elseif favid or pedid then print("no proper number on one arg!") --if theres only 1 arg
        check:close() return
    end

    --NO ARGUMENT
    print("no arg")
    local displayroom = imagevips.Image.new_from_file("assets/displayroom.png")
    local sheet = imagevips.Image.new_from_file("assets/ARSHEET.png")
    local pixel_x local pixel_y --starting pixel is (64, 48)

    --======o
    for x = 1, 16 do --for loop increments by 1 by default so we just start with the initial value and the limit
        pixel_x = 32 * ((x - 1) % 6) + 64
        pixel_y = 32 * math.floor((x - 1) / 6) + 48
        -- draw stuff here
        if favinv[x] ~= -1 then
            local artifactID = favinv[x] print(artifactID)
            local selected = sheet:crop(16 * ((artifactID - 1) % 16), 16 * math.floor((artifactID - 1) / 16), 16, 16)
            displayroom = displayroom:composite(selected, "over",{x=pixel_x, y=pixel_y})
        end
    end
    local finalroom = displayroom:resize(3, {kernel = "nearest"})
    --======o

    --------------------------------------------------------------------MESSAGE
    message.channel:send{
        embed = {
            color = 0x000000,
            author = {
                name = pname.."'s Room",
                icon_url = iconurl
            },

            --image = {
                --file = {"test.png", finalroom:cast("uchar"):write_to_buffer(".png")}
            --},

            footer = {
                text = "Do h$d [artifact ID] [pedestal number] to place an artifact.\nDo h$d guide to see every pedestals number.",
            }
        },
        file = {"test.png", finalroom:cast("uchar"):write_to_buffer(".png")}
    }
    check:close()
end
return command --

