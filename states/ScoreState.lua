class "ScoreState"("BaseState")

local score_body = love.graphics.newImage(images .. "Game-Over-Body.png")
local game_over = love.graphics.newImage(images .. "Game-Over-Title.png")

local medals = {
	bronze = love.graphics.newImage(images .. "Bronze-Medal.png"),
	silver = love.graphics.newImage(images .. "Silver-Medal.png"),
	gold = love.graphics.newImage(images .. "Gold-Medal.png"),
	platinum = love.graphics.newImage(images .. "Platinum-Medal.png")
}

local scores = {
	bronze = 0,
	silver = 5,
	gold = 25,
	platinum = 100
}

function ScoreState:ScoreState()
	self.medal = nil
	if score >= scores.platinum then
		self.medal = medals.platinum
	elseif score >= scores.gold then
		self.medal = medals.gold
	elseif score >= scores.silver then
		self.medal = medals.silver
	else
		self.medal = medals.bronze
	end
end

function ScoreState:update(dt)
	if love.keyboard.wasPressed("enter") or love.keyboard.wasPressed("return") then
		gStateMachine:change("countdown")
		score = 0
	end
end

function ScoreState:render()
	love.graphics.draw(game_over, VIRTUAL_WIDTH / 2 - game_over:getWidth() / 2, VIRTUAL_HEIGHT / 8)

	love.graphics.draw(
		score_body,
		VIRTUAL_WIDTH / 2 - score_body:getWidth() / 2,
		VIRTUAL_HEIGHT / 2 - score_body:getHeight() / 2
	)

	love.graphics.draw(self.medal, 175, 465)

	love.graphics.setColor(63 / 255, 31 / 255, 9 / 255, 0.75)
	love.graphics.setFont(flappyFont)
	love.graphics.print(tostring(score), VIRTUAL_WIDTH / 2 + 150, VIRTUAL_HEIGHT / 2 - 50)
	love.graphics.setColor(100 / 255, 100 / 255, 100 / 255, 1)
end
