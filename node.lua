require 'class'
require 'util'

node = class:subclass()

function node:init(parent, x, y)
	self.parent = parent
	self.x = x
	self.y = y
	self.blocking = false
	self.gScore = 0
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

local function reconstructPath(cameFrom, current)
	local totalPath = {current}

	while not table.find(cameFrom, current) and current ~= nil do
		current = current.cameFrom
		table.insert(totalPath, current)
	end

	return totalPath
end

function node:getRoute(goal)
	local closedSet = {}
	local openSet = {self}
	local cameFrom = {}
	self.gScore = 0
	self.fScore = self.gScore + self:distanceFrom(goal)

	while #openSet > 0 do
		table.sort(openSet, function(a, b) return a:distanceFrom(goal) < b:distanceFrom(goal) end)
		local current = openSet[1]

		if current == goal then
			return reconstructPath(cameFrom, goal)
		end

		table.remove(openSet, 1)
		table.insert(closedSet, current)

		for neighbor in current:neighbors() do
			if not table.contains(closedSet, neighbor) then
				local tg = current.gScore + current:distanceFrom(neighbor)

				if not table.contains(openSet, neighbor) or tg < neighbor.gScore then
					neighbor.cameFrom = current
					neighbor.gScore = tg
					neighbor.fScore = neighbor.gScore + neighbor:distanceFrom(goal)

					if not table.contains(openSet, neighbor) then
						table.insert(openSet, neighbor)
					end
				end
			end
		end
	end
end

function node:getPositionOnScreen()
	return self.parent.x + 2 * self.x * self.parent.radius, self.parent.y + 2 * self.y * self.parent.radius
end

function node:draw()
	local myX, myY = self:getPositionOnScreen()

	if self.blocking then
		love.graphics.circle('fill', myX, myY, self.parent.radius - 1)
	else
		love.graphics.circle('line', myX, myY, self.parent.radius - 1)
	end
end

function node:onClick(mouseX, mouseY)
	local myX, myY = self:getPositionOnScreen()

	if myX^2 + myY^2 < self.parent.radius^2 then
		self.blocking = not self.blocking
	end
end