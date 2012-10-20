local Main = Game:addState('Main')

function Main:enteredState()
  love.physics.setMeter(64)
  self.world = love.physics.newWorld(0, 200, true)
  self.world:setCallbacks(self.beginContact, self.endContact, self.preSolve, self.postSolve)
end

function Main:update(dt)
  cron.update(dt)
  self.world:update(dt)

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
  self.egg = Egg:new(x, y, 1)
end

function Main:mousereleased(x, y, button)
  self.egg:clean()
  self.egg = nil
end

function Main:keypressed(key, unicode)
  self.sperm = Sperm:new(100, 100, 20)
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
  self.world:destroy()
end

function Main.beginContact(fixture_one, fixture_two, coll)
  local x,y = coll:getNormal()
  local object_one, object_two = fixture_one:getUserData(), fixture_two:getUserData()
  print(object_one, "colliding", object_two)

  if type(object_one.on_collide) == "function" then
    object_one:on_collide(dt, shape_one, shape_two, mtv_x, mtv_y)
  end

  if type(object_two.on_collide) == "function" then
    object_two:on_collide(dt, shape_two, shape_one, -mtv_x, -mtv_y)
  end
end

function Main.endContact(fixture_one, fixture_two, coll)
  -- persisting = 0
  local x,y = coll:getNormal()
  local object_one, object_two = fixture_one:getUserData(), fixture_two:getUserData()
  print(object_one, "uncolliding", object_two)
end

function Main.preSolve(fixture_one, fixture_two, coll)
  local x,y = coll:getNormal()
  local object_one, object_two = fixture_one:getUserData(), fixture_two:getUserData()
  print(object_one, "touching", object_two)
  -- if persisting == 0 then    -- only say when they first start touching
  --     text = text.."\n"..a:getUserData().." touching "..b:getUserData()
  -- elseif persisting < 20 then    -- then just start counting
  --     text = text.." "..persisting
  -- end
  -- persisting = persisting + 1    -- keep track of how many updates they've been touching for
end

function Main.postSolve(fixture_one, fixture_two, coll)
end

return Main
