--CLIEÑT
--package.path = package.path .. ";../../?.lua"
gamera = require "gamera.gamera"
require "gooi.gooi"
require "gooi.button"
require "gooi.joy"
require "gooi.panel"
require "gooi.slider"
require "gooi.layout"
require "gooi.label"
require "gooi.spinner"
require "gooi.component"
require "gooi.checkbox"
local sti = require "sti.sti"
bump=require"bump.bump"
sock = require "sock.sock"
bitser = require "sock.spec.bitser"

local playerX,playerY,tx,ty=0,0,0,0
gravityAccel = 200
function love.load()
world = bump. newWorld(40)
nightTime=0
isNightTime=false
bg =love.graphics. newImage("imgs/BG_01.png")
bg2 =love.graphics. newImage("imgs/sky_01_0.png")
	-- Load map file
	map = sti("test.lua",{"bump"})
 map:resize(love.graphics.getWidth()*1.5,love.graphics.getHeight()*1.5)
	 	map:bump_init(world)
--world = bump. newWorld(40)
username="rocket"
cam = gamera.new(-1000,-1000,3130,1860)
W, H = love.graphics.getWidth(),
love.graphics.getHeight()
gooi.load()
    -- how often an update is sent out
    tickRate = 1/60
    tick = 0
    --client = sock.newClient("localhost", 22122)
 client = sock.newClient("192.168.43.45",22122)   
    
  
--client = sock.newClient("192.168.1.128",22122)   
    
client:setSerialization(bitser.dumps, bitser.loads)
    client:setSchema("playerState", {
        "index",
        "player",
    })
    -- store the client's index
    -- playerNumber is nil otherwise
    client:on("playerNum", function(num)
        playerNumber = num+1
    end)

if playerNumber == nil then
playerNumber=2
end
    -- receive info on where the players are located
    client:on("playerState", function(data)
        local index = data.index
        local player = data.player
        -- only accept updates for the other player
        if playerNumber and index ~= playerNumber then
            players[index] = player
        end
    end)
    client:on("ballState", function(data)
        ball = data
    end)
    client:on("scores", function(data)
        scores = data
    end)
    client:connect()
    function newPlayer(x, y)
        local o={
            
x = x,
y = y,
w = 12,
h = 25,
vx= 0,
vy = 0,
live=3,
boost = 200,
deadCounter = 0,
isBlob= true,
canShoot=true,
onGround=false,
deadDuration  = 6,   -- seconds until res-pawn
runAccel      = 50, -- the player acceleration while going left/right
brakeAccel    = 50,--100,
speed = 120, -- Acceleration speed of player
maxSpeed = 100,
jumpVelocity  = 100,
bounciness = -0,
cooldown = 0, cooldownAdd = 0.15,--0.40,
health = 100, healthMax = 100, healthRegen = 30, hit = false

        }
    world:add(o,o.x,o.y,o.w,o.h)
return o
end

    local marginX = 50
    players = {
        newPlayer(marginX, love.graphics.getHeight()/2),
        newPlayer(love.graphics.getWidth() - marginX, love.graphics.getHeight()/2),
   newPlayer(love.graphics.getWidth() - marginX, love.graphics.getHeight()/2)

    }

playersBullet={
{},
{},
{},
{},
}

function addWall(x, y, d, size)
o={
damage=10,
health=200,
healthMax = 200,
shape=
{

{a={},b={},c={}},


{a={},b={},c={}},


{a={},b={},c={}},

}

}
return o
end


playersWeapon={
{addWall()},--(x, y, d, size)},
{addWall()},
{},
{}
}

do
for i,o in ipairs (playersWeapon[playerNumber][1].shape) do
local si=10
local num=1
for j,p in pairs (o) do
p.x=0
p.y=0
p.vx=0
p.vy=0
p.isWall=playerNumber
p.health=playersWeapon[playerNumber][1].health
p.healthMax=playersWeapon[playerNumber][1].healthMax
p.damage=playersWeapon[playerNumber][1].damage
 world:add(p,p.x,p.y,si,si)
