local command = {}
function command.run(message)
    print("profile")
    --------------------------------------------------------------------FILESELETCT
    --hookshot
    local SaveData, DiscordUsername, DiscordPFP = ReturnUserData(message, message.mentionedUsers[1], "Hookshot")

    if SaveData == nil then
        return
    end

    --------------------------------------------------------------------INFO
    local Inventory = SaveData.inv
    local GiftKeyText = "Ready!"

    local GiftKeyCheck, GiftKeyTime = os.time() > SaveData.timers.giftkeytimer + GiftKeyCOOLDOWN, SecondsToClock(SaveData.timers.giftkeytimer + GiftKeyCOOLDOWN - os.time())
    if GiftKeyCheck == false then
        GiftKeyText = GiftKeyTime
    end
    
    
    local Keys = SaveData.wallet.keys
    local Capsules = SaveData.wallet.capsules
    --local Marbles = SaveData.wallet.marbles
    --local materialstat = SaveData.wallet.materials
    local Ingredients = SaveData.wallet.ingredients
    local Emblems = SaveData.wallet.emblems

    --------------------------------------------------------------------MESSAGE
    message.channel:send{
        embed = {
            color = 0xffffff, title = "Stats",
            author = {
                name = DiscordUsername.. "'s Profile",
                icon_url = DiscordPFP
            },
            description = "**-- Artifact Progress ["..#Inventory.."/256] --**",

            fields = {
                {
                    name = MenuGIFTKEY.." Gift Key",
                    value = GiftKeyText, inline = false
                },
                {
                    name = MenuKEY.." Keys",
                    value = Keys, inline = true
                },
                {
                    name = MenuCAPSULE.." Capsules",
                    value = Capsules, inline = true
                },
                --{
                    --name = MenuMARBLE.." Marbles",
                    --value = Marbles, inline = true
                --},
                --{
                    --name = MenuMATERIAL.." Materials",
                    --value = materialstat, inline = true
                --},
                {
                    name = MenuINGREDIENT.." Ingredients",
                    value = Ingredients, inline = true
                },
                {
                    name = MenuEMBLEM.." Emblems",
                    value = Emblems, inline = true
                }
            }
        }
    }
end
return command --