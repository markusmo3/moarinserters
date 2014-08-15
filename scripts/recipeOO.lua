require("scripts/util")

MoarInserterRecipePrototypeTemplate = {
    type = "recipe",
    name = "TEMPLATE",
    enabled = "false",
    ingredients =
    {
      {"TEMPLATE", 1337}
    },
    result = "TEMPLATE"
}

function init(obj, typeArg, rangeArg)
  local baseName = typeArg .. "-" .. rangeArg .. "-MIinserter"
  
  obj.name = baseName
  if typeArg == "alien" then
    obj.ingredients = {
      {"smart-inserter", 1},
      {debugMode and "copper-plate" or "advanced-circuit", 2},
      {debugMode and "iron-plate" or "alien-science-pack", 1}
    }
  else
    obj.ingredients = {
      {typeArg .. "-inserter", 1},
      {"electronic-circuit", 2}
    }
  end
  obj.result = baseName
end

function createRecipePrototype(typeArg, rangeArg)
  local copy = moarinserters_deepcopy(MoarInserterRecipePrototypeTemplate)
  init(copy, typeArg, rangeArg)
  return copy
end

function getOrderCharacter(rangeArg)
  if rangeArg == "short" then
    return "a"
  elseif rangeArg == "normal" then
    return "b"
  elseif rangeArg == "medium" then
    return "c"
  elseif rangeArg == "long" then
    return "d"
  end
end
