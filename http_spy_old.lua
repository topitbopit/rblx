if not game:IsLoaded() then game.Loaded:Wait() end

-- Update 12/7/21
  -- Organized code
  -- Fixed colors
  -- Added :GetObjects and .GetObjects hook
  -- Fixed BlockedDomains and BlockedContent overwriting 
  -- Added "api.myip.com" by request
  -- Fixed request hooking not checking the url
  -- Fixed request hooking not being able to print headers or cookies properly


local plr = game:GetService("Players").LocalPlayer
_G.BlockedDomains  = _G.BlockedDomains or {
    "discord.com/api/webhooks/", -- discord webhooks
    "webhook", -- some webhook proxies have 'webhook' in the url
    "000webhost", -- some malicious webservers use 000webhost (though there are some legit ones)
    "freehosting", -- some malicious webservers use freehosting (though there are some legit ones)
    "ident.me", -- website that gives ip info
    "ipify.org", -- website that gives ip info
    "dyndns.org", -- website that gives ip info 
    "checkip.amazonaws.com", -- website that gives ip info
    "httpbin.org/ip", -- website that gives ip info
    "ifconfig.io", -- website that gives ip info
    "ipaddress.sh", -- website that gives ip info
    "ligma.wtf", -- used with kfc obfuscator
    "library.veryverybored", -- used with kfc obfuscator
    "repl.co", -- some malicious webservers use repl.co (though there are some legit ones)
    "repl.it", -- same as repl.co
    "myip.com" -- website that gives ip info
}
_G.BlockedContent = _G.BlockedContent or {
    ["Player name"] = plr.Name,
    ["Server ID"] = game.JobId,
    ["Place ID"] = game.PlaceId,
    ["Executor name"] = (identifyexecutor or getexecutor or getexecutorname or function() return "Unknown" end)(),
}

rconsoleclear()

rconsoleprint("@@BLUE@@")
rconsoleprint([[
---------------------------------------------
   __ __ ______ ______ ___    ____          
  / // //_  __//_  __// _ \  / __/___  __ __
 / _  /  / /    / /  / ___/ _\ \ / _ \/ // /
/_//_/  /_/    /_/  /_/    /___// .__/\_, / 
                               /_/   /___/  
---------------------------------------------
]])

-- intro
rconsoleprint("@@LIGHT_MAGENTA@@")
rconsoleprint("Made by topit\nUpdated 12/7/21\n")

-- blocked stuff
do
    rconsoleprint("@@LIGHT_BLUE@@")
    rconsoleprint("\n\nBlocked URL content (")
    rconsoleprint("@@LIGHT_MAGENTA@@")
    rconsoleprint("_G")
    rconsoleprint("@@WHITE@@")
    rconsoleprint(".BlockedDomains")
    rconsoleprint("@@LIGHT_BLUE@@")
    rconsoleprint("):")
    for i,v in ipairs(_G.BlockedDomains) do
        rconsoleprint("@@LIGHT_BLUE@@")
        rconsoleprint("\n => ")
        rconsoleprint("@@WHITE@@")
        rconsoleprint(v)
    end
    
    rconsoleprint("@@LIGHT_BLUE@@")
    rconsoleprint("\n\nBlocked body content (")
    rconsoleprint("@@LIGHT_MAGENTA@@")
    rconsoleprint("_G")
    rconsoleprint("@@WHITE@@")
    rconsoleprint(".BlockedContent")
    rconsoleprint("@@LIGHT_BLUE@@")
    rconsoleprint("):")
    for i,v in pairs(_G.BlockedContent) do
        rconsoleprint("@@LIGHT_BLUE@@")
        rconsoleprint("\n => ")
        rconsoleprint("@@WHITE@@")
        rconsoleprint(i)
        rconsoleprint("@@DARK_GRAY@@")
        rconsoleprint(" ("..tostring(v)..")")
    end
