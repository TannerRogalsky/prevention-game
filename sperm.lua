Sperm = class('Sperm', Base)

function Sperm:initialize(x, y, radius)
  Base.initialize(self)

  self.pos = {x = x, y = y}
  self.pos.incr = function(self, k, v) self[k] = self[k] + v end
  self.radius = radius

  self._physics_body = game.collider:addCircle(self.pos.x, self.pos.y, self.radius)
  self._physics_body.parent = self
end

function Sperm:update(dt)
end

function Sperm:render()
  g.setColor(COLORS.BLUE:rgb())
  self._physics_body:draw("fill")
end

function Sperm:move(x, y)
  self.pos:incr('x', x)
  self.pos:incr('y', y)
  self._physics_body:move(x,y)
end

function Sperm:move_to(x, y)
  self.pos = {x = x, y = y}
  self._physics_body:moveTo(x,y)
end
