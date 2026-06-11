-- lua/plugins/telescope.lua
return {
  "nvim-telescope/telescope.nvim",
  event = "VimEnter",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-treesitter/nvim-treesitter" }, -- Mantido para evitar erros de carregamento
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },
    { "nvim-telescope/telescope-ui-select.nvim" },
    { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
  },
  config = function()
    -- -----------------------------------------------------------------------
    -- FIX DE COMPATIBILIDADE: TELESCOPE X TREESITTER
    -- Adicionado para resolver o erro "attempt to call field 'ft_to_lang' (a nil value)"
    -- -----------------------------------------------------------------------
    local ok, parsers = pcall(require, "nvim-treesitter.parsers")
    if ok and not parsers.ft_to_lang then
      parsers.ft_to_lang = parsers.get_buf_lang or function()
        return nil
      end
    end
    -- -----------------------------------------------------------------------

    require("telescope").setup({
      defaults = {
        preview = {
          treesitter = false,
        },
        file_ignore_patterns = {
          "node_modules",
          "%.git",
        },
      },
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown(),
        },
      },
    })

    pcall(require("telescope").load_extension, "fzf")
    pcall(require("telescope").load_extension, "ui-select")

    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
    vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
    vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
    vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
    vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
    vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
    vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
    vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
    vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
    vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

    vim.keymap.set("n", "<leader>sn", function()
      builtin.find_files({ cwd = vim.fn.stdpath("config") })
    end, { desc = "[S]earch [N]eovim files" })

    vim.keymap.set("n", "<leader>sgg", function()
      local home = vim.fn.expand("~")
      builtin.find_files({
        prompt_title = "📘 Meu Glossário Neovim",
        search_dirs = { home .. "/.config/nvim/gloss" },
      })
    end, { desc = "[S]earch [G]lossário" })

    -- vim.keymap.set("n", "<leader>fp", function()
    --    local root = "/mnt/c/Users/fabriciov/Desktop/Fabricio/projects"
    --    builtin.find_files({
    --      search_dirs = { root },
    --      prompt_title = "🔍 Projetos",
    --      cwd = root,
    --      path_display = { "truncate" },
    --    })
    -- end, { desc = "Buscar arquivos nos projetos" })

    vim.keymap.set("n", "<leader>/", function()
      builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        winblend = 10,
        previewer = false,
        -- ts_highlight = false, -- (Opcional: Com o fix acima, esta linha não é mais estritamente necessária, mas mal não faz)
      }))
    end, { desc = "[/] Fuzzily search in current buffer" })

    vim.keymap.set("n", "<leader>s/", function()
      builtin.live_grep({
        grep_open_files = true,
        prompt_title = "Live Grep in Open Files",
      })
    end, { desc = "[S]earch [/] in Open Files" })

    vim.keymap.set("n", "<leader>tc", function()
      require("telescope.builtin").colorscheme()
    end, { desc = "[T]elescope [C]olorschemes " })
  end,
}
