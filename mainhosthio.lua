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
require "gooi.checkbox"
local sti = require "sti.sti"
bump=require"bump.bump"
sock = require "sock.sock"
bitser = require "sock.spec.bitser"
-- Utility functions

local playerX,playerY,tx,ty=0,0,0,0
function love.load()
point1=0
point2=0

gravityAccel = 200
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


username="ADMIN *<|:-)"
W, H = love.graphics.getWidth(),
love.graphics.getHeight()


playerNumber=1
gooi.load()
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


   -- receive info on where a player is located
    server:on("wall", function(y, client)
        local index = client:getIndex()+1
        playersWeapon[index][1] = y
    end)


    server:on("mybulletAdd", function(y, client)
        local index = client:getIndex()+1
        addBulletcol(y.px, y.py, y.d, y.s, y.id)
 --server:sendToAll("playerState", {i, player})
    end)



--[[
    server:on("mybulletMove", function(y, client)
        local index = client:getIndex()+1
        --playersBullet[y.id][y.i]. x=y.x
        --playersBullet[y.id][y.i].y=y.y
 --server:sendToAll("playerState", {i, player})


for j,o in ipairs (playersBullet[y.id]) do
    	  --if world:hasItem(playersBullet[y.id][y.i]) then
    	   if world:hasItem(o) then

  				--local next_l, next_t, cols, len = world:move(playersBullet[y.id][y. i], y.x, y.y, self.filter)
  				local next_l, next_t, cols, len = world:move(o, y.x, y.y)--, self.filter)

    o. x=next_l
        o.y=next_t
]]

     --playersBullet[y.id][y.i]. x=next_l
        --playersBullet[y.id][y.i].y=next_t
      --playersBullet[y.id][y.i]. x=y.x
        --playersBullet[y.id][y.i].y=y.y

--end
--end
  --self.x, self.y = next_l, next_t


--[[
         for z=1,len do
           local coll=cols[z]

        
                     media.sfx.clank1:stop()
                     media.sfx.clank1:play()
          
]]




--[[
    server:on("mybulletRemove", function(z, client)
for k,p in ipairs (playersBullet[z.id]) do
        local index = client:getIndex()+1]]



    	   --[[if world:hasItem(playersBullet[z.id][z.i]) then
            world:remove(playersBullet[z.id][z.i])	 
     	      table.remove(playersBullet[z.id], z.i)
					end]]
					
					
				
					
			
--[[
if world:hasItem(o) then
            world:remove(o)	 
     	      table.remove(playersBullet[z.id],k)
					end
end
    end)
--]]




  --self.x, self.y = next_l, next_t


						--[[	if coll.other.isBlob then
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
					end]]





    --end)


    --[[
    server:on("mouseX", function(x, client)
        local index = client:getIndex()+1
        players[index].x = x
    end)]]
    function newPlayer(x, y)
        local o={
            
x = x,
y = y,
w = 12,
h = 25,
vx= 0,
vy = 0,
name="unknown!", 
live=3,
isDead=false, 
deadCounter = 0,
isBlob= true,
canShoot=true,
onGround=false,
kills=0, 
deadDuration  = 3,   -- seconds until res-pawn
runAccel      = 50, -- the player acceleration while going left/right
brakeAccel    = 50,--100,
speed = 120, -- Acceleration speed of player
maxSpeed = 100,
jumpVelocity  = 100,
bounciness = -0,
cooldown = 0, cooldownAdd =0.05,-- 0.35,--0.40,
health = 100, healthMax = 100, healthRegen = 15, hit = false, 
boost = 100, boostMax = 100, boostRegen = 15,

        }
    world:add(o,o.x,o.y,o.w,o.h)
return o
end

    players = {
        newPlayer(marginX, love.graphics.getHeight()/2),
        newPlayer(love.graphics.getWidth() - marginX, love.graphics.getHeight()/2),
   				newPlayer(76,76) , 
newPlayer(176,76) 
   }

