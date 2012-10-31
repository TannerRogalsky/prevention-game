require('requirements')

SCREEN_UNITS_X, SCREEN_UNITS_Y = 720, 1280
SCREEN_WIDTH, SCREEN_HEIGHT = SCREEN_UNITS_X, SCREEN_UNITS_Y
MOAISim.openWindow("Prevention", SCREEN_WIDTH, SCREEN_HEIGHT )
MOAIGfxDevice.setClearColor(1,1,1,1)

do
  mainThread = MOAICoroutine.new ()
  mainThread:run(function()
    local game = Game:new()
    game.egg = Egg:new(0,0,10)
    game.action_layer:insertProp(game.egg.sprite)

    while true do
      coroutine.yield()
      local dt = MOAISim.getStep()

      game:update(dt)
    end
  end)
end
