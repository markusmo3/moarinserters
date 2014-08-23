require("scripts/util")

distanceMap = {
  short = 0.85,
  normal = 1.15,
  medium = 1.85,
  long = 2.15
}

MoarInserterEntityPrototypeTemplate = {
  type = "inserter",
  name = "TEMPLATE",
  icon = "TEMPLATE",
  flags = {"placeable-neutral", "placeable-player", "player-creation"},
  minable = {hardness = 0.2, mining_time = 0.5},
  max_health = 40,
  corpse = "small-remnants",
  resistances = {
    {
      type = "fire",
      percent = 90
    }
  },
  order = "TEMPLATE",
  collision_box = {{-0.15, -0.15}, {0.15, 0.15}},
  selection_box = {{-0.4, -0.35}, {0.4, 0.45}},
  pickup_position = {0, -5},
  insert_position = {0, 5},
  energy_per_movement = 13337,
  energy_per_rotation = 13337,
  rotation_speed = 1337,
  hand_size = 5,
  energy_source = {
    type = "electric",
    usage_priority = "secondary-input",
    drain = "0.4kW"
  },
  extension_speed = 1337,
  fast_replaceable_group = "inserter",
--[[  working_sound = -- nah sorry, too lazy to create inserter sounds...
  {
    match_progress_to_activity = true,
    sound =
    {
      {
        filename = "__MoarInserters__/sound/inserter-long-handed-1.ogg",
        volume = 0.75
      },
      {
        filename = "__MoarInserters__/sound/inserter-long-handed-2.ogg",
        volume = 0.75
      },
      {
        filename = "__MoarInserters__/sound/inserter-long-handed-3.ogg",
        volume = 0.75
      },
      {
        filename = "__MoarInserters__/sound/inserter-long-handed-4.ogg",
        volume = 0.75
      },
      {
        filename = "__MoarInserters__/sound/inserter-long-handed-5.ogg",
        volume = 0.75
      }
    }
  }, ]]--
  hand_base_picture = {
    filename = "TEMPLATE",
    priority = "extra-high",
    width = 8,
    height = 34
  },
  hand_closed_picture = {
    filename = "TEMPLATE",
    priority = "extra-high",
    width = 18,
    height = 41
  },
  hand_open_picture = {
    filename = "TEMPLATE",
    priority = "extra-high",
    width = 18,
    height = 41
  },
  hand_base_shadow = {
    filename = "__MoarInserters__/graphics/entity/shadow/hand-base-shadow.png",
    priority = "extra-high",
    width = 8,
    height = 34
  },
  hand_closed_shadow = {
    filename = "__MoarInserters__/graphics/entity/shadow/hand-closed-shadow.png",
    priority = "extra-high",
    width = 18,
    height = 41
  },
  hand_open_shadow = {
    filename = "__MoarInserters__/graphics/entity/shadow/hand-open-shadow.png",
    priority = "extra-high",
    width = 18,
    height = 41
  },
  platform_picture = {
    priority = "extra-high",
    width = 46,
    height = 46,
    sheet = "TEMPLATE"
  }
}