function addWall(x, y, d, size)
o={
damage=10,
health=200,
healthMax=200,
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
{addWall()},--(x, y, d, size)},
{addWall()}
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


--


    scores = {0, 0}
    --ball = newBall(love.graphics.getWidth()/2, love.graphics.getHeight()/2)
    
    
   players[playerNumber].name=username
   players[playerNumber].isPlayer=playerNumber
   players[playerNumber].live=99999
   players[playerNumber].points=0--1000


   players[3].kills=6

playersBullet={
{},
{},
{},
{},
}



spawnPoint  ={{x=795,y=-20}, {x=535,y=10}, {x=295,y=-10}, {x=70,y=10}
--, return, return, return
}

gameTime={max=20,timeup=false, counter=0,counterReal=2}
done_once = false
startMatch=false	
showLobbyMenu=true 
Drawscorescreen=false

scoreBoard ={{kills=0}, {kills=9}, {kills=7}, {kills=3}}
scoreBoard2=scoreBoard

for i=1,#scoreBoard do
scoreBoard[i].name =players[i].name 
scoreBoard[i].id=i
end




end





function drawLobbyMenu(c)
if showLobbyMenu then
--[[{}
cam2:draw(function()
love.graphics.setColor(1,1,1)
   drawPalette()
love.graphics.setColor( meColorR, meColorG,  meColorB) 
love.graphics.rectangle ("fill", paletteX+paletteWidth+150 , 10, 100, 100)
love.graphics.setColor(bordercolor)
love.graphics.rectangle ("line", paletteX+paletteWidth+150 , 10, 100, 100)

love.graphics.setColor(bordercolor) 
love.graphics.rectangle("line", paletteX, paletteY , paletteWidth, paletteHeight )

love.graphics.circle("line", c_x, c_y, 20)

end)
]]
gooi. draw ("grp2" )
--getGrid(W,H,9,26)
end
gooi.setGroupVisible("grp2",showLobbyMenu)
gooi.setGroupEnabled("grp2",showLobbyMenu)

end






function drawBullets()
for i=1,#playersBullet do
    for _,bullet in ipairs(playersBullet[i]) do
        love.graphics.rectangle("line",bullet.x,bullet.y,bullet.w,bullet.h)
    end
end
end






function addBulletcol(px, py, d, s, id)
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
		table.insert(playersBullet[id],o)
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

--[[
player.checkKeys(dt) --Check all the keys and apply velocity accordingly
player.applyFriction(dt) --Apply friction to the player velocity. ||This code uses a fancy trick, ask me if you want it explained||
player.limitSpeed() --Limits the player speed. ||This code is also quite tricky, again, ask if you want it explained||
player.move(dt) --Apply velocity to the player position
]]


function updateBlob(self,dt)
Updatedeathscreen(self)

					PlayerupdateHealth(self, dt)
					PlayerchangeVelocityByKeys(self,dt)
					Friction(self,dt)
					--applyFriction(self,dt)
					PlayerchangeVelocityByGravity(self,dt)
					PlayermoveColliding(self,dt)
					--PlayerchangeVelocityByBeingOnGround(self) --this somehow makes you stik to walls
end



function updateOtherBlobs(self,dt)
					Updatedeathscreen(self)
					PlayerupdateHealth(self, dt)
					--PlayerchangeVelocityByKeys(self,dt)
					Friction(self,dt)
					--applyFriction(self,dt)
					PlayerchangeVelocityByGravity(self,dt)
					PlayermoveColliding(self,dt)
					--PlayerchangeVelocityByBeingOnGround(self) --this somehow makes you stik to walls
end




function PlayerchangeVelocityByBeingOnGround(self)
 				 if self.onGround then
 							   self.vy =math.min(self.vy, 0)
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



function PlayercheckIfOnGround(self,ny,len)
					if ny < 0 then self.onGround = true 
  else self.onGround = false end
					if  len >= 1 then
										self.onGround=true
					else
										self.onGround=false
					end
