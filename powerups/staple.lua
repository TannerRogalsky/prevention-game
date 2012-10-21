Staple = class('Staple', PowerUp)

function Staple:initialize(x, y, width, height)
  PowerUp.initialize(self)
end

function Staple:update(dt)
end

function Staple:render()
  g.setColor(COLORS.GREEN:rgb())
  self._physics_body:draw("fill")
end

function Staple:effect()
  game.score = game.score + 5
end
