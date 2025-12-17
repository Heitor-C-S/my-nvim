return {
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
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
		require("telescope").setup({
			defaults = {
				file_ignore_patterns = {
					"node_modules",
					"%.git",
				},
			},

			-- START CHANGE: Configuração para terminais
			-- START CHANGE: Configuração CORRIGIDA para terminais
			pickers = {
				terminals = {
					attach_mappings = function(_, map)
						local actions = require("telescope.actions")
						local action_state = require("telescope.actions.state")

						-- Ação padrão (abrir terminal)
						map("i", "<CR>", function(prompt_bufnr)
							local selection = action_state.get_selected_entry()
							if selection and selection.bufnr then
								actions.close(prompt_bufnr)
								vim.api.nvim_set_current_buf(selection.bufnr)
							end
						end)

						-- ATUALIZADO: <C-x> para excluir terminal inativo
						map("i", "<C-x>", function(prompt_bufnr)
							local selection = action_state.get_selected_entry()
							if not (selection and selection.bufnr) then
								vim.notify("Buffer não encontrado", vim.log.levels.ERROR)
								return
							end

							local bufnr = selection.bufnr

							-- Verifica se terminal está inativo (sem job_id ou job_id=0)
							local ok, job_id = pcall(vim.api.nvim_buf_get_var, bufnr, "terminal_job_id")

							-- FECHA O PICKER PRIMEIRO!
							actions.close(prompt_bufnr)

							-- Aguarda um pouco para garantir que o picker fechou
							vim.defer_fn(function()
								if not ok or not job_id or job_id == 0 then
									-- Tenta excluir o buffer do terminal inativo
									local success, err = pcall(vim.api.nvim_buf_delete, bufnr, { force = true })
									if success then
										vim.notify("✓ Terminal inativo removido", vim.log.levels.INFO)
									else
										vim.notify("✗ Erro: " .. tostring(err), vim.log.levels.ERROR)
									end
								else
									vim.notify("⚠ Terminal ainda ativo (job: " .. job_id .. ")", vim.log.levels.WARN)
								end
							end, 50) -- 50ms de delay é suficiente
						end)

						return true
					end,
				},
			},
			-- END CHANGE

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
				search_dirs = { home .. "/AppData/Local/nvim/gloss" },
			})
		end, { desc = "[S]earch [G]lossário" })

		vim.keymap.set("n", "<leader>fp", function()
			local root = "/mnt/c/Users/fabriciov/Desktop/Fabricio/projects"
			builtin.find_files({
				search_dirs = { root },
				prompt_title = "🔍 Projetos",
				cwd = root,
				path_display = { "truncate" },
			})
		end, { desc = "Buscar arquivos nos projetos" })

		vim.keymap.set("n", "<leader>/", function()
			builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				winblend = 10,
				previewer = false,
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

		-- START CHANGE: Novos atalhos para terminais

		-- Abre picker de terminais (todos, ativos e inativos)
		vim.keymap.set("n", "<leader>st", function()
			builtin.terminals()
		end, { desc = "[S]earch [T]erminais (Ctrl+d para excluir inativos)" })

		-- Comando para limpar TODOS os terminais inativos de uma vez
		vim.api.nvim_create_user_command("ClearDeadTerms", function()
			local count = 0
			for _, buf in pairs(vim.api.nvim_list_bufs()) do
				if vim.api.nvim_buf_get_option(buf, "buftype") == "terminal" then
					local ok, job_id = pcall(vim.api.nvim_buf_get_var, buf, "terminal_job_id")
					if not ok or not job_id or job_id == 0 then
						vim.api.nvim_buf_delete(buf, { force = true })
						count = count + 1
					end
				end
			end
			vim.notify(string.format("Removidos %d terminais inativos", count), vim.log.levels.INFO)
		end, { desc = "Remove todos os terminais finalizados" })

		-- Atalho rápido para limpar terminais mortos
		vim.keymap.set("n", "<leader>tc", ":ClearDeadTerms<CR>", { desc = "[T]erminal [C]lear inativos" })

		-- END CHANGE
	end,
}
