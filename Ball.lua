Ball =
{
	x=0,
	y=0,
	size=1,
	gravity=1,
	impulse=0,
	fall=0,
	energyLost = 0.75,
	movement=false,
	bounce=true,
	countsForLives=true,
	rotation=0
}

function Ball:new(object)
	object = object or {}
	setmetatable(object, self)
	self.__index = self
	return object
end

function Ball:create(posicionX, posicionY, tamano, gravedad, percent)
	self.x = posicionX
	self.y = posicionY
	self.size = tamano
	self.gravity = gravedad
	self.energyLost = percent
	self:start()
end

function Ball:start()
	self.movement = true
end

function Ball:stop()
	self.movement = false
	self.fall = 0
end

function Ball:move(nX, nY)
	self.x = nX
	self.y = nY
end

function Ball:changeSize(t)
	if t > 0 then
		self.size = t
	end
end

function Ball:modifyGravity(g)
	self.gravity = g
end

function Ball:impulse(n)
	self.impulse = n
	self.fall = self.fall + self.impulse
end

function Ball:plusVelocity(n)
	self.fall = self.fall + n
end

function Ball:reduceVelocityPercent(f)
	self.fall = self.fall * f
end

function Ball:setEnergyLost(e)
	self.energyLost = e
end

function Ball:setBounce(r)
	self.bounce = r
end

function Ball:doNotCountIt()
	self.countsForLives = false
end

function Ball:rotate(r)
	self.rotation = self.rotation + r
end

function Ball:startFalling()
	if self.movement then
		if self.bounce then
			self:move(self.x, self.y+self.fall)
			self:plusVelocity(self.gravity/240)
		else
			self:move(self.x, self.y-self.fall)
			self:plusVelocity(-self.gravity/240)
		end
		if self.y >= love.graphics.getHeight()-self.size/2 then
			self:setBounce(false)
			self:reduceVelocityPercent(self.energyLost)
			if self.fall <= 0.4 then
				self:stop()
			end
		end
		if self.fall <= 0 then
			if self.bounce then
				self:setBounce(false)
				self:stop()
			else
				self:plusVelocity(self.gravity/240)
				self:setBounce(true)
			end
		end
	end
end

return Ball