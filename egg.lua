Egg = class('Egg', Base)
Egg.static.GROWTH_EXPONENT = 2

function Egg:initialize(x, y, radius)
  Base.initialize(self)

  -- load the sprite sheet; this will be the source for our sprite
  local start_index, stop_index = 1, 10
  local spriteSheet = MOAITileDeck2D.new ()
  spriteSheet:setTexture("images/egg.png") -- load a texture
  spriteSheet:setSize(stop_index, 1)
  spriteSheet:setRect(-radius, -radius, radius, radius) -- set the world space dimensions of the sprites

  -- create a sprite and initialize it
  self.sprite = MOAIProp2D.new()
  self.sprite:setDeck(spriteSheet)

  -- create the animation curve
  local anim_curve = MOAIAnimCurve.new()
  anim_curve:reserveKeys(stop_index)

  local time_to_run = 2
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
end

function Egg:update(dt)
  self.sprite:addScl(dt)
end

function Egg:grow(dt)
  -- self.radius = self.start_radius + math.pow(self.alive, Egg.GROWTH_EXPONENT)
end
