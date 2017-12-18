local Util = require("util")


function love.load()
	time = 0
	loadingTime = 8
	draw = true

	introText = "Vehicle Simulator Toolbox"
	introTextAsian = "車両シミュレータツールボックス"

	conthraxFont = love.graphics.newFont("assets/conthrax-sb.ttf", 14)
	logotypejpFont = love.graphics.newFont("assets/logotypejp_mp_m_1.ttf", 20)

	sound = love.audio.newSource("assets/st014.mp3", "static")
	sound:play()
end


function love.update(dt)
	time = time + dt

	if time >= loadingTime then
		love.filesystem.load("vehicle_select.lua")()
		love.load()
	end
end


function love.draw()
	love.graphics.setFont(logotypejpFont)
	local xPos = 10
	local yPos = 10

	love.graphics.setFont(conthraxFont)
	love.graphics.print(introText, xPos, yPos)

	love.graphics.setFont(logotypejpFont)
	love.graphics.print(introTextAsian, xPos, yPos+conthraxFont:getHeight())

	love.graphics.setFont(conthraxFont)
	Util.centered_print("Connecting...",
		0, 0,
		love.graphics.getWidth(),
		love.graphics.getHeight(),
		0, 0)

	local versionText = "ver.3.54"
	love.graphics.setFont(conthraxFont)
	yPos = love.graphics.getHeight() - conthraxFont:getHeight() - 10
	xPos = love.graphics.getWidth() - conthraxFont:getWidth(versionText) - 10
	love.graphics.print(versionText, xPos, yPos)

end
