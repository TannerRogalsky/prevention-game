Decoy = class('Decoy', PowerUp)

function Decoy:initialize(game)
  PowerUp.initialize(self)

  self.image = game.preloaded_image["icon_7.png"]
end

function Decoy:update(dt)
end

function Decoy:render(x, y, w, h)
  local img = self.image
  local iw, ih = img:getWidth(), img:getHeight()
  g.draw(img, x, y, w / iw, h / ih)
end

function Decoy:effect()
end
