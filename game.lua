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
  self.fps_textbox:setRect(-SCREEN_WIDTH/2, -SCREEN_HEIGHT/2, SCREEN_WIDTH/2, SCREEN_HEIGHT/2)
  -- self.fps_textbox:setLoc(10, 0)
  -- self.fps_textbox:setAlignment(MOAITextBox.RIGHT_JUSTIFY)
  self.fps_textbox:setYFlip(true)
  self.fps_textbox:setColor(COLORS.GREEN:rgb())
  self.ui_layer:insertProp(self.fps_textbox)

  local background_image = MOAIGfxQuad2D.new()
  background_image:setTexture("images/background.png")
  background_image:setRect(-720/2, -1280/2, 720/2, 1280/2)

  self.background = MOAIProp2D.new()
  self.background:setDeck(background_image)

  self.action_layer:insertProp(self.background)

  -- local scriptDeck = MOAIScriptDeck.new()
  -- scriptDeck:setRect(-720/2, -1280/2, 720/2, 1280/2)
  -- scriptDeck:setDrawCallback(function(index,xOff,yOff,xFlip,yFlip)
  --   MOAIGfxDevice.setPenColor(COLORS.RED:rgb())
  --   -- MOAIGfxDevice.setPenWidth(3)
  --   -- MOAIDraw.fillCircle(SCREEN_WIDTH/2, SCREEN_HEIGHT/2, 50, 20)
  --   MOAIDraw.fillFan(SCREEN_WIDTH/2,SCREEN_HEIGHT/2, 0,SCREEN_HEIGHT/2, 0,0)
  -- end)

  -- local prop = MOAIProp2D.new()
  -- prop:setDeck(scriptDeck)
  -- self.ui_layer:insertProp(prop)
end

function Game:update(dt)
  self.fps_textbox:setString("FPS: " .. math.round(MOAISim.getPerformance()))
  self.egg:update(dt)
end

function Game:mousepressed(x, y, button)
end

function Game:mousereleased(x, y, button)
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
