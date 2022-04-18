class "CountDownState"("BaseState")

COUNTDOWN_TIME = 0.75

function CountDownState:CountDownState()
    self.count = 3
    self.timer = 0
end

function CountDownState:update(dt)
    self.timer = self.timer + dt

    if self.timer > COUNTDOWN_TIME then
        self.timer = self.timer % COUNTDOWN_TIME
        self.count = self.count - 1

        if self.count == 0 then
            gStateMachine:change("play")
        end
    end
end

function CountDownState:render()
    love.graphics.setFont(titleFont)
    love.graphics.printf(tostring(self.count), 0, VIRTUAL_HEIGHT / 2 - 48, VIRTUAL_WIDTH, "center")
end
