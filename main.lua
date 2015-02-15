require 'class'
require 'util'
require 'map'
require 'creep'

function love.load()
	myMap = map:new(0, 0, 35, 25, 10)
end

function love.update(dt)
	myMap:update(dt)
end

function love.draw()
	love.graphics.print("press escape to exit", 500, 535)
	love.graphics.print("Start Wave", 65, 535)
	love.graphics.rectangle('line', 50, 520, 100, 50)
	myMap:draw()
end

function love.mousepressed(x, y, b)
	if b == 'l' then
		myMap:onClick(x, y)
	elseif b == 'r' then
		myMap:onRightClick(x, y)
	end
end

function love.keypressed(k)
	if k == 'r' then
		myMap.creepEntranceNode = myMap:randomEdgeNode()
		myMap:regenerateRoute()
	end
end
function love.keypressed(key)
   if key == "escape" then
      love.event.quit()
   end
end
