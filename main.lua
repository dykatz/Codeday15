require 'class'
require 'util'
require 'map'
require 'creep'

function love.load()
	myMap = map:new(0, 0, 35, 25, 10)
	myCreep = creep:new(myMap)
end

function love.update(dt)
	myMap:update(dt)
end

function love.draw()
	myMap:draw()
end

function love.mousepressed(x, y, b)
	myMap:onClick(x, y)
end
