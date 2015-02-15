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
	myMap:onClick(x, y)	
	if (love.mouse.isDown('r')) then
		x,y = love.mouse.getPosition()
		if (x<150 and x>50) then
			if (y<570 and y>520) then
				myMap:startWave()
			end
		end
	end
end
function love.keypressed(key)
   if key == "escape" then
      love.event.quit()
   end
end