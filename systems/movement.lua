local movement_system = tiny.processingSystem() 
movement_system.filter = tiny.requireAll('position', 'velocity', 'movement_speed', 'direction')

function movement_system:onAddToWorld()
  print 'Movement System added to world'
end

function movement_system:process(e, dt)
  print("e.direction.x: "..e.direction.x)
  e.position = e.position + (e.direction * e.movement_speed * dt)
end

return movement_system