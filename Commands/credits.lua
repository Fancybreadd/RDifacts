local CreditsPage1 = (
    "# RDIFACTS ver 0.9 beta\n\n"
    .."- Written in LUA using Discordia\n"
    .."- Pixelart made in Aseprite"
    .."- Please be aware of potential bugs!"
)

local CreditsPage2 = (
    "# A SUPER SPECIAL THANKS!\nto my dear friend **DeadlySprinklez** for sticking with me through the entire development process of this project. She practically helped build this bot from the ground up by teaching me the ropes of everything there is to know about how this bot should work. My dream project wouldn't have been any close to possible without her.\n\n"
    .."Please check out her projects! And consider giving her some support here: \n https://ko-fi.com/DeadlySprinklez"
)

local CreditsPage3 = (
    "# Extra Mentions\n\n"
    .."- **The RDcards Development Team** and **DPS2004** for backend access to RDCards internal workings for research.\n"
    .."- **Shareoff** for testing, code assistance, level suggestions, and extra feedback.\n"
    .."- **Random Guy JCI** for discordia embed knowledge and assistance.\n"
    .."- **Fizzd**, **Giacomo**, **Winston**, and **The 7BG Team** for developing the games we know and love!\n"
    .."- **The entire RD community**, this project wouldn't have sparked as much without you!"
)

local NextButton = discordia.Button {type = "button", style = "primary", id = "credits-next", label = ">>", disabled = false}
local PreviousButton = discordia.Button {type = "button", style = "primary", id = "credits-prev", label = "<<", disabled = false}

local command = {}
function command.run(message)
    print("credits")
    --------------------------------------------------------------------COMMAND
    local CurrentPage = 1
    local MaxPage = 3
    local PageDescription = "" local PageImage = ""

    local function CreditsMessage()
        if CurrentPage == 1 then PreviousButton:disable() else PreviousButton:enable() end
        if CurrentPage == MaxPage then NextButton:disable() else NextButton:enable() end

        if CurrentPage == 1 then PageDescription = CreditsPage1 PageImage = "https://file.garden/ZXX1N2MYuz15fq1X/RDIFACTS/credits/credits1.png"
        elseif CurrentPage == 2 then PageDescription = CreditsPage2 PageImage = "https://file.garden/ZXX1N2MYuz15fq1X/RDIFACTS/credits/credits2.gif"
        elseif CurrentPage == 3 then PageDescription = CreditsPage3 PageImage = "https://file.garden/ZXX1N2MYuz15fq1X/RDIFACTS/credits/credits3.gif" end

    --------------------------------------------------------------------MESSAGE
        return {
            
            embed = {
                color = 0x000000,
                author = {
                    name = "Credits",
                }, --
                image = {
                    url = PageImage
                },
                description = PageDescription,
                footer = {
                    text = "Page "..CurrentPage.."/"..MaxPage,
                }
            },
            components = discordia.Components {PreviousButton,NextButton},
            
        }
    end

    local CreditsUpdate = message.channel:sendComponents(CreditsMessage())

    --------------------------------------------------------------------BUTTON CODE
    while true do
        local pressed, interaction = CreditsUpdate:waitComponent("button", nil, 1000 * 60 * 5, function(interaction)
            return true
        end)

        if pressed then
            if interaction.data.custom_id == "credits-next" then
                CurrentPage = CurrentPage + 1
            elseif interaction.data.custom_id == "credits-prev" then
                CurrentPage = CurrentPage - 1
            end

            interaction:update(CreditsMessage())
        else
            -- Timeout
            break
        end
    end
end

return command
