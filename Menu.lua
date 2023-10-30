-- Define Functions for program

local function centerText(text) -- Write centered text, Never ysed
    local x,y = term.getSize()
    local x2,y2 = term.getCursorPos()
    term.setCursorPos(math.ceil((x / 2) - (text:len() / 2)), y2)
    write(text)
end

local function titlebar(title) -- Write Yellow Title bar
    term.clear()
    term.setTextColor(colors.yellow)
    term.setCursorPos(1,1)
    term.write(title)
    term.setTextColor(colors.white)
    term.setCursorPos(1,2)
end

local function invokemenu(menucontents, menutitle) -- Invokes a menu dialog
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

-- Start of program
multishell.setTitle(shell.openTab("shell"), "Shell") -- Open default shell

while true do
    multishell.setTitle(multishell.getCurrent(), "Menu")
    local menu1 = invokemenu({"Programs","Shell","Logout","Power Options"},"Main Menu")
    -- Program Selector
    if menu1 == 1 then
        local proglist = fs.list("/Programs")
        local exitnumber = #proglist + 1
        table.insert(proglist, "Back")
        local programsmenu = invokemenu(proglist,"Programs")
        if programsmenu == exitnumber then 
            a = 1
        else 
            local progtorun = "/Programs/"..proglist[programsmenu]
            shell.switchTab(shell.openTab(progtorun))
        end
    -- Open Shell
    elseif menu1 == 2 then 
        local tabnum = shell.openTab("shell")
        multishell.setTitle(tabnum, "Shell")
        shell.switchTab(tabnum)
    -- Logout
    elseif menu1 == 3 then 
        shell.run("startup/loginsys")
        os.exit()
    -- Shutdown Options
    elseif menu1 == 4 then
        shutdownmenu = invokemenu({"Shutdown", "Reboot", "Back"},"Power Options")
        if shutdownmenu == 1 then 
            os.shutdown()
        elseif shutdownmenu == 2 then 
            os.reboot()
        elseif os.shutdown == 3 then 
            a = 1
        end
    end
end