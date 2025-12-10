-- C:\Users\heito\AppData\Local\nvim\lua\plugins\neotree.lua
return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  config = function()
    require('neo-tree').setup {
      close_if_last_window = false,
      popup_border_style = 'rounded',
      enable_git_status = true,
      enable_diagnostics = true,
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },
      window = {
        position = 'left',
        width = 40,
        mappings = {
          ['<space>'] = { 'toggle_node', nowait = false },
          ['<cr>'] = 'open',
          ['s'] = 'open_vsplit',
          ['t'] = 'open_tabnew',
          ['w'] = 'open_with_window_picker',
          ['C'] = 'close_node',
          ['z'] = 'close_all_nodes',
          ['R'] = 'refresh',
          ['a'] = { 'add', config = { show_path = 'none' } },
          ['d'] = 'delete',
          ['r'] = 'rename',
          ['y'] = 'copy_to_clipboard',
          ['x'] = 'cut_to_clipboard',
          ['p'] = 'paste_from_clipboard',
          ['q'] = 'close_window',
          ['/'] = 'fuzzy_finder',
          ['D'] = 'fuzzy_finder_directory',
          ['f'] = 'filter_on_submit',
          ['<c-x>'] = 'clear_filter',
        },
      },
    }

    -- Atalhos
    vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>', { noremap = true, silent = true })
    vim.keymap.set('n', '<leader>nr', function()
      require('neo-tree.command').execute({ dir = vim.fn.expand('%:p:h') })
    end, { desc = 'Neo-tree root' })
  end,
}
