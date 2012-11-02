Sperm = class('Sperm', Base)

function Sperm:initialize(x, y, radius)
  Base.initialize(self)

  self.sprite = MOAIProp2D.new()
  self.time_alive = 0


  -- load the sprite sheet; this will be the source for our sprite
  local start_index, stop_index = 1, 4
  local spriteSheet = MOAITileDeck2D.new ()
  spriteSheet:setTexture("images/sperm.png") -- load a texture
  spriteSheet:setSize(stop_index, 1)
  spriteSheet:setRect(-radius, -radius * 3, radius, radius * 3) -- set the world space dimensions of the sprites

  self.sprite:setDeck(spriteSheet)

  -- create the animation curve
  local anim_curve = MOAIAnimCurve.new()
  anim_curve:reserveKeys(stop_index)

  local time_to_run = 0.8
  local step = time_to_run/stop_index

  -- loop through each frame over time
  for index = start_index, stop_index do
    -- index is 1-indexed but time is 0-indexed
    anim_curve:setKey(index, step * (index - 1), index, MOAIEaseType.FLAT)
  end

  local anim = MOAIAnim:new()
  anim:reserveLinks(1)
  anim:setLink(1, anim_curve, self.sprite, MOAIProp.ATTR_INDEX)
  anim:setMode(MOAITimer.LOOP)

  self.sprite:setIndex(start_index)
  anim:start()
end

-- function Sperm:update(dt)
--   if game.egg then
--     local tx, ty = game.egg.sprite:getLoc()
--     local sx, sy = self.sprite:getLoc()
--     local angle = math.atan2(ty - sy, tx - sx)
--     -- self.angle = desired_angle
--     x = self.pos.x + self.speed * math.cos(self.angle)
--     y = self.pos.y + self.speed * math.sin(self.angle)
--   end
-- end
