local movement_system = tiny.processingSystem() 
movement_system.filter = tiny.requireAll('position', 'velocity')

function movement_system:onAddToWorld()
  print 'Movement System added to world'
end

function movement_system:process(e, dt)
  e.position.x = e.position.x + (e.velocity.x * dt)
  e.position.y = e.position.y + (e.velocity.y * dt)
  e.velocity.y = 0
  e.velocity.x = 0
  print("position: "..e.position.x.." , "..e.position.y)
end

return movement_system