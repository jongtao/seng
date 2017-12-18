local Entity = {}
Entity.__index = Entity

function Entity.new(entityType)
	local self = {
		entityType = entityType,
		size = {l=0, w=0, h=0},
		pos = {
			x=0, y=0, z=0,
			yaw=0, pitch=0, roll=0
		},
		vel = {
			x=0, y=0, z=0,
			yaw=0, pitch=0, roll=0
		}
	}
	setmetatable(self, Entity)
	return self
end


return Entity
