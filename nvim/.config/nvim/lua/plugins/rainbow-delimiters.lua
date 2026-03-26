return {
  "HiPhish/rainbow-delimiters.nvim",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    local rainbow = require("rainbow-delimiters")
    require("rainbow-delimiters.setup").setup({
      strategy = {
        [""] = rainbow.strategy["global"],
        python = rainbow.strategy["global"],
      },
      query = {
        [""] = "rainbow-delimiters",
        python = "rainbow-delimiters",
      },
      highlight = {
        "RainbowCyan",
        "RainbowGreen",
        "RainbowBlue",
        "RainbowYellow",
        "RainbowViolet",
        "RainbowOrange",
        "RainbowRed",
      },
    })
  end,
}
