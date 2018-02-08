Paddle = Class{}
  

function Paddle:init(x, y, width, heigth)
	self.x = x
	self.y = y
	self.width = width
	self.heigth = heigth
	self.dy = 0
	
end

function Paddle:update(dt)
	
	if self.dy < 0 then
		self.y = math.max(0, self.y + self.dy * dt)
	else
		self.y = math.min(VIRTUAL_HEIGHT - self.heigth, self.y + self.dy * dt)

	end
end

function Paddle:render()
	love.graphics.rectangle('fill', self.x, self.y, self.width, self.heigth)
end