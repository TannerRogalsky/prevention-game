Slow = class('Slow', PowerUp)

function Slow:initialize(game)
  PowerUp.initialize(self)

  self.image = game.preloaded_image["icon_6.png"]
end

function Slow:update(dt)
end

function Slow:render(x, y, w, h)
  local img = self.image
  local iw, ih = img:getWidth(), img:getHeight()
  g.draw(img, x, y, w / iw, h / ih)
end

function Slow:effect()
end
