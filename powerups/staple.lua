Staple = class('Staple', PowerUp)

function Staple:initialize()
  PowerUp.initialize(self)
end

function Staple:update(dt)
end

function Staple:render(x, y, w, h)
  local img = game.preloaded_image["icon_1.png"]
  local iw, ih = img:getWidth(), img:getHeight()
  g.draw(img, x, y, w / iw, h / ih)
end

function Staple:effect()
  local targets, target = {}, nil

  for id,sperm in pairs(game.sperm) do
    table.insert(targets, sperm)
  end

  target = targets[r(#targets)]
  target.stapled = true

  cron.after(5, function()
    target.stapled = false
  end)
end
