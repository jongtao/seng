local Util = require("util")


function love.load()
  time = 0
  loadingTime = 7
  draw = true

  introText = "SENG HEAVY INDUSTRIES"
  introTextAsian = "桒重工業"

  conthraxFont = love.graphics.newFont("assets/conthrax-sb.ttf", 14)
  logotypejpFont = love.graphics.newFont("assets/logotypejp_mp_m_1.ttf", 14)

  sound = love.audio.newSource("assets/st002.mp3", "static")
  sound:play()
end


function love.update(dt)
  time = time + dt

  if time >= loadingTime then
    love.filesystem.load("intro2.lua")()
    love.load()
  end
end


function love.draw()
  love.graphics.setFont(conthraxFont)
  Util.centered_print(introText,
                      0, 0,
                      love.graphics.getWidth(),
                      love.graphics.getHeight(),
                      0, 0)

  love.graphics.setFont(logotypejpFont)
  Util.centered_print(introTextAsian,
                      0, 0,
                      love.graphics.getWidth(),
                      love.graphics.getHeight(),
                      0, conthraxFont:getHeight())
end
