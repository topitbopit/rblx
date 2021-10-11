--[[
RBXEvent Library
RBXEvent.lua
Written by chasedig1. Contact for inquiries.
This script is licensed to the public, and is open source.


Not made by me (topit)
This is an upload to github as a perm link for my use


]]



local RBXEvent = {};
RBXEvent.__index = RBXEvent;

local EventListener = {} do
    EventListener.__index = EventListener;
    
    function EventListener.new(callback, disconnectFunction)
    	local listenerObject = {};
    	setmetatable(listenerObject, EventListener);
    	listenerObject.callback = callback;
    	listenerObject.disconnectFunction = disconnectFunction;
    	return listenerObject;
    end
    
    function EventListener:Disconnect()
    	self.disconnectFunction(self.id);
    end
    
    function EventListener:FireListener(...)
    	coroutine.resume(coroutine.create(function(...)
    		self.callback(...); -- Call the callback function associated to this event listener
    	end), ...);
    end
end



function RBXEvent.new()
	local RBXEventObject = {};
	setmetatable(RBXEventObject, RBXEvent);
	RBXEventObject.active = true;
	RBXEventObject.observers = {};
	return RBXEventObject;
end;

function RBXEvent:Fire(...) -- Fire the event
	for _,observer in pairs(self.observers) do
		observer:FireListener(...); -- Fire the listener with the variable number of arguments
	end;
end;

function RBXEvent:DisconnectListener(id)
	table.remove(self.observers, id);
end

function RBXEvent:Connect(callback)
	if (callback == nil) then
		error("The event callback function provided was nil");
		return;
	end
	local listener = EventListener.new(callback, function(id)
		self:DisconnectListener(id);
	end);
	listener.id = #self.observers + 1;
	table.insert(self.observers, listener);
	return listener;
end

function RBXEvent:Wait()
	local thread = coroutine.running();
	
	local connection;
	connection = self:Connect(function(...)
		connection:Disconnect();
		coroutine.resume(thread, ...);
	end)
	
	return coroutine.yield();
end

function RBXEvent:Destroy()
	for _,observer in pairs(self.observers) do
		observer:Disconnect();
	end
	self.observers = {};
	self.active = false;
end

return RBXEvent;
