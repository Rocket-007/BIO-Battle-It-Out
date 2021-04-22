function scum()
function love.load ()
original_width =3800
original_height = 3600
window_width,window_height =
love.graphics.getDimensions()
window_scale_y = window_height/original_height
window_scale_x = window_scale_y
window_translate_x = (window_width - (window_scale_x*original_width))/ 2
function love.draw ()
love.graphics.translate(window_translate_x, 0)
love.graphics.scale(window_scale_x,window_scale_y)
--Drawing--
love.graphics.setColor( 1, 0, 0)
love.graphics.rectangle( "fill" ,-window_translate_x, 0,window_translate_x/ 2,original_height)
love.graphics.rectangle( "fill" ,original_width, 0,window_translate_x/ 2 ,original_height)
end
end
end




function gghj()
local ball = { x=200, y=200, r=40 }
local hold = false  -- is mouse button being kept pressed?
local px, py = 0, 0  -- last click position
function love.update (dt)
  if hold then
    -- if holding the mouse button pressed, keep the
    -- circle at the same position as the mouse cursor
    ball.x = love.mouse.getX()
    ball.y = love.mouse.getY()
  end
end
function love.mousereleased (x, y, btn)
  if btn == 1 then
    hold = false
  end
end
function love.mousepressed (x, y, btn)
  px, py = x, y
  -- pythagorean theorem gives us a hand to detect we areclicking
  -- in the circle
  hold = math.sqrt(math.pow(x - ball.x, 2) + math.pow(y -
ball.y, 2)) <= ball.r
end
function love.draw()
  love.graphics.printf('hold: ' .. tostring(hold), 0, 0, 100)
  love.graphics.printf('last pressed: ' .. px .. ',' .. py, 0, 20,
140)
  if love.mouse.isDown(1) then
    love.graphics.printf('mouse left btn is down', 0, 40, 140)
  end
  love.graphics.circle('fill', ball.x, ball.y, ball.r)
end
end



function inpush()
io.stdout:setvbuf('no')
push = require "push.push" --require the library
love.window.setTitle("Press space to switch examples")
local examples = {
  "low-res",
  "single-shader",
  "multiple-shaders",
  "mouse-input",
  "canvases-shaders",
  "stencil"
}
local example = 1
for i = 1, #examples do
  examples[i] = require("push.examples." .. examples[i])
end
function love.resize(w, h)
  push:resize(w, h)
end
function love.keypressed(key, scancode, isrepeat)
  if key == "space" then
    example = (example < #examples) and example + 1 or 1
    --be sure to reset push settings
    push:resetSettings()
    examples[example]()
    love.load()
  elseif key == "f" then --activate fullscreen mode
    push:switchFullscreen() --optional width and height parameters for window mode
  end
end
examples[example]()
end


