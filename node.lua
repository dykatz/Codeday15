require 'class'

node = class:subclass()

function node:init(parent, x, y)
	self.parent = parent
	self.x = x
	self.y = y
	self.neighbors = {}
	self.blocking = false
end

function node:neighbors()
	return coroutine.wrap(function()
		if self.x > 1 then
			coroutine.yield(self.parent[self.x - 1][self.y])
		end

		if self.x < self.parent.width then
			coroutine.yield(self.parent[self.x + 1][self.y])
		end

		if self.y > 1 then
			coroutine.yield(self.parent[self.x][self.y - 1])
		end

		if self.y < self.parent.height then
			coroutine.yield(self.parent[self.x][self.y + 1])
		end
	end)
end

function node:distanceFrom(arg)
	return math.sqrt((self.x - arg.x)^2 + (self.y - arg.y)^2)
end

function node:draw(x, y, radius)
	love.graphics.circle('line', x + 2 * self.x * radius, y + 2 * self.y * radius, radius - 1)
end
