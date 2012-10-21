PowerUp = class('PowerUp', Base)

function PowerUp:initialize(x, y, width, height)
  Base.initialize(self)

  if x and y and width and height then
    self.pos = {x = x, y = y}
    self.pos.incr = function(self, k, v) self[k] = self[k] + v end
    self.dimensions = {w = width, h = height}

    self._physics_body = game.collider:addRectangle(self.pos.x, self.pos.y, self.dimensions.w, self.dimensions.h)
    self._physics_body.parent = self
  end
end

function PowerUp:update(dt)
end

function PowerUp:render()
  g.setColor(COLORS.GREEN:rgb())
  self._physics_body:draw("fill")
end

function PowerUp:effect()
  game.score = game.score + 5
end

function PowerUp:contains(x, y)
  return self._physics_body:contains(x, y)
end

function PowerUp:on_collide(dt, shape_one, shape_two, mtv_x, mtv_y)
  local other_object = shape_two.parent

  -- if instanceOf(Egg, other_object) then
  --   game.collider:remove(shape_one)
  --   self:effect()
  --   game.powerups[self.id] = nil
  -- end
end
