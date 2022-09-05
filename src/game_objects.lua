--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

GAME_OBJECT_DEFS = {
    ['switch'] = {
        collidable = true,
        consumable = false,
        type = 'switch',
        texture = 'switches',
        frame = 2,
        width = 16,
        height = 16,
        solid = false,
                carriable = false,
        defaultState = 'unpressed',
        states = {
            ['unpressed'] = {
                frame = 2
            },
            ['pressed'] = {
                frame = 1
            }
        }
    },
    ['pot'] = {
        collidable = true,
        consumable = false,
        type = 'pot',
        texture = 'tiles',
        frame = 14,
        width = 16,
        height = 16,
        solid = true,
        defaultState = 'unshattered',
        carriable = true,
        firable = true,
        fired = false,
        states = {
          ['unshattered'] = {
            frame = 15
          },
          ['shattered'] = {
            frame = 53
          }
        }
    },
    ['heart'] = {
      type = 'heart',
      texture = 'hearts',
      solid = false,

      width = 16,
      height = 16,
      defaultState = 'fullheart',
              carriable = false,
      states = {
        ['fullheart'] = {
          frame = 5
        }
      },
      frame = 5,
      collidable = false,
      consumable = true
    }
}
