return {
  "williamboman/mason-lspconfig.nvim",
  -- Garante que o 'mason' e 'lspconfig' carreguem antes
  dependencies = {
    "williamboman/mason.nvim",
    "neovim/nvim-lspconfig",
  },
  config = function()
    -- Esta função configura o mason-lspconfig
    require("mason-lspconfig").setup({
      -- Lista de servidores que o Mason deve instalar automaticamente
      ensure_installed = {
        "tsserver",
        "pyright",
      },
      -- Esta é a configuração padrão para iniciar CADA servidor
      handlers = {
        function(server_name)
          require("lspconfig")[server_name].setup({})
        end,
      },
    })
  end,
}