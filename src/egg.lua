Egg = class('Egg', Base)
Egg.static.GROWTH_EXPONENT = 2

function Egg:initialize(x, y, radius)
  Base.initialize(self)

  self.sprite = MOAIProp2D.new()
  self.sprite:setLoc(x, y)
  self.time_alive = 0

  -- load the sprite sheet; this will be the source for our sprite
  local start_index, stop_index = 1, 10
  local spriteSheet = MOAITileDeck2D.new ()
  spriteSheet:setTexture("images/egg_small.png") -- load a texture
  spriteSheet:setSize(stop_index, 1)
  spriteSheet:setRect(-radius, -radius, radius, radius) -- set the world space dimensions of the sprites

  self.sprite:setDeck(spriteSheet)

  -- create the animation curve
  local anim_curve = MOAIAnimCurve.new()
  anim_curve:reserveKeys(stop_index)

  local time_to_run = 1
  local step = time_to_run/stop_index

  -- loop through each frame over time
  for index = start_index, stop_index do
    -- index is 1-indexed but time is 0-indexed
    anim_curve:setKey(index, step * (index - 1), index, MOAIEaseType.FLAT)
  end

  local anim = MOAIAnim:new()
  anim:reserveLinks(1)
  anim:setLink(1, anim_curve, self.sprite, MOAIProp.ATTR_INDEX)
  anim:setMode(MOAITimer.PING_PONG)

  self.sprite:setIndex(start_index)
  anim:start()

  local tx, ty = self.sprite:getLoc()
  local sx, sy = game.sperm.sprite:getLoc()
  local angle = math.angle(sx, sy, tx, ty) - 90
  if angle >= 180 then
    angle = angle - 180
  end
  game.sperm.sprite:seekRot(angle, 1)

  local driver = MOAIEaseDriver.new()
  driver:reserveLinks(2)
  driver:setLink(1, game.sperm.sprite, MOAITransform.ATTR_X_LOC, self.sprite, MOAITransform.ATTR_X_LOC)
  driver:setLink(2, game.sperm.sprite, MOAITransform.ATTR_Y_LOC, self.sprite, MOAITransform.ATTR_Y_LOC)
  driver:setSpan(3)
  driver:start()
end

function Egg:update(dt)
  self.time_alive = self.time_alive + dt

  self.sprite:addScl(dt * math.pow(self.time_alive, Egg.GROWTH_EXPONENT))
end
