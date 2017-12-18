local PositionPID = require("positionPID")

local FollowParent  = lovetoys.Component.create("FollowParent")


function FollowParent:simple(target, source, dt)
  target.x = source.x
  target.y = source.y
  target.z = source.z
end


function FollowParent:distancePID(target, source, dt)
  self.pid:update(target, source, dt)
end


function FollowParent:initialize(behavior, options)
  if behavior == "PositionPID" then
    self.pid = PositionPID.create(options.kp, options.ki, options.kd)
    self.method = FollowParent.distancePID
  elseif behavior == "Simple" then
    self.method = FollowParent.simple
  else  
    self.method = FollowParent.simple
  end
end


return FollowParent
