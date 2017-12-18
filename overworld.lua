local Util = require("util")
local Input = require("input")

lovetoys = require("lib/lovetoys/lovetoys")
lovetoys.initialize({globals = false, debug = true})

local Position = require("components/position")
local Controllable = require("components/controllable")
local Cameraman = require("components/cameraman")
local DrawCircle = require("components/drawCircle")
local DrawSprite = require("components/drawSprite")
local FollowParent = require("components/followParent")

local SysControlMove = require("systems/controlmove")
local SysFollowParent = require("systems/followParent")
local SysDrawCircle = require("systems/drawCircle")
local SysDrawSprite = require("systems/drawSprite")

local engine = lovetoys.Engine()


function create_tile(targetEngine, imageFile, quad, x, y, z)
  local tile = lovetoys.Entity()
  tile:initialize()
  tile:add(Position(x, y, z))
  tile:add(DrawSprite(imageFile, quad, 32, 32))
  targetEngine:addEntity(tile)
  return tile
end


function create_tile_grid(engine)
  local imageFile = love.graphics.newImage("assets/glow_tile.png")
   local tile = love.graphics.newQuad(0, 0, 64, 64, imageFile:getDimensions())

  N = 5
  M = 5

  map = {}
  for i=1,N do
    map[i] = {}
    for j=1,M do
      map[i][j] = 1
      create_tile(engine, imageFile, tile, 
                  64*(i-1), 64*(j-1), 0)
    end
  end
end


function love.load()
  --sound = love.audio.newSource("assets/Only Human.mp3")
  --sound:play()

  create_tile_grid(engine)

  local car = lovetoys.Entity()
  car:initialize()
  car:add(Position(0, 0, 0))
  car:add(Controllable())
  car:add(DrawCircle(10, 255, 255, 255))
  engine:addEntity(car)

  local cameraman = lovetoys.Entity()
  cameraman:initialize()
  cameraman:add(Position(0, 0, 0))
  cameraman:add(Cameraman(0, 0,
                          love.graphics.getWidth(),
                          love.graphics.getHeight()))
  --cameraman:add(FollowParent("Simple"))
  cameraman:add(FollowParent("PositionPID", {kp=0.02, ki=0.02, kd=0.002}))
  
  cameraman:setParent(car)
  engine:addEntity(cameraman)

  engine:addSystem(SysControlMove(Input))
  engine:addSystem(SysFollowParent())

  engine:addSystem(SysDrawSprite(camera))
  engine:addSystem(SysDrawCircle(camera))

end


function love.update(dt)
  engine:update(dt)
  Input.update_timers(dt)
end


function love.draw()
  engine:draw(dt)
end


function love.keypressed(key, scan, isrepeat)
  if key == "escape" then
    love.event.push("quit")
  end

  Input.press(key)
end


function love.keyreleased(key, scan)
  Input.release(key)
end
