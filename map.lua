require 'class'
require 'node'

map = class:subclass()

function map:init(x, y, width, height, radius)
	self.x = x
	self.y = y
	self.radius = radius
	self.width = width
	self.height = height

	for x = 1, width do
		self[x] = {}

		for y = 1, height do
			self[x][y] = node:new(self, x, y)
		end
	end
end

function map:draw(x, y, radius)
	for i = 1, self.width do
		for j = 1, self.height do
			self[i][j]:draw()
		end
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
