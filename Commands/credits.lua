local credits1 = (
    "**[#] RDifacts was developed and created entirely by Fancybread [#]** \n\n"
    .."Written in LUA, using discordia and its libraries\n"
    .."All sprites and pixelart done in Aseprite"
)
local credits2 = (
    "A **SUPER SPECIAL** thanks to my dear friend ``DeadlySprinklez`` for sticking with me through the entire development process of this project. She practically helped build this bot from the ground up by teaching me the ropes of everything there is to know about how this bot should work, and so my dream project wouldn't have been any close to possible without her.\n\n"
    .."Please check out her projects! And consider giving her some support here: ``insert link``"
)
local credits3 = (
    "Extra Mentions:\n\n"
    .."- ``The RDcards Development Team`` and ``DPS2008`` for giving me access to their bots internal workings\n"
    .."- ``Shareoff`` for testing, code assistance, level suggestions, and extra feedback\n"
    .."- ``Random Guy JCI`` for providing discordiawithbuttons and giving useful discordia embed knowledge\n"
    .."- ``Okamii`` for being an S+ best friend and all around a pal for all these years"
)
local credimage1 = "https://media.discordapp.net/attachments/944290668086448148/1061991998845890690/IMG_0637.webp?width=561&height=522"
local credimage2 = "https://images-ext-2.discordapp.net/external/h4WW2alcIbtyH0yDGL7CParlCowXQiI282GEjDYltbc/https/pbs.twimg.com/media/Fl5W-4laAAA5K8-.jpg?width=522&height=522"
local credimage3 = "https://media.discordapp.net/attachments/944290668086448148/1061969903738966026/IMG_4840.png?width=530&height=522"

local credprevb = discordia.Button {type = "button", style = "primary", id = "credits-prev", label = "<<", disabled = false}
local crednextb = discordia.Button {type = "button", style = "primary", id = "credits-next", label = ">>", disabled = false}
----oo[]#[[X]]#[]oo----

local command = {}
function command.run(message)
    print("credits")
    
    --==--

    Credmenu = message.channel:sendComponents {
        embed = {
            color = 0x000000,
            author = {
                name = "RDifacts Credits",
            }, --
            description = credits1,
            image = {url = credimage1},
            footer = {
                text = "Page 1/3",
            }
        },
        components = discordia.Components {credprevb,crednextb}
    }
end

client:on("interactionCreate", function(interaction) -- look at this later
    if string.split(interaction.data.custom_id, "-")[1] == "credits" then
        local embedpage = interaction.message.embed.footer.text --BIG note, youre taking objects from the MESSAGE, not the updated one below
        local embednumber = tonumber(string.sub(embedpage, 6)) --6th character of the "Page X" footer, turn it from string into number
        Page = 1

        if discordia.enums.interactionType.messageComponent then --if a button is pressed..
            print("a button!")
            --==oo##oo==--
            if interaction.data.custom_id == "credits-next" and embednumber < 3 then -->>
                print("credits>>")
                Page = embednumber + 1
                print(Page)
                if Page == 2 then
                    interaction:update{embed = {
                    color = 0x000000,

                    author = {
                        name = "~RDifacts Credits~",
                    },

                    description = credits2,
                    image = {url = credimage2},
                    footer = {
                        text = "Page "..Page.."/3",
                    },
                    }}
                else
                    if Page == 3 then
                        interaction:update{embed = {
                        color = 0x000000,

                        author = {
                        name = "~RDifacts Credits~",
                        },

                        description = credits3,
                        image = {url = credimage3},
                        footer = {
                            text = "Page "..Page.."/3",
                        },
                        }}
                    end
                end
            end

            if interaction.data.custom_id == "credits-prev" and embednumber < 3 then --<<
                print("credits<<")
                Page = embednumber - 1
                print(Page)
                if Page == 2 then
                    interaction:update{embed = {
                    color = 0x000000,

                    author = {
                        name = "~RDifacts Credits~",
                    },

                    description = credits2,
                    image = {url = credimage2},
                    footer = {
                        text = "Page "..Page.."/3",
                    }
                    }}
                else
                    if Page == 1 then
                        interaction:update{embed = {
                        color = 0x000000,

                        author = {
                            name = "~RDifacts Credits~",
                        },

                        description = credits1,
                        image = {url = credimage1},
                        footer = {
                            text = "Page "..Page.."/3",
                        }
                        }}
                    end
                end
            end
        end
    end
end)
return command --
