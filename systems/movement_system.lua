local movement_system = tiny.processingSystem() 
movement_system.filter = tiny.requireAll('position', 'velocity')

function movement_system:process(e, dt)
  e.position.x = e.position.x + e.velocity.x
  e.position.y = e.velocity.y + e.velocity.y
  print('x: ' .. e.position.x)
end

return movement_system