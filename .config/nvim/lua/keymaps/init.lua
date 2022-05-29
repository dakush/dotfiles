vim.g.mapleader = "ñ"
-- Search and mark the original place to mark "s" so you can go back with 's
-- You can change "/" and "?" with other keys if you want
vim.keymap.set("n", "/", "ms/", { noremap = true, silent = false })
vim.keymap.set("o", "/", "ms/", { noremap = true, silent = false })
vim.keymap.set("n", "?", "ms?", { noremap = true, silent = false })
vim.keymap.set("o", "?", "ms?", { noremap = true, silent = false })
-- Center search term when found
vim.keymap.set("n", "n", "nzz", { noremap = true, silent = true })
vim.keymap.set("n", "N", "Nzz", { noremap = true, silent = true })

-- Avoid fucking ex mode
vim.keymap.set("n", "Q", "<nop>", { noremap = true, silent = true })

-- Center jumps in screen when going to next/previous
vim.keymap.set("n", "<C-o>", "<C-o>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-i>", "<C-i>zz", { noremap = true, silent = true })

-- Paste mode
vim.opt.pastetoggle = "<leader>p"
-- Yank to system clipboard even over SSH
-- After selecting something in visual mode:
vim.keymap.set("v", "<leader>y", ":OSCYank<CR>", { noremap = true, silent = false })
-- As an operator, e.g. <leader>o_  = copy the current line, <leader>oip = copy the inner paragraph
vim.keymap.set("n", "<leader>o", [[ OSCYankOperator('') ]], { noremap = false, silent = true, expr = true })

-- Double space over word to find and replace
vim.keymap.set(
	"n",
	"<Space><Space>",
	':%s/<C-r>=expand("<cword>")<CR>//gc<left><left><left>',
	{ noremap = true, silent = false }
)
-- Clear search highlight with Esc
vim.keymap.set("n", "<esc>", ":noh<return><esc>", { noremap = true, silent = true })
-- Reselect pasted text (it pairs nicely with native mapping gv, which reselects last visual selection)
vim.keymap.set("n", "gp", "`[v`]", { noremap = true, silent = false })
-- Avoid 'change' to overwrite the main register
vim.keymap.set("n", '"c', "_c", { noremap = true, silent = false })
vim.keymap.set("n", '"C', "_C", { noremap = true, silent = false })
-- Avoid to overwrite the register when using visual mode to replace chunks of text
vim.keymap.set("x", "p", '""p:let @"=@0<CR>', { noremap = true, silent = true })

-- Toggle cursor line
vim.keymap.set("n", "<leader>cl", ":set cursorline!<cr>", { noremap = true, silent = false })
-- Toggle show white characters
vim.keymap.set("n", "<leader>w", ":set list!<cr>", { noremap = true, silent = true })

-- Keep visual selection when indenting/outdenting
vim.keymap.set("v", "<", "<gv", { noremap = false, silent = false })
vim.keymap.set("v", ">", ">gv", { noremap = false, silent = false })

-- Switch between current and last buffer
vim.keymap.set("n", "<leader>l", "<c-^>", { noremap = false, silent = false })
-- Buffer cycling with Tab
vim.keymap.set("n", "<Tab>", ":bnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", { noremap = true, silent = false })
-- Buffer cycling with Tab and don't return to the deleted buffer
-- vim.keymap.set("n", "<Tab>", ":<c-u>exe v:count ? v:count . 'b' : 'b' . (bufloaded(0) ? '#' : 'n')<cr>", { noremap = true, silent = true })
-- vim.keymap.set("n", "<S-Tab>", ":<c-u>exe v:count ? v:count . 'b' : 'b' . (bufloaded(0) ? '#' : 'p')<cr>", { noremap = true, silent = true })
-- Close the buffer but keep the window
vim.keymap.set("n", "<leader>q", ":ene<CR>:bw #<CR>", { noremap = false, silent = false })

-- Enable . command in visual mode
vim.keymap.set("v", ".", ":normal .<cr>", { noremap = true, silent = false })

-- Move line mappings
-- ∆ is <A-j> on macOS (¶ in spanish keyboard)
-- ˚ is <A-k> on macOS (§ in spanish keyboard)
vim.keymap.set("n", "<A-j>", ":m .+1<cr>==", { noremap = true, silent = false })
vim.keymap.set("n", "<A-k>", ":m .-2<cr>==", { noremap = true, silent = false })
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<cr>==gi", { noremap = true, silent = false })
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<cr>==gi", { noremap = true, silent = false })
vim.keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { noremap = true, silent = false })
vim.keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { noremap = true, silent = false })
-- Scroll the viewport faster
vim.keymap.set("n", "<C-e>", "3<C-e>", { noremap = true, silent = false })
vim.keymap.set("n", "<C-y>", "3<C-y>", { noremap = true, silent = false })
-- Moving up and down work as you would expect
-- Except if preceeded with a count, e.g. 5j moves 5 "real" lines down
-- Also, it records jump points if the movement is larger than 5 lines
vim.keymap.set(
	"n",
	"j",
	[[v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj']],
	{ noremap = true, expr = true }
)
vim.keymap.set(
	"n",
	"k",
	[[v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gk']],
	{ noremap = true, expr = true }
)
-- These are the "simple" keymaps, where j/k are changed to gj/gk always
-- vim.keymap.set("n", "j", "gj", { noremap = true, silent = true })
-- vim.keymap.set("n", "k", "gk", { noremap = true, silent = true })
vim.keymap.set("n", "$", "g$", { noremap = true, silent = true })

-- W to save as sudo if you forgot to edit the file as sudo
--vim.keymap.set('c', 'W', '"w !sudo tee % > /dev/null" | :edit!<cr>', {noremap = true, silent= false})
vim.cmd([[ command W :execute ':silent w !sudo tee % > /dev/null' | :edit!" ]])

-------------------------------------------------------------------------------
---------------------------------- PLUGINS ------------------------------------
-------------------------------------------------------------------------------
-- Format with formatter plugin
vim.keymap.set("n", "<leader>f", ":Format<CR>", { noremap = true, silent = false })

-- Insert annotation with neogen plugin
vim.keymap.set("n", "<Leader>n", ":lua require('neogen').generate()<CR>", { noremap = true, silent = true })

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
vim.keymap.set(
	"n",
	"<Leader>ññ",
	":lua require('telescope.builtin').buffers()<cr>",
	{ noremap = true, silent = true }
)
vim.keymap.set(
	"n",
	"<Leader>ñf",
	":lua require('telescope.builtin').find_files()<cr>",
	{ noremap = true, silent = true }
)
vim.keymap.set(
	"n",
	"<Leader>ñg",
	":lua require('telescope.builtin').live_grep()<cr>",
	{ noremap = true, silent = true }
)
vim.keymap.set(
	"n",
	"<Leader>ñr",
	":lua require('telescope.builtin').registers()<cr>",
	{ noremap = true, silent = true }
)
vim.keymap.set(
	"n",
	"<Leader>ñj",
	":lua require('telescope.builtin').jumplist()<cr>",
	{ noremap = true, silent = true }
)
vim.keymap.set(
	"n",
	"<Leader>ñz",
	":lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>",
	{ noremap = true, silent = true }
)
