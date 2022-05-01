-- local player = require('entities.player')({
--     debug = true,
--     position = {x=64, y=64},
--     velocity = {x=0, y=0},
--     size = {width=32, height=32},
-- })

Player = Class {
  entity_type = 'Player',
  required_components = {'debug', 'position', 'velocity', 'acceleration', 'size'},
  movement_speed = 250,
}

function Player:init(args)
  local added_components = {}

  self.acceleration = vector(0,0)
  self.direction = vector(0,0)

  added_components[#added_components+1] = 'acceleration'

  for k,v in pairs(args) do
    added_components[#added_components+1] = k
    self[k] = v
  end

  local missing_components = Player.required_components
  local extra_components = added_components

  for required_index, required_component in ipairs(Player.required_components) do
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
end

Player:include(require('traits.movable'))