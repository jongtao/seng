local DrawCircle = lovetoys.Component.create("DrawCircle")


function tern(condition, main, alternative)
	if condition then
		return main
	else
		return alternative
	end
end


function DrawCircle:initialize(radius, colorR, colorG, colorB, style, segments)
	self.radius = radius

	self.colorR = colorR
	self.colorG = colorG
	self.colorB = colorB

	self.style = tern(style, style, "fill")
	self.segments = tern(segments, segments, 10)
end

return DrawCircle
