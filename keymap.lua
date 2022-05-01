KeyMap = Class{}

function KeyMap:init()
  self.player = nil
end

function KeyMap:set_player(player)
  self.player = player
end

function KeyMap:commands()
  return {
    up = {
      pressed = function(dt)
        beholder.trigger('movable_move_up_start', self.player)
      end,
      released = function(dt)
        beholder.trigger('movable_move_up_end', self.player)
      end
    },
    down = {
      pressed = function(dt)
        beholder.trigger('movable_move_down_start', self.player)
      end,
      released = function(dt)
        beholder.trigger('movable_move_down_end', self.player)
      end
    },
    left = {
      pressed = function(dt)
        beholder.trigger('movable_move_left_start', self.player)
      end,
      released = function(dt)
        beholder.trigger('movable_move_left_end', self.player)
      end
    },
    right = {
      pressed = function(dt)
        beholder.trigger('movable_move_right_start', self.player)
      end,
      released = function(dt)
        beholder.trigger('movable_move_right_end', self.player)
      end
    },
  }
end