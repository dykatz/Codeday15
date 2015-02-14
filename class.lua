class = {}
class.__index = class

function class:subclass()
	local o = setmetatable({}, self)
	o.__index = o
	return o
end

function class:new(...)
	local o = setmetatable({}, self)
	if o.init then o:init(...) end
	return o
end

--[[

myClass = class:subclass()

function myClass:init(x, y, q)
	self.x = x
	self.y = y
	self.q = q
end

function myClass:myMethod()
	return (self.x + self.y) / self.q
end

myObject = myClass:new(23, 34, 45)
print(myObject:myMethod())

]]
