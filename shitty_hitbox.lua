if not game:IsLoaded() then
    game.Loaded:Wait() 
end

local plrs = game:GetService"Players"
local rs = game:GetService"RunService"
local plr = plrs.LocalPlayer


local edit_self
local edit_other
local noclip

local fix
local noclips = {}

local self_hitbox = {
    enabled = false,
    size = 4,
    visible = false
}

local others_hitbox = {
    enabled = false,
    size = 4,
    visible = false
}

local undetectable = false


local ui = loadstring(game:HttpGet("https://raw.githubusercontent.com/topitbopit/misc-dependancies/main/material_lua_mirror.lua"))()

local gui = ui.Load({
	Title = "Hitbox modifier",
	Style = 3,
	SizeX = 500,
	SizeY = 350,
	Theme = "Dark"
})

local main = gui.New({
	Title = "hitbox modifiers"
})


main.Button({
    Text = "Metatable hook",
    Callback = function()
        if not undetectable then
            undetectable = true
            
            local old 
            old = hookmetamethod(game, "__index", function(...) 
                local among, us = ...
                
                if tostring(among) == "HumanoidRootPart" and tostring(us) == "Size" then
                    return Vector3.new(2, 2, 1) 
                end
                
                return old(...)
            end)
        else
            gui.Banner({
                Text = "Already enabled!"
                
            })
        end
    end,
	Menu = {
		Information = function(self)
			gui.Banner({
				Text = "Prevents localscripts from detecting the changes. However, this may lag your game. Cannot be disabled!"
			})
		end
	}
    
})

main.Toggle({
	Text = "LocalPlayer hitbox toggle",
	Callback = function(v)
		self_hitbox.enabled = v 
		
		if v then
		    pcall(edit_self, plr.Character)
		    
		    noclips["local"] = p
		else
		    pcall(fix, plr.Character)
        end
	end,
	Enabled = false,
	Menu = {
		Information = function(self)
			gui.Banner({
				Text = "Affects the local player. Change the size setting to make it bigger."
			})
		end
	}
})

main.Toggle({
	Text = "LocalPlayer hitbox visibility",
	Callback = function(v)
		self_hitbox.visible = v 
		
		pcall(edit_self, plr.Character)
	end,
	Enabled = false,
	Menu = {
		Information = function(self)
			gui.Banner({
				Text = "Changes if your hitbox is seen or not."
			})
		end
	}
})
main.Slider({
	Text = "LocalPlayer hitbox size",
	Callback = function(v)
		self_hitbox.size = v 
		
		pcall(edit_self, plr.Character)
	end,
	Min = 2,
	Max = 25,
	Def = 4,
	Menu = {
		Information = function(self)
			gui.Banner({
				Text = "How big (in studs) the hitbox is. To switch to roblox default, untoggle the hitbox modifier."
			})
		end
	}
})


main.Toggle({
	Text = "Other player hitbox toggle",
	Callback = function(v)
		others_hitbox.enabled = v 
		
		if v then 
    		for _,p in pairs(plrs:GetPlayers()) do
    		    if p.Name ~= plr.Name then
    		        pcall(edit_other, p.Character)
    		        
    		        noclips[p.Name] = p
    		    end
    		end
		else
    		for _,p in pairs(plrs:GetPlayers()) do
    		    if p.Name ~= plr.Name then
    		        pcall(fix, p.Character)
    		        
    		        noclips[p.Name] = nil
    		    end
    		end
        end
	end,
	Enabled = false,
	Menu = {
		Information = function(self)
			gui.Banner({
				Text = "Affects other players."
			})
		end
	}
})

main.Toggle({
	Text = "Other player hitbox visibility",
	Callback = function(v)
		others_hitbox.visible = v 
		
		for _,p in pairs(plrs:GetPlayers()) do
		    if p.Name ~= plr.Name then
		        pcall(edit_other, p.Character)
		        
		        
		    end
		end
	end,
	Enabled = false,
	Menu = {
		Information = function(self)
			gui.Banner({
				Text = "Changes if other player hitboxes are seen or not."
			})
		end
	}
})

main.Slider({
	Text = "Other player hitbox size",
	Callback = function(v)
		others_hitbox.size = v 
		
		for _,p in pairs(plrs:GetPlayers()) do
		    if p.Name ~= plr.Name then
		        pcall(edit_other, p.Character)
		    end
		end
	end,
	Min = 2,
	Max = 25,
	Def = 4,
	Menu = {
		Information = function(self)
			gui.Banner({
				Text = "How big (in studs) other player hitboxes should be. To switch to roblox default, untoggle the hitbox modifier."
			})
		end
	}
})

