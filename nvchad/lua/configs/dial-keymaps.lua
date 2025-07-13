return {
  {
    "<C-a>",
    function()
      return require("dial.map").manipulate("increment", "normal")
    end,
    desc = "Increment",
    mode = { "n", "v" },
  },
  {
    "<C-x>",
    function()
      return require("dial.map").manipulate("decrement", "normal")
    end,
    desc = "Decrement",
    mode = { "n", "v" },
  },
  {
    "g<C-a>",
    function()
      return require("dial.map").manipulate("increment", "normal")
    end,
    desc = "Increment",
    mode = { "n", "v" },
  },
  {
    "g<C-x>",
    function()
      return require("dial.map").manipulate("decrement", "normal")
    end,
    desc = "Decrement",
    mode = { "n", "v" },
  },
}
