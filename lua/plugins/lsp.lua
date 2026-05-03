-- lua/plugins/lsp.lua
return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
      "folke/lazydev.nvim", -- Garante que o lazydev carregue antes do LSP
    },
    config = function()
      local lspconfig = require("lspconfig")
      local mason_lspconfig = require("mason-lspconfig")
      local capabilities = vim.lsp.protocol.make_client_capabilities()

      -- Integração com nvim-cmp (autocompletar)
      local ok, cmp = pcall(require, "cmp_nvim_lsp")
      if ok then
        capabilities = cmp.default_capabilities(capabilities)
      end

      mason_lspconfig.setup({
        ensure_installed = { "lua_ls", "clangd", "pyright", "ts_ls", "html", "cssls" },
        handlers = {
          -- Handler padrão
          function(server_name)
            lspconfig[server_name].setup({
              capabilities = capabilities,
            })
          end,

          ["ts_ls"] = function()
            return
          end,
          -- Configuração do Lua LS simplificada
          -- O lazydev.nvim vai injetar o "vim" global automaticamente aqui
          ["lua_ls"] = function()
            lspconfig.lua_ls.setup({
              capabilities = capabilities,
              settings = {
                Lua = {
                  diagnostics = {
                    globals = { "vim" },
                  },
                  telemetry = { enable = false },
                },
              },
            })
          end,
        },
      })
    end,
  },
}
