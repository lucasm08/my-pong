
push = require "push"

Class = require "class"

require "Paddle"

require "Ball"




WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PADDLE_SPEED = 200

function love.load()
	love.graphics.setDefaultFilter('nearest', 'nearest') 

	love.window.setTitle('Pong')

	math.randomseed(os.time())

	smallFont = love.graphics.newFont('font.ttf', 8)
    largeFont = love.graphics.newFont('font.ttf', 16)
    scoreFont = love.graphics.newFont('font.ttf', 32)

	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })

	player1 = Paddle(10, 30, 5, 20)
	player2 = Paddle(VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 30, 5, 20)
	Ball = Ball(VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)

	player1Score = 0

	player2Score = 0

	servePlayer = 1

	winner = 0

	k = "key"




	gameState = "start"

end	

function love.update(dt)


	if love.keyboard.isDown("w") then
		player1.dy = PADDLE_SPEED
	elseif love.keyboard.isDown("s") then
		player1.dy = -PADDLE_SPEED
	else
		player1.dy = 0
	end

	

	if love.keyboard.isDown("up") then
		player2.dy =  -PADDLE_SPEED
	elseif love.keyboard.isDown("down") then
		player2.dy = PADDLE_SPEED
	else
		player2.dy = 0
	end

	if gameState == "serve" then

		Ball.dx = math.random(-50, 50)

		if servePlayer == 1 then
			Ball.dx = math.random(90, 140)
		else
			Ball.dx = -math.random(90, 140)
		end
	end


	if gameState == "play" then

		if Ball.y <= 0 then
			Ball.dy = -Ball.dy
		end

		if Ball.y >= VIRTUAL_HEIGHT - 4 then
			Ball.dy = -Ball.dy
		end

		if Ball:collides(player2) then
			Ball.dx = -Ball.dx * 1.03
			Ball.x = player2.x - 5

			if Ball.dy < 0 then
                Ball.dy = -math.random(10, 150)
            else
                Ball.dy = math.random(10, 150)
            end
		end

		if Ball:collides(player1) then
			Ball.dx = -Ball.dx * 1.03
			Ball.x = player1.x + 5

			if Ball.dy < 0 then
                Ball.dy = -math.random(10, 150)
            else
                Ball.dy = math.random(10, 150)
            end
		end


		if Ball.x > VIRTUAL_WIDTH then
			servePlayer = 2
			player1Score = player1Score + 1
			gameState = "serve"

			if player1Score == 10 then
				servePlayer = 2
				gameState = "winning"
				winner = 1
			end

			Ball:reset()
		end

		if Ball.x < 0 then
			servePlayer = 1
			player2Score = player2Score + 1
			gameState  = "serve"
			Ball:reset()

			if player2Score == 10 then
				servePlayer = 1
				gameState = "winning"
				winner = 2
			end
		end 

	end


	if gameState == "play" then
		Ball:update(dt)

	end



	player1:update(dt)
	player2:update(dt)

end



function love.keypressed(key)

	k = key

	if key == "escape" then
		love.event.quit()
	end

	if key == "enter" or key == "return" then
		if gameState == "start" then
			gameState = "serve"
			Ball:reset()
		elseif gameState == "serve" then
			
			gameState = "play"
		elseif gameState == "winning" then
			player2Score = 0
			player1Score = 0
			gameState = "serve"
			Ball:reset()
		end
	end

	if key == "space" then
		if	gameState == "play" then
			gameState = "pause"
		elseif gameState == "pause"then
			gameState = "play"
		end 

	end

end

function love.draw()
	push:apply('start')

	love.graphics.clear(40, 45, 52, 255)

	displayScore()

	
	if gameState == "start" then
		love.graphics.setFont(smallFont)
		love.graphics.printf('Welcome to Pong!', 0, 5, VIRTUAL_WIDTH, 'center')
		love.graphics.printf('Press Enter to begin', 0, 15, VIRTUAL_WIDTH, 'center')
	elseif gameState == "serve" then
		love.graphics.setFont(smallFont)
		love.graphics.printf('Player '.. tostring(servePlayer) .. "'s serve" , 0, 5, VIRTUAL_WIDTH, 'center')
		love.graphics.printf('Press Enter to serve', 0, 15, VIRTUAL_WIDTH, 'center')
	elseif gameState == "winning" then
		love.graphics.setFont(smallFont)
		love.graphics.printf('Player '.. tostring(winner) .. "'s win" , 0, 5, VIRTUAL_WIDTH, 'center')
		love.graphics.printf('Press Enter to play again', 0, 15, VIRTUAL_WIDTH, 'center')
	elseif gameState == "pause" then
		love.graphics.setFont(smallFont)
		love.graphics.printf('Pause', 0, 5, VIRTUAL_WIDTH, 'center')
		love.graphics.printf('Press Space to continue', 0, 15, VIRTUAL_WIDTH, 'center')

	end

	player1:render()
	player2:render()
	Ball:render()

	push:apply('end')
end

function displayScore()

	love.graphics.setFont(scoreFont)
	love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 3)
	love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH / 2 + 32, VIRTUAL_HEIGHT / 3)
	-- body
end

function debugging()
	love.graphics.setFont(smallFont)
    love.graphics.setColor(0, 255, 0, 255)
    love.graphics.print('ball.dx: ' .. tostring(Ball.dx), 10, 10)
    love.graphics.print('ball.dy: ' .. tostring(Ball.dy), 10, 20)
    love.graphics.print('ball.x: ' .. tostring(Ball.x), 10, 30)
    love.graphics.setColor(255, 255, 255, 255)
   

end


function displayKeyPresssed()
	-- body
	love.graphics.setFont(smallFont)
    love.graphics.setColor(0, 255, 0, 255)
    love.graphics.print('key: ' .. k, 10, 10)
    love.graphics.setColor(255, 255, 255, 255)
end