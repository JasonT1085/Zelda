PlayerCarryPotState = Class{__includes = EntityIdleState}

function PlayerCarryPotState:init(player, dungeon)
  self.player = player
  self.dungeon = dungeon
  self.player.offsetY = 5
  self.player.offsetX = 0
  local direction = self.player.direction
    self.pot = nil

end

function PlayerCarryPotState:enter(params)
  self.pot = params.pot
  
  self.player:changeAnimation('carry-pot-' .. self.player.direction)
end

function PlayerCarryPotState:update(dt)

  Timer.after(1, function()   if love.keyboard.isDown('left') or love.keyboard.isDown('right') or
       love.keyboard.isDown('up') or love.keyboard.isDown('down') then
        self.player:changeState('walk-pot', {pot = self.pot})
    end
  end)

  if self.player.currentAnimation.timesPlayed > 0 then
      self.player.currentAnimation.timesPlayed = 0
      self.player:changeState('idle-pot', {pot = self.pot})
  end

end

function PlayerCarryPotState:render()
    local anim = self.player.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.player.x - self.player.offsetX), math.floor(self.player.y - self.player.offsetY))

    --
    -- debug for player and hurtbox collision rects VV
    --

    -- love.graphics.setColor(255, 0, 255, 255)
    -- love.graphics.rectangle('line', self.player.x, self.player.y, self.player.width, self.player.height)
    -- love.graphics.rectangle('line', self.swordHurtbox.x, self.swordHurtbox.y,
    --     self.swordHurtbox.width, self.swordHurtbox.height)
    -- love.graphics.setColor(255, 255, 255, 255)
end