end
-- hook namecalls
do
    rconsoleprint("@@LIGHT_BLUE@@")
    rconsoleprint("\n\nNamecalls hooked:")
    local old1
    old1 = hookmetamethod(game, "__namecall", function(a,b,...)
        local nc = getnamecallmethod()
        if nc:match("Get") then
            if nc:match("HttpGet") then
                do
                    local blocked = {}
                    local line = debug.traceback():gsub("[^\n]+\n-","",1):match(":(%d)")
                    
                    for _,url in ipairs(_G.BlockedDomains) do
                        if b:match(url) then
                            table.insert(blocked, url)
                        end
                    end
                    rconsoleprint("@@LIGHT_BLUE@@")
                    rconsoleprint("\n ["..os.date("%X").."] => ")
                    rconsoleprint("@@LIGHT_RED@@")
                    rconsoleprint("game")
                    rconsoleprint("@@WHITE@@")
                    rconsoleprint(":")
                    rconsoleprint("@@YELLOW@@")
                    rconsoleprint(nc)
                    rconsoleprint("@@LIGHT_CYAN@@")
                    rconsoleprint("\n   -Blocked: ")
                    if #blocked > 0 then
                        rconsoleprint("@@LIGHT_GREEN@@")
                        rconsoleprint("Yes")
                    else
                        rconsoleprint("@@LIGHT_RED@@")
                        rconsoleprint("No")
                    end
                    rconsoleprint("@@LIGHT_CYAN@@")
                    rconsoleprint("\n   -URL: ")
                    rconsoleprint("@@WHITE@@")
                    if b then
                        rconsoleprint(tostring(b))
                    else
                        rconsoleprint("N/A")
                    end
                    rconsoleprint("@@LIGHT_CYAN@@")
                    rconsoleprint("\n   -Line: "..line)
                    
                    if #blocked > 0 then 
                        rconsoleprint("@@LIGHT_RED@@")
                        rconsoleprint("\nAn attempt to make a possibly malicious request was made. Blacklisted content detected: ")
                        for _,content in ipairs(blocked) do
                            rconsoleprint("\n    -"..content)
                        end
                        rconsoleprint("\n")
                        blocked = nil
                        return nil 
                    end
                end
            elseif nc:match("GetObjects") then
                do
                    
                    local blocked = {}
                    local line = debug.traceback():gsub("[^\n]+\n-","",1):match(":(%d)")
                    
                    rconsoleprint("@@LIGHT_BLUE@@")
                    rconsoleprint("\n ["..os.date("%X").."] => ")
                    rconsoleprint("@@LIGHT_RED@@")
                    rconsoleprint("game")
                    rconsoleprint("@@WHITE@@")
                    rconsoleprint(":")
                    rconsoleprint("@@YELLOW@@")
                    rconsoleprint(nc)
                    rconsoleprint("@@LIGHT_CYAN@@")
                    rconsoleprint("\n   -Asset: ")
                    rconsoleprint("@@WHITE@@")
                    if b then
                        rconsoleprint(tostring(b))
                    else
                        rconsoleprint("N/A")
                    end
                    rconsoleprint("@@LIGHT_CYAN@@")
                    rconsoleprint("\n   -Line: "..line)
                end
            end
        elseif nc:match("Post") then
            if nc:match("HttpPost") then 
                do
                    local c,d,e,f,g = ...
                    
                
                    local blocked = {}
                    local line = debug.traceback():gsub("[^\n]+\n-","",1):match(":(%d)")
                
                    for _,url in ipairs(_G.BlockedDomains) do
                        if b:match(url) then
                            table.insert(blocked, url)
                        end
                    end
                    rconsoleprint("@@LIGHT_BLUE@@")
                    rconsoleprint("\n ["..os.date("%X").."] => ")
                    rconsoleprint("@@LIGHT_RED@@")
                    rconsoleprint("game")
                    rconsoleprint("@@WHITE@@")
                    rconsoleprint(":")
                    rconsoleprint("@@YELLOW@@")
                    rconsoleprint(nc)
                    rconsoleprint("@@LIGHT_CYAN@@")
                    rconsoleprint("\n   -Blocked: ")
                    if #blocked > 0 then
                        rconsoleprint("@@LIGHT_GREEN@@")
                        rconsoleprint("Yes")
                    else
                        rconsoleprint("@@LIGHT_RED@@")
                        rconsoleprint("No")
                    end
                    rconsoleprint("@@LIGHT_CYAN@@")
                    rconsoleprint("\n   -URL: ")
                    rconsoleprint("@@WHITE@@")
                    if b then
                        rconsoleprint(tostring(b))
                    else
                        rconsoleprint("N/A")
                    end
                    rconsoleprint("@@LIGHT_CYAN@@")
                    rconsoleprint("\n   -Line: "..line)
                    if c then
                        rconsoleprint("\n   -Data:")
                        rconsoleprint("\n      -"..tostring(c))
                    end
                    if d then
                        rconsoleprint("\n      -"..tostring(d))
                    end
                    if e then
                        rconsoleprint("\n      -"..tostring(e))
                    end
                    if f then
                        rconsoleprint("\n      -"..tostring(f))
                    end
                    if g then
                        rconsoleprint("\n      -"..tostring(g))
                    end
                    
                    if #blocked > 0 then 
                        rconsoleprint("@@LIGHT_RED@@")
                        rconsoleprint("\nAn attempt to make a possibly malicious request was made. Blacklisted content detected: ")
                        for _,content in ipairs(blocked) do
                            rconsoleprint("\n    -"..content)
                        end
                        rconsoleprint("\n")
                        blocked = nil
                        return nil 
                    end
                end
            end
        end
        
        return old1(a,b,...) 
    end)
    
    local a = {"HttpGet","HttpPost","HttpGetAsync","HttpPostAsync","GetObjects"}
    table.foreach(a,function(i,v) 
        rconsoleprint("@@LIGHT_BLUE@@")
        rconsoleprint("\n => ")
        rconsoleprint("@@LIGHT_RED@@")
        rconsoleprint("game")
        rconsoleprint("@@WHITE@@")
        rconsoleprint(":")
        rconsoleprint("@@YELLOW@@")
        rconsoleprint(v)
    end)
    
    a = nil
