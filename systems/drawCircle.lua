local Graphics = require("graphics")

local DrawCircle = lovetoys.class("DrawCircle", lovetoys.System)


function DrawCircle:initialize()
  lovetoys.System.initialize(self)
end


function DrawCircle:draw()
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
    local circle = entity:get("DrawCircle")
    local position = entity:get("Position")

    love.graphics.setColor(circle.colorR, circle.colorG, circle.colorB)
    local screenX, screenY = Graphics.toIso(1, 0.5, position.x, position.y, position.z)
    love.graphics.circle(circle.style,
                         screenX + cameraTransform.x, screenY + cameraTransform.y,
                         circle.radius, circle.segments)
  end
end


function DrawCircle:requires()
  return {entities={"Position", "DrawCircle"},
          camera={"Position", "Cameraman"}}
end


return DrawCircle
