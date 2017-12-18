local Graphics = {}


function Graphics.toIso(sx, sy, x, y, z)
	nx = sx / 2 * (x - y)
	ny = sy / 2 * (x + y - z)

	return nx, ny
end


function Graphics.getCameraTransform(targetX, targetY, targetZ,
                                     width, height, offsetX, offsetY)
	local camOffsetX, camOffsetY = Graphics.toIso(1, 0.5, targetX, targetY, targetZ)

	local cameraTransform = {
		x = width/2 - camOffsetX + offsetX,
		y = height/2 - camOffsetY + offsetY 
	}

	return cameraTransform
end


function Graphics.create_sprite(imageFile, x, y, sx, sy)
	return love.graphics.newQuad(x, y, sx, sy, imageFile:getDimensions())
end


return Graphics
