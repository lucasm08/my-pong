
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

	love.window .setTitle('Pong')

	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })

	player1 = Paddle(10, 30, 5, 20)
	player2 = Paddle(VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 30, 5, 20)
	ball = Ball(VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)	

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

end

function love.draw()
	push:apply('start')

	love.graphics.clear(40, 45, 52, 255)

	player1:render()
	player2:render()
	ball:render()

	push:apply('end')
end