-- lua/plugins/lazydev.lua
return {
  {
    "folke/lazydev.nvim",
    ft = "lua", -- carrega apenas em arquivos lua
    opts = {
      library = {
        -- Carrega tipos do luvit quando a palavra `vim.uv` é encontrada
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },
  -- Dependência opcional para tipagem correta do sistema de arquivos (vim.uv)
  { "Bilal2453/luvit-meta", lazy = true },
}
