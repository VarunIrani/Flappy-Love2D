require("Bird")
require("PipePair")

class "PlayState"("BaseState")

local pipe_spawn_frequency = math.random(1.0, 2.0)
score = 0
paused = false

function PlayState:PlayState()
	BaseState.BaseState(self)
	self.bird = Bird()
	self.pipePairs = {}
	self.spawn_timer = 0
end

function PlayState:update(dt)
	if love.keyboard.wasPressed("p") then
		paused = not paused
	end
	if not paused then
		self.bird:update(dt)
		self.spawn_timer = self.spawn_timer + dt
		if self.spawn_timer > pipe_spawn_frequency then
			table.insert(self.pipePairs, PipePair())
			self.spawn_timer = 0
			pipe_spawn_frequency = math.random(1.0, 1.5)
		end
		for k, pipePair in pairs(self.pipePairs) do
			-- Score check
			if not pipePair.scored then
				if pipePair.pipes[1].x + pipePair.width < self.bird.x then
					score = score + 1
					pipePair.scored = true
					sounds["score"]:play()
				end
			end
			pipePair:update(dt)
		end
		for k, pipePair in pairs(self.pipePairs) do
			-- Collision check
			for l, pipe in pairs(pipePair.pipes) do
				if self.bird:collides(pipe) then
					gStateMachine:change("score")
					sounds["hit"]:play()
				end
			end
			if pipePair.pipes[1].x + pipePair.width < 0 then
				table.remove(self.pipePairs, k)
			end
		end
		if self.bird.y >= VIRTUAL_HEIGHT - land_sprite:getHeight() then
			gStateMachine:change("score")
			sounds["hit"]:play()
		end
	else
		sky_scroll = 0
		land_scroll = 0
	end
end

function PlayState:render()
	text = "Press P to pause"
	for k, pipePair in pairs(self.pipePairs) do
		pipePair:render()
	end
	self.bird:render()
	love.graphics.setFont(titleFont)
	love.graphics.printf(tostring(score), 0, VIRTUAL_HEIGHT / 8, VIRTUAL_WIDTH, "center")
	if paused then
		text = "Press P to resume"
		love.graphics.printf("||", 0, VIRTUAL_HEIGHT / 2 - titleFont:getHeight() / 2, VIRTUAL_WIDTH, "center")
	end
	love.graphics.setFont(love.graphics.newFont("font.ttf", 32))
	love.graphics.setColor(63 / 255, 31 / 255, 9 / 255, 1)
	love.graphics.printf(text, 10, 10, VIRTUAL_WIDTH - 10, "left")
	love.graphics.setColor(1, 1, 1, 1)
end