end


function Playerchecklen(self,len)
					if  len >= 1 then
										self.onGround=true

					else
										self.onGround=false
					end
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



function applyFriction(self,dt)
if self.vx > 0 then
self.vx = math.max(self.vx-self.brakeAccel*dt, 0) --Round to everything above 0, or 0 itself
elseif self.vx < 0 then
self.vx = math.min(self.vx+self.brakeAccel*dt, 0) --Round to everything below 0, or 0 itself
end
--[[
if self.vy > 0 then
self.vy = math.max(self.vy-self.brakeAccel*dt, 0) --Round to everything above 0, or 0 itself
elseif self.vy < 0 then
self.vy = math.min(self.vy+self.brakeAccel*dt, 0) --Round to everything below 0, or 0 itself
end]]
end


function PlayerchangeVelocityByKeys(self,dt)
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
     													 --self.vy = math.min(self.vy,self.jumpVelocity+20)
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
																--self.vx = math.max(-self.maxSpeed,self.vx-self.speed* (dt))
						 										self.vy = -self.jumpVelocity
    														self.isJumpingOrFlying = true
										
										end

					end
players[playerNumber].name=username
end


Playerfilter=function(item, other)
if other. isWall ==playerNumber then return nil--"cross"
elseif other.width then return "slide"
elseif other.isBlob and other.isDead then return nil
elseif other.isBlob then return "slide"
end
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
    server:update(dt)
            local playerX = players[playerNumber].x
            local playerY = players[playerNumber].y

    -- wait until 2 players connect to start playing
    local enoughPlayers = #server.clients >= 0
   -- if not enoughPlayers then return end

--[[
    tick = tick + dt
    if tick >= tickRate then
        tick = 0
        for i, player in pairs(players) do
            --server:sendToAll("playerState", {i, player})
        end
        --server:sendToAll("ballState", ball)
    end]]
        for i, player in pairs(players) do
            server:sendToAll("playerState", {i, player})
        end

        for i, wall in pairs(playersWeapon) do
           -- server:sendToAll("wallState", {i, wall})
            --server:sendToAll("wallState", {i, playersWeapon[i][1]})
            server:sendToAll("wallState", {i,wall[1]})

        end

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

if startMatch==false then
gameTime.max=slidTime:getValue()*480
end





--cam:setPosition(players[playerNumber].x,players[playerNumber].y)
ang_ljoy=math.atan2(ljoy:yValue(), ljoy:xValue() ) 
--cos0 = math.cos(ang_ljoy)
--sin0 = math.sin(ang_ljoy)

ang_rjoy=math.atan2(rjoy:yValue(), rjoy:xValue() ) 
cos = math.cos(ang_rjoy)
sin = math.sin(ang_rjoy)

            --mouseY =40 --love.mouse.getY()
            --mouseX =60 --love.mouse.getX()
--[[
if ljoy:xValue() ~= 0 and ljoy:yValue() ~= 0 then
players[playerNumber].x = players[playerNumber].x + 200 * cos0  * dt
players[playerNumber].y= players[playerNumber].y+ 200 * sin0  * dt
end
]]
            --[[local playerY = mouseY - players[playerNumber].h/2
            local playerX = mouseX - players[playerNumber].w/2
            -- Update our own player position and send it to the server
            players[playerNumber].y =mouseY-- playerY
            players[playerNumber].x =mouseX-- playerX
            --client:send("mouseY", playerY)
            --client:send("mouseX", playerX)
   					 --cam:setPosition(playerX,playerY)]]

--local screeen_width =love.graphics.getWidth()/ sxx
--local screeen_height =love.graphics.getHeight()/ sxx
--tx = (players[playerNumber].x - screeen_width /2 )
--ty = (players[playerNumber].y -screeen_height /2 )
							--tx = math .floor(players[playerNumber].x- W/sxx/2 )
							--ty = math .floor(players[playerNumber].y- H/sxx/2 )


