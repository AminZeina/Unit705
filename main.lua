-----------------------------------------------------------------------------------------
--
-- main.lua
--
-- Created by: Amin Zeina
-- Created on: Apr 2018
--
-- Collision
-----------------------------------------------------------------------------------------

local physics = require( "physics" )

physics.start()
physics.setGravity( 0, 25 )
physics.setDrawMode( "hybrid" )

local theGround = display.newImage( "./assets/sprites/land.png" )
theGround.x = display.contentCenterX - 600
theGround.y = display.contentHeight
theGround.id = "the ground"
physics.addBody( theGround, 'static', {
    friction = 0.5, 
    bounce = 0.3 
    } )

local theGround2 = display.newImage( "./assets/sprites/land.png" )
theGround2.x = 1450
theGround2.y = display.contentHeight
theGround2.id = "the ground 2"
physics.addBody( theGround2, 'static', {
    friction = 0.5, 
    bounce = 0.3 
    } )

local leftWall = display.newRect( 0, display.contentHeight / 2, 1, display.contentHeight )
physics.addBody( leftWall, "static", { 
    friction = 0.5, 
    bounce = 0.3 
    } )

local rightWall = display.newRect( 2048, display.contentHeight / 2, 1, display.contentHeight )
physics.addBody( rightWall, "static", { 
    friction = 0.5, 
    bounce = 0.3 
    } )

local theCharacter = display.newImage( "./assets/sprites/ninjaBoy.png" )
theCharacter.x = display.contentCenterX - 800
theCharacter.y = display.contentCenterY
theCharacter.id = "the character"
physics.addBody( theCharacter, "dynamic", { 
    density = 3.0, 
    friction = 0.5, 
    bounce = 0.3 
    } )
theCharacter.isFixedRotation = true

local ninjaGirl = display.newImage( "./assets/sprites/ninjaGirl.png" )
ninjaGirl.x = display.contentCenterX + 500
ninjaGirl.y = display.contentCenterY
ninjaGirl.id = "ninja girl character"
physics.addBody( ninjaGirl, "dynamic", { 
    density = 3.0, 
    friction = 0.5, 
    bounce = 0.3 
    } )
ninjaGirl.isFixedRotation = true
ninjaGirl.xScale = -1

local dPad = display.newImage( "./assets/sprites/d-pad.png" )
dPad.x = 150
dPad.y = display.contentHeight - 150
dPad.id = "d-pad"
dPad.alpha = 0.50

local upArrow = display.newImage( "./assets/sprites/upArrow.png" )
upArrow.x = 150
upArrow.y = display.contentHeight - 260
upArrow.id = "up arrow"

local downArrow = display.newImage( "./assets/sprites/downArrow.png" )
downArrow.x = 150
downArrow.y = display.contentHeight - 40
downArrow.id = "down arrow"

local rightArrow = display.newImage( "./assets/sprites/rightArrow.png" )
rightArrow.x = 260
rightArrow.y = display.contentHeight - 150
rightArrow.id = "right arrow"

local leftArrow = display.newImage( "./assets/sprites/leftArrow.png" )
leftArrow.x = 40
leftArrow.y = display.contentHeight - 150
leftArrow.id = "left arrow"

local jumpButton = display.newImage( "./assets/sprites/jumpButton.png" )
jumpButton.x = display.contentWidth - 80
jumpButton.y = display.contentHeight - 80
jumpButton.id = "jump button"
jumpButton.alpha = 0.5

local function characterCollision( self, event )
    -- print what the chararcter collided with
    if ( event.phase == "began" ) then
        print( self.id .. ": collision began with " .. event.other.id )
 
    elseif ( event.phase == "ended" ) then
        print( self.id .. ": collision ended with " .. event.other.id )
    end
end

function upArrow:touch( event )
    if ( event.phase == "ended" ) then
        -- moves character up
        transition.moveBy( theCharacter, { 
            x = 0, -- move 0 pixels horizontally
            y = -50, -- move 50 pixels up
            time = 100 -- move in 100 milliseconds
            } )
    end

    return true
end

function downArrow:touch( event )
    if ( event.phase == "ended" ) then
        -- moves character down
        transition.moveBy( theCharacter, { 
            x = 0, -- move 0 pixels horizontally
            y = 50, -- move 50 pixels down
            time = 100 -- move in 100 milliseconds
            } )
    end

    return true
end

function rightArrow:touch( event )
    if ( event.phase == "ended" ) then
        -- Turns Character
        theCharacter.xScale = 1
        -- moves character right
        transition.moveBy( theCharacter, { 
            x = 50, -- move 50 pixels right
            y = 0, -- move 0 pixels vertically
            time = 100 -- move in 100 milliseconds
            } )
    end

    return true
end

function leftArrow:touch( event )
    if ( event.phase == "ended" ) then
        -- Turns Character
        theCharacter.xScale = -1
        -- moves character left
        transition.moveBy( theCharacter, { 
            x = - 50, -- move 50 pixels left
            y = 0, -- move 0 pixels vertically
            time = 100 -- move in 100 milliseconds
            } )
    end

    return true
end

function jumpButton:touch( event )
    if ( event.phase == "ended" ) then
        -- makes character jump
        theCharacter:setLinearVelocity( 0, -750 )
    end

    return true
end


function checkCharacterPosition( event )
    -- respawn character if it falls off the map
    if theCharacter.y > display.contentHeight + 500 then
        theCharacter.x = display.contentCenterX - 200
        theCharacter.y = display.contentCenterY
    end
end

upArrow:addEventListener( "touch", upArrow )
downArrow:addEventListener( "touch", downArrow )
rightArrow:addEventListener( "touch", rightArrow )
leftArrow:addEventListener( "touch", leftArrow )
jumpButton:addEventListener( "touch", jumpButton)
Runtime:addEventListener( "enterFrame", checkCharacterPosition )
theCharacter.collision = characterCollision
theCharacter:addEventListener( 'collision')