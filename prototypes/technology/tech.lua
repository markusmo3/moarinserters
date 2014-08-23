local effectTable = {}
local effectTableAlien = {}

for _,typeVar in pairs(inserterTypes) do
  for _,rangeVar in pairs(inserterRanges) do
    if typeVar == "alien" then
      table.insert(effectTableAlien, { type = "unlock-recipe", recipe = typeVar .. "-" .. rangeVar .. "-MIinserter" })
    else
      table.insert(effectTable, { type = "unlock-recipe", recipe = typeVar .. "-" .. rangeVar .. "-MIinserter" })
    end
  end
end

data:extend({
  {
    type = "technology",
    name = "moar-inserters-tech",
    icon = "__MoarInserters__/graphics/technology/moar-inserters-tech.png",
    prerequisites = {"electronics"},
    effects = effectTable,
    unit = 
	{
      count = debugMode and 1 or 30,
      ingredients = 
	  {
		{"science-pack-1", 1}
	  },
      time = 15
    }
  },
  {
    type = "technology",
    name = "moar-inserters-tech-alien",
    icon = "__MoarInserters__/graphics/technology/moar-inserters-tech-alien.png",
    prerequisites = {"moar-inserters-tech"},
    effects = effectTableAlien,
    unit = 
	{
      count = debugMode and 1 or 20,
      ingredients = 
	  {
        {"science-pack-1", 1},
        {"science-pack-2", 1},
        {"science-pack-3", 1},
		{"alien-science-pack", 1}
	  },
      time = 30
    }
  }
})