num=num+1
end
end
end




    scores = {0, 0}
           mouseY =40 --love.mouse.getY()
            mouseX =60 --love.mouse.getX()

if playerNumber then

end
end





function drawBullets()
    for _,bullet in ipairs(playersBullet[playerNumber]) do
        love.graphics.rectangle("line",bullet.x,bullet.y,bullet.w,bullet.h)
    end
end


function addBulletcol(px, py, d, s)
	local o = {
vx= 0,
vy = 0,
		x = px, -- position X
		y = py, -- position Y
     xX = px, -- position X
		yY = py, -- position Y
		r =  8, -- radius
     w =  5, -- radius
     h =  5, -- radius
		moveSpeed = s, -- movement speed
		moveDir = d, -- movement direction
		moveX =math.cos(d) * s,
		moveY =math.sin(d) * s,
    damage= 20,
    isBullet=true,

    					}
		table.insert(playersBullet[playerNumber],o)
    world:add(o,o.x,o.y,o.w,o.h)
    --addBullet(startXX,startYY,20,20)
	return o
end


		


function calc(a1,b1,a2,b2)
local c1=b1-a1
local c2=b2-a2
local len = math.sqrt(c1*c1+c2*c2)
return len
end



function updateBlob(self,dt)
					PlayerchangeVelocityByKeys(self,dt)
					Friction(self,dt)
					PlayerchangeVelocityByGravity(self,dt)
					PlayermoveColliding(self,dt)
end




function PlayerchangeVelocityByBeingOnGround(self)
 				 if self.onGround then
 							   self.vy = math.min(self.vy, 0)
 				 end
end



function PlayerchangeVelocityByGravity(self,dt)
 				 self.vy = self.vy + gravityAccel * dt
end


function PlayerchangeVelocityByCollisionNormal(self,nx, ny, bounciness)
 				 bounciness = bounciness or 0
 				 if (nx < 0 and self.vx > 0) or (nx > 0 and self.vx < 0) then
    								self.vx = -self.vx * bounciness
 				 end

  			 if (ny < 0 and self.vy > 0) or (ny > 0 and self.vy < 0) then
   									 self.vy = -self.vy * bounciness
 				 end
end



function PlayercheckIfOnGround(self,ny)
 				 if ny < 0 then self.onGround = true end
end


function Friction(self,dt)
					if self.onGround then
										if ljoy:xValue() ~= 0 and ljoy:yValue() ~= 0 then
																	self.brakeAccel    = 30
										else
																	self.brakeAccel    = 250
										end
					else
										self.brakeAccel    = 30
					end

					--local vx, vy = self.vx, self.vy
					local brake = dt * (self.vx < 0 and self.brakeAccel or -self.brakeAccel)
  			  if math.abs(brake) > math.abs(self.vx) then
      							self.vx = 0
    			else
      							self.vx = self.vx + brake
   				end
					--self.vx, self.vy = vx, vy

end



function Playerchecklen(self,len)
					if  len >= 1 then
										self.onGround=true
					else
										self.onGround=false
					end
end

Playerfilter=function(item, other)
if other. isWall ==playerNumber then return nil--"cross"
elseif other.width then return "slide"
end
end

