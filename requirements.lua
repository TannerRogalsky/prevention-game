-- Helper assignments and erata
GRAVITY = 700
math.tau = math.pi * 2
COLORS = setmetatable({}, {__newindex = function(t, k, v)
  v.rgb = function(color) return color.r / 255.0, color.g / 255.0, color.b / 255.0 end
  v.rgba = function(color) return color.r / 255.0, color.g / 255.0, color.b / 255.0, color.a / 255.0 end
  rawset(t, k, v)
end})
COLORS.RED =    {r = 255, g = 0,   b = 0,   a = 255}
COLORS.GREEN =  {r = 0,   g = 255, b = 0,   a = 255}
COLORS.BLUE =   {r = 0,   g = 0,   b = 255, a = 255}
COLORS.WHITE =  {r = 255, g = 255, b = 255, a = 255}
COLORS.BLACK =  {r = 0,   g = 0,   b = 0,   a = 255}
COLORS.YELLOW = {r = 0,   g = 255, b = 255, a = 255}
COLORS.PURPLE = {r = 255, g = 0,   b = 255, a = 255}

math.randomseed(MOAISim.getDeviceTime())
r = math.random
function math.round(n, deci) deci = 10^(deci or 0) return math.floor(n*deci+.5)/deci end
function math.clamp(low, n, high) return math.min(math.max(low, n), high) end
function math.dist(x1, y1, x2, y2) return math.sqrt(math.pow(x2 - x1, 2) + math.pow(y2 - y1, 2)) end
function pointInCircle(circle, point) return (point.x-circle.x)^2 + (point.y - circle.y)^2 < circle.radius^2 end
function string:split(sep) return self:match((self:gsub("[^"..sep.."]*"..sep, "([^"..sep.."]*)"..sep))) end
function math.angle(x1, y1, x2, y2) return math.deg(math.atan2(y2 - y1, x2 - x1)) end
globalID = 0
function generateID() globalID = globalID + 1 return globalID end

function draw_circle(center_x, center_y, radius)
  local d = (5 - radius * 4)/4
  local x, y = 0, radius
  local octants = {}
  for i=1,8 do octants[i] = {} end

  while true do
    table.insert(octants[1], {center_x + x, center_y + y})
    table.insert(octants[2], {center_x + x, center_y - y})
    table.insert(octants[3], {center_x - x, center_y + y})
    table.insert(octants[4], {center_x - x, center_y - y})
    table.insert(octants[5], {center_x + y, center_y + x})
    table.insert(octants[6], {center_x + y, center_y - x})
    table.insert(octants[7], {center_x - y, center_y + x})
    table.insert(octants[8], {center_x - y, center_y - x})

    if d < 0 then
      d = d + 2 * x + 1
    else
      d = d + 2 * (x - y) + 1
      y = y - 1
    end
    x = x + 1

    if x > y then break end
  end

  return octants
end


font = MOAIFont.new ()
font:loadFromTTF("fonts/arialbd.ttf", "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789,.?!", 12, 163)

-- Put any game-wide requirements in here
require 'lib/middleclass'
Stateful = require 'lib/stateful'
-- skiplist = require "lib/skiplist"
-- HC = require 'lib/HardonCollider'
-- inspect = require 'lib/inspect'
-- require 'lib/AnAL'
-- cron = require 'lib/cron'

require 'base'
require 'game'
require 'egg'

require 'states.main'
