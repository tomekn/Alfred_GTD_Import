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
        -- movement start
        beholder.observe('movable_move_left_start', self.target, function() self.target.movable.start_move(self.target, 'left') end)
        beholder.observe('movable_move_right_start', self.target, function() self.target.movable.start_move(self.target, 'right') end)
        beholder.observe('movable_move_up_start', self.target, function() self.target.movable.start_move(self.target, 'up') end)
        beholder.observe('movable_move_down_start', self.target, function() self.target.movable.start_move(self.target, 'down') end)
        -- movement end
        beholder.observe('movable_move_left_end', self.target, function() self.target.movable.end_move(self.target, 'left') end)
        beholder.observe('movable_move_right_end', self.target, function() self.target.movable.end_move(self.target, 'right') end)
        beholder.observe('movable_move_up_end', self.target, function() self.target.movable.end_move(self.target, 'up') end)
        beholder.observe('movable_move_down_end', self.target, function() self.target.movable.end_move(self.target, 'down') end)
      end)
    end,
  }
}