updateBlob(players[playerNumber],dt)


for h=1,#players do
if h ~= playerNumber then
updateOtherBlobs(players[h],dt)
end
end
   					 --playerX ,playerY
							--tx = math .floor(players[playerNumber].x- W/sxx/2 )
							--ty = math .floor(players[playerNumber].y- H/sxx/2 )

							tx = (players[playerNumber].x)- W/sxx/2 
							ty = (players[playerNumber].y)- H/sxx/2 


function clickButton(mx,my,btn)
if mx >= btn.x and mx < btn.x + btn. w
and my >= btn.y and my < btn.y + btn.h then
-- stuff to do when your image has been clicked
return true end
end

function circle_collid(c1, c2)
    return (c2.x - c1.x)^2 + (c2.y- c1.y)^2 < (c1.r + c2.r)^2
    -- return distance^2 <= (radius1 + radius2)^2
end


camroundx= getcenterx(players[playerNumber])+math.cos(ang_rjoy )*23
camroundy= getcentery(players[playerNumber])+math.sin(ang_rjoy )*23
camroundxx=  getcenterx(players[playerNumber])+math.cos(ang_rjoy+3.14)*50
camroundyy= getcentery(players[playerNumber]) +math.sin(ang_rjoy+3.14 )*50

--if clickButton(point1,point2,{x=players[playerNumber].x ,y=players[playerNumber].y,w=100,h=100}) then
--if calc(point1,getcenterx(players[playerNumber]),
--point2,getcentery(players[playerNumber])) <= 24 then

--[[
if circle_collid({x=point1,y=point2,r=1 },{x=getcenterx(players[playerNumber]), y=getcentery(players[playerNumber]), r=28}) then
ang_r=math.atan2(camroundy-(point2),camroundx-(point1))
point1=point1+math.cos(ang_r )*dt*38
point2=point2+math.sin(ang_r )*dt*38
else
point1,point2=camroundx, camroundy
end
]]

--point1=point1+18
--point2=point2+18

							--tx = (point1)- W/sxx/2 
							--ty = (point2)- H/sxx/2 



cam:setPosition(players[playerNumber].x ,players[playerNumber].y)
--cam:setPosition(point1 ,point2)

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





for i,o in ipairs (playersWeapon[1][1].shape) do
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
local angle = ang_rjoy
players[playerNumber].cooldown = players[playerNumber].cooldownAdd
addBulletcol(camroundx,camroundy,angle+love.math.random (-3,3)*0.1,500,playerNumber) 

end


function Bulletfilter()
return "cross"
end

function BulletmoveColliding(self,dt, i, h)

  				local future_l = self.x + self.vx * dt
  				local future_t = self.y + self.vy * dt

  				local next_l, next_t, cols, len = world:move(self, future_l, future_t, Bulletfilter)

  self.x, self.y = next_l, next_t



         for z=1,len do
           local coll=cols[z]
--[[
        
                     media.sfx.clank1:stop()
                     media.sfx.clank1:play()
          
]]
							if coll.other.isBlob and coll.other.isDead==false then
         	 					 coll.other.health= math.max(0, coll.other.health-self.damage)
         		    			if coll.other.health <= 0 then
         		    			if coll.other.isDead==false or nil then
												--if not done_once then
--done_once = true
															players[h].points=players[h].points+1000
--for i, o in ipairs (scoreBoard) do
for j=1,#scoreBoard do
															if scoreBoard[j].id==h then
															scoreBoard[j].kills=scoreBoard[j].kills+1
															players[h].kills=scoreBoard[j].kills
															scoreBoard[j].name=players[h].name
															
											end end end end
    	   							if world:hasItem(self) then
            									world:remove(self)	 
     	      									table.remove(playersBullet[h], i)
      								end
            end
    					--if col.other.properties.collidable== "true" then
     					if coll.other.name == "collidable" then
    	   if world:hasItem(self) then
            world:remove(self)	 
     	      table.remove(playersBullet[h], i)
      		end
    					 end
 									
     					if coll.other.heighht then
    	   if world:hasItem(self) then
            world:remove(self)	 
     	      table.remove(playersBullet[h], i)
      		end
    					 end
					end


		if calc(self.xX,self.x,self.yY,self.y) >=200  then
    	   if world:hasItem(self) then
            world:remove(self)	 
     	      table.remove(playersBullet[h], i)
      		end

    end

