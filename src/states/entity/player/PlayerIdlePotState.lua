PlayerIdlePotState = Class{__includes = BaseState}

function PlayerIdlePotState:init(player, dungeon)
  self.entity = player
  self.dungeon = dungeon
  self.entity.offsetY = 5
  self.entity.offsetX = 0

    self.pot = nil
end


function PlayerIdlePotState:enter(params)
    -- render offset for spaced character sprite (negated in render function of state)
    self.entity.offsetY = 5
    self.entity.offsetX = 0
    self.entity:changeAnimation('pot-idle-' .. self.entity.direction)
    self.pot = params.pot
end

function PlayerIdlePotState:update(dt)

    if self.entity:collides(self.pot) then
      if not self.pot.collidable and self.pot.solid and self.pot.carriable then
        self.pot.x = self.entity.x
        self.pot.y = self.entity.y - 3
      end
    end

    if love.keyboard.isDown('left') or love.keyboard.isDown('right') or
       love.keyboard.isDown('up') or love.keyboard.isDown('down') then
        self.entity:changeState('walk-pot', {pot = self.pot})
    end

    if love.keyboard.isDown('f') then
      self.entity:changeState('throw-pot', {pot = self.pot})
    end
end

function PlayerIdlePotState:render()
    local anim = self.entity.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.x - self.entity.offsetX), math.floor(self.entity.y - self.entity.offsetY))

    -- love.graphics.setColor(255, 0, 255, 255)
    -- love.graphics.rectangle('line', self.entity.x, self.entity.y, self.entity.width, self.entity.height)
    -- love.graphics.setColor(255, 255, 255, 255)
end
