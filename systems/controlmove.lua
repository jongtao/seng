local ControlMove = lovetoys.class("ControlMove", lovetoys.System)


function ControlMove:initialize(keyInput)
  lovetoys.System.initialize(self)
  self.input = keyInput
end


function ControlMove:update(dt)
  local moveRate = 2 + dt

  for key, entity in pairs(self.targets) do
    local position = entity:get("Position")

    if self.input.get("up") then
      position.y = position.y - moveRate
    end

    if self.input.get("down") then
      position.y = position.y + moveRate
    end

    if self.input.get("left") then
      position.x = position.x - moveRate
    end

    if self.input.get("right") then
      position.x = position.x + moveRate
    end
  end
end


function ControlMove:requires()
  return {"Position", "Controllable"}
end


return ControlMove
