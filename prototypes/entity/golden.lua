--[[
#####
#####
##g##
#####
#####
]]--


entityPrototypes = {}

for xinput=-1,2 do
  for yinput=-2,-1 do
    for xoutput=-2,2 do
      for youtput=-2,2 do
        if not (xoutput == 0 and youtput == 0) and not (xinput == xoutput and yinput == youtput)
            and not (xinput == 2 and yinput == -1) and not (xinput == -1 and yinput == -1) then
          table.insert(entityPrototypes, createGoldenEntityPrototype(xinput, yinput, xoutput, youtput, false))
          table.insert(entityPrototypes, createGoldenEntityPrototype(xinput, yinput, xoutput, youtput, true))
        end
      end
    end
  end
end

data:extend(entityPrototypes)