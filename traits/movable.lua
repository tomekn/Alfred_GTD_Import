return {
  movable = {
    target = nil,
    state = {
      up = { active = false, vector = {x = 0, y = -1} },
      down = { active = false, vector = {x = 0, y = 1} },
      left = { active = false, vector = {x = -1, y = 0} },
      right = { active = false, vector = {x = 1, y = 0} },
    },
    start_move = function(self, direction)
      self.movable.state[direction].active = true
      self.movable:calculate_direction()
    end,
    end_move = function(self, direction)
      self.movable.state[direction].active = false
      self.movable:calculate_direction()
    end,
    force_move = function(self, direction)
      self.movable.reset_state()
      self.movable.state[direction].active = true
      self.movable.calculate_direction()
    end,
    force_stop = function(self)
      self.movable.reset_state()
      self.movable.calculate_direction()
    end,
    reset_state = function(self)
      for _, state in self.movable.state do
        state.active = false
      end
    end,
    calculate_direction = function(self)
      self.target.direction:set(0,0)

      for _, movement_state in pairs(self.state) do
        if movement_state.active == true then
          self.target.direction = self.target.direction + vector(movement_state.vector.x, movement_state.vector.y)
        end 
      end

      -- self.target.direction:norm()
    end,
    register_movable_events = function(self)
      beholder.group(self.target, function()
        beholder.observe('movable_move', self.target, function(direction, key_status)
          local is_moving = key_status == 'key_pressed'

          if is_moving then
            self.target.movable.start_move(self.target, direction)
          else
            self.target.movable.end_move(self.target, direction)
          end
        end)
      end)
    end,
  }
}