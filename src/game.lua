Game = class('Game', Base):include(Stateful)

function Game:initialize()
  Base.initialize(self)

  self.viewport = MOAIViewport.new()
  self.viewport:setSize(SCREEN_WIDTH, SCREEN_HEIGHT)
  self.viewport:setScale (SCREEN_UNITS_X, SCREEN_UNITS_Y)

  self.action_layer = MOAILayer2D.new()
  self.action_layer:setViewport(self.viewport)
  MOAISim.pushRenderPass(self.action_layer)

  self.ui_layer = MOAILayer2D.new()
  self.ui_layer:setViewport(self.viewport)
  MOAISim.pushRenderPass(self.ui_layer)

  self.fps_textbox = MOAITextBox.new()
  self.fps_textbox:setFont(font)
  self.fps_textbox:setTextSize(20)
  self.fps_textbox:setRect(-SCREEN_UNITS_X/2, -SCREEN_UNITS_Y/2, SCREEN_UNITS_X/2, SCREEN_UNITS_Y/2)
  self.fps_textbox:setYFlip(true)
  self.fps_textbox:setColor(COLORS.GREEN:rgb())
  self.ui_layer:insertProp(self.fps_textbox)

  local background_image = MOAIGfxQuad2D.new()
  background_image:setTexture("images/background.png")
  background_image:setRect(-SCREEN_UNITS_X/2, -SCREEN_UNITS_Y/2, SCREEN_UNITS_X/2, SCREEN_UNITS_Y/2)

  self.background = MOAIProp2D.new()
  self.background:setDeck(background_image)

  self.action_layer:insertProp(self.background)

  self.sperm = {}
end

function Game:update(dt)
  self.fps_textbox:setString("FPS: " .. math.round(MOAISim.getPerformance()))

  if self.egg then
    self.egg:update(dt)
  end
end

function Game:mouse_pressed(x, y, button)
  if self.egg == nil then
    local x, y = self.action_layer:wndToWorld(x,y)
    self.egg = Egg:new(x, y, 6)
    self.action_layer:insertProp(self.egg.sprite)
  end
end

function Game:mouse_released(x, y, button)
  if self.egg then
    self.action_layer:removeProp(self.egg.sprite)
    self.egg = nil
  end
end

-- function Game:keypressed(key, unicode)
-- end

-- function Game:keyreleased(key, unicode)
-- end

-- function Game:joystickpressed(joystick, button)
--   print(joystick, button)
-- end

-- function Game:joystickreleased(joystick, button)
--   print(joystick, button)
-- end

-- function Game:focus(has_focus)
-- end

-- function Game:quit()
-- end
