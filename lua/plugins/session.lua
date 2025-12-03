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

  -- Dashboard for startup
  {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      dashboard.section.header.val = {
        "                                                     ",
        "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
        "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
        "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
        "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
        "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
        "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
        "                                                     ",
      }

      dashboard.section.buttons.val = {
        dashboard.button("n", "  New file", "<cmd>ene<CR>"),
        dashboard.button("f", "󰈞  Find file", "<cmd>Telescope find_files<CR>"),
        dashboard.button("r", "  Recent files", "<cmd>Telescope oldfiles<CR>"),
        dashboard.button("s", "󰑓  Restore session", "<cmd>AutoSession restore<CR>"),
        dashboard.button("p", "󰉋  Projects", function()
          local has_telescope, telescope = pcall(require, "telescope")
          if has_telescope then
            telescope.extensions.projects.projects({})
          end
        end),
        dashboard.button("c", "  Configuration", "<cmd>edit ~/.config/nvim/<CR>"),
        dashboard.button("q", "󰅚  Quit", "<cmd>qa<CR>"),
      }

      dashboard.section.footer.val = "Neovim"

      alpha.setup(dashboard.config)

      -- Auto-open dashboard when no file is opened
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          if vim.fn.argc() == 0 then
            alpha.start(true)
          end
        end,
      })
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