function PlayerchangeVelocityByKeys(self,dt)
--players[playerNumber].name=username




  				self.isJumpingOrFlying = false
  				--if self.isDead then return end
					if ljoy:xValue() ~= 0 and ljoy:yValue() ~= 0 then
										--self.vx = self.vx + self.runAccel  * cos0  * dt    
										--self.vy = self.vy + self.runAccel * sin0  * dt
  									if ljoy:direction()=="l" then
											self.vx = math.max(-self.maxSpeed,self.vx-self.speed* (dt))
															--self.vx = self.vx-self.speed* dt
    													--self.vx = self.vx - math.min(self.runAccel, (2*dt) *(self.vx > 0 
															--and self.brakeAccel or self.runAccel))
  									elseif ljoy:direction()=="r" then
    													--self.vx = self.vx + (2*dt) * (self.vx < 0 and self.brakeAccel or self.runAccel)
											self.vx = math.min(self.maxSpeed,self.vx+self.speed* (dt))
										end
  									if ljoy:direction()=="t" then --and ( nil or self.onGround) then 
										-- and (self:canFly() or self.onGround) then -- jump/fly
		  													--media.sfx.jet2:stop()
      													--media.sfx.jet2:play()
     													 self.vy = -self.jumpVelocity
    														self.isJumpingOrFlying = true
     														--self.boost= self.boost-(dt*60)
  									elseif ljoy:direction()=="b" then --and ( nil or self.onGround) then 
     													 self.vy = self.jumpVelocity*(dt*20)
    														--self.isJumpingOrFlying = true
  							
  									end
  									if ljoy:direction()=="tr" then --and ( nil or self.onGround) then 
																--self.vx = self.vx + dt * (self.vx < 0 
--and self.brakeAccel or math.max(self.runAccel,(self.runAccel+self.runAccel+self.runAccel)))
    													--self.vx = self.vx + dt * (self.vx < 0 and self.brakeAccel or self.runAccel)
													self.vx = math.min(self.maxSpeed,self.vx+self.speed* (dt))
						 										self.vy = -self.jumpVelocity
    														self.isJumpingOrFlying = true
  									elseif ljoy:direction()=="tl" then --and ( nil or self.onGround) then 
																self.vx = math.max(-self.maxSpeed,self.vx-self.speed* (dt))
						 										self.vy = -self.jumpVelocity
    														self.isJumpingOrFlying = true
										
										end

					end
players[playerNumber].name=username

end



function PlayermoveColliding(self,dt)

  				local future_l = self.x + self.vx * dt
  				local future_t = self.y + self.vy * dt

  				local next_l, next_t, cols, len = world:move(self, future_l, future_t, Playerfilter)
					Playerchecklen(self,len)
  				for i=1, len do
    									local col = cols[i]
    									PlayerchangeVelocityByCollisionNormal(self,col.normal.x, col.normal.y,self.bounciness)
    									PlayercheckIfOnGround(self,col.normal.y,len)
  				end

  self.x, self.y = next_l, next_t

end





function getcenter(self)
						local var1,var2
						var1=getcenterx(self)
						var2=getcentery(self)
return var1,var2
end


function getcenterx(self)
						local var1
						var1=self.x+(self.w/2)
return var1
end


function getcentery(self)
						local var2
						var2=self.y+(self.h/2)
return var2
end





Wallfilter=function(item, other)
  if other. isPlayer==playerNumber then
    return "cross"
elseif other. isWall ==playerNumber then
    return "slide"
elseif other.width then
  --return "cross"
 return "slide"
end
  --if other. isWall ==playerNumber then
    --return "cross"
--end

end






function love.update(dt)
gooi.update(dt)
	--map:update(dt)
    client:update()
    --if client:getState() == "connected"  then
    if client:getState() == "connected" or client:getState() == "connecting" or client:getState() == "disconnected" then
        tick = tick + dt
        -- simulate the ball locally, and receive corrections from the server
    --end
    --if tick >= tickRate then
        tick = 0
        if playerNumber then
if isNightTime==true then
		nightTime=nightTime+0.02* dt
		if nightTime >= 1 then
					isNightTime=false
		end
elseif isNightTime==false then
		nightTime=nightTime-0.02* dt
		if nightTime <= 0 then
					isNightTime= true
		end
end


ll=slid:getValue() 
cam:setScale((ll+0.2)* 1.9)
sxx=cam:getScale()
ang_ljoy=math.atan2(ljoy:yValue(), ljoy:xValue() ) 
--cos0 = math.cos(ang_ljoy)
--sin0 = math.sin(ang_ljoy)

ang_rjoy=math.atan2(rjoy:yValue(), rjoy:xValue() ) 
cos = math.cos(ang_rjoy)
sin = math.sin(ang_rjoy)

updateBlob(players[playerNumber],dt)
            client:send("player", players[playerNumber])
							tx = math .floor(players[playerNumber].x- W/sxx/2 )
							ty = math .floor(players[playerNumber].y- H/sxx/2 )
