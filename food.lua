local iFood = {}

function createFood ()
  food = {}
  food.x = 0
  food.y = 0
  
  function food:loadFood (snake)
    self.x = 10 * math.random(0, math.floor(love.graphics:getWidth()/snake.width))
    self.y = 10 * math.random(0, math.floor(love.graphics:getHeight()/snake.width))
    for i,c in ipairs(snake.cells) do
      if (self.x == c.x) and (self.y == c.y) then
        self.loadFood(snake)
      end
    end
  end

  food:loadFood(snake)
  return food
end

iFood.createFood = createFood
return iFood
