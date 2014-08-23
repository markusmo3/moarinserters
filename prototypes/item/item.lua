require("scripts.itemOO")

itemPrototypes = {}

for x,typeVar in pairs(inserterTypes) do
  for y,rangeVar in pairs(inserterRanges) do
    table.insert(itemPrototypes, createItemPrototype(typeVar, rangeVar))
  end
end

data:extend(itemPrototypes)