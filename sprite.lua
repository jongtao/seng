local Sprite = {}

function Sprite.create(imageFile, x, y, sx, sy)
	local sprite = {
		imageFile=imageFile,
		quad=love.graphics.newQuad(x, y, sx, sy, imageFile:getDimensions())
	}

	return sprite
end

return Sprite
