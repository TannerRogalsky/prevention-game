require('requirements')

SCREEN_UNITS_X, SCREEN_UNITS_Y = 720, 1280
SCREEN_WIDTH, SCREEN_HEIGHT = SCREEN_UNITS_X, SCREEN_UNITS_Y
MOAISim.openWindow("Prevention", SCREEN_WIDTH, SCREEN_HEIGHT )
MOAIGfxDevice.setClearColor(1,1,1,1)

game = Game:new()

do
  mainThread = MOAICoroutine.new ()
  mainThread:run(function()
    while true do
      coroutine.yield()
      local dt = MOAISim.getStep()

      game:update(dt)
    end
  end)
end


if MOAIInputMgr.device.pointer then
  local function mouse_callback(down, button)
    local x, y = MOAIInputMgr.device.pointer:getLoc()
    if down then game:mouse_pressed(x, y, button)
    else game:mouse_released(x, y, button) end
  end

  MOAIInputMgr.device.mouseLeft:setCallback(function(down) mouse_callback(down, "left") end)
  MOAIInputMgr.device.mouseRight:setCallback(function(down) mouse_callback(down, "right") end)
  MOAIInputMgr.device.mouseMiddle:setCallback(function(down) mouse_callback(down, "middle") end)
else
  MOAIInputMgr.device.touch:setCallback(
    function(eventType, idx, x, y, tapCount)
      if eventType == MOAITouchSensor.TOUCH_DOWN then
        game:mouse_pressed(x, y, "touch")
      elseif eventType == MOAITouchSensor.TOUCH_UP then
        game:mouse_released(x, y, "touch")
      end
    end)
end

