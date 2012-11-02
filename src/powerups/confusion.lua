Confusion = class('Confusion', PowerUp)

function Confusion:initialize(game)
  PowerUp.initialize(self)

  self.image = game.preloaded_image["icon_2.png"]
end

function Confusion:update(dt)
end

function Confusion:render(x, y, w, h)
  local img = self.image
  local iw, ih = img:getWidth(), img:getHeight()
  g.draw(img, x, y, w / iw, h / ih)
end

function Confusion:effect()
end
