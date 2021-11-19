-- code by asad1
-- optimized by topit
local RunService = game:GetService("RunService")
local placeEvent = game:GetService("ReplicatedStorage").Sockets.Edit.Place --store the remote so you don't index it every time

--locals are faster than globals but it doesn't much of a difference
local startx = 56487 -- X coord to start from
local starty = 0 -- Y coord to start from
local startz = 10 -- Z coord to start from


local curx = startx
local cury = starty
local curz = startz

-- microoptimizations
local wait = task.wait
local spawn = task.spawn
local blockargs = {
    ["Reflectance"] = 0,
    ["CanCollide"] = true,
    ["Color"] = Color3.new(0,0,0) --[[Color3]],
    ["LightColor"] = nil --[[Color3]],
    ["Transparency"] = 0,
    ["Light"] = 0,
    ["Material"] = {1,1,1,1,1,1,1,1,1,1},
    ["Shape"] = {1,1,1,1,1,1,1,1,1,1},
    ["Size"] = {1,1,1,1,1,1,1,1,1,1}
}

print("starting 5 seconds")
wait(5)
for i = 0, 150 do --i wouldn't use a while loop for this unless you want to crash your game after 5s 
    curx = curx + 1
    spawn(function() -- call each remote on a different thread
        coord = tostring(curx) .. " " .. tostring(cury) .. " " .. tostring(curz)
       
        blockargs.Color = Color3.new(math.random(), math.random(), math.random())  
        placeEvent:InvokeServer(coord.."/0", blockargs)
       
        print("Placed block with coordinates: " .. coord)
    end)
    wait()
end
