local Main = Game:addState('Main')

function Main:enteredState()
  self.collider = HC(50, self.on_start_collide, self.on_stop_collide)
  local w,h = love.graphics.getMode()
  self.sperm = {}
  self.powerups = {}
  self.score = 0
  self.background = self.preloaded_image["background.png"]

  self:make_item_boxes(6)
end

function Main:update(dt)
  if game.over then
    self.egg.anim:update(dt)
    return
  end

  cron.update(dt)
  self.collider:update(dt)

  if self.egg then
    self.egg:update(dt)
  end

  for id,sperm in pairs(self.sperm) do
    sperm:update(dt)
  end

  for id,powerup in pairs(self.powerups) do
    powerup:update(dt)
  end
end

function Main:render()
  self.camera:set()

  g.setColor(COLORS.WHITE:rgb())
  g.draw(self.background, 0, 0, 0, 0.5, 0.5)

  for id,powerup in pairs(self.powerups) do
    powerup:render()
  end

  if self.egg then
    self.egg:render()
  end

  for id,sperm in pairs(self.sperm) do
    sperm:render()
  end

  self:ui_overlay()

  if game.over then
    self:game_over_overlay()
  end

  self.camera:unset()
end

function Main:mousepressed(x, y, button)
  local clicked_powerup = false
  for id,powerup in pairs(self.powerups) do
    if powerup:contains(x, y) then
      clicked_powerup = powerup
      break
    end
  end

  for i,ui_box in ipairs(self.item_boxes) do
    if ui_box:contains(x, y) then
      ui_box:select()
      break
    end
  end

  if clicked_powerup then
    game.collider:remove(clicked_powerup._physics_body)
    clicked_powerup:effect()
    game.powerups[clicked_powerup.id] = nil
  elseif self.egg == nil then
    self.egg = Egg:new(x, y, 2)
  end
end

function Main:mousereleased(x, y, button)
  if self.egg and not game.over then
    self.collider:remove(self.egg._physics_body)
    cron.cancel(self.egg.power_spawn)
    self.egg = nil
  end
end

function Main:keypressed(key, unicode)
  if self.item_boxes[tonumber(key)] then
    self.item_boxes[tonumber(key)]:select()
  else
    local w,h = love.graphics.getMode()
    local new_sperm = Sperm:new(r(w), r(h), 10)
    self.sperm[new_sperm.id] = new_sperm
  end
end

function Main:keyreleased(key, unicode)
end

function Main:joystickpressed(joystick, button)
end

function Main:joystickreleased(joystick, button)
end

function Main:focus(has_focus)
end

function Main:exitedState()
end

function Main.on_start_collide(dt, shape_one, shape_two, mtv_x, mtv_y)
  if game.over then return end

  local object_one, object_two = shape_one.parent, shape_two.parent

  -- print(object_one, object_two)

  if type(object_one.on_collide) == "function" then
    object_one:on_collide(dt, shape_one, shape_two, mtv_x, mtv_y)
  end

  if type(object_two.on_collide) == "function" then
    object_two:on_collide(dt, shape_two, shape_one, -mtv_x, -mtv_y)
  end
end

function Main.on_stop_collide(dt, shape_one, shape_two)
  -- print(tostring(shape_one.parent) .. " stopped colliding with " .. tostring(shape_two.parent))
end

function Main:ui_overlay()
  -- quarter circle thing at the top right
  g.setColor(COLORS.WHITE:rgb())
  g.arc("fill", g.getWidth(), 0, 95, math.rad(180), math.rad(90))
  g.setColor(COLORS.PURPLE:rgb())
  g.arc("fill", g.getWidth(), 0, 95, math.rad(180), math.rad(180 - (self.score % 100 * 0.9)))

  g.setColor(COLORS.BLACK:rgb())
  g.arc("fill", g.getWidth(), 0, 95 - 10, math.rad(180), math.rad(90))
  if self.active_item then
    g.setColor(COLORS.WHITE:rgb())
    g.draw(self.active_item, 0, 0)
  end


  -- g.circle("fill", g.getWidth(), 0, 95 - 10)

  -- bottom boxes
  for i,ui_box in ipairs(self.item_boxes) do
    ui_box:render()
  end
end

function Main:game_over_overlay()
  g.setColor(0,0,0,255/2)
  g.rectangle('fill', 0,0,g.getWidth(), g.getHeight())
  g.setColor(255,255,255,255)
  local text = "You got the bitch pregnant. Fuck, man."
  local offset = self.font:getWidth(text) / 2
  g.print(text, g.getWidth() / 2 - offset, g.getHeight() / 2)
end

function Main:make_item_boxes(count)
  local w,h = g.getMode()
  local b_size = w / count
  self.item_boxes = {}

  local click = function(ui_box)
    local powerup = ui_box.powerup
    game.active_item = new_textured_circle(powerup.image, g.getWidth(), 0, 85, 0, 0.2, 0.2, 85 * 4)
    powerup:effect()
  end

  local render = function(ui_box)
    g.setColor(COLORS.BLACK:rgb())
    g.rectangle("fill", ui_box.pos.x, ui_box.pos.y, ui_box.dimensions.w, ui_box.dimensions.h)
    g.setColor(ui_box.outline_color:rgb())
    ui_box.powerup:render(ui_box.pos.x, ui_box.pos.y, ui_box.dimensions.w, ui_box.dimensions.h)
    g.rectangle("line", ui_box.pos.x, ui_box.pos.y, ui_box.dimensions.w, ui_box.dimensions.h)
  end

  for i=0,count - 1 do
    local ui_box = UIBox:new(self, i * b_size, h - b_size, b_size, b_size, click)
    ui_box.render = render
    ui_box.powerup = PowerUp.TYPES[i + 1]:new(self)
    table.insert(self.item_boxes, ui_box)
  end
end

function new_textured_circle(img, x, y, radius, orientation, scale_x, scale_y, offset_x, offset_y)
    -- Set up and store our clipped canvas once as it's expensive
    local canvas = love.graphics.newCanvas()
    g.setColor(COLORS.WHITE:rgb())
    g.setCanvas(canvas)

    -- Our clipping function, we want to render within a polygon shape
    local myStencilFunction = function()
      g.circle("fill", x, y, radius)
    end
    g.setStencil(myStencilFunction)

    -- Setting to premultiplied means that pixels just get overlaid ignoring
    -- their alpha values. Then when we render this canvas object itself, we
    -- will use the alpha of the canvas itself
    g.setBlendMode("premultiplied")

    -- Draw the repeating image within the quad
    g.draw(img, x, y, orientation, scale_x, scale_y, offset_x, offset_y)

    -- Reset everything back to normal
    g.setBlendMode("alpha")
    g.setStencil()
    g.setCanvas()

    return canvas
end

return Main
