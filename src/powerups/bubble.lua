Bubble = class('Bubble', PowerUp)

function Bubble:initialize(game)
  PowerUp.initialize(self)

  self.image = game.preloaded_image["icon_5.png"]
end

function Bubble:update(dt)
end

function Bubble:render(x, y, w, h)
  local img = self.image
  local iw, ih = img:getWidth(), img:getHeight()
  g.draw(img, x, y, w / iw, h / ih)
end

function Bubble:effect()
end
