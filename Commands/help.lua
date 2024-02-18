local command = {}
function command.run(message)
    print("help")
    --------------------------------------------------------------------MESSAGE
    message.channel:send{
      embed = {
        color = 0x000000,
        title = "Command Information",

        thumbnail = {
          url = MenuHEMB
        },

        description =
        "# Artifact Collection\n"
        .."**r$open [r$o]** (1 **Capsule** "..MenuCAPSULE.." , 1 **Key** "..MenuKEY.." Cost)"
        .."\n- Opens a **Capsule** "..MenuCAPSULE.." to reveal an artifact! Duplicates will be turned in for **Emblems** "..MenuEMBLEM.." instead."

        .."\n\n**r$profile [r$p]** ``Pingable``"
        .."\n- Shows a users profile. Displays stats."

        .."\n\n**r$collection [r$col]** ``Pingable``"
        .."\n- Shows the list of the users collected artifacts along with your Artifact Progress (16 per page)."

        .."\n\n**r$shortcollection [r$scol]** ``Pingable``"
        .."\n- Shows the users collected artifacts only in emoji form (32 per page)."

        .."\n\n**r$inspect** ``Artifact ID`` **[r$i** ``Artifact ID``**]**"
        .."\n- Reveals extra information about an artifact. *(You must already have the chosen artifact to be able to inspect it!)*"

        .."\n\n**r$museum [r$m]** ``Pingable`` ("..MuseumCost.." **Ingredients** "..MenuINGREDIENT.." to unlock)"
        .."\n- A museum to display your most prized artifacts!"

        .."\n# Actions\n"
        .."**r$adventure [r$adv]** (6 Hr)"
        .."\n- Explore for the chance of finding a **Capsule** "..MenuCAPSULE.." ! Also rewards a varied amount of **Ingredients** "..MenuINGREDIENT

        .."\n\n**r$cook [r$c]** ("..CookingCost.." **Ingredients** "..MenuINGREDIENT.." Cost)"
        .."\n- Cuts your **Adventure Cooldown** timer, amount varies on roll."

        .."\n\n**r$transmute [r$t]**"
        .."\n- Allows you to transmute things into other things!"

        .."\n\n**r$dailykey [r$dk]** (12 Hr)"
        .."\n- Gives you a free **Key** "..MenuKEY.." to open a **Capsule** "..MenuCAPSULE.." with!"

        .."\n\n**r$giftkey** ``@user`` **[r$gk** ``@user`` **]** (42 Hr)"
        .."\n- Mention a registered user of choice to gift a **Gift Key** "..MenuGIFTKEY.." to them! This key is only able to be given to *someone else.* So choose wisely! *(Avaliable Gift Keys do not stack after cooldown.)*"

        .."\n\n**r$cooldowns [r$cd]**"
        .."\n- Shows all your current cooldowns for all cooldown timed commands."

        .."\n# Misc\n"
        .."**r$help**"
        .."\n- Brings you this menu! Displays all RDifact bot commands and their functions."

        .."\n\n**r$ping**"
        .."\n- Pong!"

        .."\n\n**r$credits**"
        .."\n- Shows developer credits of the RDifacts bot.",
      }
    }
end
return command --