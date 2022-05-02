local draw_mouse_pointer_system = tiny.system()

function draw_mouse_pointer_system:onAddToWorld(_)
  love.mouse.setVisible( false )
end

function draw_mouse_pointer_system:update()
  local x, y = push:toGame(love.mouse.getPosition())

  love.graphics.points(x, y, x - 2, y, x, y-2, x + 2, y, x, y + 2)
end

draw_mouse_pointer_system.draw = true

return draw_mouse_pointer_system