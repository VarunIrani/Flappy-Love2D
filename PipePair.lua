require("Pipe")

class "PipePair"

local PIPE_UP_IMAGE = love.graphics.newImage(images .. "PipeUp.png")

local PIPE_DOWN_IMAGE = love.graphics.newImage(images .. "PipeDown.png")

local land_y = VIRTUAL_HEIGHT - land_sprite:getHeight()

function PipePair:PipePair()
    y_offset = math.random(PIPE_UP_IMAGE:getHeight(), PIPE_UP_IMAGE:getHeight() / 2)
    -- Random Pipe Gaps
    random_gap = math.random(PIPE_UP_IMAGE:getHeight() / 2, PIPE_UP_IMAGE:getHeight() / 3)
    -- Random Pipe Distance
    top_pipe = Pipe(PIPE_DOWN_IMAGE, VIRTUAL_WIDTH, random_gap - y_offset)
    bottom_pipe = Pipe(PIPE_UP_IMAGE, VIRTUAL_WIDTH, land_y - y_offset)
    self.pipes = { top_pipe, bottom_pipe }
    self.x = self.pipes[1].x
    self.width = self.pipes[1].width
    self.scored = false
end

function PipePair:update(dt)
    for l, pipe in pairs(self.pipes) do
        pipe:update(dt)
    end
end

function PipePair:render()
    for l, pipe in pairs(self.pipes) do
        pipe:render()
    end
end
