data:extend({
  {
    type = "recipe",
    name = "golden-MIinserter",
    enabled = "false",
    ingredients = {
      {"smart-inserter", 2},
      {debugMode and "copper-plate" or "processing-unit", 10},
      {debugMode and "iron-plate" or "alien-artifact", 1}
    },
    result = "golden-MIinserter"
  }
})