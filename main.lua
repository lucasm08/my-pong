
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
	ball = Ball(VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)

	player1Score = 0

	player2Score = 0

	servePlayer = 1




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



	player1:update(dt)
	player2:update(dt)

end



function love.keypressed(key)

	if key == "escape" then
		love.event.quit()
	end

	if key == "enter" or key == "return" then
		if gameState == "start" then
			gameState = "serve"
			Ball:reset()
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
		love.graphics.printf('Press Enter to begin', 0, 15, VIRTUAL_WIDTH, 'center')
	end

	

	player1:render()
	player2:render()
	ball:render()

	push:apply('end')
end

function displayScore()

	love.graphics.setFont(scoreFont)
	love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 3)
	love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH / 2 + 32, VIRTUAL_HEIGHT / 3)
	-- body
end