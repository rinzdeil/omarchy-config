return {
  -- 1. nvim-lspconfig: The core LSP setup
  {
    "neovim/nvim-lspconfig",
    -- Your general LSP on_attach function or capabilities can go here.
    -- E.g., setting up keymaps, or passing capabilities from nvim-cmp.
    config = function()
      -- Example of setting up an event to configure common settings on attach
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          -- Set keymaps only for the LSP buffer
          local opts = { buffer = ev.buf }
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          -- ... other keymaps
        end,
      })

      -- You do NOT need to call 'lspconfig.server_name.setup({})' for servers
      -- managed by mason-lspconfig unless you need custom configuration.
    end,
  },

  -- 2. mason.nvim: The package manager
  {
    "mason-org/mason.nvim",
    cmd = "Mason",
    opts = {
      -- Optional configuration for mason itself
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },

  -- 3. mason-lspconfig.nvim: Bridge between mason and lspconfig
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      -- A list of servers to ensure are installed upon first setup.
      ensure_installed = {
        "lua_ls",
        "bashls",
        "html",
        "cssls",
        -- Add any other LSP servers you want
      },

      -- Set to true to automatically enable installed servers via vim.lsp.enable()
      automatic_enable = true,
    },
  },
}
