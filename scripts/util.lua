function moarinserters_deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[moarinserters_deepcopy(orig_key)] = moarinserters_deepcopy(orig_value)
        end
        setmetatable(copy, moarinserters_deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

function moarinserters_stringsplit(str, pat)
   local t = {}  -- NOTE: use {n = 0} in Lua-5.0
   local fpat = "(.-)" .. pat
   local last_end = 1
   local s, e, cap = str:find(fpat, 1)
   while s do
      if s ~= 1 or cap ~= "" then
	 table.insert(t,cap)
      end
      last_end = e+1
      s, e, cap = str:find(fpat, last_end)
   end
   if last_end <= #str then
      cap = str:sub(last_end)
      table.insert(t, cap)
   end
   return t
end

function stupidLuaMinusZero(value)
  -- I really hate lua for that kind of stuffs... see http://lua-users.org/lists/lua-l/2011-06/msg00308.html
  return ((value == 0 or value == -0) and 0 or value)
end

function getOrderCharacterRange(rangeArg)
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

function getOrderCharacterDirection(directionArg)
  if directionArg == "lower_left" then
    return "a"
  elseif directionArg == "left" then
    return "b"
  elseif directionArg == "upper_left" then
    return "c"
  elseif directionArg == "straight" then
    return "d"
  elseif directionArg == "upper_right" then
    return "e"
  elseif directionArg == "right" then
    return "f"
  elseif directionArg == "lower_right" then
    return "g"
  end
end

function getNextDirection(directionArg, isAlien)
  if isAlien then
    if directionArg == "lower_left" then
      return "left"
    elseif directionArg == "left" then
      return "upper_left"
    elseif directionArg == "upper_left" then
      return "straight"
    elseif directionArg == "straight" then
      return "upper_right"
    elseif directionArg == "upper_right" then
      return "right"
    elseif directionArg == "right" then
      return "lower_right"
    elseif directionArg == "lower_right" then
      return "lower_left"
    end
  else
    if directionArg == "left" then
      return "straight"
    elseif directionArg == "straight" then
      return "right"
    elseif directionArg == "right" then
      return "left"
    end
  end
  return "failing getNextDirection()"
end