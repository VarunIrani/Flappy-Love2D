push = require("push")

scale = 0.7

WINDOW_WIDTH = 768 * scale
WINDOW_HEIGHT = 1024 * scale

VIRTUAL_WIDTH = 768
VIRTUAL_HEIGHT = 1024

images = "assets/img/"
audio = "assets/audio/"

sky_sprite = love.graphics.newImage(images .. "sky.png")
land_sprite = love.graphics.newImage(images .. "land.png")

sky_scroll = 0
land_scroll = 0

require("class")

-- States
require("StateMachine")
require("states/BaseState")
require("states/CountDownState")
require("states/PlayState")
require("states/ScoreState")
require("states/TitleScreenState")

local SKY_SPEED = 30
local LAND_SPEED = 200

function love.load()
	math.randomseed(os.time())

	love.graphics.setDefaultFilter("nearest", "nearest")
	love.window.setTitle("Flappy Bird")

	titleFont = love.graphics.newFont("font.ttf", 92)
	flappyFont = love.graphics.newFont("font.ttf", 48)

	love.graphics.setFont(flappyFont)

	sounds = {
		["flap"] = love.audio.newSource(audio .. "Wing.wav", "static"),
		["score"] = love.audio.newSource(audio .. "Point.wav", "static"),
		["hit"] = love.audio.newSource(audio .. "Hit.wav", "static")
	}

	push:setupScreen(
		VIRTUAL_WIDTH,
		VIRTUAL_HEIGHT,
		WINDOW_WIDTH,
		WINDOW_HEIGHT,
		{
			vsync = true,
			fullscreen = false,
			resizable = false
		}
	)

	gStateMachine =
		StateMachine {
		["title"] = function()
			return TitleScreenState()
		end,
		["countdown"] = function()
			return CountDownState()
		end,
		["play"] = function()
			return PlayState()
		end,
		["score"] = function()
			return ScoreState()
		end
	}

	gStateMachine:change("title")

	love.keyboard.keysPressed = {}
end

function love.keypressed(key)
	love.keyboard.keysPressed[key] = true
	if key == "escape" then
		love.event.quit()
	end
end

function love.keyboard.wasPressed(key)
	return love.keyboard.keysPressed[key]
end

function love.update(dt)
	sky_scroll = (sky_scroll + SKY_SPEED * dt) % VIRTUAL_WIDTH
	land_scroll = (land_scroll + LAND_SPEED * dt) % VIRTUAL_WIDTH

	gStateMachine:update(dt)

	love.keyboard.keysPressed = {}
end

function love.draw()
	push:start()

	love.graphics.draw(sky_sprite, -sky_scroll, 0)
	love.graphics.draw(sky_sprite, VIRTUAL_WIDTH - sky_scroll, 0)

	gStateMachine:render()

	love.graphics.draw(land_sprite, -land_scroll, VIRTUAL_HEIGHT - land_sprite:getHeight())
	love.graphics.draw(land_sprite, land_sprite:getWidth() - land_scroll, VIRTUAL_HEIGHT - land_sprite:getHeight())

	push:finish()
end
