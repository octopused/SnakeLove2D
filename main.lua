local iSnake = require "snake"
local iFood = require "food"


function love.load ()
  timer = 0
  snake = iSnake.createSnake(10, nil, love.graphics:getWidth()/2, love.graphics:getHeight()/2)
  food = iFood.createFood(snake)
end

function love.update (dt)
  if snake.moving then
    timer = dt + timer
    if timer >= snake.cooldown then
      snake:move()
      if snake:checkCollision() then
        snake.moving = false
      end
      if snake:checkFood(food) then
        snake:grow()
        food:loadFood(snake)
      end
      timer = 0
    end
  end
end

function love.draw ()
  for i,c in ipairs(snake.cells) do
    love.graphics.rectangle('fill', c.x, c.y, snake.width, snake.width)
  end
  love.graphics.rectangle('fill', food.x, food.y, snake.width, snake.width)
end

function love.keypressed(key)
  if key == 'up' then
    snake:moveUp()
  elseif key == 'right' then
    snake:moveRight()
  elseif key == 'down' then
    snake:moveDown()
  elseif key == 'left' then
    snake:moveLeft()
  end
end

function loadFood ()
  food = {}
  food.x = 10 * math.random(0, math.floor(love.graphics:getWidth()/snake.width))
  food.y = 10 * math.random(0, math.floor(love.graphics:getHeight()/snake.width))
end
