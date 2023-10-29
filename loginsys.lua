-- AtlasOS Login System

local users = { {"user1", "user1"}, {"user2", "user2"} }
local loggedin = false
old_terminate = os.pullEvent
os.pullEvent = os.pullEventRaw
currentuser = "none"

function titlebar(title)
    term.clear()
    term.setTextColor(colors.yellow)
    term.setCursorPos(1,1)
    term.write(title)
    term.setTextColor(colors.white)
    term.setCursorPos(1,2)
end

while loggedin == false do 
    titlebar("Login")
    term.setCursorPos(1,2)

    term.write("Username > ")
    local user = read()

    term.setCursorPos(1,3)
    local pass = read("*")

    for _,u in pairs(users) do
        if user == "shutdown" then
            os.shutdown()
        elseif (user == u[1]) and (pass == u[2]) then
            term.clear()
            temr.setCursorPos(1,1)
            os.pullEvent = old_terminate
            currentuser = u[1]
            shell.run("/rom/programs/shell.lua")
            os.pullEvent = os.pullEventRaw
            currentuser = "none"
        else
            local a = 1
        end
    end
end
