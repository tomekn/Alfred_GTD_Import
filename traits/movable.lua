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
    calculate_direction = function(self)
      self.target.direction:set(0,0)

      for _, movement_state in pairs(self.state) do
        if movement_state.active == true then
          self.target.direction = self.target.direction + vector(movement_state.vector.x, movement_state.vector.y)
        end 
      end

      self.target.direction:norm()
      -- print('direction x: '..self.direction.x..' y: '..self.direction.y)
    end,
    register_movable_events = function(self)
      beholder.group(self.target, function()
        beholder.observe('movable_move', self.target, function(direction, is_start)
          if is_start == 'key_pressed' then
            self.target.movable.start_move(self.target, direction)
          else
            self.target.movable.end_move(self.target, direction)
          end
        end)
      end)
    end,
  }
}