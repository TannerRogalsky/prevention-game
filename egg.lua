Egg = class('Egg', Base)
Egg.static.GROWTH_MULTIPLIER = 5

function Egg:initialize(x, y, radius)
  Base.initialize(self)

  self.pos = {x = x, y = y}
  self.pos.incr = function(self, k, v) self[k] = self[k] + v end
  self.radius = radius

  self._physics_body = game.collider:addCircle(self.pos.x, self.pos.y, self.radius)
  self._physics_body.parent = self
end

function Egg:update(dt)
  self:grow(dt)
end

function Egg:render()
  g.setColor(COLORS.RED:rgb())
  self._physics_body:draw("fill")
end

function Egg:grow(dt)
  self.radius = self.radius + dt * Egg.GROWTH_MULTIPLIER
  self._physics_body._radius = self.radius
end

function Egg:move(x, y)
  self.pos:incr('x', x)
  self.pos:incr('y', y)
  self._physics_body:move(x,y)
end

function Egg:move_to(x, y)
  self.pos = {x = x, y = y}
  self._physics_body:moveTo(x,y)
end
