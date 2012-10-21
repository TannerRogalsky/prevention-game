Egg = class('Egg', Base)
Egg.static.GROWTH_EXPONENT = 2

function Egg:initialize(x, y, radius)
  Base.initialize(self)

  self.pos = {x = x, y = y}
  self.pos.incr = function(self, k, v) self[k] = self[k] + v end
  self.start_radius = radius
  self.alive = 0

  self._physics_body = game.collider:addCircle(self.pos.x, self.pos.y, self.start_radius)
  self._physics_body.parent = self

  self.power_spawn = cron.every(1.5, function()
    local new_powerup = PowerUp:new(r(g.getWidth()), r(g.getHeight()), 15, 15)
    game.powerups[new_powerup.id] = new_powerup
  end)
end

function Egg:update(dt)
  self.alive = self.alive + dt
  self:grow(dt)
end

function Egg:render()
  g.setColor(COLORS.RED:rgb())
  self._physics_body:draw("fill")
end

function Egg:grow(dt)
  self.radius = self.start_radius + math.pow(self.alive, Egg.GROWTH_EXPONENT)
  game.score = game.score + self.radius * 0.02
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
