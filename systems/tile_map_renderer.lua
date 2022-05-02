
local tile_map_renderer_system = tiny.processingSystem()

tile_map_renderer_system.filter = tiny.requireAll('tile', 'position', 'quad')

function tile_map_renderer_system:load_map(map)
  self.map = map
  return self
end

function tile_map_renderer_system:preWrap(dt)
  self.map.map_sprite_batch:clear()
end

function tile_map_renderer_system:process(e, dt)
  self.map.map_sprite_batch:add(e.quad, e.position.x, e.position.y)
end

function tile_map_renderer_system:postWrap(dt)
end

function tile_map_renderer_system:render()
  love.graphics.draw(self.map.map_sprite_batch)
end

return tile_map_renderer_system