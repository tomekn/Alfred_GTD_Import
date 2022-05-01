-- local player = require('entities.player')({
--     debug = true,
--     position = {x=64, y=64},
--     velocity = {x=0, y=0},
--     size = {width=32, height=32},
-- })

Player = Class {
  entity_type = 'Player',
  init = function(self, args)
    local required_components = {'debug', 'position', 'velocity', 'acceleration', 'size'}
    local added_components = {}

    self.acceleration = vector(0,0)
    self.direction = vector(0,0)
    self.movement_speed = 250

    added_components[#added_components+1] = 'acceleration'

    self.movement_state = {
      up = { active = false, vector = vector(0, -1) },
      down = { active = false, vector = vector(0, 1) },
      left = { active = false, vector = vector(-1, 0) },
      right = { active = false, vector = vector(1, 0) },
    }

    for k,v in pairs(args) do
      added_components[#added_components+1] = k
      self[k] = v
    end

    local missing_components = required_components
    local extra_components = added_components

    for required_index, required_component in ipairs(required_components) do
      for added_index, added_component in ipairs(added_components) do
        if added_component == required_component then
          missing_components[required_index] = 'component_is_present'
          extra_components[added_index] = 'component_is_required'
        end    
      end 
    end

    for k,v in pairs(missing_components) do
      if (v ~= "component_is_present") then
        print("Required component "..v.." missing from constructor")
      end
    end

    for k,v in pairs(extra_components) do
      if (v ~= "component_is_required") then
        print("Component "..v.." not defined in entity class")
      end
    end
  end,

  register_events = function(self)
    beholder.group(self, function()
      -- movement start
      beholder.observe('player_move_left_start', function() self:start_move('left') end)
      beholder.observe('player_move_right_start', function() self:start_move('right') end)
      beholder.observe('player_move_up_start', function() self:start_move('up') end)
      beholder.observe('player_move_down_start', function() self:start_move('down') end)
      -- movement end
      beholder.observe('player_move_left_end', function() self:end_move('left') end)
      beholder.observe('player_move_right_end', function() self:end_move('right') end)
      beholder.observe('player_move_up_end', function() self:end_move('up') end)
      beholder.observe('player_move_down_end', function() self:end_move('down') end)
    end)
  end,

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
        self.direction = self.direction + movement_state.vector
      end 
    end

    self.direction:norm()
    -- print('direction x: '..self.direction.x..' y: '..self.direction.y)
  end
}