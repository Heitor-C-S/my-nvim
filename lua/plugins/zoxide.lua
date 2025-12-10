return {
  {
    "jvgrootveld/telescope-zoxide",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/popup.nvim",
    },
    config = function()
      -- Isso carrega a extensão zoxide dentro do Telescope
      require("telescope").load_extension("zoxide")
      
      -- Configuração opcional para mapeamentos dentro da janela do zoxide
      local z_utils = require("telescope._extensions.zoxide.utils")
      require("telescope").setup({
        extensions = {
          zoxide = {
            prompt_title = "[ Meus Diretórios (Zoxide) ]",
            mappings = {
              default = {
                after_action = function(selection)
                  print("Diretório alterado para " .. selection.path)
                end
              },
            },
          },
        },
      })
    end,
    -- Define o atalho <leader>z para abrir a lista
    keys = {
      { "<leader>z", "<cmd>Telescope zoxide list<cr>", desc = "Mudar diretório (Zoxide)" },
    },
  },
}