function edit_self(chr) 
    chr.HumanoidRootPart.Transparency = self_hitbox.visible and 0.3 or 1
    chr.HumanoidRootPart.Size = self_hitbox.enabled and Vector3.new(self_hitbox.size, 2, self_hitbox.size) or Vector3.new(2, 2, 1)
end

function edit_other(chr)
    chr.HumanoidRootPart.Transparency = others_hitbox.visible and 0.3 or 1
    chr.HumanoidRootPart.Size = others_hitbox.enabled and Vector3.new(others_hitbox.size, others_hitbox.size, others_hitbox.size) or Vector3.new(2, 2, 1)
end

function fix(chr) 
    chr.HumanoidRootPart.Transparency = 1
    chr.HumanoidRootPart.Size = Vector3.new(2, 2, 1)
end

function noclip(p) 
    p.Character.HumanoidRootPart.CanCollide = false
end


plr.CharacterAdded:Connect(function(chr) 
    wait()
    pcall(edit_self, chr)
end)

for _,p in pairs(plrs:GetPlayers()) do
    p.CharacterAdded:Connect(function(chr) 
        wait()
        pcall(edit_other, chr)
    end) 
end

plrs.PlayerAdded:Connect(function(p) 
    p.CharacterAdded:Connect(function(chr)
        wait()
        pcall(edit_other, chr)
    end)
end)

plrs.PlayerRemoving:Connect(function(p) 
    noclips[p.Name] = nil
end)

rs.RenderStepped:Connect(function() 
    for id,player in pairs(noclips) do
        pcall(noclip, player) 
    end
end)

if game.GameId == 423435674 then
    local second = gui.New({
    	Title = "football universe"
    })
    
    
    local footballinstance
    
    
    local function getFootball() 
        local inst = workspace:GetDescendants()
        
        for i,v in pairs(inst) do
            if v.ClassName == "Tool" then
                if pcall(function() return v["Handle"]["CaughtSound"] end) then
                    print("Scanned and got football "..tostring(v))
                    return v
                end
            end
        end
    end
    
    
    local football_hitbox = {
        enabled = false,
        size = 2,
        visible = false
    }
    
    local function edit_fb(fb)
        fb.Handle.Transparency = football_hitbox.visible and 0.3 or 0
        fb.Handle.Size = football_hitbox.enabled and Vector3.new(football_hitbox.size, football_hitbox.size, football_hitbox.size) or Vector3.new(0.85, 1.2, 0.85)
    end
    
    second.Toggle({
    	Text = "Football hitbox toggle",
    	Callback = function(v)
    		football_hitbox.enabled = v 
    		
    		if v then 
        		footballinstance = getFootball()
        		
        		pcall(edit_fb, footballinstance)
        		
                task.spawn(function() 
                    wait(3)
                    while football_hitbox.enabled do
                        footballinstance = getFootball()
                        wait(8)
                        
                    end
                end)
            else
                pcall(function() 
                    footballinstance.Handle.Transparency = 0 
                    footballinstance.Handle.Size = Vector3.new(0.85, 1.2, 0.85)
                end)

            end
    	end,
    	Enabled = false,
    	Menu = {
    		Information = function(self)
    			gui.Banner({
    				Text = "Affects the football in Football Universe. Refreshes the football every 8 seconds, so if this doesn't work it should only be temporarily."
    			})
    		end
    	}
    })
    
    second.Toggle({
    	Text = "Football hitbox visibility",
    	Callback = function(v)
    		football_hitbox.visible = v 
    		
    		pcall(edit_fb, footballinstance)
    	end,
    	Enabled = false,
    	Menu = {
    		Information = function(self)
    			gui.Banner({
    				Text = "Changes if the football hitbox is seen or not."
    			})
    		end
    	}
    })
    
    second.Slider({
    	Text = "Other player hitbox size",
    	Callback = function(v)
    		football_hitbox.size = v 
    		
    		pcall(edit_fb, footballinstance)
    	end,
    	Min = 2,
    	Max = 10,
    	Def = 4,
    	Menu = {
    		Information = function(self)
    			gui.Banner({
    				Text = "How big (in studs) the football's hitbox should be. To switch to the games default, untoggle the hitbox modifier."
    			})
    		end
    	}
    })
end
