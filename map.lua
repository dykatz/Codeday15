require 'class'
require 'node'
require 'creep'

map = class:subclass()

function map:init(x, y, width, height, radius)
	self.x = x
	self.y = y
	self.radius = radius
	self.width = width
	self.height = height
	self.inWave = false
	self.wave = 0
	self.money = 30
	self.health = 20
	self.creeps = {}

	for x = 1, width do
		self[x] = {}

		for y = 1, height do
			self[x][y] = node:new(self, x, y)
		end
	end

	self.creepEntranceNode = self:randomEdgeNode()
	self:regenerateRoute()
end

function map:draw(x, y, radius)
	for i = 1, self.width do
		for j = 1, self.height do
			self[i][j]:draw()
		end
	end

	self:drawRoute(self.route)

	for _, creep in ipairs(self.creeps) do
		creep:draw()
	end
end

function map:drawRoute(route)
	local line = {}

	for _, k in ipairs(route) do
		local x, y = k:getPositionOnScreen()
		table.insert(line, x)
		table.insert(line, y)
	end

	love.graphics.line(line)
end

function map:randomEdgeNode()
	local nodenum = love.math.random(1, (self.width + self.height) * 2 - 4)

	if nodenum <= self.width then
		return self[nodenum][1]
	elseif nodenum <= self.width + self.height - 1 then
		return self[self.width][nodenum - self.height]
	elseif nodenum <= 2 * self.width + self.height - 2 then
		return self[2 * self.width + self.height - 1 - nodenum][self.height]
	else
		return self[1][(self.width + self.height) * 2 - 2 - nodenum]
	end
end

function map:randomNode()
	return self[love.math.random(1, self.width)][love.math.random(1, self.height)]
end

function map:centerNode()
	return self[math.ceil(self.width / 2)][math.ceil(self.height / 2)]
end

function map:regenerateRoute()
	self.route = self.creepEntranceNode:getRoute(self:centerNode())
end

function map:onClick(x, y)
	for _, row in ipairs(self) do
		for _, n in ipairs(row) do
			n:onClick(x, y)
		end
	end

	if not self.inWave then
		self:regenerateRoute()
	end
end

function map:update(dt)
	for _, creep in pairs(self.creeps) do
		creep:update(dt)
	end

	if #self.creeps == 0 and self.inWave then
		self.inWave = false
		self.creepEntranceNode = self:randomEdgeNode()
	end
end

function map:startWave()
	self.wave = self.wave + 1
	self.inWave = true
end
