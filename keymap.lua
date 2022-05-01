return {
  up = {
    pressed = function(dt)
      beholder.trigger('player_move_up_start', dt)
    end,
    released = function(dt)
      beholder.trigger('player_move_up_end', dt)
    end
  },
  down = {
    pressed = function(dt)
      beholder.trigger('player_move_down_start', dt)
    end,
    released = function(dt)
      beholder.trigger('player_move_down_end', dt)
    end
  },
  left = {
    pressed = function(dt)
      beholder.trigger('player_move_left_start', dt)
    end,
    released = function(dt)
      beholder.trigger('player_move_left_end', dt)
    end
  },
  right = {
    pressed = function(dt)
      beholder.trigger('player_move_right_start', dt)
    end,
    released = function(dt)
      beholder.trigger('player_move_right_end', dt)
    end
  },
}