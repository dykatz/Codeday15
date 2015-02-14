require 'class'
require 'node'

map = class:subclass()

function map:init(width, height)
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
			self[i][j]:draw(x, y, radius)
		end
	end
end
