local Main = Game:addState('Main')

function Main:enteredState()
  -- self.collider = HC(50, self.on_start_collide, self.on_stop_collide)
  love.physics.setMeter(64)
  self.world = love.physics.newWorld(0, 0, true)
  self.world:setCallbacks(self.beginContact, self.endContact, self.preSolve, self.postSolve)
end

function Main:update(dt)
  cron.update(dt)
  -- self.collider:update(dt)
  self.world:update(dt)

  if self.egg then
    self.egg:update(dt)
  end
  if self.egg2 then
    self.egg2:update(dt)
  end

  -- print(self.world:getBodyCount())

end

function Main:render()
  self.camera:set()

  if self.egg then
    self.egg:render()
  end
  if self.egg2 then
    self.egg2:render()
  end

  self.camera:unset()
end

function Main:mousepressed(x, y, button)
  if self.egg2 == nil then
    self.egg2 = Egg:new(100, 100, 50)
  end
  self.egg = Egg:new(x, y, 1)
end

function Main:mousereleased(x, y, button)
  self.egg:clean()
  self.egg = nil
end

function Main:keypressed(key, unicode)
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

-- function Main.on_start_collide(dt, shape_one, shape_two, mtv_x, mtv_y)
--   if game.over then return end

--   local object_one, object_two = shape_one:getUserData(), shape_two:getUserData()

--   -- print(object_one, object_two)

--   if type(object_one.on_collide) == "function" then
--     object_one:on_collide(dt, shape_one, shape_two, mtv_x, mtv_y)
--   end

--   if type(object_two.on_collide) == "function" then
--     object_two:on_collide(dt, shape_two, shape_one, -mtv_x, -mtv_y)
--   end
-- end

-- function Main.on_stop_collide(dt, shape_one, shape_two)
--   -- print(tostring(shape_one.parent) .. " stopped colliding with " .. tostring(shape_two.parent))
-- end

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
