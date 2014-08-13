require("scripts.entityOO")

entityPrototypes = {}

for x,typeVar in pairs(inserterTypes) do
  for y,rangeVar in pairs(inserterRanges) do
    for z,directionVar in pairs(typeVar == "alien" and alienInserterDirections or inserterDirections) do
      table.insert(entityPrototypes, createEntityPrototype(typeVar, rangeVar, directionVar))
    end
  end
end

data:extend(entityPrototypes)