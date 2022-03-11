class "TitleScreenState"("BaseState")

local title_image = love.graphics.newImage(images .. "title.png")
local play_button = love.graphics.newImage(images .. "PlayButton.png")

play_button_position = {x = VIRTUAL_WIDTH / 2 - play_button:getWidth() / 2, y = VIRTUAL_HEIGHT / 2 - 100}

function TitleScreenState:update(dt)
	if love.mouse.isDown(1) then
		mouseX = love.mouse.getX() / scale
		mouseY = love.mouse.getY() / scale
		if
			mouseX >= play_button_position.x and mouseX < play_button_position.x + play_button:getWidth() and
				mouseY >= play_button_position.y and
				mouseY < play_button_position.y + play_button:getHeight()
		 then
			gStateMachine:change("countdown")
		end
	end
end

function TitleScreenState:render()
	love.graphics.draw(title_image, VIRTUAL_WIDTH / 2 - title_image:getWidth() / 2, VIRTUAL_HEIGHT / 8)

	love.graphics.draw(play_button, play_button_position.x, play_button_position.y)

	love.graphics.setColor(63 / 255, 31 / 255, 9 / 255, 1)

	love.graphics.printf("Press Escape to exit", 0, VIRTUAL_HEIGHT - VIRTUAL_HEIGHT / 3, VIRTUAL_WIDTH, "center")

	love.graphics.setColor(1, 1, 1, 1)
end
