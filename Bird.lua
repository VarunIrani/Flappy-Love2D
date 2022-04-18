class "Bird"

GRAVITY = 50

function Bird:Bird()
    self.image = love.graphics.newImage(images .. "bird.png")
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.x = VIRTUAL_WIDTH / 2 - (self.width / 2)
    self.y = VIRTUAL_HEIGHT / 2 - (self.height / 2)

    self.dy = 0
end

function Bird:render()
    love.graphics.draw(self.image, self.x, self.y)
end

function Bird:update(dt)
    self.dy = self.dy + GRAVITY * dt
    self.y = self.y + self.dy

    if love.keyboard.wasPressed("space") then
        self.dy = -10
        sounds["flap"]:play()
    end
end

function Bird:collides(pipe)
    -- AABB Collision Detection
    if self.x > pipe.x + pipe.width or pipe.x > self.x + self.width then
        return false
    end

    if self.y > pipe.y + pipe.height or pipe.y > self.y + self.height then
        return false
    end

    return true
end
