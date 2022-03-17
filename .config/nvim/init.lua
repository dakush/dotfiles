require("plugins")
require("treesitter-config")
require("setup")
require("keymaps")
HOME = os.getenv("HOME")

-------------------------------------------------------------------------------
---------------------------------- VISUAL -------------------------------------
-------------------------------------------------------------------------------
vim.cmd("colorscheme dracula")
vim.cmd("hi Normal guibg=NONE ctermbg=NONE") -- Make the window transparent
-- enable 24 bit color support if supported
if vim.fn.has("termguicolors") == 1 then
	vim.opt.termguicolors = true
end
vim.opt.cursorline = true -- Highlight the line with the cursor
vim.opt.title = true -- vim.opt.terminal title
-- switch cursor to line when in insert mode, and block when not
vim.opt.guicursor =
	[[n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175]]

-- Invisible characters
vim.opt.list = true
vim.opt.listchars = {
	tab = "→·",
	eol = "¬",
	--trail = '⋅',
	trail = "·",
	extends = "❯",
	precedes = "❮",
}

-- Automatically resize panes on resize
vim.cmd([[
  augroup configgroup
    autocmd!
    autocmd VimResized * exe 'normal! \<c-w>='
    autocmd BufWritePost .vimrc,.vimrc.local,init.vim source %
    autocmd BufWritePost .vimrc.local source %
    autocmd FileType qf wincmd J
    autocmd FileType qf nmap <buffer> q :q<cr>
  augroup END
]])

-------------------------------------------------------------------------------
--------------------------------- VARIABLES -----------------------------------
-------------------------------------------------------------------------------
-- Set temporary directories location
vim.opt.backup = true
vim.opt.backupdir = HOME .. "/.cache/.vim-tmp"
vim.opt.directory = HOME .. "/.cache/.vim-tmp"
vim.opt.undodir = HOME .. "/.cache/.undo/"

vim.opt.syntax = "enable"
vim.opt.autoread = true -- check if the file has changed before reloading it
vim.opt.history = 1000
vim.opt.textwidth = 120

-- Don't show blank characters
vim.opt.list = false

-- Disable spell checking
vim.cmd([[ autocmd BufEnter,BufRead,BufNewFile * set nospell ]])

vim.opt.backspace = "indent,eol,start" -- make backspace behave in a sane manner
-- Yank to the system clipboard
vim.opt.clipboard = vim.opt.clipboard + "unnamed,unnamedplus"

if vim.fn.has("mouse") == 1 then
	vim.opt.mouse = "a"
end

-- Searching
vim.opt.ignorecase = true -- case insensitive searching
vim.opt.smartcase = true -- case-sensitive if expresson contains a capital letter
vim.opt.lazyredraw = true -- don't redraw while executing macros

vim.opt.magic = true -- Set magic on, for regex

-- error bells
vim.opt.errorbells = false
vim.opt.visualbell = true

-- miliseconds to wait for a mapped sequence to complete (default = 1000)
vim.opt.tm = 500

-- Set relative line numbers except when in insert mode or when the buffer loses focus
vim.opt.number = true
vim.opt.relativenumber = true
vim.cmd([[
  augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
  augroup END
]])

-- Wrap lines
vim.opt.wrap = true -- turn on line wrapping
vim.opt.wrapmargin = 8 -- wrap lines when coming within n characters from side
vim.opt.linebreak = true -- vim.opt.soft wrapping
vim.opt.breakindent = true -- indent wrapped lines
vim.opt.breakindentopt = "shift:2" -- indent is 2x regular indent
vim.opt.showbreak = "❯❯ " -- show ellipsis at breaking
-- vim.opt.showbreak = "…" -- show ellipsis at breaking

-- Tab control
vim.opt.expandtab = true -- We use spaces, not hard tabs
vim.opt.tabstop = 4 -- the visible width of tabs
vim.opt.softtabstop = 4 -- edit as if the tabs are 4 characters wide
vim.opt.shiftwidth = 4 -- number of spaces to use for indent and unindent
vim.opt.shiftround = true -- round indent to a multiple of 'shiftwidth'

-- Folding
vim.opt.foldmethod = "indent" -- fold based on indent
vim.opt.foldlevelstart = 99
vim.opt.foldnestmax = 10 -- deepest fold is 10 levels
vim.opt.foldenable = false -- don't fold by default
vim.opt.foldlevel = 1

-- Misc
vim.opt.diffopt = vim.opt.diffopt + "vertical,iwhite,internal,algorithm:patience,hiddenoff"
vim.opt.so = 7 -- set 7 lines to the cursor's when moving vertical
vim.opt.wildmode = "longest:list,full" -- complete files like a shell
vim.opt.updatetime = 300
vim.opt.signcolumn = "number"
vim.opt.nrformats = "" -- Don't increment/decrement numbers with keybinds

-- highlight conflicts
--vim.cmd([[match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$']])

-- Disables automatic commenting on newline
vim.cmd("autocmd BufNewFile,BufRead * setlocal formatoptions-=cro")

-- Required by nvim-cmp plugin for completion
vim.opt.completeopt = "menu,menuone,noselect"
