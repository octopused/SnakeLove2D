local iSnake = {}
snakeWidth = 10
cooldown = 0.2

function createSnake (length, speed, x, y)
  if length == nil then
    length = 5
  end
  if speed == nil then
    speed = 5
  end
  cells = {}
  for i = 1, length do
    cells[i] = {x = 0, y = 0, direction = 2}
  end
  snake = {x = x, y = y, speed = speed, moving = false, width = snakeWidth, cells = cells, cooldown = cooldown, moves = {}, nextMove = 2}

  function snake:organize()
    for i,c in ipairs(self.cells) do
      if i > 1 then
        if c.direction == 1 then
          c.x = snake.cells[i - 1].x
          c.y = snake.cells[i - 1].y + self.width
        elseif c.direction == 2 then
          c.x = snake.cells[i - 1].x - self.width
          c.y = snake.cells[i - 1].y
        elseif c.direction == 3 then
          c.x = snake.cells[i - 1].x
          c.y = snake.cells[i - 1].y - self.width
        elseif c.direction == 4 then
          c.x = snake.cells[i - 1].x + self.width
          c.y = snake.cells[i - 1].y
        end
      else
        c.x = self.x
        c.y = self.y
      end
    end
  end

  function snake:move()
    self.cells[1].direction = self.nextMove
    for i,c in ipairs(self.cells) do
      if c.direction == 1 then
        c.y = c.y - self.width
        if c.y < 0 then
          c.y = love.graphics:getHeight() - self.width
        end
      elseif c.direction == 2 then
        c.x = c.x + self.width
        if c.x >= love.graphics.getWidth() then
          c.x = 0
        end
      elseif c.direction == 3 then
        c.y = c.y + self.width
        if c.y >= love.graphics:getHeight() then
          c.y = 0
        end
      elseif c.direction == 4 then
        c.x = c.x - self.width
        if c.x < 0 then
          c.x = love.graphics:getWidth() - self.width
        end
      end
    end
    i = 1
    while i <= #self.moves do
      moveIndex = self.moves[i]
      self.cells[moveIndex].direction = self.cells[moveIndex - 1].direction
      moveIndex = moveIndex + 1
      if moveIndex <= #self.cells then
        self.moves[i] = moveIndex
        i = i + 1
      else
        table.remove(snake.moves, i)
      end
    end
  end

  function snake:moveUp ()
    if not (self.cells[1].direction == 3) then
      self.moving = true
      self.nextMove = 1
      table.insert(self.moves, 2)
    end
  end
  function snake:moveRight ()
    if not (self.cells[1].direction == 4) then
      self.moving = true
      self.nextMove = 2
      table.insert(self.moves, 2)
    end
  end
  function snake:moveDown ()
    if not (self.cells[1].direction == 1) then
      self.moving = true
      self.nextMove = 3
      table.insert(self.moves, 2)
    end
  end
  function snake:moveLeft ()
    if not (self.cells[1].direction == 2) then
      self.moving = true
      self.nextMove = 4
      table.insert(self.moves, 2)
    end
  end

  function snake:checkCollision ()
    i = 2
    while i <= #self.cells do
      if (self.cells[1].x == self.cells[i].x) and (self.cells[1].y == self.cells[i].y) then
        return true
      end
      i = i + 1
    end
    return false
  end

  function snake:checkFood (food)
    if (snake.cells[1].x == food.x) and (snake.cells[1].y == food.y) then
      return true
    end
    return false
  end

  function snake:grow ()
    table.insert(snake.cells, 1, snake.cells[1])
  end

  snake:organize()
  return snake
end

iSnake.createSnake = createSnake

return iSnake
