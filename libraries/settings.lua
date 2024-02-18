_G["Prefix"] = "r$"

_G["CollectionLength"] = 16
_G["ShortCollectionLength"] = 32

_G["CookingCost"] = 15
_G["MuseumCost"] = 375

_G["CapsuleTrigger"] = .85

_G["IngredientGrade1"],
_G["IngredientGrade2"],
_G["IngredientGrade3"],
_G["IngredientGrade4"],
_G["IngredientGrade5"]
= .4, .7, .87, .97, 1


_G["CookGrade1"],
_G["CookGrade2"],
_G["CookGrade3"],
_G["CookGrade4"],
_G["CookGrade5"] 
= .35, .6, .8, .95, 1

_G["CookBonusTrigger"] = .2

_G["AdventureCOOLDOWN"] = 21600 -- 6 hours
_G["DailyKeyCOOLDOWN"] = 43200 -- 12 hours
_G["GiftKeyCOOLDOWN"] = 115200 --32 hours

---transmute

_G["Transmute1cost"], _G["Transmute1reward"] = 200, 1 -- food > capsule
_G["Transmute2cost"], _G["Transmute2reward"] = 2, 1 -- emblem > capsule
_G["Transmute3cost"], _G["Transmute3reward"] = 3, 1 -- capsule > key





local TemplateJson = io.open(BotPath.."PROFILES/TEMPLATE.json","r")

_G["TemplateSave"] = json.decode(TemplateJson:read("a*"))
TemplateJson:close()

print("settings loaded!")
--------------------------------------------------------------------------ASSETS--------
--wallet
_G["MenuCAPSULE"] = "<:capsule:1183518599630049440>"
_G["MenuKEY"] = "<:capsulekey:1183518675974766592>"
_G["MenuEMBLEM"] = "<:emblem:1183518634472120350>"
--_G["MenuMARBLE"] = ""
--_G["MenuMATERIAL"] = ""
_G["MenuINGREDIENT"] = "<:ingredient:1183518652092395571>"
_G["MenuSTARTONIC"] = "<:startonic:1183519094205587598>"
_G["MenuGIFTKEY"] = "<:giftkey:1183519049594978354>"

--actions
_G["MenuC"] = ""
_G["MenuADV"] = "<:adventuring:1184423506469998633>"
_G["MenuI"] = ""
--_G["MenuMINE"] = ""
_G["MenuCD"] = ""
_G["MenuM"] = ""
_G["MenuHELP"] = ""
--_G["MenuSH"] = ""
--_G["MenuTALK"] = ""

--actionembeds
_G["MenuOEMB"] = "https://file.garden/ZXX1N2MYuz15fq1X/RDIFACTS/menus/capsule.png"
_G["MenuCEMB"] = "https://file.garden/ZXX1N2MYuz15fq1X/RDIFACTS/menus/cooking.png"
_G["MenuGKEMB"] = "https://file.garden/ZXX1N2MYuz15fq1X/RDIFACTS/menus/giftkey.png"
_G["MenuDKEMB"] = "https://file.garden/ZXX1N2MYuz15fq1X/RDIFACTS/menus/key.png"
_G["MenuADVEMB"] = "https://file.garden/ZXX1N2MYuz15fq1X/RDIFACTS/menus/adventuring.png"
_G["MenuIEMB"] = "https://file.garden/ZXX1N2MYuz15fq1X/RDIFACTS/menus/inspect.png"
_G["MenuCDEMB"] = "https://file.garden/ZXX1N2MYuz15fq1X/RDIFACTS/menus/cooldowns.png"
_G["MenuMEMB"] = "https://file.garden/ZXX1N2MYuz15fq1X/RDIFACTS/menus/museum.png"
_G["MenuTEMB"] = "https://file.garden/ZXX1N2MYuz15fq1X/RDIFACTS/menus/transmute.png"
_G["MenuHEMB"] = "https://file.garden/ZXX1N2MYuz15fq1X/RDIFACTS/menus/help.png"

--origin
_G["OrTable"] = {
    "<:originalorigin:1183518970125484062>  ",
    "<:levelorigin:1183518952131924129>  Rhythm Doctor Custom Level : ",
    "<:gameorigin:1183518985422123079>  Game : ",
    "<:mediaorigin:1183519012647358576>  Media : ",
    "<:memoryorigin:1183519000194465915>  Memory : "
}
