local command = {}
function command.run(message)
    print("cooldown")
    --------------------------------------------------------------------FILESELECT
    local SaveData, DiscordUsername, DiscordPFP = ReturnUserData(message, nil, "Normal")

    --------------------------------------------------------------------COMMAND
    local AdventureCooldown = SaveData.timers.adventuretimer + AdventureCOOLDOWN - os.time()
    local KeyCooldown = SaveData.timers.keytimer + DailyKeyCOOLDOWN - os.time()
    local GiftKeyCooldown = SaveData.timers.giftkeytimer + GiftKeyCOOLDOWN - os.time()

    --print(AdventureCooldown) print(KeyCooldown)

    --turn that into readable time (hours, minutes, seconds)
    local AdvFormattedCooldown = SecondsToClock(AdventureCooldown)
    local KeyFormattedCooldown = SecondsToClock(KeyCooldown)
    local GKeyFormattedCooldown = SecondsToClock(GiftKeyCooldown)

    local KeyText, AdventureText, GiftKeyText = "", "", ""

    if KeyCooldown <= 0 then KeyText = "Ready!" else KeyText = KeyFormattedCooldown end
    if AdventureCooldown <= 0 then AdventureText = "Ready!" else AdventureText = AdvFormattedCooldown end
    if GiftKeyCooldown <= 0 then GiftKeyText = "Ready!" else GiftKeyText = GKeyFormattedCooldown end

    --------------------------------------------------------------------MESSAGE
    message.channel:send{
        embed = {
            color = 0x177dff, title = "Cooldowns",
            author = {
                name = DiscordUsername,
                icon_url = DiscordPFP
            },

            fields = {
                {
                    name = MenuKEY.."  r$dailykey [r$dk]",
                    value = "``"..KeyText.."``"
                },
                {
                    name = MenuGIFTKEY.."  r$giftkey [r$gk]",
                    value = "``"..GiftKeyText.."``"
                },
                {
                    name = MenuADV.."  r$adventure [r$adv]",
                    value = "``"..AdventureText.."``"
                }
            },
            thumbnail = {
                url = MenuCDEMB
            },
        }
    }
end
return command --
