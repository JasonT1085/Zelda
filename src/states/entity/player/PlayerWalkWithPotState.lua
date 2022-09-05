PlayerWalkWithPotState = Class{__includes = EntityWalkState}

function PlayerWalkWithPotState:init(player, dungeon)
  self.entity = player
  self.dungeon = dungeon
  self.entity.offsetY = 5
  self.entity.offsetX = 0
  self.pot = nil
end

function PlayerWalkWithPotState:enter(params)
  self.pot = params.pot

end

function PlayerWalkWithPotState:update(dt)
    if self.entity:collides(self.pot) then
      if not self.pot.collidable and self.pot.solid and self.pot.carriable then


        self.pot.x = self.entity.x
        self.pot.y = self.entity.y
        self.pot.firable = true
      end

      if love.keyboard.isDown('f') and self.pot.firable then
        self.pot.fired = true
        self.pot.firable = false
        self.entity:changeState('throw-pot', {pot = self.pot})
      end

  end

  if love.keyboard.isDown('left') then
      self.entity.direction = 'left'
      self.entity:changeAnimation('pot-walk-left')
  elseif love.keyboard.isDown('right') then
      self.entity.direction = 'right'
      self.entity:changeAnimation('pot-walk-right')
  elseif love.keyboard.isDown('up') then
      self.entity.direction = 'up'
      self.entity:changeAnimation('pot-walk-up')
  elseif love.keyboard.isDown('down') then
      self.entity.direction = 'down'
      self.entity:changeAnimation('pot-walk-down')
  else
      self.entity:changeState('idle-pot', {pot = self.pot})
  end


  EntityWalkState.update(self, dt)

  if self.bumped then
      if self.entity.direction == 'left' then

          -- temporarily adjust position into the wall, since bumping pushes outward
          self.entity.x = self.entity.x - PLAYER_WALK_SPEED * dt

          -- check for colliding into doorway to transition
          for k, doorway in pairs(self.dungeon.currentRoom.doorways) do
              if self.entity:collides(doorway) and doorway.open then

                  -- shift entity to center of door to avoid phasing through wall
                  self.entity.y = doorway.y + 4
                  Event.dispatch('shift-left')
              end
          end

          -- readjust
          self.entity.x = self.entity.x + PLAYER_WALK_SPEED * dt
      elseif self.entity.direction == 'right' then

          -- temporarily adjust position
          self.entity.x = self.entity.x + PLAYER_WALK_SPEED * dt

          -- check for colliding into doorway to transition
          for k, doorway in pairs(self.dungeon.currentRoom.doorways) do
              if self.entity:collides(doorway) and doorway.open then

                  -- shift entity to center of door to avoid phasing through wall
                  self.entity.y = doorway.y + 4
                  Event.dispatch('shift-right')
              end
          end

          -- readjust
          self.entity.x = self.entity.x - PLAYER_WALK_SPEED * dt
      elseif self.entity.direction == 'up' then

          -- temporarily adjust position
          self.entity.y = self.entity.y - PLAYER_WALK_SPEED * dt

          -- check for colliding into doorway to transition
          for k, doorway in pairs(self.dungeon.currentRoom.doorways) do
              if self.entity:collides(doorway) and doorway.open then

                  -- shift entity to center of door to avoid phasing through wall
                  self.entity.x = doorway.x + 8
                  Event.dispatch('shift-up')
              end
          end

          -- readjust
          self.entity.y = self.entity.y + PLAYER_WALK_SPEED * dt
      else

          -- temporarily adjust position
          self.entity.y = self.entity.y + PLAYER_WALK_SPEED * dt

          -- check for colliding into doorway to transition
          for k, doorway in pairs(self.dungeon.currentRoom.doorways) do
              if self.entity:collides(doorway) and doorway.open then

                  -- shift entity to center of door to avoid phasing through wall
                  self.entity.x = doorway.x + 8
                  Event.dispatch('shift-down')
              end
          end

          -- readjust
          self.entity.y = self.entity.y - PLAYER_WALK_SPEED * dt

      end
  end

end
