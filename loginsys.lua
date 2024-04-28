-- AtlasOS Login System

local users = { {"user1", "user1"}, {"user2", "user2"} } -- Very SecureTM list of users : {username,password}
local loggedin = false
old_terminate = os.pullEvent -- Remove terminate
os.pullEvent = os.pullEventRaw -- remove terminate (2)
currentuser = "none"

function titlebar(title) -- Function for invoking a yellow titlebar
    term.clear()
    term.setTextColor(colors.yellow)
    term.setCursorPos(1,1)
    term.write(title)
    term.setTextColor(colors.white)
    term.setCursorPos(1,2)
end
-- Check to see if all settings are correct 
settings.load()
if settings.get("SYSTEM.shell") ~= nil then 
    settings.set("SYSTEM.shell","shell")
    settings.save()
end

--- Main Loop
while loggedin == false do 
    titlebar("Login")
    term.setCursorPos(1,2)

    term.write("Username > ")
    local user = read()

    term.setCursorPos(1,3)
    local pass = read("*") -- Read with every char being *

    for _,u in pairs(users) do -- check all users
        if user == "shutdown" then -- if shutdown
            os.shutdown()
        elseif (user == u[1]) and (pass == u[2]) then -- check username and password
            term.clear() 
            term.setCursorPos(1,1)
            os.pullEvent = old_terminate -- restore ^t Terminate
            currentuser = u[1] -- set current user global (idk if this works i havent tested it yet)
            shell.run("/rom/programs/shell.lua") -- run shell, need to add setting for detecting os 
            -- This runs when logged off ()
            os.pullEvent = os.pullEventRaw 
            currentuser = "none" 
        else end -- if not user 
    end
end
