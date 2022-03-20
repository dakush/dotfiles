return require("packer").startup(function()
	-- Packer can manage itself
	use("dracula/vim")
	use("preservim/vim-colors-pencil")
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use("neovim/nvim-lspconfig") -- Collection of configurations for the built-in LSP client
	use("nvim-lua/lsp-status.nvim") -- LSP functions for the status line (e.g. lualine)
	use("arkav/lualine-lsp-progress") -- And yet another plugin for the lualine
	use("mhartington/formatter.nvim")

	-- Snippets
	use("L3MON4D3/LuaSnip")
	use("rafamadriz/friendly-snippets")

	-- Completion
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use({
		"hrsh7th/nvim-cmp",
		config = function()
			require("cmp").setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},

				sources = {
					{ name = "luasnip" },
					-- more sources
				},
			})
		end,
	})
	use("saadparwaiz1/cmp_luasnip")

	-- Dim unused variables
	use({
		"narutoxy/dim.lua",
		requires = { "nvim-treesitter/nvim-treesitter", "neovim/nvim-lspconfig" },
		config = function()
			require("dim").setup({})
		end,
	})

	-- Detect indentation automatically
	use({
		"nmac427/guess-indent.nvim",
		config = function()
			require("guess-indent").setup({})
		end,
	})

	-- Annotations (comments for functions)
	use({
		"danymat/neogen",
		config = function()
			require("neogen").setup({})
		end,
		requires = "nvim-treesitter/nvim-treesitter",
		-- Uncomment next line if you want to follow only stable versions
		-- tag = "*"
	})

	-- Comments
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})

	-- 2-letter movement
	use("ggandor/lightspeed.nvim")

	-- Stabilyze buffer position when opening a new window
	use({
		"luukvbaal/stabilize.nvim",
		config = function()
			require("stabilize").setup({
				force = true, -- stabilize window even when current cursor position will be hidden behind new window
				forcemark = nil, -- set context mark to register on force event which can be jumped to with '<forcemark>
				ignore = { -- do not manage windows matching these file/buftypes
					filetype = { "help", "list", "Trouble" },
					buftype = { "terminal", "quickfix", "loclist" },
				},
				nested = nil, -- comma-separated list of autocmds that wil trigger the plugins window restore function
			})
		end,
	})

	-- Scrollbar
	use("petertriho/nvim-scrollbar")

	-- Telescope
	use("nvim-lua/plenary.nvim")
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use("kyazdani42/nvim-web-devicons")
	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	-- VIM Cheatsheet with Telescope
	use({
		"sudormrfbin/cheatsheet.nvim",

		requires = {
			{ "nvim-telescope/telescope.nvim" },
			{ "nvim-lua/popup.nvim" },
			{ "nvim-lua/plenary.nvim" },
		},
	})

	-- Writer plugins
	use("junegunn/goyo.vim")
	use("preservim/vim-markdown")
end)
