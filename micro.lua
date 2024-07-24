-- Load plugins
-- require("plugins")

-- General Settings
vim.o.mouse = "a"
vim.o.number = true
vim.o.compatible = false
vim.o.laststatus = 2
vim.o.cursorline = true
vim.o.ignorecase = true
vim.o.hlsearch = true
vim.o.clipboard = "unnamedplus"
vim.o.termguicolors = true

-- Statusline
nvim_version = vim.fn.system("nvim --version | grep NVIM | tail -c 7"):gsub("%s+", "")
vim.o.statusline = "%f %m (%l,%v) | Ft:%y | %{&ff} | %{&fenc==''?&enc:&fenc} | %=%= NVIM " .. nvim_version

-- Arrow keys hack for Vim
if vim.fn.has('nvim') == 0 then
	vim.api.nvim_set_keymap('i', '<esc>x', '<esc>x', {})
end

-- Function definitions
function force_exit()
	vim.cmd('q!')
end

function prompt_save()
	if vim.fn.expand('%') ~= "" then
		vim.cmd('write')
		return 1
	end
	local name = vim.fn.input('File Name to Write: ')
	if name == "" then
		return 0
	else
		vim.cmd('write! ' .. name)
		return 1
	end
end

function insert_file()
	local name = vim.fn.input('File to insert [from ./]: ')
	if name ~= "" then
		vim.cmd('read ' .. name)
	end
end

function exit()
	if vim.bo.modified then
		local name = vim.fn.confirm('Save changes to file before closing?', "Y\nN\nCancel")
		if name == 3 then
			-- Do nothing
		elseif name == 2 then
			force_exit()
		else
			if prompt_save() == 1 then
				force_exit()
			end
		end
	else
		force_exit()
	end
end

function show_info()
	local curline = vim.fn.line('.')
	local totalline = vim.fn.line('$')
	local curcol = vim.fn.col('.')
	local totalcol = vim.fn.col('$')
	local lineperc = 100 * curline / totalline
	local colperc = 100 * curcol / totalcol
	print("[ line " .. curline .. "/" .. totalline .. " (" .. lineperc .. "%), col " .. curcol .. "/" .. totalcol .. " (" .. colperc .. "%) ]")
end

function goto_line()
	local name = vim.fn.input('Enter line number, column number: ')
	if name ~= "" then
		local newlist = vim.split(name, "[ ,]")
		local r, c = tonumber(newlist[1]), tonumber(newlist[2])
		vim.fn.cursor(r, c)
	end
end

function first_line()
	vim.cmd('normal gg')
end

function last_line()
	vim.cmd('normal G')
end

function redo()
	vim.cmd('redo')
end

function deline()
	vim.cmd('.d')
end

function duline()
	vim.cmd('t.')
end

function help()
	vim.cmd('help')
end

