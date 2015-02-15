require 'class'
require 'util'

creep = class:subclass()

function creep:init(parent)
	self.parent = parent
	self.route = self.parent.route
	self.health = 50
	self.nodeId = 1
	self.speed = 1
	self.value = 1
	self.x, self.y = self.route[self.nodeId]:getPositionOnScreen()

	if not table.contains(self.parent.creeps, self) then
		table.insert(self.parent.creeps, self)
	end
end

function creep:draw()
	love.graphics.setColor(255, 0, 0)
	love.graphics.circle('fill', self.x, self.y, self.parent.radius / 2)
	love.graphics.setColor(255, 255, 255)
end

function creep:update(dt)
	local xnew, ynew = self.route[self.nodeId + 1]:getPositionOnScreen()
	local speed = self.speed * self.parent.radius * dt
	local dirx, diry = math.sign(xnew - self.x), math.sign(ynew - self.y)
	self.x, self.y = self.x + dirx * speed, self.y + diry * speed

	if (dirx * self.x >= dirx * xnew and dirx ~= 0) or
	   (diry * self.y >= diry * ynew and diry ~= 0) then
		self.nodeId = self.nodeId + 1
		self.x, self.y = xnew, ynew

		if self.nodeId == #self.route then
			self.parent.health = self.parent.health - self.value
			table.remove(self.parent.creeps, table.find(self.parent.creeps, self))
		end
	end

	if self.health <= 0 then
		self.parent.money = self.parent.money + self.value
		table.remove(self.parent.money, table.find(self.parent.money, self))
	end
end
