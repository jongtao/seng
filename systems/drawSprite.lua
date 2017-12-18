local Graphics = require("graphics")

local DrawSprite = lovetoys.class("DrawSprite", lovetoys.System)


function DrawSprite:initialize()
  lovetoys.System.initialize(self)
end


function DrawSprite:draw()
  local camera = nil
  local campos = nil
  for key, entity in pairs(self.targets.camera) do
    camera = entity:get("Cameraman")
    campos = entity:get("Position")
  end

  cameraTransform = Graphics.getCameraTransform(campos.x, campos.y, campos.z,
                                                camera.w, camera.h,
                                                camera.x, camera.y)

  for key, entity in pairs(self.targets.entities) do
    local sprite = entity:get("DrawSprite")
    local position = entity:get("Position")

    local screenX, screenY = Graphics.toIso(1, 0.5, position.x, position.y, position.z)

    love.graphics.draw(sprite.image, sprite.quad,
                       screenX - sprite.offsetX + cameraTransform.x,
                       screenY - sprite.offsetY + cameraTransform.y)
  end
end


function DrawSprite:requires()
  return {entities={"Position", "DrawSprite"},
          camera={"Position", "Cameraman"}}
end


return DrawSprite
