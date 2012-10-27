UIBox = class('UIBox', Base)

function UIBox:initialize(game, x, y, width, height, clicked_callback)
  Base.initialize(self)

  self.pos = {x = x, y = y}
  self.dimensions = {w = width, h = height}
  self.clicked_callback = clicked_callback

  self.outline_color = COLORS.WHITE

  self._physics_body = game.collider:addRectangle(self.pos.x, self.pos.y, self.dimensions.w, self.dimensions.h)
  game.collider.setGhost(self._physics_body)
  self._physics_body.parent = self
end

function UIBox:update(dt)
end

function UIBox:render()
end

function UIBox:contains(x, y)
  return self._physics_body:contains(x, y)
end

function UIBox:select()
  self.outline_color = COLORS.YELLOW
  for _,ui_box in ipairs(game.item_boxes) do
    if self ~= ui_box then
      ui_box.outline_color = COLORS.WHITE
    end
  end

  if type(self.clicked_callback) == "function" then
    self:clicked_callback()
  end
end

function UIBox:on_collide(dt, shape_one, shape_two, mtv_x, mtv_y)
  local other_object = shape_two.parent

  -- if instanceOf(Egg, other_object) then
  --   game.collider:remove(shape_one)
  --   self:effect()
  --   game.powerups[self.id] = nil
  -- end
end
