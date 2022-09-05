PlayerThrowPotState = Class{__includes = BaseState}


 function PlayerThrowPotState:init(player, dungeon)
  self.entity = player
  self.dungeon = dungeon
  self.entity.offsetY = 5
  self.entity.offsetX = 0

 self.entity:changeAnimation('carry-pot-' .. self.entity.direction)
 end

 function PlayerThrowPotState:enter(params)
self.pot = params.pot

   self.entity.currentAnimation:refresh()


     self.pot:Throw(self.entity.direction)


 end

 function PlayerThrowPotState:update(dt)
   local direction = self.entity.direction

              for k, entity in pairs(self.dungeon.currentRoom.entities) do
                    if entity:collides(self.pot) and not entity.dead then
                       entity:damage(1)
                       gSounds['hit-enemy']:play()
                       self.pot.state = 'shattered'
                       self.pot.carriable = false
                       self.pot.moveSpeed = 0
                       Timer.after(1, function() self.pot.Remove = true end)
                     end
                  end
Timer.after(0.3, function() self.entity:changeState('idle') end)
 end

function PlayerThrowPotState:render()
    local anim = self.entity.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.x - self.entity.offsetX), math.floor(self.entity.y - self.entity.offsetY))

    --
    -- debug for player and hurtbox collision rects VV
    --

    -- love.graphics.setColor(255, 0, 255, 255)
    -- love.graphics.rectangle('line', self.player.x, self.player.y, self.player.width, self.player.height)
    -- love.graphics.rectangle('line', self.swordHurtbox.x, self.swordHurtbox.y,
    --     self.swordHurtbox.width, self.swordHurtbox.height)
    -- love.graphics.setColor(255, 255, 255, 255)
end
