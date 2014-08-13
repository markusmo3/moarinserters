data:extend(
{
  {
    type = "recipe",
    name = "moar-inserters-wrench",
    enabled = "true",
    ingredients =
    {
      {"iron-gear-wheel", 5},
      {"iron-plate", 5}
    },
    result = "moar-inserters-wrench"
  },
  {
    type = "item",
    name = "moar-inserters-wrench",
    icon = "__MoarInserters__/graphics/icons/moar-inserters-wrench.png",
    flags = {"goes-to-quickbar"},
    subgroup = "moarinserters-tools",
    order = "moar-inserters-wrench",
    stack_size = 1
  }
}
)
