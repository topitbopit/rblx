_G.Block000 = _G.Block000 or true


rconsoleclear()

rconsoleprint("@@BLUE@@")
rconsoleprint("---------------------------------------------\n"..[[
   __ __ ______ ______ ___    ____          
  / // //_  __//_  __// _ \  / __/___  __ __
 / _  /  / /    / /  / ___/ _\ \ / _ \/ // /
/_//_/  /_/    /_/  /_/    /___// .__/\_, / 
                               /_/   /___/  ]].."\n---------------------------------------------\n")

rconsoleprint("@@LIGHT_MAGENTA@@")
rconsoleprint("Made by topit\n")
rconsoleprint("@@LIGHT_BLUE@@")
rconsoleprint("Namecalls hooked:")

local a = {"HttpGet","HttpPost","HttpGetAsync","HttpPostAsync"}
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
rconsoleprint("@@LIGHT_BLUE@@")
rconsoleprint("\n\nFunctions hooked:")
table.foreach(a,function(i,v) 
    rconsoleprint("@@LIGHT_BLUE@@")
    rconsoleprint("\n => ")
    rconsoleprint("@@LIGHT_RED@@")
    rconsoleprint("game")
    rconsoleprint("@@WHITE@@")
    rconsoleprint(".")
    rconsoleprint("@@YELLOW@@")
    rconsoleprint(v)
end)
a = nil
do
    local old1
    old1 = hookmetamethod(game, "__namecall", function(a,b,...)
    local nc = getnamecallmethod()
    if nc:match("Http") then
        if nc:match("Get") then
            
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
            rconsoleprint("\n   -URL: "..b)
            rconsoleprint("\n   -Line: "..line)
            
        elseif nc:match("Post") then
            local c,d,e,f,g = ...
            
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
            rconsoleprint("\n   -URL: "..b)
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
        end
    end
    return old1(a,b,...) 
end)
end
do
    local old2
    old2 = hookfunction(game.HttpGet, function(...) 
        local a,b = ...
        
        local line = debug.traceback():gsub("[^\n]+\n-","",1):match(":(%d)")
        rconsoleprint("@@LIGHT_BLUE@@")
        rconsoleprint("\n ["..os.date("%X").."] => ")
        rconsoleprint("@@LIGHT_RED@@")
        rconsoleprint("game")
        rconsoleprint("@@WHITE@@")
        rconsoleprint(".")
        rconsoleprint("@@YELLOW@@")
        rconsoleprint("HttpGet")
        rconsoleprint("@@LIGHT_CYAN@@")
        rconsoleprint("\n   -URL: "..b)
        rconsoleprint("\n   -Line: "..line)
        return old2(...)
    end)
    
    local old2
    old2 = hookfunction(game.HttpGetAsync, function(...) 
        local a,b = ...
        
        local line = debug.traceback():gsub("[^\n]+\n-","",1):match(":(%d)")
        rconsoleprint("@@LIGHT_BLUE@@")
        rconsoleprint("\n ["..os.date("%X").."] => ")
        rconsoleprint("@@LIGHT_RED@@")
        rconsoleprint("game")
        rconsoleprint("@@WHITE@@")
        rconsoleprint(".")
        rconsoleprint("@@YELLOW@@")
        rconsoleprint("HttpGetAsync")
        rconsoleprint("@@LIGHT_CYAN@@")
        rconsoleprint("\n   -URL: "..b)
        rconsoleprint("\n   -Line: "..line)
        return old2(...)
    end)
    
    local old2
    old2 = hookfunction(game.HttpPost, function(...) 
        local a,b,c,d,e,f,g = ...
        
        local line = debug.traceback():gsub("[^\n]+\n-","",1):match(":(%d)")
        rconsoleprint("@@LIGHT_BLUE@@")
        rconsoleprint("\n ["..os.date("%X").."] => ")
        rconsoleprint("@@LIGHT_RED@@")
        rconsoleprint("game")
        rconsoleprint("@@WHITE@@")
        rconsoleprint(".")
        rconsoleprint("@@YELLOW@@")
        rconsoleprint("HttpPost")
        rconsoleprint("@@LIGHT_CYAN@@")
        rconsoleprint("\n   -URL: "..b)
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
        return old2(...)
    end)
    
    local old2
    old2 = hookfunction(game.HttpPostAsync, function(...) 
        local a,b,c,d,e,f,g = ...
        
        local line = debug.traceback():gsub("[^\n]+\n-","",1):match(":(%d)")
        rconsoleprint("@@LIGHT_BLUE@@")
        rconsoleprint("\n ["..os.date("%X").."] => ")
        rconsoleprint("@@LIGHT_RED@@")
        rconsoleprint("game")
        rconsoleprint("@@WHITE@@")
        rconsoleprint(".")
        rconsoleprint("@@YELLOW@@")
        rconsoleprint("HttpPostAsync")
        rconsoleprint("@@LIGHT_CYAN@@")
        rconsoleprint("\n   -URL: "..b)
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
        return old2(...)
    end)
