local Position  = lovetoys.Component.create("Position")

function Position:initialize(x, y, z)
    self.x = x
    self.y = y
		self.z = z
end

return Position
