return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        -- 🔴 ESSENCIAL: NUNCA compile localmente
        auto_install = false,
        sync_install = false,
        ignore_install = { "latex", "help", "c", "cpp" },
        

        ensure_installed = {
          "lua", "vim", "vimdoc", "query", "javascript", "typescript", "python", "html", "css", "json"
        },
        
        highlight = {
          enable = true,
          -- 🔴 DESATIVE regex adicional (causa erros no Windows)
          additional_vim_regex_highlighting = false,
          -- 🔴 Use apenas highlights do Tree-sitter
          disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
        },
        
        indent = { 
          enable = true,
          disable = { "lua" } -- 🔴 Desative para lua se ainda der erro
        },
      })
    end,
  },
}