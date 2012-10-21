Sperm = class('Sperm', Base)

function Sperm:initialize(x, y, radius)
  Base.initialize(self)

  self.pos = {x = x, y = y}
  self.pos.incr = function(self, k, v) self[k] = self[k] + v end
  self.radius = radius
  self.angle = 0
  self.speed = 1.5

  self._physics_body = game.collider:addCircle(self.pos.x, self.pos.y, self.radius)
  self._physics_body.parent = self
end

function Sperm:update(dt)
  local target = nil
  if game.egg then
    target = game.egg
  else
    local closest_powerup
    -- loop through and find the closest powerup to the sperm
    for id,power_up in pairs(game.powerups) do
      if closest_powerup == nil then
        closest_powerup = power_up
      else
        local current_dist = math.dist(self.pos.x, self.pos.y, closest_powerup.pos.x, closest_powerup.pos.y)
        local proposed_dist = math.dist(self.pos.x, self.pos.y, power_up.pos.x, power_up.pos.y)
        if proposed_dist < current_dist then
          closest_powerup = power_up
        end
      end
    end
    target = closest_powerup
  end

  if target then
    local max_rotation = 0.05
    local x, y = target.pos.x, target.pos.y
    local desired_angle = math.atan2(y - self.pos.y, x - self.pos.x)
    -- TODO this doesn't work properly because of .5pi and radians
    -- the bottom half of the circle doesn't computer properly
    local angle_delta = self.angle - desired_angle
    if angle_delta > math.pi then
      -- print(math.deg(angle_delta))
      desired_angle = math.abs(math.pi - angle_delta)
      -- print(self.angle, desired_angle, math.deg(angle_delta))
    end
    -- print(self.angle, desired_angle)
    self.angle = math.clamp(self.angle - max_rotation, desired_angle, self.angle + max_rotation)
    -- self.angle = desired_angle
    x = self.pos.x + self.speed * math.cos(self.angle)
    y = self.pos.y + self.speed * math.sin(self.angle)
    self:move_to(x,y)
  end
end

function Sperm:render()
  g.setColor(COLORS.BLUE:rgb())
  self._physics_body:draw("fill")
  local x = self.pos.x + (self.radius  + 50) * -math.cos(self.angle)
  local y = self.pos.y + (self.radius  + 50) * -math.sin(self.angle)
  g.line(self.pos.x, self.pos.y, x, y)
end

function Sperm:move(x, y)
  self.pos:incr('x', x)
  self.pos:incr('y', y)
  self._physics_body:move(x,y)
end

function Sperm:move_to(x, y)
  self.pos.x = x
  self.pos.y = y
  self._physics_body:moveTo(x,y)
end

function Sperm:on_collide(dt, shape_one, shape_two, mtv_x, mtv_y)
  local other_object = shape_two.parent

  if instanceOf(Sperm, other_object) then
    self:move(mtv_x, mtv_y)
  elseif instanceOf(Egg, other_object) then
    game.over = true
  elseif instanceOf(PowerUp, other_object) and game.egg == nil then
    game.collider:remove(other_object._physics_body)
    game.powerups[other_object.id] = nil
  end
end
