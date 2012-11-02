local Menu = Game:addState('Menu')

function Menu:enteredState()
  self.background = self.preloaded_image["menu.png"]
end

function Menu:render()
  local iw, ih = self.background:getWidth(), self.background:getHeight()
  local ww, wh = g.getMode()
  g.setColor(COLORS.WHITE:rgb())
  g.draw(self.background, 0, 0, 0, ww / iw, wh / ih)
end

function Menu:mousepressed(x, y, button)
  self:gotoState("Main")
end

function Menu:keypressed(key, unicode)
  self:gotoState("Main")
end

function Menu:exitedState()
end

return Menu
