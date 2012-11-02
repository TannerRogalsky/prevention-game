Wall = class('Wall', PowerUp)

function Wall:initialize(game)
  PowerUp.initialize(self)

  self.image = game.preloaded_image["icon_4.png"]
end

function Wall:update(dt)
end

function Wall:render(x, y, w, h)
  local img = self.image
  local iw, ih = img:getWidth(), img:getHeight()
  g.draw(img, x, y, w / iw, h / ih)
end

function Wall:effect()
end
