-- Bootstrap

function love.load()
	--file = "intro.lua"
	--file = "intro2.lua"
	--file = "vehicle_select.lua"
	file = "overworld.lua"
	if not love.filesystem.exists(file) then
		print("Could not load file .. " .. file)
		return
	end
	
	love.filesystem.load(file)()
	love.load()
end
