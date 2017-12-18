local Util = require("util")


function love.load()
  time = 0
  bgmDelay = 2
  loadingTime = 20
  draw = true

  carImage = love.graphics.newImage("assets/models.png")

  introText = "Vehicle Simulator Toolbox"
  introTextAsian = "車両シミュレータツールボックス"

  conthraxFont = love.graphics.newFont("assets/conthrax-sb.ttf", 14)
  logotypejpFont = love.graphics.newFont("assets/logotypejp_mp_m_1.ttf", 20)

  bgm = love.audio.newSource("assets/tw007.mp3")
  bgm:setLooping(true)

  completeSound = love.audio.newSource("assets/btn13.mp3")
end


function love.update(dt)
  time = time + dt

  bgmDelay = bgmDelay - dt
  if bgmDelay < 0 and not bgm:isPlaying() then
    bgm:play()
  end

  if time >= loadingTime then
    love.filesystem.load("overworld.lua")()
    love.load()
    completeSound:play()
    bgm:stop()
  end
end


function love.draw()
  love.graphics.setFont(logotypejpFont)
  local xPos = 10
  local yPos = 10

  love.graphics.setFont(conthraxFont)
  love.graphics.print("VEHICLE TYPE:    S", xPos, yPos)
  yPos = yPos + 25
  love.graphics.print("IDENTIFICATION:    5YJSP003", xPos, yPos)
  yPos = yPos + 25
  love.graphics.print("START TIME:    07/10/2117", xPos, yPos)
  yPos = yPos + 50
  love.graphics.print("CUSTOMER NAME:    Michel Tsuru", xPos, yPos)

  love.graphics.draw(carImage, 200, 200, 0, 0.25, 0.25)
end
