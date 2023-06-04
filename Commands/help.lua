local command = {}
function command.run(message)
    print("help")
    --------------------------------------------------------------------MESSAGE
    message.channel:send{embed = {
        color = 0x000000,
        title = "Command Information",

        description =
        "# Artifact Collection\n"
        .."**r$open [r$o]** (1 **Capsule** "..MenuCAPSULE.." , 1 **Key** "..MenuKEY.." Cost)"
        .."\n- Opens a capsule to reveal an artifact! Duplicates will be turned in for **Emblems** "..MenuEMBLEM.." instead."

        .."\n\n**r$profile [r$p]**"
        .."\n- Shows your profile. Displays stats."

        .."\n\n**r$collection [r$col]**"
        .."\n- Shows the list of your collected artifacts along with your Artifact Progress."

        .."\n\n**r$collectionshort [r$cols]**"
        .."\n- Shows your collected artifacts embedless."

        .."\n\n**r$inspect** ``Artifact ID``** [r$i** ``Artifact ID``**]**"
        .."\n- Reveals extra information about an artifact. ***(You must already have the chosen artifact to be able to inspect it!)***"

        .."\n\n**r$museum [r$m]** (200 **Marbles** "..MenuMARBLE.." to unlock)"
        .."\n- to be added"

        .."\n# Actions\n"
        .."**r$adventure [r$adv] (6 Hours)**"
        .."\n- Explore for the chance of finding a **Capsule** "..MenuCAPSULE.." ! Also rewards a varied amount of **Ingredients** "..MenuINGREDIENT.." and **Marbles** "..MenuMARBLE.." ."

        .."\n\n**r$cook [r$c]** (25 **Ingredients** "..MenuINGREDIENT.." Cost)"
        .."\n- Cuts your **Adventure Cooldown** timer, amount varies on roll."

        .."\n\n**r$transmute [r$t]**"
        .."\n- Allows you to transmute things into other things!"

        .."\n\n**r$dailykey [r$dk] (12 Hours)**"
        .."\n- Gives you a free **Key** "..MenuKEY.." to open a Capsule with!"

        .."\n\n**r$giftkey** ``@user`` **[r$gk** ``@user`` **]** (36 Hr Cooldown)"
        .."\n- Mention a registered user of choice to gift your **Gift Key** "..MenuGIFTKEY.." to them! You can only gift this key to *someone else.* So choose wisely! ***(Gift Keys can only be gifted once per cooldown.)***"

        .."\n\n**r$cooldowns [r$cd]**"
        .."\n- Shows all your current cooldowns for all cooldown timed commands."

        .."\n# Misc\n"
        .."**r$help**"
        .."\n- Brings you this menu! Displays all commands and their functions."

        .."\n\n**r$ping**"
        .."\n- Pong!"

        .."\n\n**r$credits**"
        .."\n- Shows RDifacts Credits!",
    }
  }
end
return command --