end



for h=1,#playersBullet do

for i,o in ipairs(playersBullet[h]) do
   		o.x = o.x + o.moveX * dt
		  o.y = o.y + o.moveY * dt
if world:hasItem(o) then
BulletmoveColliding(o,dt, i, h)
end


end
end


--Updatedeathscreen(players[playerNumber])
if startMatch then
showLobbyMenu=false
Gametime(gameTime, dt)
--gameTime.timeup=false

end


if gameTime.timeup then
--
if not done_once then
done_once = true
startMatch=false
if players[playerNumber].isDead==false then showLobbyMenu=true  end

for i, o in ipairs (players) do
o.health=0
end end

end



end









function getGrid(x,y,p1,p2)
local sx,sy,xx,yy
sx=30
sy=sx

xx=x/sx
yy=y/sy
for i=1,sx do
for j=1,sy do
--drawGrid(i*xx-(xx),j*yy -(yy) ,xx,yy )
end
end
pos1=p1*xx
pos2=p2*yy
return pos1,pos2
end


function PlayerupdateHealth(self,dt)
  self.achievedFullHealth = false
  if self.isDead then
       self.deadCounter = self.deadCounter + dt
    if self.deadCounter >= self. deadDuration then
      self.live= self.live-1
      Playerrespawn(self)
    end
  elseif self.health < 200 then
    self.health = math.min(self.healthMax, self.health + (dt*self.healthRegen))
    self.achievedFullHealth = self.health == 200
  end
end


function Playerrespawn(self)
--done_once = false--true
local rspX,rspY=self.spawn1x,self.spawn1y--3000,150--250,150
self.isDead = false
self.canShoot=true

self.health = self.healthMax
self.boost = self.boostMax
self.deadCounter = 0
local spwn=love . math.random (4)
self.x,self.y=spawnPoint[spwn]. x,  spawnPoint[spwn].y
--world: update (self,0,0)
end



function Playerdie(self)
  self.canShoot=false
  self.isDead = true
  self.health = 0
  self.screem=true
  --world:remove(self)
  --self.world:add(self, self.l, self.t, self.w, self.h)

end


function Updatedeathscreen(self)
if self.health <= 0 then
if self.deadCounter >= 0.7 then
self.screem=false
--media.sfx.die9:stop()
end
if self.screem then
    --media.sfx.die9:stop()
   --media.sfx.die9:play()
end
Playerdie(self)
end
end


function Gametime(self, dt)
if self. max <=0 then

self. timeup=true
self. counter=0
done_once = false--true
else self. timeup=false
end

if self. timeup==false then
--self. counter=self. max-dt--self. counter +dt
self. max=self. max-dt
self. counterReal=self. max--self. counter--self. max-self. counter
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



function Drawdeathscreen()
love .graphics .setColor (0 , 0, 0,0.4)
local a= love.graphics.getWidth()/6
local b=14
  love.graphics.rectangle("fill",a,b, love.graphics.getWidth()-(a*2) ,300)
 --love .graphics .setColor (1 , 0, 0)
love.graphics.setLineWidth(5)
  love.graphics.rectangle("line",a,b, love.graphics.getWidth()-(a*2) ,300)
love .graphics .setColor (0 , 0, 0)
love.graphics.setLineWidth(1)
--love.graphics.draw (btn15.image ,btn15.x,btn15.y,0,btn15.sx,btn15.sy)
love .graphics .setColor (1 ,1, 1)

