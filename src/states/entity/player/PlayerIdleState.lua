--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

PlayerIdleState = Class{__includes = EntityIdleState}



function PlayerIdleState:enter(params)

    -- render offset for spaced character sprite (negated in render function of state)
    self.entity.offsetY = 5
    self.entity.offsetX = 0
end

function PlayerIdleState:update(dt)
  local savedPot
    if love.keyboard.isDown('left') or love.keyboard.isDown('right') or
       love.keyboard.isDown('up') or love.keyboard.isDown('down') then
        self.entity:changeState('walk')
    end

    if love.keyboard.wasPressed('space') then
        self.entity:changeState('swing-sword')
    end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
      for k, pot in pairs(self.dungeon.currentRoom.objects) do
        if self.entity:collides(pot) then
          savedPot = pot
          if pot.collidable and pot.solid and pot.carriable then
            pot.collidable = false
          self.entity:changeState('carry-pot', {pot = savedPot})
          end

        end
      end
    end
end
