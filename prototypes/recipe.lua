require("scripts.recipeOO")

recipePrototypes = {}

for x,typeVar in pairs(inserterTypes) do
  for y,rangeVar in pairs(inserterRanges) do
    table.insert(recipePrototypes, createRecipePrototype(typeVar, rangeVar))
  end
end

data:extend(recipePrototypes)