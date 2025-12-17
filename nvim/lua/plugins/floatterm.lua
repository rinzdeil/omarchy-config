return {
  {
    "voldikss/vim-floaterm",
    -- Load the plugin only when one of its commands is used
    cmd = { "FloatermToggleBottom", "FloatermToggleRight", "FloatermKill" },

    init = function()
      local function toggle_floaterm(position, width, height)
        local name = "ft-" .. position
        local cmd = string.format(
          "FloatermToggle --name=%s --position=%s --width=%.1f --height=%.1f",
          name,
          position,
          width,
          height
        )

        vim.cmd(cmd)
      end

      vim.api.nvim_create_user_command("FloatermToggleBottom", function()
        toggle_floaterm("bottom", 1.0, 0.3) -- Full width, 30% height
      end, {})

      vim.api.nvim_create_user_command("FloatermToggleRight", function()
        toggle_floaterm("right", 0.4, 1.0) -- 40% width, full height
      end, {})
    end,

    keys = {
      { "<leader>tB", "<cmd>FloatermToggleBottom<cr>", desc = "Toggle Terminal (Bottom)" },

      { "<leader>tR", "<cmd>FloatermToggleRight<cr>", desc = "Toggle Terminal (Right)" },

      { "<leader>tK", "<cmd>FloatermKill<cr>", desc = "Kill current Floaterm" },
    },
  },
}
