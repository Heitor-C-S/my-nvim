return {
	-- Session management (saves everything including Neotree state)
	{
		"rmagatti/auto-session",
		lazy = false,
		keys = {
			-- <leader>qs (Quick Session) para buscar sessões
			{ "<leader>qs", "<cmd>AutoSession search<cr>", desc = "Buscar Sessão (Session Lens)" },
			-- <leader>qw (Quick Write) para salvar manualmente
			{ "<leader>qw", "<cmd>AutoSession save <cr>", desc = "Salvar Sessão Atual" },
		},

		---enables autocomplete for opts
		---@module "auto-session"
		---@type AutoSession.Config
		opts = {
			-- Configuração corrigida de diretórios suprimidos para Windows
			suppressed_dirs = { "~/", "~/Downloads", "C:/", "~/Windows" },

			-- log_level = 'debug',
			defaults = {
				-- Saving / restoring
				enabled = true,
				auto_save = true,
				auto_restore = true,
				auto_create = true,
				auto_restore_last_session = false,
				cwd_change_handling = false,
				single_session_mode = false,

				-- Filtering
				-- suppressed_dirs = nil, -- Removido pois já definimos no nível superior (opts.suppressed_dirs)
				allowed_dirs = nil,

				-- CORREÇÃO: Adicionado chaves {} ao redor da lista
				bypass_save_filetypes = { "alpha", "neotree" },

				close_filetypes_on_save = { "checkhealth" },
				close_unsupported_windows = true,
				preserve_buffer_on_restore = nil,

				-- Git / Session naming
				git_use_branch_name = false,
				git_auto_restore_on_branch_change = false,
				custom_session_tag = nil,

				-- Deleting
				auto_delete_empty_sessions = true,
				purge_after_minutes = nil,

				-- Saving extra data
				save_extra_data = nil,
				restore_extra_data = nil,

				-- Argument handling
				args_allow_single_directory = true,
				args_allow_files_auto_save = false,

				-- Misc
				log_level = "error",
				root_dir = vim.fn.stdpath("data") .. "/sessions/",
				show_auto_restore_notif = false,
				restore_error_handler = nil,
				continue_restore_on_error = true,
				lsp_stop_on_restore = false,
				lazy_support = true,
				legacy_cmds = true,

				---@type SessionLens
				session_lens = {
					picker = "telescope",
					load_on_setup = true,
					picker_opts = {
						border = true,
						layout_config = {
							width = 0.8,
							height = 0.5,
						},
					},
					previewer = "summary",

					---@type SessionLensMappings
					mappings = {
						delete_session = { "i", "<C-d>" },
						alternate_session = { "i", "<C-s>" },
						copy_session = { "i", "<C-y>" },
					},

					---@type SessionControl
					session_control = {
						control_dir = vim.fn.stdpath("data") .. "/auto_session/",
						control_filename = "session_control.json",
					},
				},
			},
		},
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
				[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
				[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣿⣿⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
				[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⣿⣿⣿⣷⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
				[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣴⣾⣿⣿⣿⣿⣿⣿⣿⣿⣷⣦⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
				[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣴⣿⣿⣿⣿⡿⠟⠋⠀⠀⠙⠻⢿⣿⣿⣿⣿⣦⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
				[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⣾⣿⣿⣿⣿⡿⠛⠉⠀⠀⠀⢠⡄⠀⠀⠀⠉⠻⢿⣿⣿⣿⣿⣷⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
				[[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⣿⣿⣿⠿⠛⠁⠀⠀⠀⠀⢀⣰⣿⣿⣦⡀⠀⠀⠀⠀⠈⠛⠿⣿⣿⣿⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]],
				[[⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⠀⢿⣿⡟⠁⠀⠀⠀⠀⢀⣤⣾⣿⡿⠟⠻⢿⣿⣷⣤⡀⠀⠀⠀⠀⠈⢻⣿⡷⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀]],
				[[⠀⠀⣀⣀⣀⣤⣴⣾⣿⠇⠀⢸⡿⠀⠀⠀⣠⣴⣾⣿⡿⠟⠉⠀⠀⠀⠀⠉⠻⢿⣿⣷⣦⣄⠀⠀⠀⢿⡃⠀⠸⣿⣷⣦⣤⣀⣀⣀⡀]],
				[[⠀⠀⠙⢿⣿⡿⠟⠉⠀⠀⠀⠀⢧⠀⠀⠀⣿⡿⠛⠁⠀⠀⠀⣠⣾⣷⣄⠀⠀⠀⠈⠛⢿⣿⠀⠀⠀⡼⠀⠀⠀⠀⠉⠻⢿⣿⡿⠋⠀]],
				[[⠀⠀⠀⠀⢻⣧⠀⠀⠲⣶⠾⠀⠈⠄⠀⠀⢻⠁⠀⢀⣠⣴⡼⠟⠋⠙⠻⢷⣦⣄⡀⠀⠈⡛⠀⠀⠠⠁⠀⠷⣶⠖⠀⠀⣼⡟⠀⠀⠀]],
				[[⠀⠀⠀⠀⠀⢻⣆⠀⠀⠸⡆⠀⠀⠀⠀⠀⠈⠀⠀⣾⠟⠉⠀⠀⠀⠀⠀⠀⠉⠻⣿⠀⠀⠁⠀⠀⠀⠀⠀⢰⠇⠀⠀⣰⡟⠀⠀⠀⠀]],
				[[⠀⠀⠀⠀⠀⠀⢿⣄⠀⠀⠩⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⠏⠀⠀⣠⡿⠀⠀⠀⠀⠀]],
				[[⠀⠀⠀⠀⠀⠀⠈⣿⣦⠀⠀⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⠀⣴⣿⠁⠀⠀⠀⠀⠀]],
				[[⠀⠀⠀⠀⠀⠀⠀⠀⠈⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠁⠀⠀⠀⠀⠀⠀⠀]],
			}
			dashboard.section.buttons.val = {
				-- dashboard.button("e", "  > New file", ":ene <BAR> startinsert <CR>"),
				dashboard.button("b", "λ  > Browse files", ":Yazi<CR>"),
				dashboard.button("z", "λ  > Browse Directories", ":Telescope zoxide list<CR>"),
				dashboard.button("f", "λ  > Find file", ":Telescope find_files<CR>"),
				dashboard.button("r", "λ  > Recent", ":Telescope oldfiles<CR>"),
				dashboard.button("s", "λ  > Search Sessions", ":AutoSession search<CR>"),
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
