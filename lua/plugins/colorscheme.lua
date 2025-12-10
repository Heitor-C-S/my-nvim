return {
  { "vim-scripts/newsprint.vim" },
  { "gbprod/nord.nvim" },
  { "slugbyte/lackluster.nvim" },
  { "vim-scripts/zenesque.vim" },
  { "jaredgorski/fogbell.vim" },
  { "oahlen/iceberg.nvim" },
  { "Skardyy/makurai-nvim" },
  { "ellisonleao/gruvbox.nvim" },
  { "jnurmine/Zenburn" },
  {
    "sainnhe/gruvbox-material",
    config = function()
      vim.g.gruvbox_material_background = "hard"
    end,
  },
  {
    "blazkowolf/gruber-darker.nvim",
    opts = {
      bold = false,
    },
  }, -- <--- CORREÇÃO 1: Adicionada a vírgula que faltava aqui
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        integrations = {
          treesitter = true,
          native_lsp = { enabled = true },
          cmp = true,
          gitsigns = true,
          telescope = true,
          notify = false,
          mini = false,
        },
      })
    end, -- <--- CORREÇÃO 2: Adicionado o 'end' que faltava para fechar a função
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    transparent = true, -- Sua configuração de transparência
    priority = 1000,
    opts = {},
    config = function()
      -- CORREÇÃO LÓGICA: Comentei esta linha para não carregar o TokyoNight
      -- e deixar o Vague funcionar.
      -- vim.cmd([[colorscheme tokyonight-night]]) 
    end,
  },
  {
    "zenbones-theme/zenbones.nvim",
    dependencies = "rktjmp/lush.nvim",
    lazy = false,
    priority = 1000,
    italic = false,
  },
  {
    "vague2k/vague.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("vague").setup({
        transparent = true, -- Sua configuração de transparência
        style = {
          boolean = "none",
          number = "none",
          float = "none",
          error = "none",
          comments = "none",
          conditionals = "none",
          functions = "none",
          headings = "bold",
          operators = "none",
          strings = "none",
          variables = "none",
          keywords = "none",
          keyword_return = "none",
          keywords_loop = "none",
          keywords_label = "none",
          keywords_exception = "none",
          builtin_constants = "none",
          builtin_functions = "none",
          builtin_types = "none",
          builtin_variables = "none",
        },
        colors = {
          bg = "none",
        },
      })
      -- CORREÇÃO 3: Comando para efetivamente aplicar o tema Vague
      vim.cmd.colorscheme("vague")
    end,
  },
}
