return {
  process_args = function(self, args)
    local added_components = {}
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
        error("Required component '"..v.."' missing from "..self.type.." constructor")
      end
    end

    for k,v in pairs(extra_components) do
      if (v ~= "component_is_required") then
        error("Component "..v.." was passed in but not defined as required in "..self.type.." definition")
      end
    end
  end,
}