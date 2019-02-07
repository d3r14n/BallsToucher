function getImageScaleForNewDimensions(image, newWidth, newHeight)
    local currentWidth, currentHeight = image:getDimensions()
    return (newWidth / currentWidth), (newHeight / currentHeight)
end

function gameRestart()
	beachBall = {}
	bowlingBall = {}
	basketBall = {}
	soccerBall = {}
	volleyBall = {}
	baseBall = {}
	golfBall = {}
	gameOver = false
	secondsPerBall = 2
	secondsWithoutBall = secondsPerBall - 1
	seconds = 0
	minutes = 0
	fails = 0
	maxFails = 3
end

function love.load()
	--[[-MODULOS-]]
	require "Ball"
	require "Button"

	gameRestart()

	--[[-RESOLUCIONES DEBUG-]]
	--love.window.setMode(412, 732, {vsync=false}) --Nexus 6
	--love.window.setMode(320, 533, {vsync=false}) --Nokia Lumia
	--love.window.setMode(360, 640, {vsync=false}) --Galaxy S5
	love.window.setMode(320, 568, {vsync=false}) --iPhone 5
	--love.window.setMode(375, 667, {vsync=false}) --iPhone 8
	--love.window.setMode(414, 736, {vsync=false}) --iPhone 8 Plus
	--love.window.setMode(375, 812, {vsync=false}) --iPhone X
	--love.window.setMode(768, 1024, {vsync=false}) --iPad

	--[[-VISTA-]]
	view = 0
	--[[
		0.- Main Menu
		1.- Game
		2.- Pause Menu
	--]]

	--[[-SPRITES-]]
	failSprite = love.graphics.newImage("sprites/fail.png")

	playButtonSprite = love.graphics.newImage("sprites/button_play.png")
	instructiveButtonSprite = love.graphics.newImage("sprites/button_play.png")
	shopButtonSprite = love.graphics.newImage("sprites/button_play.png")
	pauseButtonSprite = love.graphics.newImage("sprites/button_play.png")
	backButtonSprite = love.graphics.newImage("sprites/button_play.png")

	beachBallSprite = love.graphics.newImage("sprites/beach_ball.png")
	bowlingBallSprite = love.graphics.newImage("sprites/bowling_ball.png")
	soccerBallSprite = love.graphics.newImage("sprites/soccer_ball.png")
	basketBallSprite = love.graphics.newImage("sprites/basket_ball.png")
	volleyBallSprite = love.graphics.newImage("sprites/volley_ball.png")
	baseBallSprite = love.graphics.newImage("sprites/base_ball.png")
	golfBallSprite = love.graphics.newImage("sprites/golf_ball.png")

	--[[-FUENTE-]]
	font = love.graphics.newFont(44)

	--[[-BOTONES-]]
	button = {}
	button['play'] = Button:new()
	button['instructive'] = Button:new()
	button['shop'] = Button:new()
	button['pause'] = Button:new()
	button['back'] = Button:new()

	button['play']:create(playButtonSprite, 0, 0, 200, 150)
	button['instructive']:create(instructiveButtonSprite, 0, 0, 200, 150)
	button['shop']:create(shopButtonSprite, 0, 0, 200, 150)
	button['pause']:create(pauseButtonSprite, 0, 0, 200, 150)
	button['back']:create(backButton, 0, 0, 200, 150)

	--[[-OBJETOS-]]
	beachBallSize = 100
	beachBallEnergy = 0.86

	bowlingBallSize = 88
	bowlingBallEnergy = 0.25

	basketBallSize = 82
	basketBallEnergy = 0.85

	soccerBallSize = 80
	soccerBallEnergy = 0.75

	volleyBallSize = 78
	volleyBallEnergy = 0.8

	baseBallSize = 50
	baseBallEnergy = 0.72

	golfBallSize = 30
	golfBallEnergy = 0.69

	--[[-FUERZA-]]
	force = 0.15

	--[[-BACKGROUND-]]
	bgColorR = 55
	bgColorG = 90
	bgColorB = 165