function sort(a,b)
--if b and a then
return a.kills > b.kills -- sorts it by high score
--end
end



--for i,p in ipairs(scoreBoard) do
for i=#scoreBoard,1,-1 do
local p=scoreBoard[i]
--table.insert(scoreBoard, i, players[i].kills)
table.sort(scoreBoard,sort)
--love.graphics.printf(" \n KILLCOUNT:  "..#Enemykill.."\n RESPAWNING IN: "..math.floor(deadDuration-blob.deadCounter),0,18,500,"center")
love.graphics.print(p.name.. "       " ..p.kills, a*1.2, 25+(i* 15))
end


end



function drawblobStats(self)

local W, H = love.graphics.getWidth(),
love.graphics.getHeight()

--health
 love .graphics .setColor (0 , 0, 0)
  local a= love.graphics.getWidth()/9
   local b=14
  love.graphics.rectangle("fill",a*2,b,self.healthMax*2,10)
 love .graphics .setColor ( 1, 0,1,0.4)
  love.graphics.rectangle("fill",a*2,b,self.health*2,10)
love .graphics .setColor (0 , 0, 0)
--love.graphics.setLineWidth(2)
love.graphics.rectangle("line",a*2,b,self.healthMax*2,10)
  


--boost
 local c=30
 love .graphics .setColor (0 , 0, 0)
love.graphics.rectangle("fill",a*2,c,self.boostMax*2,10)
 love .graphics .setColor (0, 0, 0.7)
  love.graphics.rectangle("fill",a*2,c,self.boost*2,10)
love .graphics .setColor (0 , 0, 0)
--love.graphics.setLineWidth(2)
love.graphics.rectangle("line",a*2,c,self.boostMax*2,10)
  love .graphics .setColor (1 , 0.2, 0.3)


love.graphics.push()
love.graphics.scale(1.0)
love.graphics.printf( math.floor(gameTime.max), 0,18,W,"center")

love.graphics.printf( 
--"FPS: "   ..love.timer.getFPS()..   "\n\nLIVES: "   ..blob.live..   "\nKILLCOUNT:  "   ..#Enemykill..   "\nROUND:  "   ..counter.stage..   "\nENEMIES LEFT: "   ..#enemies,
"FPS: "   ..love.timer.getFPS()..   "\n\nLIVES: "   ..self.live..   "\nPOINTS: "   ..self.points..   "\nKILLS: "   ..self.kills,

W/2+W/4,18,W,"left")
love.graphics.pop()
   love .graphics .setColor (1 , 1, 1)

if  self.isDead or Drawscorescreen then-- or not self.isDead then
Drawdeathscreen(self)
end
--Drawdeathscreen(self)
if self.live<=0 then
DrawRetryscreen(self)
end

if pausing then
Pausescreen(self)
end 

end





function love.draw()
            local playerX = players[playerNumber].x
            local playerY = players[playerNumber].y

--local scale = 1
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
love.graphics.draw(bg,0,0,0,screen_width/bg:getWidth(),
screen_height/bg:getHeight()) 
	love .graphics .setColor (1 , 1, 1)
	 map:draw(-tx,-ty,sxx,sxx)--tx,-ty),2,2
	



cam:draw(function()

    for i, player in pairs(players) do

if player.isDead ~= true then
    		love.graphics.printf(player.name or "unknown",player.x-40,player.y-20,100,"center")
drawHealth(player, 1, 0,1)


love.graphics.setColor(1,1,1,0.4)
        love.graphics.rectangle('fill',player.x,player.y, player.w, player.h)
love.graphics.setColor(1,1,1)
        love.graphics.rectangle('line',player.x,player.y, player.w, player.h)
end
    end

do
local num=1

for h= 1,#playersWeapon do
for i,o in ipairs (playersWeapon[h][1].shape) do
for j,p in pairs (o) do
--if p ==1 then

if players[h].isDead ~= true then 
if p.y then
love.graphics.rectangle("line",p.x,p.y,10,10)--o.w,o.h)
end
end
--love.graphics.print("o"..p,70,40)
--end
end
num=num+1
end
end

