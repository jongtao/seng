local Util = {}


function Util.centered_print(string, containerX, containerY, containerW, containerH, offsetX, offsetY)
  local h = love.graphics.getHeight()
  local w = love.graphics.getWidth()

  local font = love.graphics.getFont()

  local xPos = math.floor(containerW/2 - font:getWidth(string)/2)
  xPos = xPos + containerX + offsetX

  local yPos = math.floor(containerH/2 - font:getHeight()/2) + containerY
  yPos = yPos + containerY + offsetY

  love.graphics.print(string, xPos , yPos)
end


function Util.right_print(string, containerX, containerY, containerW, containerH, offsetX, offsetY)
  local h = love.graphics.getHeight()
  local w = love.graphics.getWidth()

  local font = love.graphics.getFont()

  local xPos = math.floor(-font:getWidth(string))
  xPos = xPos + containerX + offsetX

  local yPos = math.floor(containerH/2 - font:getHeight()/2) + containerY
  yPos = yPos + containerY + offsetY

  love.graphics.print(string, xPos , yPos)
end


function Util.copy(table)
  if type(table) ~= 'table' then return table end -- non table

  local newTable = {}
  for k,v in pairs(table) do
    newTable[k] = Util.copy(v)
  end
  return newTable
end

return Util
