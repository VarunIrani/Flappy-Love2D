class "Pipe"

local PIPE_SCROLL = -200

function Pipe:Pipe(image, x, y)
    self.x = x
    self.image = image
    self.y = y
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
end

function Pipe:render()
    love.graphics.draw(self.image, self.x, self.y)
end

function Pipe:update(dt)
    self.x = self.x + PIPE_SCROLL * dt
end