end



if players[playerNumber].isDead ~= true then
		love.graphics.circle("line",camroundx,camroundy,6)
		--love.graphics.rectangle("line",camroundxx-(40/2),camroundyy-(40/2),40,40)
		love.graphics.setColor(1,0,0)
love.graphics.line(camroundx,camroundy,getcenter(players[playerNumber]))
love.graphics.setColor(0,0,1)
love.graphics.line(camroundxx,camroundyy,getcenter(players[playerNumber]))
love.graphics.setColor(1,1,1)
		drawBullets()

love.graphics.rectangle("line", point1,point2,3,3)
love.graphics.rectangle("line",players[playerNumber].x-18,players[playerNumber].y-12,50,30)
end

    end)


    local score = ("%d - %d"):format(scores[1], scores[2])

    love.graphics.print(
--score
nightTime, 5, 5)
    love.graphics.print("playe   r.  "..ljoy:direction(),10,30)
love.graphics.print("isDead".. tostring(players[playerNumber].isDead),10,20)


love.graphics.print("gameTime. timeup: "   ..tostring(gameTime. timeup),0,10)

do
local num=1

for i,o in pairs (playersWeapon[1][1].shape[1].a) do
love.graphics.print("weapon:  "..tostring(o),100,40+(10* num))
num=num+1
end
end
--love.graphics.print(tostring(num),2,2)
love.graphics.print(tostring(kim),70,30)
love.graphics.print(tostring("   vx : "..players[playerNumber].vx),80,30)
love.graphics.print("   vy :"..tostring(players[playerNumber].vy),80,40)



--Drawdeathscreen() 
drawblobStats(players[playerNumber])



gooi.draw()
drawLobbyMenu(showLobbyMenu)
end




function love.touchpressed (id, x,
 y) gooi.pressed(id, x, y) end

function love.touchreleased(id, x, y) gooi.
released(id, x, y) end

function love.touchmoved (
id, x, y) gooi.moved(id, x, y)
end




function gooi.load()
slidTime = gooi.newSlider({
value = 0.9 ,x = 210 ,y = 254 ,w = 257 ,h = 15,
group = "grp2"
})


buttonStart=gooi.newButton({
x=W-75,
y=7 ,
text="start",
w=60,
h=40,
sx=0.25,
sy=0.25,
--icon="paintTool.png"
group = "grp2"
}): onRelease(function() startMatch=true--;gameTime. timeup=false 
for i, o in ipairs (players) do
o.health=0
end
end)
--buttonBrush .x, buttonBrush.y=getGrid(W,H,0,8)




slid = gooi.newSlider({
value = 0.9 ,x = 237 ,y = 284 ,w = 227 ,h = 27,
--group = "grp1"
})

lock=gooi.newCheck({
text = "Lock" ,x = 14 ,y = 48 ,w = 200 ,h = 40,--75,
--group = "grp1" ,
checked = true -- default = false
}):change()

control1()
end


function control1()
ljoy = gooi.newJoy({
x=76, y=208, size = 80,})
--:setImage( "/imgs/joys.png" )
:noScaling():anyPoint()
--:noSpring() 
:setDigital()
--:direction)

rjoy = gooi.newJoy({
x=W-220,y=195, size = 60})
--:setImage( "/imgs/joys.png" )
:noScaling():anyPoint():noSpring() 
--:setDigital()
--:direction()
end



function control2()
ljoy = gooi.newJoy({
x=290, y=130, size = 50,})
--:setImage( "/imgs/joys.png" )
:noScaling():anyPoint()
--:noSpring() 
:setDigital()
--:direction()

rjoy = gooi.newJoy({x=W-180, y=194, size = 90})
--:setImage( "/imgs/joys.png" )
:noScaling()
:anyPoint()
:noSpring() 
--:setDigital()
--:direction()
end
