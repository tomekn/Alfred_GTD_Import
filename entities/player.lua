-- local player = require('entities.player')({
--     debug = true,
--     position = {x=64, y=64},
--     velocity = {x=0, y=0},
--     size = {width=32, height=32},
-- })

Player = Class {
  type = 'Player',
  required_components = {'debug', 'position', 'velocity', 'size'},
  movement_speed = 128,
}

Player:include(require('traits.strong_components'))
Player:include(require('traits.movable'))

function Player:init(args)
  self.acceleration = vector(0,0)
  self.direction = vector(0,0)

  self:process_args(args)
  self.movable.target = self
  self.movable:register_movable_events()
end