end
-- hook functions
do
    rconsoleprint("@@LIGHT_BLUE@@")
    rconsoleprint("\n\nFunctions hooked:")

    local old2
    old2 = hookfunction(game.HttpGet, function(...) 
        local a,b = ...
        
        
        local blocked = {}
        local line = debug.traceback():gsub("[^\n]+\n-","",1):match(":(%d)")
        
        for _,url in ipairs(_G.BlockedDomains) do
            if b:match(url) then
                table.insert(blocked, url)
            end
        end
        
        rconsoleprint("@@LIGHT_BLUE@@")
        rconsoleprint("\n ["..os.date("%X").."] => ")
        
        rconsoleprint("@@LIGHT_RED@@")
        rconsoleprint("game")
        rconsoleprint("@@WHITE@@")
        rconsoleprint(".")
        rconsoleprint("@@YELLOW@@")
        rconsoleprint("HttpGet")
        
        rconsoleprint("@@LIGHT_CYAN@@")
        rconsoleprint("\n   -Blocked: ")
        if #blocked > 0 then
            rconsoleprint("@@LIGHT_GREEN@@")
            rconsoleprint("Yes")
        else
            rconsoleprint("@@LIGHT_RED@@")
            rconsoleprint("No")
        end
        rconsoleprint("@@LIGHT_CYAN@@")
        rconsoleprint("\n   -URL: ")
        rconsoleprint("@@WHITE@@")
        if b then
            rconsoleprint(tostring(b))
        else
            rconsoleprint("N/A")
        end
        rconsoleprint("@@LIGHT_CYAN@@")
        rconsoleprint("\n   -Line: "..line)
        
        
        
        
        
        
        if #blocked > 0 then 
            rconsoleprint("@@LIGHT_RED@@")
            rconsoleprint("\nAn attempt to make a possibly malicious request was made. Blacklisted content detected: ")
            for _,content in ipairs(blocked) do
                rconsoleprint("\n    -"..content)
            end
            rconsoleprint("\n")
            blocked = nil
            return nil 
        end
        return old2(...)
    end)
    
    rconsoleprint("@@LIGHT_BLUE@@")
    rconsoleprint("\n => ")
    rconsoleprint("@@LIGHT_RED@@")
    rconsoleprint("game")
    rconsoleprint("@@WHITE@@")
    rconsoleprint(".")
    rconsoleprint("@@YELLOW@@")
    rconsoleprint("HttpGet")
    
    local old2
    old2 = hookfunction(game.HttpGetAsync, function(...) 
        local a,b = ...
        
        
        local blocked = {}
        local line = debug.traceback():gsub("[^\n]+\n-","",1):match(":(%d)")
        
        for _,url in ipairs(_G.BlockedDomains) do
            if b:match(url) then
                table.insert(blocked, url)
            end
        end
        
        rconsoleprint("@@LIGHT_BLUE@@")
        rconsoleprint("\n ["..os.date("%X").."] => ")
        
        rconsoleprint("@@LIGHT_RED@@")
        rconsoleprint("game")
        rconsoleprint("@@WHITE@@")
        rconsoleprint(".")
        rconsoleprint("@@YELLOW@@")
        rconsoleprint("HttpGetAsync")
        
        rconsoleprint("@@LIGHT_CYAN@@")
        rconsoleprint("\n   -Blocked: ")
        if #blocked > 0 then
            rconsoleprint("@@LIGHT_GREEN@@")
            rconsoleprint("Yes")
        else
            rconsoleprint("@@LIGHT_RED@@")
            rconsoleprint("No")
        end
        rconsoleprint("@@LIGHT_CYAN@@")
        rconsoleprint("\n   -URL: ")
        rconsoleprint("@@WHITE@@")
        if b then
            rconsoleprint(tostring(b))
        else
            
            rconsoleprint("N/A")
        end
        rconsoleprint("@@LIGHT_CYAN@@")
        rconsoleprint("\n   -Line: "..line)
        
        if #blocked > 0 then 
            rconsoleprint("@@LIGHT_RED@@")
            rconsoleprint("\nAn attempt to make a possibly malicious request was made. Blacklisted content detected: ")
            for _,content in ipairs(blocked) do
                rconsoleprint("\n    -"..content)
            end
            rconsoleprint("\n")
            blocked = nil
            return nil 
        end
        
        return old2(...)
    end)
    
    rconsoleprint("@@LIGHT_BLUE@@")
    rconsoleprint("\n => ")
    rconsoleprint("@@LIGHT_RED@@")
    rconsoleprint("game")
    rconsoleprint("@@WHITE@@")
    rconsoleprint(".")
    rconsoleprint("@@YELLOW@@")
    rconsoleprint("HttpGetAsync")
    
    -- i dont think HttpPost even works anymore
    -- so im just gonna bs this one
    local old2
    old2 = hookfunction(game.HttpPost, function(...) 
        local a,b,c,d,e,f,g = ...
        
        local blocked = {}
        local line = debug.traceback():gsub("[^\n]+\n-","",1):match(":(%d)")
        
        for _,url in ipairs(_G.BlockedDomains) do
            if b:match(url) then
                table.insert(blocked, url)
            end
        end
        
        rconsoleprint("@@LIGHT_BLUE@@")
        rconsoleprint("\n ["..os.date("%X").."] => ")
        rconsoleprint("@@LIGHT_RED@@")
        rconsoleprint("game")
        rconsoleprint("@@WHITE@@")
        rconsoleprint(".")
        rconsoleprint("@@YELLOW@@")
        rconsoleprint("HttpPost")
        rconsoleprint("@@LIGHT_CYAN@@")
        rconsoleprint("\n   -Blocked: ")
        if #blocked > 0 then
            rconsoleprint("@@LIGHT_GREEN@@")
            rconsoleprint("Yes")
        else
            rconsoleprint("@@LIGHT_RED@@")
            rconsoleprint("No")
        end
        rconsoleprint("@@LIGHT_CYAN@@")
        rconsoleprint("\n   -URL: ")
        rconsoleprint("@@WHITE@@")
        if b then
            rconsoleprint(tostring(b))
        else
            rconsoleprint("N/A")
        end
        rconsoleprint("@@LIGHT_CYAN@@")
        rconsoleprint("\n   -Line: "..line)
        if c then
        rconsoleprint("\n   -Data:")
        rconsoleprint("\n      -"..tostring(c))
        end
        if d then
            rconsoleprint("\n      -"..tostring(d))
        end
        if e then
            rconsoleprint("\n      -"..tostring(e))
        end
        if f then
            rconsoleprint("\n      -"..tostring(f))
        end
        if g then
            rconsoleprint("\n      -"..tostring(g))
        end
        
        if #blocked > 0 then 
            rconsoleprint("@@LIGHT_RED@@")
            rconsoleprint("\nAn attempt to make a possibly malicious request was made. Blacklisted content detected: ")
            for _,content in ipairs(blocked) do
                rconsoleprint("\n    -"..content)
            end
            rconsoleprint("\n")
            blocked = nil
            return nil 
        end
        
        return old2(...)
    end)
    
    rconsoleprint("@@LIGHT_BLUE@@")
    rconsoleprint("\n => ")
    rconsoleprint("@@LIGHT_RED@@")
    rconsoleprint("game")
    rconsoleprint("@@WHITE@@")
    rconsoleprint(".")
    rconsoleprint("@@YELLOW@@")
    rconsoleprint("HttpPost")
    
    -- same as above
    local old2
    old2 = hookfunction(game.HttpPostAsync, function(...) 
        local a,b,c,d,e,f,g = ...
        
        local blocked = {}
        local line = debug.traceback():gsub("[^\n]+\n-","",1):match(":(%d)")
        
        for _,url in ipairs(_G.BlockedDomains) do
            if b:match(url) then
                table.insert(blocked, url)
            end
        end
        
        rconsoleprint("@@LIGHT_BLUE@@")
        rconsoleprint("\n ["..os.date("%X").."] => ")
        rconsoleprint("@@LIGHT_RED@@")
        rconsoleprint("game")
        rconsoleprint("@@WHITE@@")
        rconsoleprint(".")
        rconsoleprint("@@YELLOW@@")
        rconsoleprint("HttpPostAsync")
        rconsoleprint("@@LIGHT_CYAN@@")
        rconsoleprint("\n   -Blocked: ")
        if #blocked > 0 then
            rconsoleprint("@@LIGHT_GREEN@@")
            rconsoleprint("Yes")
        else
            rconsoleprint("@@LIGHT_RED@@")
            rconsoleprint("No")
        end
        rconsoleprint("@@LIGHT_CYAN@@")
        rconsoleprint("\n   -URL: ")
        rconsoleprint("@@WHITE@@")
        if b then
            rconsoleprint(tostring(b))
        else
            rconsoleprint("N/A")
        end
        rconsoleprint("@@LIGHT_CYAN@@")
        rconsoleprint("\n   -Line: "..line)
        if c then
            rconsoleprint("\n   -Data:")
            rconsoleprint("\n      -"..tostring(c))
        end
        if d then
            rconsoleprint("\n      -"..tostring(d))
        end
        if e then
            rconsoleprint("\n      -"..tostring(e))
        end
        if f then
            rconsoleprint("\n      -"..tostring(f))
        end
        if g then
            rconsoleprint("\n      -"..tostring(g))
        end
        
        if #blocked > 0 then 
            rconsoleprint("@@LIGHT_RED@@")
            rconsoleprint("\nAn attempt to make a possibly malicious request was made. Blacklisted content detected: ")
            for _,content in ipairs(blocked) do
                rconsoleprint("\n    -"..content)
            end
            rconsoleprint("\n")
            blocked = nil
            return nil 
        end
        
        return old2(...)
    end)
    
    rconsoleprint("@@LIGHT_BLUE@@")
    rconsoleprint("\n => ")
    rconsoleprint("@@LIGHT_RED@@")
    rconsoleprint("game")
    rconsoleprint("@@WHITE@@")
    rconsoleprint(".")
    rconsoleprint("@@YELLOW@@")
    rconsoleprint("HttpPostAsync")
