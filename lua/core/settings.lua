local keymap = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true }
local cmd = vim.cmd
local opt = vim.opt


function Map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end


cmd [[set relativenumber]]


opt.shiftwidth = 2
opt.tabstop = 2
opt.smartindent = true

--indentention
keymap("v", "<", "<gv", default_opts)
keymap("v", ">", ">gv", default_opts)


-- Switch buffer
keymap("n", "<S-h>", ":bprevious<CR>", default_opts)
keymap("n", "<S-l>", ":bnext<CR>", default_opts)

--splits navigation
Map("n", "<C-h>", "<C-w>h")
Map("n", "<C-j>", "<C-w>j")
Map("n", "<C-k>", "<C-w>k")
Map("n", "<C-l>", "<C-w>l")


--Map('n', '<C-n>', ':NvimTreeToggle<CR>')            -- open/close
--Map('n', '<leader>f', ':NvimTreeRefresh<CR>')       -- refresh
--Map('n', '<leader>n', ':NvimTreeFindFile<CR>')      -- search file
