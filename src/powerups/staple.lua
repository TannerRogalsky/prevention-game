Staple = class('Staple', PowerUp)

function Staple:initialize(game)
  PowerUp.initialize(self)

  self.image = game.preloaded_image["icon_1.png"]
end

function Staple:update(dt)
end

function Staple:render(x, y, w, h)
  local img = self.image
  local iw, ih = img:getWidth(), img:getHeight()
  g.draw(img, x, y, w / iw, h / ih)
end

function Staple:effect()
  local targets, target = {}, nil

  for id,sperm in pairs(game.sperm) do
    if sperm.stapled ~= true then
      table.insert(targets, sperm)
    end
  end

  if #targets > 0 and game.staples > 0 then
    target = targets[r(#targets)]
    target.stapled = true
    game.staples = game.staples - 1

    cron.after(5, function()
      target.stapled = false
    end)
  end
end
