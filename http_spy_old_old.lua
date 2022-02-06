if not game:IsLoaded() then game.Loaded:Wait() end

local plr = game:GetService("Players").LocalPlayer
_G.BlockedDomains = _G.BlockedDomains or {
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
    "repl.it" -- same as repl.co
}

_G.BlockedContent = _G.BlockedContent or {
    ["Player name"] = plr.Name,
    ["Server ID"] = game.JobId,
    ["Place ID"] = game.PlaceId,
    ["KRNL"] = "KRNL",
    ["Synapse"] = "Synapse",
    ["Fluxus"] = "Fluxus",
    ["Scriptware"] = "Scriptware"
}






rconsoleclear()

rconsoleprint("@@BLUE@@")
rconsoleprint("---------------------------------------------\n"..[[
   __ __ ______ ______ ___    ____          
  / // //_  __//_  __// _ \  / __/___  __ __
 / _  /  / /    / /  / ___/ _\ \ / _ \/ // /
/_//_/  /_/    /_/  /_/    /___// .__/\_, / 
                               /_/   /___/  ]].."\n---------------------------------------------\n")

rconsoleprint("@@LIGHT_MAGENTA@@")
rconsoleprint("Made by topit\nUpdated 12/5/21\n")
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
            rconsoleprint("\n   -URL: "..b)
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
            
        elseif nc:match("Post") then
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
    return old1(a,b,...) 
end)
end
do
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
        rconsoleprint("\n   -URL: "..b)
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
        rconsoleprint("\n   -URL: "..b)
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
        
        
        local blocked = {}
        local line = debug.traceback():gsub("[^\n]+\n-","",1):match(":(%d)")
        
        for name,content in pairs(_G.BlockedContent) do
            if data.Body:match(content) then
                table.insert(blocked, name)
            end
        end
        for _,url in ipairs(_G.BlockedDomains) do
            if data.Url:match(url) then
                table.insert(blocked, url)
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
            
            for name,content in pairs(_G.BlockedContent) do
                if data.Body:match(content) then
                    table.insert(blocked, name)
                end
            end
            for _,url in ipairs(_G.BlockedDomains) do
                if data.Url:match(url) then
                    table.insert(blocked, url)
                end
            end
            
            rconsoleprint("@@LIGHT_BLUE@@")
            rconsoleprint("\n ["..os.date("%X").."] => ")
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
rconsoleprint("\n\n")
rconsoleprint("@@LIGHT_BLUE@@")
rconsoleprint("Logs:")
