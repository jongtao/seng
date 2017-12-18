local Velocity = lovetoys.Component.create("Velocity")


function Velocity:initialize(x, y, z)
  self.x = x
  self.y = y
  self.z = z
end


return Velocity
