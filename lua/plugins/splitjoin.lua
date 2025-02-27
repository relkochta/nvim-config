return {
  {
    'echasnovski/mini.splitjoin',
    version = false,
    keys = {
      { "gS", function() require("mini.splitjoin").toggle() end, desc = "Toggle splitjoin" },
    },
    opts = {
      mappings = {
        toggle = '',
        split = '',
        join = '',
      },
    },
  },
}
