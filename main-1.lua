--SERVER
--package.path = package.path .. ";../../?.lua"
gamera = require "gamera.gamera"
require "gooi.gooi"
require "gooi.button"
require "gooi.joy"
require "gooi.panel"
require "gooi.layout"
require "gooi.label"
require "gooi.slider"
require "gooi.component"
require "gooi.checkbox"

sock = require "sock.sock"
bitser = require "sock.spec.bitser"
-- Utility functions


function love.load()
username="ADMIN B-|"
W, H = love.graphics.getWidth(),
love.graphics.getHeight()


playerNumber=1
gooi.load()
mouseX=0
mouseY=0
cam = gamera.new(0,0,2130,1460)
    local marginX = 50
    -- how often an update is sent out
    tickRate = 1/60
    tick = 0
   -- server = sock.newServer("0.0.0.0", 22122,2)
      server = sock.newServer("0.0.0.0",22122,3)
 server:setSerialization(bitser.dumps, bitser.loads)
    -- Players are being indexed by peer index here, definitely not a good idea
    -- for a larger game, but it's good enough for this application.
    server:on("connect", function(data, client)
        -- tell the peer what their index is
        client:send("playerNum", client:getIndex())

  end)
    -- receive info on where a player is located
    server:on("player", function(y, client)
        local index = client:getIndex()+1
        players[index] = y
    end)
    --[[
    server:on("mouseX", function(x, client)
        local index = client:getIndex()+1
        players[index].x = x
    end)]]
    function newPlayer(x, y)
        return {
            x = x,
            y = y,
            w = 20,
            h = 20,
        }
    end
    function newBall(x, y)
        return {
            x = x,
            y = y,
            vx = 150,
            vy = 150,
            w = 15,
            h = 15,
        }
    end
    --local marginX = 50
    players = {
        newPlayer(marginX, love.graphics.getHeight()/2),
        newPlayer(love.graphics.getWidth() - marginX, love.graphics.getHeight()/2),
   newPlayer(76,76) 
   }
    scores = {0, 0}
    --ball = newBall(love.graphics.getWidth()/2, love.graphics.getHeight()/2)
    
    
   players[playerNumber].name=username
end






function love.update(dt)
gooi.update(dt)
    server:update(dt)
    -- wait until 2 players connect to start playing
    local enoughPlayers = #server.clients >= 0
   -- if not enoughPlayers then return end
    for i, player in pairs(players) do
        -- This is a naive solution, if the ball is inside the paddle it might bug out
        -- But hey, it's low stakes pong
--[[
        if isColliding(ball, player) then
            ball.vx = ball.vx * -1
            ball.vy = ball.vy * -1
        end
--]]
    end	
    tick = tick + dt
    if tick >= tickRate then
        tick = 0
        for i, player in pairs(players) do
            server:sendToAll("playerState", {i, player})
        end
        --server:sendToAll("ballState", ball)
    end

ll=slid:getValue() 
cam:setScale(ll+0.2)
cam:setPosition(players[playerNumber].x,players[playerNumber].y)
ang_ljoy=math.atan2(ljoy:yValue(), ljoy:xValue() ) 
cos0 = math.cos(ang_ljoy)
sin0 = math.sin(ang_ljoy)

            --mouseY =40 --love.mouse.getY()
            --mouseX =60 --love.mouse.getX()
if ljoy:xValue() ~= 0 and ljoy:yValue() ~= 0 then
players[playerNumber].x = players[playerNumber].x + 200 * cos0  * dt
players[playerNumber].y= players[playerNumber].y+ 200 * sin0  * dt
end
            --[[local playerY = mouseY - players[playerNumber].h/2
            local playerX = mouseX - players[playerNumber].w/2
            -- Update our own player position and send it to the server
            players[playerNumber].y =mouseY-- playerY
            players[playerNumber].x =mouseX-- playerX
            --client:send("mouseY", playerY)
            --client:send("mouseX", playerX)
   					 --cam:setPosition(playerX,playerY)]]
      
end




function love.draw()
gooi.draw()

cam:draw(function()
    for i, player in pairs(players) do
    		love.graphics.printf(player.name or "unknown",player.x-40,player.y-20,100,"center")
        love.graphics.rectangle('fill',math.floor(player.x),math.floor( player.y), player.w, player.h)
    end
    --love.graphics.rectangle('fill', ball.x, ball.y, ball.w, ball.h)
    end)
    local score = ("%d - %d"):format(scores[1], scores[2])

    love.graphics.print(score, 5, 5)
    love.graphics.print("playe   r"..players[1].x,10,30)
end




function love.touchpressed (id, x,
 y) gooi.pressed(id, x, y) end

function love.touchreleased(id, x, y) gooi.
released(id, x, y) end

function love.touchmoved (
id, x, y) gooi.moved(id, x, y)
end






function gooi.load()
slid = gooi.newSlider({

value = 0.9 ,

x = 237 ,

y = 284 ,

w = 227 ,

h = 27,

--group = "grp1"
})



lock=gooi.newCheck({
text = "Lock" ,
x = 14 ,
y = 48 ,
w = 200 ,
h = 40,--75,
--group = "grp1" ,
checked = true -- default = false
}):change()

ljoy = gooi.newJoy({x=290, 
y=130, 
size = 50,})
--:setImage( "/imgs/joys.png" )
:noScaling()
:anyPoint()
--:noSpring() 
--:setDigital()
--:direction)

rjoy = gooi.newJoy({x=W-160,--x=332, 
y=194, 
size = 90})

--:setImage( "/imgs/joys.png" )


:noScaling()

:anyPoint()

:noSpring() 

--:setDigital()

--:direction()



end
