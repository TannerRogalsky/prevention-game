Sperm = class('Sperm', Base)

function Sperm:initialize(x, y, radius)
  Base.initialize(self)

  self._physics_body = love.physics.newBody(game.world, x, y, "dynamic")
  self._body_shape = love.physics.newCircleShape(radius)
  self._body_fixture = love.physics.newFixture(self._physics_body, self._body_shape)
  self._body_fixture:setUserData(self)

  -- self._physics_tail = love.physics.newBody(game.world, x, y, "dynamic")
  -- self._tail_shape = love.physics.newChainShape(false, x, y, x + 100, y)
  -- self._tail_fixture = love.physics.newFixture(self._physics_tail, self._tail_shape)
  -- self._tail_fixture:setUserData(self)

  self._physics_tail = love.physics.newBody(game.world, x + 10, y, "static")
  self._tail_shape = love.physics.newCircleShape(radius)
  self._tail_fixture = love.physics.newFixture(self._physics_tail, self._tail_shape)
  self._tail_fixture:setUserData(self)

  -- self._joint = love.physics.newPrismaticJoint(self._physics_body, self._physics_tail, x, y, 1, 1, false)
  -- self._joint:enableLimit(true)
  -- self._joint:setLimits(-1, 1)
  -- self._joint:enableMotor(true)
  -- self._joint:setMotorSpeed(2)
  -- self._joint:setMaxMotorForce(100)
  self._joint = love.physics.newDistanceJoint(self._physics_body, self._physics_tail, x, y, x + 10, y, false)
end

function Sperm:update(dt)
end

function Sperm:render()
  g.setColor(COLORS.BLUE:rgb())
  local x, y = self._physics_body:getPosition()
  g.circle("fill", x, y, self._body_shape:getRadius())
  -- g.line(self._tail_shape:getPoints())
  g.setColor(COLORS.GREEN:rgb())
  local x, y = self._physics_tail:getPosition()
  g.circle("fill", x, y, self._tail_shape:getRadius())
end

function Sperm:clean()
  self._body_fixture:destroy()
  self._physics_body:destroy()
  self._tail_fixture:destroy()
  self._physics_tail:destroy()
end

function Sperm:move_to(x, y)
  self._physics_body:setPosition(x,y)
end
