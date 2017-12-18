local PositionPID = {}
PositionPID.__index = PositionPID

function PositionPID.unit_vec(to, from)
  local dx = to.x - from.x
  local dy = to.y - from.y
  local dz = to.z - from.z

  local magnitude = math.sqrt(dx*dx + dy*dy + dz*dz)

  local vector = {x=0, y=0, z=0}
  vector.x = dx / magnitude
  vector.y = dy / magnitude
  vector.z = dz / magnitude

  if vector.x == math.huge or vector.y == math.huge or vector.z == math.huge  or
     vector.x ~= vector.x or vector.y ~= vector.y or vector.z ~= vector.z then
    local unitDefault = 0.5773503

    vector.x = unitDefault
    vector.y = unitDefault
    vector.z = unitDefault
  end

  return vector, magnitude
end


function PositionPID.step(
  target, source, dt, 
  kp, ki, kd, clamp,
  memory)
  if clamp then clampValue = clamp else clampValue = 1.5 end

  local errorUnit, errorDistance = PositionPID.unit_vec(source, target)
  if errorDistance < clampValue then
    errorDistance = 0
    memory.integral = 0
  end

  memory.integral = memory.integral + errorDistance*dt - 1
  if memory.integral < 0.01 then memory.integral = 0 end;
  local derivative = (errorDistance - memory.lastError) / dt
  local outputMagnitude = kp*errorDistance + ki*memory.integral + kd*derivative
  print(kp*errorDistance, ki*memory.integral, kd*derivative, outputMagnitude)


  memory.lastError = errorDistance

  local vx = outputMagnitude*errorUnit.x
  local vy = outputMagnitude*errorUnit.y
  local vz = outputMagnitude*errorUnit.z

  target.x = target.x + vx
  target.y = target.y + vy
  target.z = target.z + vz
end


function PositionPID:update(target, source, dt)
  PositionPID.step(target, source, dt,
                   self.kp, self.ki, self.kd, self.clamp,
                   self)
end


function PositionPID.create(kp, ki, kd)
  local self = {}
  setmetatable(self, PositionPID)
  self.kp = kp
  self.ki = ki
  self.kd = kd

  self.integral = 0
  self.lastError = 0
  self.clamp = nil

  return self
end

return PositionPID
