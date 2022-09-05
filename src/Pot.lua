--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

Pot = Class{__includes = GameObject}

function Pot:init(def, x, y)

GameObject.init(self, def, x, y)

self.moveSpeed = 0
self.direction = 'none'
self.distanceTraveled = 0
self.isThrown = false
self.Remove = false
self.state = 'unshattered'
end

function Pot:Throw(direction)
self.y = self.y + 12
self.direction = direction
self.solid = true
self.moveSpeed = 100
self.isThrown = true
end



function Pot:update(dt)
local wallCollide = false
if self.isThrown then
  self.distanceTraveled = self.distanceTraveled + self.moveSpeed * dt
  if self.distanceTraveled >= TILE_SIZE * 4 then
   self.moveSpeed = 0
   self.state = 'shattered'
 end


  if self.direction == 'left' then
      self.x = self.x - self.moveSpeed * dt
      if self.x <=MAP_RENDER_OFFSET_X + TILE_SIZE then
          self.x = MAP_RENDER_OFFSET_X + TILE_SIZE
          wallCollide = true
          self.state = 'shattered'
       end
  elseif self.direction =='right' then
      self.x = self.x + self.moveSpeed * dt
        if self.x + self.width >= VIRTUAL_WIDTH - TILE_SIZE * 2 then
          self.x = VIRTUAL_WIDTH - TILE_SIZE * 2 - self.width
          wallCollide = true
          self.state = 'shattered'
      end
  elseif self.direction == 'up' then
    self.y = self.y - self.moveSpeed * dt
      if self.y <= MAP_RENDER_OFFSET_Y + TILE_SIZE + self.height / 2 then
        self.y = MAP_RENDER_OFFSET_Y + TILE_SIZE + self.height / 2
        wallCollide = true
        self.state = 'shattered'
      end
  elseif self.direction == 'down' then
    self.y = self.y + self.moveSpeed * dt
      if self.y >= VIRTUAL_HEIGHT - (VIRTUAL_HEIGHT - MAP_HEIGHT * TILE_SIZE) + MAP_RENDER_OFFSET_Y - TILE_SIZE then
        self.y = VIRTUAL_HEIGHT - (VIRTUAL_HEIGHT - MAP_HEIGHT * TILE_SIZE) + MAP_RENDER_OFFSET_Y - TILE_SIZE
        wallCollide = true
        self.state = 'shattered'
      end
  end

end

if wallCollide or self.state == 'shattered' then
  Timer.after(1, function() self.Remove = true end)
end

end

function Pot:render(adjacentOffsetX, adjacentOffsetY)
  if not self.Remove then
  GameObject.render(self, adjacentOffsetX, adjacentOffsetY)
end

  love.graphics.setColor(255,255,255,255)
end
