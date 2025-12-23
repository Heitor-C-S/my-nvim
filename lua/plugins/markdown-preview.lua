-- ~/.config/nvim/lua/plugins/markdown-preview.lua
return {
  "toppair/peek.nvim",
  event = { "VeryLazy" },
  build = "deno task --quiet build:fast",
  config = function()
    require("peek").setup({
      auto_load = true,
      app = "browser",
      port = 3001,  -- CHANGE THIS to your available port
    })
    vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
  end,
}