end

function love.update(dt)
	--[[-ACTUALIZAR TIEMPO-]]
	if not gameOver and view == 1 then
		seconds = seconds + dt
		if seconds >= 60 then
			minutes = minutes + 1
			seconds = 0
		end
		secondsWithoutBall = secondsWithoutBall + dt
	end

	--[[-ACTUALIZAR TAMAÑO DE PANTALLA, ESCALA Y FUENTE-]]
	windowWidth, windowHeight = love.graphics.getDimensions()
	scaleX = windowWidth/700
	scaleY = windowHeight/1020

	--[[-ESCALAR SPRITES-]]
	failSpriteScaleX, failSpriteScaleY = getImageScaleForNewDimensions(failSprite, scaleX*50, scaleY*50)

	playButtonScaleX, playButtonScaleY = getImageScaleForNewDimensions(playButtonSprite, scaleX*button['play'].width, scaleY*button['play'].height)
	instructiveButtonScaleX, instructiveButtonScaleY = getImageScaleForNewDimensions(instructiveButtonSprite, scaleX*button['instructive'].width, scaleY*button['instructive'].height)
	shopButtonScaleX, shopButtonScaleY = getImageScaleForNewDimensions(shopButtonSprite, scaleX*button['shop'].width, scaleY*button['shop'].height)
	pauseButtonScaleX, pauseButtonScaleY = getImageScaleForNewDimensions(pauseButtonSprite, scaleX*button['pause'].width, scaleY*button['pause'].height)
	backButtonScaleX, backButtonScaleY = getImageScaleForNewDimensions(backButtonSprite, scaleX*button['back'].width, scaleY*button['back'].height)

	beachBallScaleX, beachBallScaleY = getImageScaleForNewDimensions(beachBallSprite, scaleX*beachBallSize, scaleY*beachBallSize)
	bowlingBallScaleX, bowlingBallScaleY = getImageScaleForNewDimensions(bowlingBallSprite, scaleX*bowlingBallSize, scaleY*bowlingBallSize)
	basketBallScaleX, basketBallScaleY = getImageScaleForNewDimensions(basketBallSprite, scaleX*basketBallSize, scaleY*basketBallSize)
	soccerBallScaleX, soccerBallScaleY = getImageScaleForNewDimensions(soccerBallSprite, scaleX*soccerBallSize, scaleY*soccerBallSize)
	volleyBallScaleX, volleyBallScaleY = getImageScaleForNewDimensions(volleyBallSprite, scaleX*volleyBallSize, scaleY*volleyBallSize)
	baseBallScaleX, baseBallScaleY = getImageScaleForNewDimensions(baseBallSprite, scaleX*baseBallSize, scaleY*baseBallSize)
	golfBallScaleX, golfBallScaleY = getImageScaleForNewDimensions(golfBallSprite, scaleX*golfBallSize, scaleY*golfBallSize)

	--[[-ESCALAR VELOCIDADES-]]
	beachBallSpeedX = scaleX*2
	beachBallSpeedY = scaleY*0.5
	bowlingBallSpeedX = scaleX*0.4
	bowlingBallSpeedY = scaleY*2
	basketBallSpeedX = scaleX*0.9
	basketBallSpeedY = scaleY*1.2
	soccerBallSpeedX = scaleX*1.1
	soccerBallSpeedY = scaleY*1
	volleyBallSpeedX = scaleX*1.3
	volleyBallSpeedY = scaleY*0.7
	baseBallSpeedX = scaleX*1.9
	baseBallSpeedY = scaleY*0.85
	golfBallSpeedX = scaleX*2.5
	golfBallSpeedY = scaleY*1.5

	--[[-JUEGO-]]
	if view == 1 then
		--[[-GAME OVER-]]
		if gameOver then
			for i=1, table.getn(beachBall) do
				beachBall[i]:startFalling()
			end
			for i=1, table.getn(bowlingBall) do
				bowlingBall[i]:startFalling()
			end
			for i=1, table.getn(basketBall) do
				basketBall[i]:startFalling()
			end
			for i=1, table.getn(soccerBall) do
				soccerBall[i]:startFalling()
			end
			for i=1, table.getn(volleyBall) do
				volleyBall[i]:startFalling()
			end
			for i=1, table.getn(baseBall) do
				baseBall[i]:startFalling()
			end
			for i=1, table.getn(golfBall) do
				golfBall[i]:startFalling()
			end
			--view = 0
			button['play']:show()
		else
			if fails >= maxFails then
				gameOver = true
			end

			--[[-CREAR BOLAS-]]
			if secondsWithoutBall >= secondsPerBall then
				local selectBall = love.math.random(0, 6)
				if selectBall == 0 then
					local x = table.getn(beachBall) + 1
					beachBall[x] = Ball:new()
					beachBall[x]:create(love.math.random(0, windowWidth-scaleX*beachBallSize), -1*beachBallSize, beachBallSize, beachBallSpeedY, beachBallEnergy)
				end
				if selectBall == 1 then
					local x = table.getn(bowlingBall) + 1
					bowlingBall[x] = Ball:new()
					bowlingBall[x]:create(love.math.random(0, windowWidth-scaleX*bowlingBallSize), -1*bowlingBallSize, bowlingBallSize, bowlingBallSpeedY, bowlingBallEnergy)
				end
				if selectBall == 2 then
					local x = table.getn(basketBall) + 1
					basketBall[x] = Ball:new()
					basketBall[x]:create(love.math.random(0, windowWidth-scaleX*basketBallSize), -1*basketBallSize, basketBallSize, basketBallSpeedY, basketBallEnergy)
				end
				if selectBall == 3 then
					local x = table.getn(soccerBall) + 1
					soccerBall[x] = Ball:new()
					soccerBall[x]:create(love.math.random(0, windowWidth-scaleX*soccerBallSize), -1*soccerBallSize, soccerBallSize, soccerBallSpeedY, soccerBallEnergy)
				end
				if selectBall == 4 then
					local x = table.getn(volleyBall) + 1
					volleyBall[x] = Ball:new()
					volleyBall[x]:create(love.math.random(0, windowWidth-scaleX*volleyBallSize), -1*volleyBallSize, volleyBallSize, volleyBallSpeedY, volleyBallEnergy)
				end
				if selectBall == 5 then
					local x = table.getn(baseBall) + 1
					baseBall[x] = Ball:new()
					baseBall[x]:create(love.math.random(0, windowWidth-scaleX*baseBallSize), -1*baseBallSize, baseBallSize, baseBallSpeedY, baseBallEnergy)
				end
				if selectBall == 6 then
					local x = table.getn(golfBall) + 1
					golfBall[x] = Ball:new()
					golfBall[x]:create(love.math.random(0, windowWidth-scaleX*golfBallSize), -1*golfBallSize, golfBallSize, golfBallSpeedY, golfBallEnergy)
				end
				secondsPerBall = secondsPerBall + 3
				secondsWithoutBall = 0
			end

			--[[-CHECAR SI ALGUNA BOLA DEJÓ DE REBOTAR-]]
			for i=1, table.getn(beachBall) do
				beachBall[i]:startFalling()
				--beachBall[i]:rotate(dt)
				if not beachBall[i].movement then
					if beachBall[i].countsForLives then
						fails = fails + 1
						beachBall[i]:doNotCountIt()
					end
				end
			end
			for i=1, table.getn(bowlingBall) do
				bowlingBall[i]:startFalling()
				--bowlingBall[i]:rotate(dt)
				if not bowlingBall[i].movement then
					if bowlingBall[i].countsForLives then
						fails = fails + 1
						bowlingBall[i]:doNotCountIt()
					end
				end
			end
			for i=1, table.getn(basketBall) do
				basketBall[i]:startFalling()
				--basketBall[i]:rotate(dt)
				if not basketBall[i].movement then
					if basketBall[i].countsForLives then
						fails = fails + 1
						basketBall[i]:doNotCountIt()
					end
				end
			end
			for i=1, table.getn(soccerBall) do
				soccerBall[i]:startFalling()
				--soccerBall[i]:rotate(dt)
				if not soccerBall[i].movement then
					if soccerBall[i].countsForLives then
						fails = fails + 1
						soccerBall[i]:doNotCountIt()
					end
				end
			end
			for i=1, table.getn(volleyBall) do
				volleyBall[i]:startFalling()
				--volleyBall[i]:rotate(dt)
				if not volleyBall[i].movement then
					if volleyBall[i].countsForLives then
						fails = fails + 1
						volleyBall[i]:doNotCountIt()
					end
				end
			end
			for i=1, table.getn(baseBall) do
				baseBall[i]:startFalling()
				--baseBall[i]:rotate(dt)
				if not baseBall[i].movement then
					if baseBall[i].countsForLives then
						fails = fails + 1
						baseBall[i]:doNotCountIt()
					end
				end
			end
			for i=1, table.getn(golfBall) do
				golfBall[i]:startFalling()
				--golfBall[i]:rotate(dt)
				if not golfBall[i].movement then
					if golfBall[i].countsForLives then
						fails = fails + 1
						golfBall[i]:doNotCountIt()
					end
				end
			end
		end
	end
