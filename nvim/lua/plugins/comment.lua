return {
  "numToStr/Comment.nvim",
  -- Event to lazy-load on: since commenting is common, 'VeryLazy' works well
  -- You can also use 'keys' to load when a comment key is pressed:
  -- lazy = false, -- or
  -- event = 'VeryLazy',

  dependencies = {
    -- Recommended for language-specific, context-aware commenting
    "JoosepAlviste/nvim-ts-context-commentstring",
  },

  config = function()
    -- 1. Setup nvim-ts-context-commentstring first
    require("ts_context_commentstring").setup({
      enable_autocmd = false, -- Use Comment.nvim's 'custom_commentstring' instead
    })

    -- 2. Setup Comment.nvim
    require("Comment").setup({
      -- Add a space between comment and the line
      padding = true,
      -- Whether the cursor should stay at its position
      sticky = true,
      -- LHS of toggle mappings in NORMAL mode
      toggler = {
        line = "gcc", -- Toggle current line
        block = "gbc", -- Toggle current line with block comments
      },
      -- LHS of toggle mappings in VISUAL mode
      opleader = {
        line = "gc", -- Use gc[motion] to comment a motion (e.g., gcw)
        block = "gb", -- Use gb[motion] to block comment a motion
      },
      -- Custom function to determine the comment string
      -- This enables Treesitter-aware commenting via the dependency
      extra = {
        extra_commentstring = require("ts_context_commentstring").calculate_commentstring,
      },
    })
  end,
}
