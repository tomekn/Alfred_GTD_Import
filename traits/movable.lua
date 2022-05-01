return {
  movement_state = {
    up = { active = false, vector = {x = 0, y = -1} },
    down = { active = false, vector = {x = 0, y = 1} },
    left = { active = false, vector = {x = -1, y = 0} },
    right = { active = false, vector = {x = 1, y = 0} },
  },
  start_move = function(self, direction)
    self.movement_state[direction].active = true
    self:calculate_direction()
  end,
  end_move = function(self, direction)
    self.movement_state[direction].active = false
    self:calculate_direction()
  end,
  calculate_direction = function(self)
    self.direction:set(0,0)

    for _, movement_state in pairs(self.movement_state) do
      if movement_state.active == true then
        self.direction = self.direction + vector(movement_state.vector.x, movement_state.vector.y)
      end 
    end

    self.direction:norm()
    -- print('direction x: '..self.direction.x..' y: '..self.direction.y)
  end,
  register_movement_events = function(self)
    beholder.group(self, function()
      -- movement start
      beholder.observe('movable_move_left_start', self, function() self:start_move('left') end)
      beholder.observe('movable_move_right_start', self, function() self:start_move('right') end)
      beholder.observe('movable_move_up_start', self, function() self:start_move('up') end)
      beholder.observe('movable_move_down_start', self, function() self:start_move('down') end)
      -- movement end
      beholder.observe('movable_move_left_end', self, function() self:end_move('left') end)
      beholder.observe('movable_move_right_end', self, function() self:end_move('right') end)
      beholder.observe('movable_move_up_end', self, function() self:end_move('up') end)
      beholder.observe('movable_move_down_end', self, function() self:end_move('down') end)
    end)
  end,
}