end
-- hook request
rconsoleprint("@@LIGHT_BLUE@@")
rconsoleprint("\n => ")
if syn then
    rconsoleprint("@@LIGHT_RED@@")
    rconsoleprint("syn")
    rconsoleprint("@@WHITE@@")
    rconsoleprint(".")
    rconsoleprint("@@YELLOW@@")
    rconsoleprint("request")
    
    local old
    old = hookfunction(syn.request, function(...) 
        local data = ...
        
        
        local blocked = {}
        local line = debug.traceback():gsub("[^\n]+\n-","",1):match(":(%d)")
        
        if type(data.Body) == "string" then 
            for name,content in pairs(_G.BlockedContent) do
                if data.Body:match(content) then
                    table.insert(blocked, name)
                end
            end
        end
        if type(data.Url) == "string" then 
            for _,url in ipairs(_G.BlockedDomains) do
                if data.Url:match(url) then
                    table.insert(blocked, url)
                end
            end
        end
        
        rconsoleprint("@@LIGHT_BLUE@@")
        rconsoleprint("\n ["..os.date("%X").."] => ")
        
        rconsoleprint("@@LIGHT_RED@@")
        rconsoleprint("syn")
        rconsoleprint("@@WHITE@@")
        rconsoleprint(".")
        rconsoleprint("@@YELLOW@@")
        rconsoleprint("request")
        
        rconsoleprint("@@LIGHT_CYAN@@")
        rconsoleprint("\n   -Line: "..line)
        rconsoleprint("\n   -Blocked: ")
        if #blocked > 0 then
            rconsoleprint("@@LIGHT_GREEN@@")
            rconsoleprint("Yes")
        else
            rconsoleprint("@@LIGHT_RED@@")
            rconsoleprint("No")
        end
        rconsoleprint("@@LIGHT_CYAN@@")
        rconsoleprint("\n   -Data:")
        rconsoleprint("\n   -URL: ")
        rconsoleprint("@@WHITE@@")
        if data.Url then
            rconsoleprint(tostring(data.Url))
        else
            rconsoleprint("N/A")
        end
        rconsoleprint("@@LIGHT_CYAN@@")
        rconsoleprint("\n   -Method: ")
        rconsoleprint("@@WHITE@@")
        if data.Method then
            rconsoleprint(tostring(data.Method))
        else
            rconsoleprint("N/A")
        end
        rconsoleprint("@@LIGHT_CYAN@@")
        if type(data.Headers) == "table" then
            rconsoleprint("\n      -Headers:")
            for i,v in pairs(data.Headers) do
                rconsoleprint("\n         -"..tostring(i)..": "..tostring(v)) 
            end
        end
        if type(data.Cookies) == "table" then
            rconsoleprint("\n      -Cookies:")
            for i,v in pairs(data.Cookies) do
                rconsoleprint("\n         -"..tostring(i)..": "..tostring(v)) 
            end
        end
        rconsoleprint("\n      -Body: "..(data.Body and data.Body or "nil"))
        
        if #blocked > 0 then 
            rconsoleprint("@@LIGHT_RED@@")
            rconsoleprint("\nAn attempt to make a possibly malicious request was made. Blacklisted content detected: ")
            for _,content in ipairs(blocked) do
                rconsoleprint("\n    -"..content)
            end
            rconsoleprint("\n")
            blocked = nil
            return nil 
        end
        
        return old(...)
    end)
