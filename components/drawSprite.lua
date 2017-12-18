local DrawSprite = lovetoys.Component.create("DrawSprite")

function DrawSprite:initialize(image, quad, offsetX, offsetY)
	self.image = image
	self.quad = quad
	self.offsetX = offsetX
	self.offsetY = offsetY
end

return DrawSprite