end

--[[-AL PRESIONAR UNA PELOTA-]]
function love.mousepressed(x, y, mouseButton)
	if view == 0 or gameOver and view == 1 then
		if button['play']:click(x, y) then
			font = love.graphics.newFont(44)
			view = 1
			gameRestart()
			button['play']:hide()
		end
	end
	if not gameOver and view == 1 then
		if mouseButton == 1 then
			for i=1, table.getn(beachBall) do
				if x > beachBall[i].x and x < beachBall[i].x+(beachBall[i].size/2) and y > beachBall[i].y and y < beachBall[i].y+(beachBall[i].size/2) then
					beachBall[i]:setBounce(false)
					beachBall[i]:plusVelocity(force*2.5)
				end
			end
			for i=1, table.getn(bowlingBall) do
				if x > bowlingBall[i].x and x < bowlingBall[i].x+(bowlingBall[i].size/2) and y > bowlingBall[i].y and y < bowlingBall[i].y+(bowlingBall[i].size/2) then
					bowlingBall[i]:setBounce(false)
					bowlingBall[i]:plusVelocity(force*0)
				end
			end
			for i=1, table.getn(basketBall) do
				if x > basketBall[i].x and x < basketBall[i].x+(basketBall[i].size/2) and y > basketBall[i].y and y < basketBall[i].y+(basketBall[i].size/2) then
					basketBall[i]:setBounce(false)
					basketBall[i]:plusVelocity(force)
				end
			end
			for i=1, table.getn(soccerBall) do
				if x > soccerBall[i].x and x < soccerBall[i].x+(soccerBall[i].size/2) and y > soccerBall[i].y and y < soccerBall[i].y+(soccerBall[i].size/2) then
					soccerBall[i]:setBounce(false)
					soccerBall[i]:plusVelocity(force)
				end
			end
			for i=1, table.getn(volleyBall) do
				if x > volleyBall[i].x and x < volleyBall[i].x+(volleyBall[i].size/2) and y > volleyBall[i].y and y < volleyBall[i].y+(volleyBall[i].size/2) then
					volleyBall[i]:setBounce(false)
					volleyBall[i]:plusVelocity(force*1.5)
				end
			end
			for i=1, table.getn(baseBall) do
				if x > baseBall[i].x and x < baseBall[i].x+(baseBall[i].size/2) and y > baseBall[i].y and y < baseBall[i].y+(baseBall[i].size/2) then
					baseBall[i]:setBounce(false)
					baseBall[i]:plusVelocity(force*2)
				end
			end
			for i=1, table.getn(golfBall) do
				if x > golfBall[i].x and x < golfBall[i].x+(golfBall[i].size/2) and y > golfBall[i].y and y < golfBall[i].y+(golfBall[i].size/2) then
					golfBall[i]:setBounce(false)
					golfBall[i]:plusVelocity(force*3)
				end
			end
		end
	end
