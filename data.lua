require("switches")

inserterTypes = {"basic", "fast", "smart", "alien"}
inserterRanges = {"short", "normal", "medium", "long"}
inserterDirections = {"left", "straight", "right"}
alienInserterDirections = {"lower_left", "left", "upper_left", "straight", "upper_right", "right", "lower_right"}

-- TECH
require("prototypes.technology.tech")

-- ITEM GROUP
require("prototypes.item-group")

-- WRENCH
require("prototypes.wrench")

-- OBJECT ORIENTED STUFFS
require("prototypes.entity.entity")
require("prototypes.item.item")
require("prototypes.recipe.recipe")
if (enableGoldenInserter) then
  require("prototypes.entity.golden")
  require("prototypes.item.golden")
  require("prototypes.recipe.golden")
  require("prototypes.technology.golden")
end

require("prototypes.style")