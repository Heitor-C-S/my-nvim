return {
  -- Session management (saves everything including Neotree state)
  {
    "rmagatti/auto-session",
    lazy = false,
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      local auto_session = require("auto-session")

      -- Create sessions directory if it doesn't exist
      local session_dir = vim.fn.stdpath("data") .. "\\sessions"
      vim.fn.mkdir(session_dir, "p")

      auto_session.setup({
        log_level = "error",
        auto_session_root_dir = session_dir,
        auto_session_suppress_dirs = { "~/", "~/Downloads", "/" },
        auto_session_use_git_branch = true,
        auto_session_enable_last_session = false,
        bypass_save_filetypes = { "alpha", "dashboard" },
        pre_save_cmds = { "Neotree close" },
        post_restore_cmds = { "Neotree filesystem show" },
      })

      -- Telescope integration (corrected)
      vim.keymap.set("n", "<leader>sss", function()
        local has_telescope, telescope = pcall(require, "telescope")
        if has_telescope then
          telescope.extensions["session-lens"].search_session()
        else
          vim.notify("Telescope not found", vim.log.levels.ERROR)
        end
      end, { desc = "[S]earch [S]e[s]sions" })

      -- Delete current session
      vim.keymap.set("n", "<leader>sd", function()
        auto_session.DeleteSession()
      end, { desc = "Delete current session" })

      -- Manual restore with better error handling
      vim.keymap.set("n", "<leader>sr", function()
        local session_name = auto_session.get_session_name()
        if session_name and session_name ~= "" then
          vim.cmd("AutoSession restore")
        else
          vim.notify("No session found for this directory", vim.log.levels.INFO)
        end
      end, { desc = "Restore session manually" })
    end,
  },

{
  "goolord/alpha-nvim",
  dependencies = {
    "echasnovski/mini.icons",
  },

  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    dashboard.section.header.val = {
      [[ ⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⣀⣀⣀⣀⠀⡀⢀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ]],
      [[ ⣶⣶⣶⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⣽⠃⠀⠀⠀⢼⠻⣿⣿⣟⣿⣿⣿⣿⣶⣶⣶⣶⣤⣤⣤⣤⣤ ]],
      [[ ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠏⠀⠀⠛⡶⢶⢺⠁⠀⠈⢿⣿⣿⣿⣿⣿⣿⣏⣿⣿⣿⣿⣿⣿⣿ ]],
      [[ ⣯⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠀⠀⣤⠀⣀⣠⡛⣣⡀⠀⠈⢿⣿⣿⣻⣏⣿⣿⣿⣿⣿⣿⣟⣿⠿ ]],
      [[ ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠃⠀⠀⣳⣶⣿⣿⣷⣾⠱⠀⠀⠊⢿⠿⠿⢛⣽⣿⡿⢿⣿⣟⠿⠿⠿ ]],
      [[ ⠉⠉⠉⠛⠛⠛⠋⠛⠛⠛⣧⠀⡀⠀⠀⢿⣿⣿⡿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠅⢀⢀⡀ ]],
      [[ ⠔⠄⢀⡀⠀⠀⠀⠄⠐⠸⠿⡀⠀⠀⠀⢘⣿⢷⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⠀⠰⣠⣇ ]],
      [[ ⣷⣆⣴⣮⢻⡲⡲⠀⠁⠀⠀⠀⠀⠀⠀⠹⡿⠘⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣀⡘⢷⣏ ]],
      [[ ⣿⣿⣿⣗⠿⢈⠁⡀⠀⠁⠀⠀⠀⠀⠀⠀⠉⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠠⢀⠄⠀⠄⠈⢿⣮⢿ ]],
      [[ ⣿⣟⡿⣾⠀⠀⠀⠀⠀⠀⠀⢀⡤⠄⠀⠀⠀⠀⠸⠁⢠⣦⣤⢀⠀⠀⠀⠀⠀⠀⠀⠀⠐⠀⠈⣿⠀ ]],
      [[ ⣿⣿⠏⠁⢀⡇⠀⠀⠀⠀⠀⠀⡄⠀⠀⠀⠘⡏⣷⣵⡻⠃⠄⢴⣆⠀⠀⠀⠀⠀⠀⠀⠰⠀⣆⣷⣿ ]],
      [[ ⣿⡿⣻⠗⠀⢠⠀⠀⠀⠀⠀⠃⠀⠀⠀⠀⢠⣤⣄⢰⣶⢯⣤⡈⠋⠀⠀⠀⠀⠀⠀⠀⠀⠆⠀⣿⣼ ]],
    }

    dashboard.section.buttons.val = {
      -- dashboard.button("e", "  > New file", ":ene <BAR> startinsert <CR>"),
      dashboard.button("b", "λ  > Browse files", ":Yazi<CR>"),
      dashboard.button("z", "λ  > Browse Directories", ":Telescope zoxide list<CR>"),
      dashboard.button("f", "λ  > Find file", ":Telescope find_files<CR>"),
      dashboard.button("r", "λ  > Recent", ":Telescope oldfiles<CR>"),
    }

    alpha.setup(dashboard.opts)
  end,
},

  -- Optional: Projects extension for Telescope
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup({
        manual_mode = false,
        detection_methods = { "pattern", "lsp" },
        patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
      })
      -- Load telescope extension safely
      vim.defer_fn(function()
        local has_telescope, telescope = pcall(require, "telescope")
        if has_telescope then
          telescope.load_extension("projects")
        end
      end, 100)
    end,
  },
}
