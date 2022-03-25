-- Change keyboard layout when entering/exiting neovim + make ImpPt a second Super key
-- vim.cmd("autocmd VimEnter * silent !setxkbmap us && xmodmap -e 'keycode 107 = Super_L'")
-- vim.cmd("autocmd VimLeave * silent !setxkbmap es && xmodmap -e 'keycode 107 = Super_L'")
-- vim.g.mapleader = " "
vim.g.mapleader = "ñ"
-- Search and mark the original place to mark "s" so you can go back with 's
-- You can change "/" and "?" with other keys if you want
vim.api.nvim_set_keymap("n", "/", "ms/", { noremap = true, silent = false })
vim.api.nvim_set_keymap("o", "/", "ms/", { noremap = true, silent = false })
vim.api.nvim_set_keymap("n", "?", "ms?", { noremap = true, silent = false })
vim.api.nvim_set_keymap("o", "?", "ms?", { noremap = true, silent = false })
-- Center search term when found
vim.api.nvim_set_keymap("n", "n", "nzz", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "N", "Nzz", { noremap = true, silent = true })

-- Avoid fucking ex mode
vim.api.nvim_set_keymap("n", "Q", "<nop>", { noremap = true, silent = true })

-- Center jumps in screen when going to next/previous
vim.api.nvim_set_keymap("n", "<C-o>", "<C-o>zz", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-i>", "<C-i>zz", { noremap = true, silent = true })

-- Paste mode
vim.opt.pastetoggle = "<leader>p"
-- Yank to system clipboard even over SSH
-- After selecting something in visual mode:
vim.api.nvim_set_keymap("v", "<leader>y", ":OSCYank<CR>", { noremap = true, silent = false })
-- As an operator, e.g. <leader>o_  = copy the current line, <leader>oip = copy the inner paragraph
vim.api.nvim_set_keymap(
	"n",
	"<leader>o",
	[[ OSCYankOperator('') ]],
	{ noremap = false, silent = true, expr = true }
)

-- Double space over word to find and replace
vim.api.nvim_set_keymap(
	"n",
	"<Space><Space>",
	':%s/<C-r>=expand("<cword>")<CR>//gc<left><left><left>',
	{ noremap = true, silent = false }
)
-- Clear search highlight with Esc
vim.api.nvim_set_keymap("n", "<esc>", ":noh<return><esc>", { noremap = true, silent = true })
-- Reselect pasted text (it pairs nicely with native mapping gv, which reselects last visual selection)
vim.api.nvim_set_keymap("n", "gp", "`[v`]", { noremap = true, silent = false })
-- Avoid 'change' to overwrite the main register
vim.api.nvim_set_keymap("n", '"c', "_c", { noremap = true, silent = false })
vim.api.nvim_set_keymap("n", '"C', "_C", { noremap = true, silent = false })
-- Avoid to overwrite the register when using visual mode to replace chunks of text
vim.api.nvim_set_keymap("x", "p", '""p:let @"=@0<CR>', { noremap = true, silent = true })
-- If the popup menu is visible, C-j C-k move up and down; if not, they do their usual action
-- In lua _G is the global table that holds all the global variables.
-- It's not strictly necessary but I'm using it to make it clear that I'm creating a global function on purpose.
--vim.api.nvim_set_keymap("i", "<C-k>", "v:lua.smartPopupNavigation", { noremap = true, expr = true })
--_G.smartPopupNavigation = function()
--	if vim.fn.pumvisible() == 1 then
--		-- we use "t" to return the code of <C-N>, not the string itself
--		return t("<C-N>")
--	else
--		return t("<C-j>")
--	end
--end
--vim.api.nvim_set_keymap("i", "<C-j>", "v:lua.smartPopupNavigation", { noremap = true, expr = true })
--_G.smartPopupNavigation = function()
--	if vim.fn.pumvisible() == 1 then
--		return t("<C-P>")
--	else
--		return t("<C-k>")
--	end
--end

-- Toggle cursor line
vim.api.nvim_set_keymap("n", "<leader>cl", ":set cursorline!<cr>", { noremap = true, silent = false })
-- Toggle show white characters
vim.api.nvim_set_keymap("n", "<leader>b", ":set list!<cr>", { noremap = true, silent = true })

-- Keep visual selection when indenting/outdenting
vim.api.nvim_set_keymap("v", "<", "<gv", { noremap = false, silent = false })
vim.api.nvim_set_keymap("v", ">", ">gv", { noremap = false, silent = false })

-- Switch between current and last buffer
vim.api.nvim_set_keymap("n", "<leader>l", "<c-^>", { noremap = false, silent = false })
-- Buffer cycling with Tab
vim.api.nvim_set_keymap("n", "<Tab>", ":bnext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-Tab>", ":bprevious<CR>", { noremap = true, silent = false })
-- Buffer cycling with Tab and don't return to the deleted buffer
-- vim.api.nvim_set_keymap("n", "<Tab>", ":<c-u>exe v:count ? v:count . 'b' : 'b' . (bufloaded(0) ? '#' : 'n')<cr>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<S-Tab>", ":<c-u>exe v:count ? v:count . 'b' : 'b' . (bufloaded(0) ? '#' : 'p')<cr>", { noremap = true, silent = true })
-- Close the buffer but keep the window
vim.api.nvim_set_keymap("n", "<leader>q", ":ene<CR>:bw #<CR>", { noremap = false, silent = false })

-- Enable . command in visual mode
vim.api.nvim_set_keymap("v", ".", ":normal .<cr>", { noremap = true, silent = false })

-- Move line mappings
-- ∆ is <A-j> on macOS (¶ in spanish keyboard)
-- ˚ is <A-k> on macOS (§ in spanish keyboard)
vim.api.nvim_set_keymap("n", "<A-j>", ":m .+1<cr>==", { noremap = true, silent = false })
vim.api.nvim_set_keymap("n", "<A-k>", ":m .-2<cr>==", { noremap = true, silent = false })
vim.api.nvim_set_keymap("i", "<A-j>", "<Esc>:m .+1<cr>==gi", { noremap = true, silent = false })
vim.api.nvim_set_keymap("i", "<A-k>", "<Esc>:m .-2<cr>==gi", { noremap = true, silent = false })
vim.api.nvim_set_keymap("v", "<A-j>", ":m '>+1<cr>gv=gv", { noremap = true, silent = false })
vim.api.nvim_set_keymap("v", "<A-k>", ":m '<-2<cr>gv=gv", { noremap = true, silent = false })
-- Scroll the viewport faster
vim.api.nvim_set_keymap("n", "<C-e>", "3<C-e>", { noremap = true, silent = false })
vim.api.nvim_set_keymap("n", "<C-y>", "3<C-y>", { noremap = true, silent = false })
-- Moving up and down work as you would expect
-- Except if preceeded with a count, e.g. 5j moves 5 "real" lines down
-- Also, it records jump points if the movement is larger than 5 lines
vim.api.nvim_set_keymap(
	"n",
	"j",
	[[v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj']],
	{ noremap = true, expr = true }
)
vim.api.nvim_set_keymap(
	"n",
	"k",
	[[v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gk']],
	{ noremap = true, expr = true }
)
-- These are the "simple" keymaps, where j/k are changed to gj/gk always
-- vim.api.nvim_set_keymap("n", "j", "gj", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "k", "gk", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "$", "g$", { noremap = true, silent = true })

-- W to save as sudo if you forgot to edit the file as sudo
--vim.api.nvim_set_keymap('c', 'W', '"w !sudo tee % > /dev/null" | :edit!<cr>', {noremap = true, silent= false})
vim.cmd([[ command W :execute ':silent w !sudo tee % > /dev/null' | :edit!" ]])

-------------------------------------------------------------------------------
---------------------------------- PLUGINS ------------------------------------
-------------------------------------------------------------------------------
-- Format with formatter plugin
vim.api.nvim_set_keymap("n", "<leader>f", ":Format<CR>", { noremap = true, silent = false })

-- Insert annotation with neogen plugin
vim.api.nvim_set_keymap("n", "<Leader>n", ":lua require('neogen').generate()<CR>", { noremap = true, silent = true })

-- Default keymaps for Comment plugin (here just for reference)
-- NORMAL mode
-- `ñcc` - Toggles the current line using linewise comment
-- `ñbc` - Toggles the current line using blockwise comment
-- `[count]ñcc` - Toggles the number of line given as a prefix-count using linewise
-- `[count]ñbc` - Toggles the number of line given as a prefix-count using blockwise
-- `ñc[count]{motion}` - (Op-pending) Toggles the region using linewise comment
-- `ñb[count]{motion}` - (Op-pending) Toggles the region using blockwise comment
-- `ñco` - Insert comment to the next line and enters INSERT mode
-- `ñcO` - Insert comment to the previous line and enters INSERT mode
-- `ñcA` - Insert comment to end of the current line and enters INSERT mode
-- VISUAL mode
-- `ñc` - Toggles the region using linewise comment
-- `ñb` - Toggles the region using blockwise comment

-- Telescope
vim.api.nvim_set_keymap(
	"n",
	"<Leader>ññ",
	":lua require('telescope.builtin').buffers()<cr>",
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<Leader>ñf",
	":lua require('telescope.builtin').find_files()<cr>",
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<Leader>ñg",
	":lua require('telescope.builtin').live_grep()<cr>",
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<Leader>ñr",
	":lua require('telescope.builtin').registers()<cr>",
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<Leader>ñj",
	":lua require('telescope.builtin').jumplist()<cr>",
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"<Leader>ñz",
	":lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>",
	{ noremap = true, silent = true }
)