function init(obj, typeArg, rangeArg, directionArg)
  local baseName = typeArg .. "-" .. rangeArg .. "-MIinserter"
  obj.name = baseName .. "-" .. directionArg
  
  -- GRAPHICS
  obj.icon = "__MoarInserters__/graphics/icons/" .. baseName .. ".png"
  obj.hand_base_picture["filename"] = "__MoarInserters__/graphics/entity/hand/" .. rangeArg .. "-hand-base.png"
  obj.hand_closed_picture["filename"] = "__MoarInserters__/graphics/entity/hand/" .. rangeArg .. "-hand-closed.png"
  obj.hand_open_picture["filename"] = "__MoarInserters__/graphics/entity/hand/" .. rangeArg .. "-hand-open.png"
  obj.platform_picture["sheet"] = "__MoarInserters__/graphics/entity/platform/" .. typeArg .. "-platform.png"
  
  -- RANGE DEPENDENT
  if rangeArg == "short" then
    obj.pickup_position = {0, -1}
    obj.hand_size = 0.9
  elseif rangeArg == "normal" then
    obj.pickup_position = {0, -1}
    obj.hand_size = 1.1
  elseif rangeArg == "medium" then
    obj.pickup_position = {0, -2}
    obj.hand_size = 1.4
  elseif rangeArg == "long" then
    obj.pickup_position = {0, -2}
    obj.hand_size = 1.6
  end
  
  -- DIRECTION DEPENDENT
  local distance = distanceMap[rangeArg]
  if directionArg == "straight" then
    obj.insert_position = {0, distance}
  else
    obj.subgroup = "moarinserters-" .. typeArg
    obj.order = "b[moarinserters]-" .. getOrderCharacterRange(rangeArg) .. "[range]-" .. getOrderCharacterDirection(directionArg) .. "[direction]"
    local xVal = string.find(directionArg, "right") and -distance or distance
    if string.find(directionArg, "upper") then
      obj.insert_position = {xVal, distance}
    elseif string.find(directionArg, "lower") then
      obj.insert_position = {xVal, -distance}
    else
      obj.insert_position = {xVal, 0}
    end
  end
  
  -- TYPE DEPENDENT
  if typeArg == "basic" then
    obj.extension_speed = 0.028
    obj.rotation_speed = 0.014
    obj.energy_per_movement = 5000
    obj.energy_per_rotation = 5000
  elseif typeArg == "fast" then
    obj.extension_speed = 0.07
    obj.rotation_speed = 0.035
    obj.energy_per_movement = 5000
    obj.energy_per_rotation = 5000
  elseif typeArg == "smart" then
    obj.extension_speed = 0.07
    obj.rotation_speed = 0.035
    obj.energy_per_movement = 7000
    obj.energy_per_rotation = 7000
    obj.filter_count = 5
    obj.programmable = true
  elseif typeArg == "alien" then
    obj.extension_speed = 0.14
    obj.rotation_speed = 0.07
    obj.energy_per_movement = 7000
    obj.energy_per_rotation = 7000
    obj.filter_count = 5
    obj.programmable = true
  end
end

function createEntityPrototype(typeArg, rangeArg, directionArg)
  local copy = moarinserters_deepcopy(MoarInserterEntityPrototypeTemplate)
  init(copy, typeArg, rangeArg, directionArg)
  return copy
end

function initGolden(obj, xinput, yinput, xoutput, youtput, isNearSideOutput)
  local baseName = "golden-MIinserter#" .. xinput .. "_".. yinput .. ":" .. xoutput .. "_" .. youtput .. (isNearSideOutput and "#near" or "#far")
  obj.name = baseName
  
  -- GRAPHICS
  obj.icon = "__MoarInserters__/graphics/icons/golden-MIinserter.png"
  obj.hand_base_picture["filename"] = "__MoarInserters__/graphics/entity/hand/golden-hand-base.png"
  obj.hand_closed_picture["filename"] = "__MoarInserters__/graphics/entity/hand/golden-hand-closed.png"
  obj.hand_open_picture["filename"] = "__MoarInserters__/graphics/entity/hand/golden-hand-open.png"
  obj.platform_picture["sheet"] = "__MoarInserters__/graphics/entity/platform/golden-platform.png"
  
  -- RANGE DEPENDENT
  obj.pickup_position = {xinput, yinput}
  obj.hand_size = 2
  
  -- DIRECTION DEPENDENT
  local outputAdder = isNearSideOutput and -0.15 or 0.15
  obj.insert_position = {xoutput + outputAdder, youtput + outputAdder}
  obj.subgroup = "moarinserters-golden"
  obj.order = baseName
  
  obj.extension_speed = 0.14
  obj.rotation_speed = 0.07
  obj.energy_per_movement = 7000
  obj.energy_per_rotation = 7000
  obj.filter_count = 5
  obj.programmable = true
end

function createGoldenEntityPrototype(xinput, yinput, xoutput, youtput, isNearSideOutput)
  local copy = moarinserters_deepcopy(MoarInserterEntityPrototypeTemplate)
  initGolden(copy, xinput, yinput, xoutput, youtput, isNearSideOutput)
  return copy
end