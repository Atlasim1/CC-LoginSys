print("wip")


-- SET SETTINGS

settings.define("SYSTEM.logonui",{
    default = "logonui.lua"
    type = "string"
})
settings.define("SYSTEM.shell",{
    default = "Menu.lua",
    type = "string"
})
settings.define("SYSTEM.userfile",{
    default = nil
})
settings.save()