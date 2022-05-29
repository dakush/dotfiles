require("impatient")

-- Installed language servers
local servers = { "clangd", "tsserver", "jsonls", "pyright", "bashls", "html", "cssls" }

-- Smooth scroll
require("neoscroll").setup()

-------------------------------------------------------------------------
-------------------------------  TREESITTER -----------------------------
-------------------------------------------------------------------------
require("nvim-treesitter.configs").setup({
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<CR>",
			scope_incremental = "<CR>",
			node_incremental = "<TAB>",
			node_decremental = "<S-TAB>",
		},
	},
})

-------------------------------------------------------------------------
-----------------------------------  LSP --------------------------------
-------------------------------------------------------------------------
---- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local lspconfig = require("lspconfig")
for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
		-- flags = {
		-- This will be the default in neovim 0.7+
		-- debounce_text_changes = 150,
		-- },
	})
end

--Enable (broadcasting) snippet capability for completion with html and CSS LSP servers
capabilities.textDocument.completion.completionItem.snippetSupport = true
require("lspconfig").html.setup({
	capabilities = capabilities,
})
require("lspconfig").cssls.setup({
	capabilities = capabilities,
})

-------------------------------------------------------------------------
----------------------------- FORMATTER ---------------------------------
-------------------------------------------------------------------------
-- Utilities for creating configurations
local util = require("formatter.util")

require("formatter").setup({
	filetype = {
		-- Pick from defaults:
		javascript = {
			require("formatter.filetypes.javascript").prettier,
		},
		json = {
			require("formatter.filetypes.json").prettier,
		},
		typescript = {
			require("formatter.filetypes.typescript").prettier,
		},
		html = {
			require("formatter.filetypes.html").prettier,
		},
		css = {
			require("formatter.filetypes.css").prettier,
		},
		lua = {
			require("formatter.filetypes.lua").stylua,
		},
		sh = {
			-- Shell Script Formatter
			function()
				return {
					exe = "shfmt",
					-- indent switch cases, simplify the code, indent with 4 spaces, dialect=bash
					args = { "-ci", "-s", "-i", 4, "-ln", "bash" },
					stdin = true,
				}
			end,
		},
		--[[ javascript = {
			-- prettier
			function()
				return {
					exe = "prettier",
					args = { "--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), "--single-quote" },
					stdin = true,
				}
			end,
		},
		json = {
			function()
				return {
					exe = "prettier",
					args = { "--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), "--double-quote" },
					stdin = true,
				}
			end,
		},
		lua = {
			function()
				return {
					exe = "stylua",
					args = {
						"--config-path " .. os.getenv("XDG_CONFIG_HOME") .. "/stylua/stylua.toml",
						"-",
					},
					stdin = true,
				}
			end,
		}, ]]
	},
})

-------------------------------------------------------------------------
-------------------------------- COMPLETION -----------------------------
-------------------------------------------------------------------------
-- local has_words_before = function()
-- 	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
-- 	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
-- end
local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
local luasnip = require("luasnip")
local cmp = require("cmp")

cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			luasnip.lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	window = {
		-- completion = cmp.config.window.bordered(),
		-- documentation = cmp.config.window.bordered(),
	},
	mapping = {
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		-- ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
		-- ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
		-- ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		-- ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
		-- ["<C-e>"] = cmp.mapping({
		-- 	i = cmp.mapping.abort(),
		-- 	c = cmp.mapping.close(),
		-- }),
		["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		--[[ ["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }), ]]
		-- Super-tab behaviour (from nvim-cmp wiki)
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" }, -- For luasnip users.
		{ name = "treesitter" },
		{ name = "buffer" },
		{ name = "path" },
	}),
})

-- Set configuration for specific filetype.
-- cmp.setup.filetype("gitcommit", {
-- 	sources = cmp.config.sources({
-- 		{ name = "buffer" },
-- 	}),
-- })

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

-------------------------------------------------------------------------
-------------------------------- LUASNIP --------------------------------
-------------------------------------------------------------------------
require("luasnip").config.set_config({
	history = true,
	updateevents = "TextChanged,TextChangedI",
	enable_autosnippets = true,
})
require("luasnip.loaders.from_vscode").load()

require("neogen").setup({ snippet_engine = "luasnip" })