-- Key mappings
local keymap_opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '<C-S>', ':lua prompt_save()<CR>', keymap_opts)
vim.api.nvim_set_keymap('i', '<C-S>', '<C-O>:lua prompt_save()<CR>', keymap_opts)
vim.api.nvim_set_keymap('n', '<C-P>', ':lua insert_file()<CR>', keymap_opts)
vim.api.nvim_set_keymap('i', '<C-P>', '<C-O>:lua insert_file()<CR>', keymap_opts)
vim.api.nvim_set_keymap('n', '<C-Q>', ':lua exit()<CR>', keymap_opts)
vim.api.nvim_set_keymap('i', '<C-Q>', '<C-O>:lua exit()<CR>', keymap_opts)
vim.api.nvim_set_keymap('n', '<C-F>', '/', keymap_opts)
vim.api.nvim_set_keymap('i', '<C-F>', '<C-O>/', keymap_opts)
vim.api.nvim_set_keymap('n', '<C-H>', ':s/find/replace/c', keymap_opts)
vim.api.nvim_set_keymap('i', '<C-H>', '<C-O>:s/find/replace/c', keymap_opts)
vim.api.nvim_set_keymap('n', '<C-C>', ':lua show_info()<CR>', keymap_opts)
vim.api.nvim_set_keymap('i', '<C-C>', '<C-O>:lua show_info()<CR>', keymap_opts)
vim.api.nvim_set_keymap('n', '<C-_>', ':lua goto_line()<CR>', keymap_opts)
vim.api.nvim_set_keymap('i', '<C-_>', '<C-O>:lua goto_line()<CR>', keymap_opts)
vim.api.nvim_set_keymap('n', '<A-\\>', ':lua first_line()<CR>', keymap_opts)
vim.api.nvim_set_keymap('i', '<A-\\>', '<C-O>:lua first_line()<CR>', keymap_opts)
vim.api.nvim_set_keymap('n', '<A-/>', ':lua last_line()<CR>', keymap_opts)
vim.api.nvim_set_keymap('i', '<A-/>', '<C-O>:lua last_line()<CR>', keymap_opts)
vim.api.nvim_set_keymap('i', '<A-f>', '<C-O>n', keymap_opts)
vim.api.nvim_set_keymap('i', '<A-]>', '<C-O>%', keymap_opts)
vim.api.nvim_set_keymap('n', '<C-e>', '<C-O>:', keymap_opts)
vim.api.nvim_set_keymap('i', '<C-e>', '<C-O>:', keymap_opts)
vim.api.nvim_set_keymap('v', '<BS>', 'x', keymap_opts)
vim.api.nvim_set_keymap('v', '<C-c>', 'y', keymap_opts)
vim.api.nvim_set_keymap('v', '<C-x>', 'd', keymap_opts)
vim.api.nvim_set_keymap('i', '<C-v>', '<C-O>p', keymap_opts)
vim.api.nvim_set_keymap('i', '<C-z>', '<C-O>u', keymap_opts)
vim.api.nvim_set_keymap('n', '<C-Y>', ':lua redo()<CR>', keymap_opts)
vim.api.nvim_set_keymap('i', '<C-Y>', '<C-O>:lua redo()<CR>', keymap_opts)
vim.api.nvim_set_keymap('n', '<C-K>', ':lua deline()<CR>', keymap_opts)
vim.api.nvim_set_keymap('i', '<C-K>', '<C-O>:lua deline()<CR>', keymap_opts)
vim.api.nvim_set_keymap('n', '<C-D>', ':lua duline()<CR>', keymap_opts)
vim.api.nvim_set_keymap('i', '<C-D>', '<C-O>:lua duline()<CR>', keymap_opts)
vim.api.nvim_set_keymap('i', '<C-a>', '<C-[>ggVG', keymap_opts)
vim.api.nvim_set_keymap('n', '<C-A>', '<C-[> ggVG', keymap_opts)
vim.api.nvim_set_keymap('i', '<A-}>', '<C-O>>>', keymap_opts)
vim.api.nvim_set_keymap('i', '<A-{>', '<C-O><<', keymap_opts)
vim.api.nvim_set_keymap('i', '<C-J>', '<C-O>gqk', keymap_opts)
vim.api.nvim_set_keymap('i', '<C-Right>', '<C-o>l', keymap_opts)
vim.api.nvim_set_keymap('i', '<C-Left>', '<C-o>h', keymap_opts)
vim.api.nvim_set_keymap('i', '<A-Left>', '<C-o>b', keymap_opts)
vim.api.nvim_set_keymap('i', '<A-Right>', '<C-o>w', keymap_opts)
vim.api.nvim_set_keymap('n', '<C-O>', ':e', keymap_opts)
vim.api.nvim_set_keymap('i', '<C-O>', '<C-O>:e', keymap_opts)
vim.api.nvim_set_keymap('n', '<C-1>', ':e', keymap_opts)
vim.api.nvim_set_keymap('i', '<C-n1>', '<C-O>:e', keymap_opts)
vim.api.nvim_set_keymap('n', '<C-4>', ':ter make clean<CR>', keymap_opts)
vim.api.nvim_set_keymap('i', '<C-4>', '<Esc>:ter make clean<CR>i', keymap_opts)
vim.api.nvim_set_keymap('n', '<C-5>', ':ter make<CR>', keymap_opts)
vim.api.nvim_set_keymap('i', '<C-5>', '<Esc>:ter make<CR>i', keymap_opts)
vim.api.nvim_set_keymap('n', '<C-6>', ':ter make test<CR>', keymap_opts)
vim.api.nvim_set_keymap('i', '<C-6>', '<Esc>:ter make test<CR>i', keymap_opts)
vim.api.nvim_set_keymap('n', '<C-G>', ':lua help()<CR>', keymap_opts)
vim.api.nvim_set_keymap('i', '<C-G>', '<C-O>:lua help()<CR>', keymap_opts)

-- Start insert mode
vim.cmd('startinsert')

-- Bracket mappings
vim.api.nvim_set_keymap('i', '{<cr>', '{<cr>}<C-o><S-O>', keymap_opts)
vim.api.nvim_set_keymap('i', '(<cr>', '(<cr>)<C-o><S-O>', keymap_opts)
vim.api.nvim_set_keymap('i', '[<cr>', '[<cr>]<C-o><S-O>', keymap_opts)
vim.api.nvim_set_keymap('i', '(', '()<left>', keymap_opts)
vim.api.nvim_set_keymap('i', '{', '{}<left>', keymap_opts)
vim.api.nvim_set_keymap('i', '[', '[]<left>', keymap_opts)
vim.api.nvim_set_keymap('i', ')', 'strpart(getline("."), col(".") - 1, 1) == ")" and "<Right>" or ")"', { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap('i', '}', 'strpart(getline("."), col(".") - 1, 1) == "}" and "<Right>" or "}"', { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap('i', ']', 'strpart(getline("."), col(".") - 1, 1) == "]" and "<Right>" or "]"', { noremap = true, expr = true, silent = true })

vim.api.nvim_set_keymap('n', '(', "mmbi(<esc>ea)<esc>`m<right>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '{', "mmbi{<esc>ea}<esc>`m<right>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '[', "mmbi[<esc>ea]<esc>`m<right>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '(', "<Esc>`<i(<Esc>`>a<right>)<Esc>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '{', "<Esc>`<i{<Esc>`>a<right>}<Esc>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '[', "<Esc>`<i[<Esc>`>a<right>]<Esc>", { noremap = true, silent = true })