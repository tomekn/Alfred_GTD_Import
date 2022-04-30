local acceleration_system = tiny.processingSystem()
acceleration_system.filter = tiny.requireAll('position', 'acceleration')

function acceleration_system:process(e, dt)
  e.velocity.x = e.velocity.x + e.acceleration.x
  e.velocity.y = e.velocity.y + e.acceleration.y
  e.acceleration.x = 0
  e.acceleration.y = 0
end

return acceleration_system