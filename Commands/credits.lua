local credits1 = (
    "# RDIFACTS ver 1.0 beta\n\n"
    .."- Written in LUA\n"
    .."- Pixelart made in Aseprite"
)

local credits2 = (
    "# A SUPER SPECIAL THANKS!\nto my dear friend **DeadlySprinklez** for sticking with me through the entire development process of this project. She practically helped build this bot from the ground up by teaching me the ropes of everything there is to know about how this bot should work. My dream project wouldn't have been any close to possible without her.\n\n"
    .."Please check out her projects! And consider giving her some support here: \n https://ko-fi.com/DeadlySprinklez"
)

local credits3 = (
    "# Extra Mentions\n\n"
    .."- **The RDcards Development Team** and **DPS2008** for backend access to RDCards internal workings.\n"
    .."- **Shareoff** for testing, code assistance, level suggestions, and extra feedback.\n"
    .."- **Random Guy JCI** for discordia embed knowledge and assistance.\n"
    .."- **Fizzd**, **Giacomo**, **Winston**, and **The 7BG Team** for developing the games we know and love!\n"
    .."- **The entire RD community**, this project wouldn't have sparked as much without you!"
)

local credimage1 = "https://media.discordapp.net/attachments/1114216800339636224/1114233049866051735/credits1.png?width=575&height=363"
local credimage2 = ""
local credimage3 = ""

local crednextb = discordia.Button {type = "button", style = "primary", id = "credits-next", label = ">>", disabled = false}
local credprevb = discordia.Button {type = "button", style = "primary", id = "credits-prev", label = "<<", disabled = false}

local command = {}
function command.run(message)
    print("credits")
    --------------------------------------------------------------------COMMAND
    local currentPage = 1
    local maxPage = 3
    local creddesc = "" local credimage = ""

    local function creditmsg()
        if currentPage == 1 then credprevb:disable() else credprevb:enable() end
        if currentPage == maxPage then crednextb:disable() else crednextb:enable() end

        if currentPage == 1 then creddesc = credits1 credimage = credimage1
        elseif currentPage == 2 then creddesc = credits2 credimage = credimage2
        elseif currentPage == 3 then creddesc = credits3 credimage = credimage3 end

    --------------------------------------------------------------------MESSAGE
        return {
            embed = {
                color = 0x000000,
                author = {
                    name = "Credits",
                }, --

                description = creddesc, image = {url = credimage},
                footer = {
                    text = "Page "..currentPage.."/"..maxPage,
                }
            },
            components = discordia.Components {credprevb,crednextb}
        }
    end

    local credmenu = message.channel:sendComponents(creditmsg())

    --------------------------------------------------------------------BUTTON CODE
    while true do
        local pressed, interaction = credmenu:waitComponent("button", nil, 1000 * 60 * 5, function(interaction)
            return true
        end)

        if pressed then
            if interaction.data.custom_id == "credits-next" then
                currentPage = currentPage + 1
            elseif interaction.data.custom_id == "credits-prev" then
                currentPage = currentPage - 1
            end

            interaction:update(creditmsg())
        else
            -- Timeout
            break
        end
    end
end

return command
