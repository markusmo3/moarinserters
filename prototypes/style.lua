data.raw["gui-style"]["default"].button_style_mi_default = 
  {
    type = "button_style",
    parent = "button_style",
    font = "default",
    width = 50,
    height = 50,
    left_click_sound =
    {
      {
        filename = "__core__/sound/gui-click.ogg",
        volume = 1
      }
    }
  }
  
data.raw["gui-style"]["default"].button_style_mi_green =   
  {
    type = "button_style",
    parent = "button_style_mi_default",
    default_graphical_set =
    {
      type = "composition",
      filename = "__MoarInserters__/graphics/gui.png",
      corner_size = {3, 3},
      position = {0, 0}
    },
  }
  
data.raw["gui-style"]["default"].button_style_mi_blue = 
  {
    type = "button_style",
    parent = "button_style_mi_default",
    default_graphical_set =
    {
      type = "composition",
      filename = "__MoarInserters__/graphics/gui.png",
      corner_size = {3, 3},
      position = {8, 0}
    },
  }