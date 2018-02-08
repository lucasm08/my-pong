Paddle = {}
  

function Paddle:init(x, y, width, heigth)
	self.x = x
	self.y = y
	self.width = width
	self.heigth = heigth
	self.dy = 0
end

function Paddle:update(dt)
	
	if self.dy < 0 then
		self.dy = math.max(0, self.y + self.dy * dt)
	else
		self.dy = math.min(VIRTUAL_HEIGHT - self.heigth, self.dy + self.dy * dt)

	end
end

function Paddle:render()
	love.graphics.printf('fill', self.x, self.y, self.width, self.heigth)
end