camroundx= getcenterx(players[playerNumber])+math.cos(ang_rjoy )*20
camroundy= getcentery(players[playerNumber])+math.sin(ang_rjoy )*20
camroundxx=  getcenterx(players[playerNumber])+math.cos(ang_rjoy+3.14)*80
camroundyy= getcentery(players[playerNumber]) +math.sin(ang_rjoy+3.14 )*80

   					 cam:setPosition(players[playerNumber].x ,players[playerNumber].y)



function WallchangeVelocityByCollisionNormal(self,nx, ny, bounciness)
 				 bounciness = bounciness or 0
 				 if (nx < 0 and self.vx > 0) or (nx > 0 and self.vx < 0) then
    								self.vx = -self.vx * bounciness
 				 end

  			 if (ny < 0 and self.vy > 0) or (ny > 0 and self.vy < 0) then
   									 self.vy = -self.vy * bounciness
 				 end
end





function WallmoveColliding(self,dt)

  				local future_l = self.x + self.vx * dt
  				local future_t = self.y + self.vy * dt

  				local next_l, next_t, cols, len = world:move(self, future_l, future_t, Wallfilter)
  				for i=1, len do
    									local col = cols[i]
    									--WallchangeVelocityByCollisionNormal(self,col.normal.x, col.normal.y,self.bounciness)
    									--PlayercheckIfOnGround(self,col.normal.y,len)
  				end
  self.x, self.y = next_l, next_t
end





for i,o in ipairs (playersWeapon[playerNumber][1].shape) do
local si=10
local num=1
for j,p in pairs (o) do


p.x=(si* num)+(camroundxx-25)
p.y=(si* i)+(camroundyy-25)

WallmoveColliding(p,dt)
num=num+1
end
end





	players[playerNumber].cooldown = math.max(0, players[playerNumber].cooldown - dt)
--if not (lock.checked) == true and player.cooldown <= 0 and blob.canShoot and gunlen >=0.94 and blob.live > 0 then
if lock.checked == true and players[playerNumber].cooldown <= 0 then
--if player.cooldown then
local angle = ang_rjoy
players[playerNumber].cooldown = players[playerNumber].cooldownAdd
addBulletcol(camroundx,camroundy,angle,800) 
end




function BulletmoveColliding(self,dt, i)

  				local future_l = self.x + self.vx * dt
  				local future_t = self.y + self.vy * dt

  				local next_l, next_t, cols, len = world:move(self, future_l, future_t, self.filter)

  self.x, self.y = next_l, next_t



         for z=1,len do
           local coll=cols[z]
--[[
        
                     media.sfx.clank1:stop()
                     media.sfx.clank1:play()
          
]]
							if coll.other.isBlob then
         	 		 coll.other.health= math.max(0, coll.other.health-self.damage)
         		    
    	   if world:hasItem(self) then
            world:remove(self)	 
     	      table.remove(playersBullet[playerNumber], i)
      		end
            end
    					--if col.other.properties.collidable== "true" then
     					if coll.other.name == "collidable" then
    	   if world:hasItem(self) then
            world:remove(self)	 
     	      table.remove(playersBullet[playerNumber], i)
      		end
    					 end
 									
     					if coll.other.heighht then
    	   if world:hasItem(self) then
            world:remove(self)	 
     	      table.remove(playersBullet[playerNumber], i)
      		end
    					 end
					end
end







for i,o in ipairs(playersBullet[playerNumber]) do
   		o.x = o.x + o.moveX * dt
		  o.y = o.y + o.moveY * dt
BulletmoveColliding(o,dt, i)

		if calc(o.xX,o.x,o.yY,o.y) >=200  then
    	   if world:hasItem(o) then
            world:remove(o)	 
     	      table.remove(playersBullet[playerNumber], i)
      		end

    end
end
--end





        end
    end
end


function drawHealth(self, r, g,b )
local x, y, w
w=self. healthMax/4
x=(self. x +(self. w/2))-(w/2)
y=self.y-6

love.graphics.setColor(r, g,b, 0.7)
    love.graphics.rectangle('fill',x,y, self. health/4, 4)
