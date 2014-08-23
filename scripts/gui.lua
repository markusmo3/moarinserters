--[[ Visualizing of Direction in factorio
701
6 2
543
And here the inputToDirectionMapping
60000
66002
66 22
64422
44442
]]--
inputToDirectionMapping = { -- inputToDirectionMapping[y][x]
  [-2] = {[-2] = 6, [-1] = 0, [0] = 0, [1] = 0, [2] = 0},
  [-1] = {[-2] = 6, [-1] = 6, [0] = 0, [1] = 0, [2] = 2},
  [0] =  {[-2] = 6, [-1] = 6, [0] = 9, [1] = 2, [2] = 2},
  [1] =  {[-2] = 6, [-1] = 4, [0] = 4, [1] = 2, [2] = 2},
  [2] =  {[-2] = 4, [-1] = 4, [0] = 4, [1] = 4, [2] = 2}
}

oldGoldenAttributes = nil
defaultButtonStyle = nil
inputButton = nil
outputButton = nil
buttonGroup = {}
guistate = nil

function showGoldenGui()
  guistate = "input"
  game.player.gui.center.add{ type = "frame", name = "goldenframe", caption = game.localise("goldenFrameChooseInputCaption")}
  game.player.gui.center.goldenframe.direction = "vertical"
  game.player.gui.center.goldenframe.add{ type = "label", name = "labelDescription", caption = game.localise("goldenFrameDescription") }
  game.player.gui.center.goldenframe.add{ type = "table", name = "tableDirection", colspan = 5 }
  
  for y=-2,2 do
    for x=-2,2 do
      datButton = { type = "button", name = "coordButton_" .. (x+2) .. "_" .. (y+2), caption = x .. "|" .. y, style = "button_style_mi_default"}
      if (y == 0 and x == 0) then 
        datButton.caption = "X"
      end
      game.player.gui.center.goldenframe.tableDirection.add(datButton)
    end
  end
  defaultButtonStyle = game.player.gui.center.goldenframe.tableDirection.coordButton_0_0.style
  game.player.gui.center.goldenframe.add{ type = "checkbox", name = "checkboxNear", caption = game.localise("goldenFrameCheckboxNear"), state = false}
  game.player.gui.center.goldenframe.add{ type = "table", name = "tableButtons", colspan = 2}
  game.player.gui.center.goldenframe.tableButtons.add{ type = "button", name = "buttonNext", caption = game.localise("goldenFrameButtonNext")}
  game.player.gui.center.goldenframe.tableButtons.add{ type = "button", name = "buttonExit", caption = game.localise("goldenFrameButtonExit")}
end

function exitGoldenGui()
  -- reset everything related to the goldenGui
  defaultButtonStyle = nil
  inputButton = nil
  outputButton = nil
  buttonGroup = {}
  guistate = nil
  oldGoldenAttributes = nil
  game.player.gui.center.goldenframe.destroy()
end

function coordButtonPressed(button, guistate)
  if (inputButton ~= nil and button.name == inputButton.name) 
      or (outputButton ~= nil and button.name == outputButton.name) 
      or (button.caption == "X") then
    -- if it is a button that is already active or it is the center one (representing the inserter)
    return
  end
  for x,otherButton in pairs(buttonGroup) do
    if guistate == "input" then
      otherButton.style = "button_style_mi_default"
    elseif guistate == "output" and otherButton.name ~= inputButton.name then
      otherButton.style = "button_style_mi_default"
    end
  end
  if guistate == "input" then
    button.style = "button_style_mi_green";
    inputButton = button
  elseif guistate == "output" then
    button.style = "button_style_mi_blue"
    outputButton = button
  end
  table.insert(buttonGroup, button)
end

game.onevent(defines.events.onguiclick, function(event)
  if string.find(event.element.name, "coordButton") ~= nil then
    coordButtonPressed(event.element, guistate)
  elseif event.element.name == "buttonExit" then
    placeInserter(oldGoldenAttributes)
    exitGoldenGui()
  elseif event.element.name == "buttonNext" then
    if guistate == "input" and inputButton ~= nil then
      guistate = "output"
      game.player.gui.center.goldenframe.caption = game.localise("goldenFrameChooseOutputCaption")
      game.player.gui.center.goldenframe.tableButtons.buttonNext.caption = game.localise("goldenFrameButtonFinish")
    elseif guistate == "output" and outputButton ~= nil then
      inputSplit = moarinserters_stringsplit(inputButton.name, "_")
      outputSplit = moarinserters_stringsplit(outputButton.name, "_")
      inputX = inputSplit[2] - 2
      inputY = inputSplit[3] - 2
      outputX = outputSplit[2] - 2
      outputY = outputSplit[3] - 2
      newDirection = inputToDirectionMapping[inputY][inputX]
      for i=1,(newDirection/2) do
        inputX, inputY = rotateAntiClockwise(inputX, inputY)
        outputX, outputY = rotateAntiClockwise(outputX, outputY)
      end
      oldGoldenAttributes.direction = newDirection
      oldGoldenAttributes.name = "golden-MIinserter#" .. inputX .. "_".. inputY .. ":" .. outputX .. "_" .. outputY .. (game.player.gui.center.goldenframe.checkboxNear.state and "#near" or "#far")
      placeInserter(oldGoldenAttributes)
      exitGoldenGui()
    end
  end
end)