-------------------------------------------------------------------------
------------------------------ LIGHTSPEED ------------------------------
-------------------------------------------------------------------------
require("lightspeed").setup({
	ignore_case = false,
	exit_after_idle_msecs = { unlabeled = 1000, labeled = nil },
	--- s/x ---
	jump_to_unique_chars = { safety_timeout = 400 },
	match_only_the_start_of_same_char_seqs = true,
	force_beacons_into_match_width = false,
	-- Display characters in a custom way in the highlighted matches.
	substitute_chars = { ["\r"] = "¬" },
	-- Leaving the appropriate list empty effectively disables "smart" mode,
	-- and forces auto-jump to be on or off.
	--safe_labels = { . . . },
	--labels = { . . . },
	-- These keys are captured directly by the plugin at runtime.
	special_keys = {
		next_match_group = "<space>",
		prev_match_group = "<tab>",
	},
	--- f/t ---
	limit_ft_matches = 4,
	repeat_ft_with_target_char = false,
})

-------------------------------------------------------------------------
------------------------------- TELESCOPE -------------------------------
-------------------------------------------------------------------------
-- You dont need to set any of these options. These are the default ones. Only
-- the loading is important
require("telescope").setup({
	defaults = {
		-- Default configuration for telescope goes here:
		-- See :help telescope.default.mappings
		mappings = {
			i = {
				-- map actions.which_key to <C-h> (default: <C-/>)
				-- actions.which_key shows the mappings for your picker,
				-- e.g. git_{create, delete, ...}_branch for the git_branches picker
				["<C-j>"] = "move_selection_next",
				["<C-k>"] = "move_selection_previous",
			},
		},
	},
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
	},
})
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require("telescope").load_extension("fzf")

-------------------------------------------------------------------------
-------------------------------- LUALINE --------------------------------
-------------------------------------------------------------------------
local function window()
	return " " .. vim.api.nvim_win_get_number(0)
end

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = "",
		section_separators = "",
		disabled_filetypes = {},
		always_divide_middle = true,
		globalstatus = false,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = {
			window,
			{ "filename", path = 1, symbols = { modified = " ", readonly = " ", unnamed = "NEW FILE " } },
		},
		lualine_x = { "lsp_progress", "require'lsp-status'.status()" },
		lualine_y = { "encoding", "fileformat", "filetype" },
		lualine_z = { "progress", "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {
			window,
			{ "filename", path = 1, symbols = { modified = " ", readonly = " ", unnamed = "NEW FILE " } },
		},
		lualine_x = {},
		lualine_y = {},
		lualine_z = { "location" },
	},
	tabline = {},
	extensions = {},
})

-------------------------------------------------------------------------
-------------------------------- OTHERS --------------------------------
-------------------------------------------------------------------------
require("Comment").setup({
	---Add a space b/w comment and the line
	---@type boolean
	padding = true,

	---Whether the cursor should stay at its position
	---NOTE: This only affects NORMAL mode mappings and doesn't work with dot-repeat
	---@type boolean
	sticky = true,

	---Lines to be ignored while comment/uncomment.
	---Could be a regex string or a function that returns a regex string.
	---Example: Use '^$' to ignore empty lines
	---@type string|fun():string
	ignore = nil,

	---LHS of toggle mappings in NORMAL + VISUAL mode
	---@type table
	toggler = {
		---Line-comment toggle keymap
		line = "ñcc",
		---Block-comment toggle keymap
		block = "ñbc",
	},

	---LHS of operator-pending mappings in NORMAL + VISUAL mode
	---@type table
	opleader = {
		---Line-comment keymap
		line = "ñc",
		---Block-comment keymap
		block = "ñb",
	},

	---LHS of extra mappings
	---@type table
	extra = {
		---Add comment on the line above
		above = "ñcO",
		---Add comment on the line below
		below = "ñco",
		---Add comment at the end of line
		eol = "ñcA",
	},

	---Create basic (operator-pending) and extended mappings for NORMAL + VISUAL mode
	---@type table
	mappings = {
		---Operator-pending mapping
		---Includes `gcc`, `gbc`, `gc[count]{motion}` and `gb[count]{motion}`
		---NOTE: These mappings can be changed individually by `opleader` and `toggler` config
		basic = true,
		---Extra mapping
		---Includes `gco`, `gcO`, `gcA`
		extra = true,
		---Extended mapping
		---Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
		extended = false,
	},

	---Pre-hook, called before commenting the line
	---@type fun(ctx: Ctx):string
	pre_hook = nil,

	---Post-hook, called after commenting is done
	---@type fun(ctx: Ctx)
	post_hook = nil,
})

require("scrollbar").setup()
