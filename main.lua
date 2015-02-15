require 'class'
require 'util'
require 'map'

function love.load()
	myMap = map:new(0, 0, 21, 21, 10)
end

function love.update(dt)

end

function love.draw()
	myMap:draw()
end

function love.mousepressed(x, y, b)
	myMap:onClick(x, y)
end
