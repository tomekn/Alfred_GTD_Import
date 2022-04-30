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

    self.acceleration = {x = 0, y = 0}
    added_components[#added_components+1] = 'acceleration'

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
      beholder.observe('player_move_left', function() self:move('left') end)
      beholder.observe('player_move_right', function() self:move('right') end)
      beholder.observe('player_move_up', function() self:move('up') end)
      beholder.observe('player_move_down', function() self:move('down') end)
    end)
  end,

  move = function(self, direction)
    local movement_speed = 800
    if (direction == 'left') then self.acceleration.x = self.acceleration.x - movement_speed end
    if (direction == 'right') then self.acceleration.x = self.acceleration.x + movement_speed end
    if (direction == 'up') then self.acceleration.y = self.acceleration.y - movement_speed end
    if (direction == 'down') then self.acceleration.y = self.acceleration.y + movement_speed end
  end,
}