end

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
        
        local line = debug.traceback():gsub("[^\n]+\n-","",1):match(":(%d)")
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
        rconsoleprint("\n   -Data:")
        rconsoleprint("\n      -Url: "..data.Url)
        rconsoleprint("\n      -Method: "..data.Method)
        if data.Headers then
            rconsoleprint("\n      -Headers:")
            for i,v in pairs(data.Headers) do
            rconsoleprint("\n         -"..tostring(i)..":"..tostring(v)) 
            end
        end
        if data.Cookies then
            rconsoleprint("\n      -Cookies:")
            for i,v in pairs(data.Cookies) do
            rconsoleprint("\n         -"..tostring(i)..":"..tostring(v)) 
            end
        end
        rconsoleprint("\n      -Body: "..data.Body)
        if data.Url:match('discord.com/api/webhooks/') then
            rconsoleprint("@@RED@@")
            rconsoleprint("\n\nBlocked an attempt to request a discord webhook.\n\n")
            return nil
        end
        
        if data.Url:match("000webhost") and _G.Block000 then
            rconsoleprint("@@RED@@")
            rconsoleprint("\n\nBlocked an attempt to request a 000webhost server.\nAlthough this may not be malicious, most of the time it is.\n")
            return nil
        end
        return old(...)
    end)
else
    local func = http and http.request or request or http_request
    if func then
        rconsoleprint("@@YELLOW@@")
        rconsoleprint(func)
        
        local old
        old = hookfunction(func, function(...) 
            local data = ...
            
            local line = debug.traceback():gsub("[^\n]+\n-","",1):match(":(%d)")
            rconsoleprint("@@LIGHT_BLUE@@")
            rconsoleprint("\n ["..os.date("%X").."] => ")
            rconsoleprint("@@YELLOW@@")
            rconsoleprint("request")
            rconsoleprint("@@LIGHT_CYAN@@")
            rconsoleprint("\n   -Line: "..line)
            rconsoleprint("\n   -Data:")
            rconsoleprint("\n      -Url: "..data.Url)
            rconsoleprint("\n      -Method: "..data.Method)
            if data.Headers then
                rconsoleprint("\n      -Headers:")
                for i,v in pairs(data.Headers) do
                rconsoleprint("\n         -"..tostring(i)..":"..tostring(v)) 
                end
            end
            if data.Cookies then
                rconsoleprint("\n      -Cookies:")
                for i,v in pairs(data.Cookies) do
                rconsoleprint("\n         -"..tostring(i)..":"..tostring(v)) 
                end
            end
            rconsoleprint("\n      -Body: "..data.Body)
            if data.Url:match('discord.com/api/webhooks/') then
                rconsoleprint("@@RED@@")
                rconsoleprint("\n\nBlocked an attempt to request a discord webhook.\n\n")
                return nil
            end
            return old(...)
        end)
    end
end
rconsoleprint("\n\n")
rconsoleprint("@@LIGHT_BLUE@@")
rconsoleprint("Logs:")
