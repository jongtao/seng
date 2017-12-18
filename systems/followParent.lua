local FollowParent = lovetoys.class("FollowParent", lovetoys.System)


function FollowParent:initialize()
  lovetoys.System.initialize(self)
end


function FollowParent:update(dt)
  for key, entity in pairs(self.targets) do
    local parentPos = entity:getParent():get("Position")
    local position = entity:get("Position")
    local follower = entity:get("FollowParent")

    follower:method(position, parentPos, dt)
  end
end


function FollowParent:requires()
  return {"Position", "FollowParent"}
end


return FollowParent
