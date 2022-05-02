local debug_entity_draw_system = tiny.processingSystem()
debug_entity_draw_system.filter = tiny.requireAll('position', 'size')

function debug_entity_draw_system:onAddToWorld(_)
  print 'Debug entity draw system added to world'
end

debug_entity_draw_system.draw = true

function debug_entity_draw_system:process(e, _)
  love.graphics.setColor(255,0,0)
  love.graphics.rectangle('fill', math.floor(e.position.x), math.floor(e.position.y), e.size.x, e.size.y)
  love.graphics.setColor(255, 255, 255)
end

return debug_entity_draw_system