local credits1 = (
    "**RDIFACTS**\n\n"
    .."-Written in LUA, using discordia-\n"
    .."-Pixelart made in Aseprite-"
)

local credits2 = (
    "A **SUPER SPECIAL** thanks to my dear friend ``DeadlySprinklez`` for sticking with me through the entire development process of this project. She practically helped build this bot from the ground up by teaching me the ropes of everything there is to know about how this bot should work, and so my dream project wouldn't have been any close to possible without her.\n\n"
    .."Please check out her projects! And consider giving her some support here: ``insert link``"
)

local credits3 = (
    "Extra Mentions:\n\n"
    .."- ``The RDcards Development Team`` and ``DPS2008`` for backend access to their bots internal workings\n"
    .."- ``Shareoff`` for testing, code assistance, level suggestions, and extra feedback\n"
    .."- ``Random Guy JCI`` for providing useful discordia embed knowledge and help\n"
    .."- ``Okamii`` for being a best friend and all around pal for all these years\n"
    .."- ``The entire RD community``, this project wouldn't have sparked without you!"
)

local credimage1 = "https://media.discordapp.net/attachments/944290668086448148/1061991998845890690/IMG_0637.webp?width=561&height=522"
local credimage2 = "https://images-ext-2.discordapp.net/external/h4WW2alcIbtyH0yDGL7CParlCowXQiI282GEjDYltbc/https/pbs.twimg.com/media/Fl5W-4laAAA5K8-.jpg?width=522&height=522"
local credimage3 = "https://media.discordapp.net/attachments/944290668086448148/1061969903738966026/IMG_4840.png?width=530&height=522"

local crednextb = discordia.Button {type = "button", style = "primary", id = "credits-next", label = ">>", disabled = false}
local credprevb = discordia.Button {type = "button", style = "primary", id = "credits-prev", label = "<<", disabled = false}

local command = {}
function command.run(message)
    print("credits")
    --------------------------------------------------------------------COMMAND
    local currentPage = 1
    local maxPage = 3
    local creddesc = "" local credimage = ""

    local function createcreditMessage()
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
                    name = "RDifacts Credits",
                }, --

                description = creddesc, image = {url = credimage},
                footer = {
                    text = "Page "..currentPage.."/"..maxPage,
                }
            },
            components = discordia.Components {credprevb,crednextb}
        }
    end

    local credmenu = message.channel:sendComponents(createcreditMessage())

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

            interaction:update(createcreditMessage())
        else
            -- Timeout
            break
        end
    end
end

return command
