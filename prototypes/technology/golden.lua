data:extend({
  {
    type = "technology",
    name = "moar-inserters-tech-golden",
    icon = "__MoarInserters__/graphics/technology/moar-inserters-tech-golden.png",
    prerequisites = {"moar-inserters-tech-alien"},
    effects = 
    {
      {
        type = "unlock-recipe",
        recipe = "golden-MIinserter"
      }
    },
    unit = 
	{
      count = debugMode and 1 or 30,
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