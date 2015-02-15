require 'class'
require 'util'
require 'map'

function love.load()
	myMap = map:new(0, 0, 20, 20, 10)
	myRoute = myMap[1][2]:getRoute(myMap[20][15])
end

function love.update(dt)

end

function love.draw()
	myMap:draw()
	map:drawRoute(myRoute)
end

function love.mousepressed(x, y, b)
	myMap:onClick(x, y)
	myRoute = myMap[1][2]:getRoute(myMap[20][15])
end
