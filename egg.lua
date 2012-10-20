Egg = class('Egg', Base)
Egg.static.GROWTH_MULTIPLIER = 5

function Egg:initialize(x, y, radius)
  Base.initialize(self)

  -- self._physics_body = game.collider:addCircle(self.pos.x, self.pos.y, self.radius)
  -- self._physics_body.parent = self
  self._physics_body = love.physics.newBody(game.world, x, y, "dynamic")
  self._shape = love.physics.newCircleShape(radius)
  self._fixture = love.physics.newFixture(self._physics_body, self._shape)
  self._fixture:setUserData(self)
end

function Egg:update(dt)
  self:grow(dt)
end

function Egg:render()
  g.setColor(COLORS.RED:rgb())
  local x, y = self._physics_body:getPosition()
  g.circle("fill", x, y, self._shape:getRadius())
end

function Egg:grow(dt)
  self._fixture:destroy()
  local radius = self._shape:getRadius() + dt * Egg.GROWTH_MULTIPLIER
  self._shape = love.physics.newCircleShape(radius)
  self._fixture = love.physics.newFixture(self._physics_body, self._shape)
  self._fixture:setUserData(self)
end

function Egg:clean()
  self._fixture:destroy()
  self._physics_body:destroy()
end

function Egg:move_to(x, y)
  self._physics_body:setPosition(x,y)
end
