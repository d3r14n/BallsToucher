Button =
{
	image = "sprites/button.png",
	x = 0,
	y = 0,
	width = 0,
	height = 0,
	display = false
}

function Button:new(object)
	object = object or {}
	setmetatable(object, self)
	self.__index = self
	return object
end

function Button:create(buttonImage, posicionX, posicionY, buttonWidth, buttonHeight)
	self.image = buttonImage
	self.x = posicionX
	self.y = posicionY
	self.width = buttonWidth
	self.height = buttonHeight
end

function Button:click(mouseX, mouseY)
	if mouseX > self.x and mouseX < (self.x + self.width/2) and mouseY > self.y and mouseY < (self.y + self.height/2) and self.display then
		return true
	else
		return false
	end
end

function Button:relocate(newX, newY)
	self.x = newX
	self.y = newY
end

function Button:changeButtonImage(newImage)
	self.image = newImage
end

function Button:show()
	self.display = true
end

function Button:hide()
	self.display = false
end

return Button