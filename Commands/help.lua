local command = {}
function command.run(message)
    print("help")
    --------------------------------------------------------------------MESSAGE
    message.channel:send{embed = {
        color = 0x000000,
        title = "Command Information",

        fields = {
          {
            name = "------#|Important|#------",
            value =
            "**h$help** \nBrings you this menu! Displays all commands and their functions."
            .."\n\n**h$ping**\nPong!"
            .."\n\n**h$credits**\nShows the credits of RDifacts, and the people that contributed to it!"
          },
          {
            name = "------#|Artifact Collection|#------",
            value = 
            "**h$open, h$o [Requires 1 Capsule and 1 Key]**"
            .."\nOpens a capsule to reveal an artifact! Getting a duplicate will reward you an **Emblem** to use as currency."

            .."\n\n**h$profile, h$p**"
            .."\nOpens your profile to check your stats. Displays amount of **Artifact Progress**, **Keys**, **Capsules**, **Marbles**, **Ingredients**, and **Materials**."

            .."\n\n**h$collection, h$col**"
            .."\nShows your list of collected artifacts along with your artifact progress."

            .."\n\n**h$collectionshort, h$cols**"
            .."\nShows your list of collected artifacts only in emote form for a clearer, simpler look."

            .."\n\n**h$inspect** ``ID number``**, h$i** ``ID number``"
            .."\nGives a detailed description and reveals extra information about an artifact. ***You must already have the chosen artifact to be able to inspect it!***"

            .."\n\n**h$display** ``a``**,** **h$d** ``a`` **[100 Marbles initial cost]**"
            .."\n``TO BE ADDED``"
          },
          {
            name = "------#|Gameplay|#------",
            value = 
            "**h$adventure, h$adv [6 Hr Cooldown]**"
            .."\nExploring will give you a brief description of what you find on your journeys. You can get varied amounts of **Materials**, **Capsules**, **Marbles**, **Ingredients**, or **Keys**. ***Adventuring does not always guarantee getting all mentioned rewards!***"

            .."\n\n**h$cook, h$c [Requires 20 Ingredients]**"
            .."\nCook something using ingredients! A random event will describe what your result is. This will give you a small time cut on your **Adventure Cooldown** depending on the result."

            .."\n\n**h$dailykey, h$dk [12 Hr Cooldown]**"
            .."\nGives you a free key to open a Capsule with!"

            .."\n\n**h$giftkey** ``@user``**,** **h$gk** ``@user`` **[36 Hr Cooldown]**"
            .."\nMention a registered user of choice to gift your **Gift Key** to them! You can only gift this key to **someone else.** So choose wisely! ***Gift Keys can only be gifted once per cooldown.***"

            .."\n\n**h$cooldowns, h$cd**"
            .."\nShows all your current cooldowns for all cooldown timed commands."
          }
        }
    }}
end
return command --