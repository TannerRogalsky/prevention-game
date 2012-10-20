local Main = Game:addState('Main')

function Main:enteredState()
  self.collider = HC(50, self.on_start_collide, self.on_stop_collide)
end

function Main:update(dt)
  cron.update(dt)
  self.collider:update(dt)

  if self.egg then
    self.egg:update(dt)
  end

  if self.sperm then
    self.sperm:update(dt)
  end

end

function Main:render()
  self.camera:set()

  if self.egg then
    self.egg:render()
  end

  if self.sperm then
    self.sperm:render()
  end

  self.camera:unset()
end

function Main:mousepressed(x, y, button)
  if self.egg == nil then
    self.egg = Egg:new(x, y, 1)
  end
end

function Main:mousereleased(x, y, button)
  if self.egg then
    self.collider:remove(self.egg._physics_body)
    self.egg = nil
 end
end

function Main:keypressed(key, unicode)
  if self.sperm == nil then
    self.sperm = Sperm:new(100, 100, 20)
  end
end

function Main:keyreleased(key, unicode)
end

function Main:joystickpressed(joystick, button)
end

function Main:joystickreleased(joystick, button)
end

function Main:focus(has_focus)
end

function Main:exitedState()
end

function Main.on_start_collide(dt, shape_one, shape_two, mtv_x, mtv_y)
  if game.over then return end

  local object_one, object_two = shape_one.parent, shape_two.parent

  print(object_one, object_two)

  if type(object_one.on_collide) == "function" then
    object_one:on_collide(dt, shape_one, shape_two, mtv_x, mtv_y)
  end

  if type(object_two.on_collide) == "function" then
    object_two:on_collide(dt, shape_two, shape_one, -mtv_x, -mtv_y)
  end
end

function Main.on_stop_collide(dt, shape_one, shape_two)
  -- print(tostring(shape_one.parent) .. " stopped colliding with " .. tostring(shape_two.parent))
end

return Main
