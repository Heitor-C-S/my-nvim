return {
  {
    "Heitor-C-S/todo",
    dir = vim.fn.stdpath("config"),
    lazy = false,
    config = function()
      require("todo").setup({
        target_file = "~/AppData/Local/nvim/todo.md",
      })
    end,
    }
  }