else
    local func = http and http.request or request or http_request
    if func then
        local old
        old = hookfunction(func, function(...) 
            local data = ...
            
            local blocked = {}
            local line = debug.traceback():gsub("[^\n]+\n-","",1):match(":(%d)")
            
            if type(data.Body) == "string" then 
                for name,content in pairs(_G.BlockedContent) do
                    if data.Body:match(content) then
                        table.insert(blocked, name)
                    end
                end
            end
            if type(data.Url) == "string" then 
                for _,url in ipairs(_G.BlockedDomains) do
                    if data.Url:match(url) then
                        table.insert(blocked, url)
                    end
                end
            end
            
            rconsoleprint("@@LIGHT_BLUE@@")
            rconsoleprint("\n ["..os.date("%X").."] => ")
            
            rconsoleprint("@@LIGHT_RED@@")
            rconsoleprint("syn")
            rconsoleprint("@@WHITE@@")
            rconsoleprint(".")
            rconsoleprint("@@YELLOW@@")
            rconsoleprint("request")
            
            rconsoleprint("@@LIGHT_CYAN@@")
            rconsoleprint("\n   -Line: "..line)
            rconsoleprint("\n   -Blocked: ")
            if #blocked > 0 then
                rconsoleprint("@@LIGHT_GREEN@@")
                rconsoleprint("Yes")
            else
                rconsoleprint("@@LIGHT_RED@@")
                rconsoleprint("No")
            end
            rconsoleprint("@@LIGHT_CYAN@@")
            rconsoleprint("\n   -Data:")
            rconsoleprint("\n   -URL: ")
            rconsoleprint("@@WHITE@@")
            if data.Url then
                rconsoleprint(tostring(data.Url))
            else
                rconsoleprint("N/A")
            end
            rconsoleprint("@@LIGHT_CYAN@@")
            rconsoleprint("\n   -Method: ")
            rconsoleprint("@@WHITE@@")
            if data.Method then
                rconsoleprint(tostring(data.Method))
            else
                rconsoleprint("N/A")
            end
            rconsoleprint("@@LIGHT_CYAN@@")
            if type(data.Headers) == "table" then
                rconsoleprint("\n      -Headers:")
                for i,v in pairs(data.Headers) do
                    rconsoleprint("\n         -"..tostring(i)..": "..tostring(v)) 
                end
            end
            if type(data.Cookies) == "table" then
                rconsoleprint("\n      -Cookies:")
                for i,v in pairs(data.Cookies) do
                    rconsoleprint("\n         -"..tostring(i)..": "..tostring(v)) 
                end
            end
            rconsoleprint("\n      -Body: "..(data.Body and data.Body or "nil"))
            
            if #blocked > 0 then 
                rconsoleprint("@@LIGHT_RED@@")
                rconsoleprint("\nAn attempt to make a possibly malicious request was made. Blacklisted content detected: ")
                for _,content in ipairs(blocked) do
                    rconsoleprint("\n    -"..content)
                end
                rconsoleprint("\n")
                blocked = nil
                return nil 
            end
            
            return old(...)
        end)
    end
end

-- logs
rconsoleprint("\n\n")
rconsoleprint("@@LIGHT_BLUE@@")
rconsoleprint("Logs:")
