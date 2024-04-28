-- Define Functions for program

local function centerText(text) -- Write centered text, Never used
    local x,y = term.getSize()
    local x2,y2 = term.getCursorPos()
    term.setCursorPos(math.ceil((x / 2) - (text:len() / 2)), y2)
    write(text)
end

local function titlebar(title) -- Function for Writing a Yellow Title bar
    term.clear()
    term.setTextColor(colors.yellow)
    term.setCursorPos(1,1)
    term.write(title)
    term.setTextColor(colors.white)
    term.setCursorPos(1,2)
end

local function invokeMenu(menucontents, menutitle) --Function for Invoking a menu dialog
    --[[
        invokeMenu(menucontents:table, menutitle:string) -> Num
        menucontents : Table with all elements of the menu
        menutitle : Title for menu (Shown in yellow at the top)
        Returns the index of the selected item
    ]]
    selectpos = 1
    lengh = #menucontents
    while true do 
        titlebar(menutitle)
        print("")
        for i=1, lengh, 1 do
            if i == selectpos then
                print(" > "..menucontents[i].."") 
            else 
                print("   "..menucontents[i].."")
            end
        end
        a,b = os.pullEventRaw()
        if a == "key" then 
            if b == 200 and selectpos > 1 then
                selectpos = selectpos - 1
            elseif b == 208 and selectpos < lengh then
                selectpos = selectpos + 1
            elseif b == 28 then 
                break
            end
        end
    end
    return selectpos
end

local function getRegistryKey(key, defaultvalue) -- Gets a registry key and defines it if it dosent exist
    settings.load()
    if settings.get(key) then 
        local value = settings.get(key)
    else 
        settings.set(key, defaultvalue)
        local value = settings.get("SYSTEM.shell")
        settings.save()
    end
    return value
end


-- Start of program
multishell.setTitle(shell.openTab("shell"), "Shell") -- Open default shell

-- Main Menu Block
while true do
    multishell.setTitle(multishell.getCurrent(), "Menu")
    local menu1 = invokeMenu({"Programs","Shell","Logout","Power Options"},"Main Menu") -- Invoke The Menu
    -- Program Selector Item
    if menu1 == 1 then
        local proglist = fs.list("/Programs") -- get the list of programs
        local exitnumber = #proglist + 1 -- get the index for the "Back" option
        table.insert(proglist, "Back") -- Add the back option
        local programsmenu = invokeMenu(proglist,"Main Menu > Programs") -- invoke menu
        if programsmenu == exitnumber then -- .. Then Do Nothing -- If selected option is "Back"
        else -- If selected option is a program then run the program
            local progtorun = "/Programs/"..proglist[programsmenu] 
            shell.switchTab(shell.openTab(progtorun)) -- and switch tab
        end
    -- Open Shell Item
    elseif menu1 == 2 then 
        local tabnum = shell.openTab("shell") -- open tab
        multishell.setTitle(tabnum, "Shell") -- set title
        shell.switchTab(tabnum) -- switch tab
    -- Logout Item
    elseif menu1 == 3 then 
        os.reboot()ss
    -- Shutdown Options Item
    elseif menu1 == 4 then  
        shutdownmenu = invokeMenu({"Shutdown", "Reboot", "Back"},"Main Menu > Power Options") -- invoke power options menu
        if shutdownmenu == 1 then 
            os.shutdown() -- shutdown item
        elseif shutdownmenu == 2 then 
            os.reboot() -- reboot item
        end -- Case for "Back" gets handeled automatically 
    end
end