love.graphics.setColor(1,1,1)
    love.graphics.rectangle('line',x,y, w, 4)
love.graphics.setColor(1,1,1)
end





function love.draw()
local scale = 1
screen_width =love.graphics.getWidth()
screen_height =love.graphics.getHeight()
love .graphics .setColor (1 , 1, 1)
--love.graphics.draw(bg2,0,0,0,screen_width/bg2:getWidth(),screen_height/bg2:getHeight()) 
	--love.graphics.setBackgroundColor(0, 200, 225)
	--love.graphics.setBackgroundColor(0, 0,0.3)


love.graphics.setColor(0, 200, 225)
        love.graphics.rectangle('fill',0,0,W, H)


love.graphics.setColor(0, 0,0.3,nightTime)
        love.graphics.rectangle('fill',0,0,W, H)



love.graphics.setColor(1,1,1)
love.graphics.draw(
bg,0,0,0,screen_width/bg:getWidth(),
screen_height/bg:getHeight()
) 

	love .graphics .setColor (1 , 1, 1)
	bb, cc=cam:getPosition()
	 map:draw(-tx,-ty,sxx,sxx)--tx,-ty),2,2
	
cam:draw(function()
   for i, player in pairs(players) do
    		love.graphics.printf(player.name or "unknown",player.x-40,player.y-20,100,"center")
drawHealth(player, 1, 0,1)

love.graphics.setColor(1,1,1,0.4)
        love.graphics.rectangle('fill',player.x,player.y, player.w, player.h)
love.graphics.setColor(1,1,1)
        love.graphics.rectangle('line',player.x,player.y, player.w, player.h)

    end

do
local num=1
for i,o in ipairs (playersWeapon[playerNumber][1].shape) do
for j,p in pairs (o) do
--if p ==1 then
love.graphics.rectangle("line",p.x,p.y,10,10)--o.w,o.h)
--love.graphics.print("o"..p,70,40)
--end
end
num=num+1
end
end
  -- love.graphics.rectangle('fill', ball.x, ball.y, ball.w, ball.h)
		love.graphics.circle("line",camroundx,camroundy,6)
		--love.graphics.rectangle("fill",camroundxx-(40/2),camroundyy-(40/2),40,40)
love.graphics.setColor(1,0,0)
love.graphics.line(camroundx,camroundy,getcenter(players[playerNumber]))
love.graphics.setColor(0,0,1)
love.graphics.line(camroundxx,camroundyy,getcenter(players[playerNumber]))
love.graphics.setColor(1,1,1)
		drawBullets()
    end)
love.graphics.print(ang_rjoy,30,30)
		love.graphics.print(client:getState(), 5, 5)
    
		if playerNumber then
        love.graphics.print("Player " .. playerNumber, 5, 25)
--love.graphics.print("Player " .. players[playerNumber].name, 60, 25)

    else
        love.graphics.print("No player number assigned", 5, 25)
    end





    local score = ("%d - %d"):format(scores[1], scores[2])
    love.graphics.print(score, 5, 45)

gooi.draw()
end





function love.touchpressed (id, x,y)
gooi.pressed(id, x, y) end

function love.touchreleased(id, x, y)
gooi.released(id, x, y) end

function love.touchmoved (id, x, y) 
gooi.moved(id, x, y) end





function gooi:load()
lock=gooi.newCheck({
text = "Lock" ,
x = 14 ,y = 48 ,w = 200 ,h = 40,--75,
--group = "grp1" ,
checked = true -- default = false
}):change()

ljoy = gooi.newJoy({
x=66, y=198, size = 90,})
--:setImage( "/imgs/joys.png" )
:noScaling():anyPoint()
--:noSpring() 
:setDigital()
--:direction)

rjoy = gooi.newJoy({
x=W-220,--x=332, 
y=195, size = 60})
--:setImage( "/imgs/joys.png" )
:noScaling():anyPoint():noSpring() 
--:setDigital()
--:direction()

slid = gooi.newSlider({
value = 0.9 ,x = 177 ,y = 254 ,w = 207 ,h = 27,
--group = "grp1"
})
end