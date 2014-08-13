--[[ DebugMode makes recipes simpler and is just for debugging purposes, default is false ]]--
debugMode = false

inserterTypes = {"basic", "fast", "smart", "alien"}
inserterRanges = {"short", "normal", "medium", "long"}
inserterDirections = {"left", "straight", "right"}
alienInserterDirections = {"lower_left", "left", "upper_left", "straight", "upper_right", "right", "lower_right"}

-- TECH
require("prototypes.tech")

-- ITEM GROUP
require("prototypes.item-group")

-- WRENCH
require("prototypes.wrench")

-- OBJECT ORIENTED STUFFS
require("prototypes.entity")
require("prototypes.item")
require("prototypes.recipe")
