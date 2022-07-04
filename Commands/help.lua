client:on('messageCreate', function(message)
    if message.content == prefix..'help' then
        print("help")
        message.channel:send{embed = {
            color = 0x000000,
                title = "Command Info",
         
                description = (
                    "**h$help**\nBrings you this menu! Displays all commands and their functions.\n\n"
                    .."**h$ping**\nPong!\n\n"
                    .."**h$signup**\nSigns you up for your progress to be registered, allows you to use all the other commands!\n\n"
                    .."**h$profile, h$p**\nOpens your profile to check your stats.\n\n"
                    .."**h$collection, h$col**\nShows your list of collected artifacts, along with your artifact progress.\n\n"
                    .."**h$collectionshort, h$cols**\nShows your list of collected artifacts only in emote form for a clearer look.\n\n"
                    .."**h$cooldowns, h$cd**\nShows all your current cooldowns for all cooldown timed commands.\n\n"
                    .."**h$dailykey, h$dk [12 Hr Cooldown]**\nGives you a free key to open a treasure box with! Works once per 12 hours.\n\n"
                    .."**h$open, h$o**\nOpens a box to reveal an artifact! Uses both 1 box and key.\n\n"
                    .."**h$adventure, h$adv [6 Hr Cooldown]**\nAdventuring will give you a brief description of what you find on your journeys, you can get varied amounts of materials, treasure boxes, marbles, ingredients, or keys. *Adventuring does not always guarantee a treasure box.*\n\n"
                    .."**h$cook, h$c**\nCook something using ingredients! A random event will describe what your result is. This will give you a boost on your *adventure cooldown* depending on the result."
                    
                    
                    
        ),

        }}
        
    end
end)
