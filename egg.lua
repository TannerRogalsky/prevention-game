Egg = class('Egg', Base)
Egg.static.GROWTH_EXPONENT = 2

function Egg:initialize(x, y, radius)
  Base.initialize(self)

  -- load the sprite sheet; this will be the source for our sprite
  local spriteSheet = MOAITileDeck2D.new ()
  spriteSheet:setTexture("images/egg.png") -- load a texture
  spriteSheet:setSize(10, 1)
  spriteSheet:setRect(-radius, -radius, radius, radius) -- set the world space dimensions of the sprites

  -- create a sprite and initialize it
  self.sprite = MOAIProp2D.new()
  self.sprite:setDeck(spriteSheet)

  local start_index, stop_index = 1, 10
  local step = start_index/stop_index

  -- create the animation curve
  local anim_curve = MOAIAnimCurve.new()
  local time = 1
  local index_count = stop_index - start_index + 2
  anim_curve:reserveKeys(index_count)
  -- loop through each frame over time
  for index = start_index, stop_index do
          anim_curve:setKey(time, step*(time-1), index, MOAIEaseType.FLAT)
          time = time + 1
        end
  -- add the last frame (to time it right)
  anim_curve:setKey(time, step*(time-1), stop_index, MOAIEaseType.FLAT)

  local anim = MOAIAnim:new()
  anim:reserveLinks(1)
  anim:setLink(1, anim_curve, self.sprite, MOAIProp.ATTR_INDEX)
  anim:setMode(MOAITimer.LOOP)

  self.sprite:setIndex(start_index)
  anim:start()
end

function Egg:update(dt)
  self.sprite:addScl(dt)
end

function Egg:grow(dt)
  -- self.radius = self.start_radius + math.pow(self.alive, Egg.GROWTH_EXPONENT)
end
