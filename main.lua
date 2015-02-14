require 'class'
require 'map'

function love.load()
	myMap = map:new(20, 20)
end

function love.update(dt)

end

function love.draw()
	myMap:draw(0, 0, 10)
end
