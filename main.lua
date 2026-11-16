function love.load()
    car = { x = 400, y = 300, angle = 0, speed = 0, maxSpeed = 500, accel = 300, friction = 150, turn = 3.5 }
end

function love.update(dt)
    if love.keyboard.isDown("up", "w") then
        car.speed = math.min(car.speed + car.accel * dt, car.maxSpeed)
    elseif love.keyboard.isDown("down", "s") then
        car.speed = math.max(car.speed - car.accel * dt, -car.maxSpeed / 2)
    else
        car.speed = car.speed > 0 and math.max(0, car.speed - car.friction * dt) or math.min(0, car.speed + car.friction * dt)
    end

    if math.abs(car.speed) > 10 then
        local dir = car.speed > 0 and 1 or -1
        if love.keyboard.isDown("left", "a") then car.angle = car.angle - car.turn * dt * dir end
        if love.keyboard.isDown("right", "d") then car.angle = car.angle + car.turn * dt * dir end
    end

    car.x = car.x + math.cos(car.angle) * car.speed * dt
    car.y = car.y + math.sin(car.angle) * car.speed * dt
end

function love.draw()
    love.graphics.setBackgroundColor(0.2, 0.2, 0.2)
    love.graphics.push()
    love.graphics.translate(car.x, car.y)
    love.graphics.rotate(car.angle)
    love.graphics.setColor(0.9, 0.1, 0.1)
    love.graphics.rectangle("fill", -20, -10, 40, 20)
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", 15, -12, 5, 24)
    love.graphics.pop()
    love.graphics.print("Speed: " .. math.floor(car.speed / 2) .. " km/h", 10, 10)
end