end

function love.draw()
	love.graphics.setBackgroundColor(bgColorR, bgColorG, bgColorB)
	love.graphics.setFont(font)

	if button['play'].display then
		love.graphics.draw(button['play'].image, button['play'].x, button['play'].y, 0, playButtonScaleX, playButtonScaleY)
	end
	if button['instructive'].display then
		love.graphics.draw(button['instructive'].image, button['instructive'].x, button['instructive'].y, 0, instructiveButtonScaleX, instructiveButtonScaleY)
	end
	if button['shop'].display then
		love.graphics.draw(button['shop'].image, button['shop'].x, button['shop'].y, 0, shopButtonScaleX, shopButtonScaleY)
	end
	if button['pause'].display then
		love.graphics.draw(button['pause'].image, button['pause'].x, button['pause'].y, 0, pauseButtonScaleX, pauseButtonScaleY)
	end
	if button['back'].display then
		love.graphics.draw(button['back'].image, button['back'].x, button['back'].y, 0, backButtonScaleX, backButtonScaleY)
	end

	if view == 0 then
		love.graphics.print("Ball's Toucher", 0, windowHeight/32)
		button['play']:relocate(windowWidth/3, windowHeight/2)
		button['play']:show()
	end

	if view == 1 then
		for i=1, table.getn(beachBall) do
			love.graphics.draw(beachBallSprite, beachBall[i].x, beachBall[i].y, beachBall[i].rotation, beachBallScaleX, beachBallScaleY)
		end
		for i=1, table.getn(bowlingBall) do
			love.graphics.draw(bowlingBallSprite, bowlingBall[i].x, bowlingBall[i].y, bowlingBall[i].rotation, bowlingBallScaleX, bowlingBallScaleY)
		end
		for i=1, table.getn(basketBall) do
			love.graphics.draw(basketBallSprite, basketBall[i].x, basketBall[i].y, basketBall[i].rotation, basketBallScaleX, basketBallScaleY)
		end
		for i=1, table.getn(soccerBall) do
			love.graphics.draw(soccerBallSprite, soccerBall[i].x, soccerBall[i].y, soccerBall[i].rotation, soccerBallScaleX, soccerBallScaleY)
		end
		for i=1, table.getn(volleyBall) do
			love.graphics.draw(volleyBallSprite, volleyBall[i].x, volleyBall[i].y, volleyBall[i].rotation, volleyBallScaleX, volleyBallScaleY)
		end
		for i=1, table.getn(baseBall) do
			love.graphics.draw(baseBallSprite, baseBall[i].x, baseBall[i].y, baseBall[i].rotation, baseBallScaleX, baseBallScaleY)
		end
		for i=1, table.getn(golfBall) do
			love.graphics.draw(golfBallSprite, golfBall[i].x, golfBall[i].y, golfBall[i].rotation, golfBallScaleX, golfBallScaleY)
		end

		if seconds < 10 then
			love.graphics.print(minutes..":0"..math.floor(seconds), windowWidth/2, windowHeight/64)
		else
			love.graphics.print(minutes..":"..math.floor(seconds), windowWidth/2, windowHeight/64)
		end

		for i=1, fails do
			love.graphics.draw(failSprite, 10, i*40, 0, failSpriteScaleX, failSpriteScaleY)
		end
	end
end