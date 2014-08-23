require("scripts/util")

MoarInserterItemPrototypeTemplate = {
  type = "item",
  name = "TEMPLATE",
  icon = "TEMPLATE",
  flags = {"goes-to-quickbar"},
  subgroup = "inserter",
  order = "TEMPLATE",
  place_result = "TEMPLATE",
  stack_size = 100
}

function init(obj, typeArg, rangeArg)
  local baseName = typeArg .. "-" .. rangeArg .. "-MIinserter"
  
  obj.name = baseName
  obj.icon = "__MoarInserters__/graphics/icons/" .. baseName .. ".png"
  obj.subgroup = "moarinserters-" .. typeArg
  obj.place_result = baseName .. "-straight"
  
  obj.order = "a[moarinserters]-" .. getOrderCharacterRange(rangeArg) .. "[range]"
end

function createItemPrototype(typeArg, rangeArg)
  local copy = moarinserters_deepcopy(MoarInserterItemPrototypeTemplate)
  init(copy, typeArg, rangeArg)
  return copy
end