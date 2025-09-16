vim.g.mapleader = " "

vim.o.mouse = "a"
vim.opt.wrap = false
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.inccommand = "split"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.scrolloff = 4

vim.schedule(function()
	vim.o.clipboard = "unnamedplus"
end)

vim.keymap.set("i", "jk", "<esc>")
vim.keymap.set("i", "kj", "<esc>")
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.api.nvim_create_autocmd("WinEnter", {
	callback = function()
		local cur = vim.api.nvim_get_current_win()
		local win_count = #vim.api.nvim_list_wins()
		if win_count < 2 then
			return
		end -- nothing to do with only one window

		local w = vim.api.nvim_win_get_width(cur)
		if w >= 90 then
			return
		end

		local ok_set = pcall(vim.api.nvim_set_option_value, "winfixwidth", true, { win = cur })
		if not ok_set then
			vim.wo.winfixwidth = true
		end

		vim.cmd("vertical resize 90")
		vim.cmd("wincmd =")

		pcall(vim.api.nvim_set_option_value, "winfixwidth", false, { win = cur })
		vim.wo.winfixwidth = false
	end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

vim.pack.add({
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope-file-browser.nvim" },
	{ src = "https://github.com/tpope/vim-obsession" },
	{ src = "https://github.com/github/copilot.vim" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/scottmckendry/cyberdream.nvim" },
})

require("mason").setup()
require("nvim-treesitter.configs").setup({
	ensure_installed = { "javascript", "html", "css", "scss", "pug" },
	auto_install = true,
	highlight = {
		enable = true,
	},
})

local actions = require("telescope.actions")
require("telescope").setup({
	defaults = {
		mappings = {
			i = { ["<C-s>"] = actions.select_vertical },
			n = { ["<C-s>"] = actions.select_vertical },
		},
	},
})
require("telescope").load_extension("file_browser")

vim.keymap.set("n", "<leader>f", "<cmd>Telescope find_files<cr>")
vim.keymap.set("n", "<leader>r", "<cmd>Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>q", "<cmd>Telescope resume<cr>")
vim.keymap.set("n", "<leader>b", "<cmd>Telescope buffers<cr>")
vim.keymap.set("n", "<leader>e", function()
	require("telescope").extensions.file_browser.file_browser({
		path = "%:p:h",
		cwd = vim.fn.getcwd(),
		respect_gitignore = false,
		hidden = true,
		grouped = true,
		previewer = true,
		initial_mode = "normal",
	})
end)
vim.keymap.set(
	"n",
	"<leader>l",
	"<cmd>split<bar>term<cr><c-w>J:resize45<cr>:setlocal nonumber norelativenumber<cr>ilazygit<cr>"
)

vim.lsp.enable({ "lua_ls", "typescript-language-server", "pug-lsp", "vscode-css-language-server" })

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "isort", "black" },
		rust = { "rustfmt", lsp_format = "fallback" },
		javascript = { "prettierd", "prettier", stop_after_first = true },
		json = { "prettierd", "prettier", stop_after_first = true },
		html = { "prettierd", "prettier", stop_after_first = true },
		xml = { "prettierd", "prettier", stop_after_first = true },
		css = { "stylelint" },
		scss = { "stylelint" },
	},
	format_on_save = true,
	format_on_save_timeout = 5000,
})
vim.keymap.set("n", "<leader>lf", function()
	require("conform").format({ lsp_fallback = true })
end, { desc = "Format file" })

vim.cmd.colorscheme("cyberdream")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#111111", bg = "none" })
