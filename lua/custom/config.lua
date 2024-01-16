-- [[ Custom Keymaps ]]
local opts = { noremap = true, silent = true }
vim.keymap.set("i", "jj", "<Esc>", opts)
vim.keymap.set("t", "<C-w>h", "<C-\\><C-n><C-w>h", opts)
-- indent by pressing > or < multiple times
vim.keymap.set('v', '>', '>gv', opts)
vim.keymap.set('v', '<', '<gv', opts)
-- Neogen annotation generation
vim.api.nvim_set_keymap("n", "<Leader>nf", ":lua require('neogen').generate({ type = 'func' })<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>nc", ":lua require('neogen').generate({ type = 'class' })<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>nt", ":lua require('neogen').generate({ type = 'type' })<CR>", opts)


--[[ Custom LSP is configured in lsp-setup.lua ]]


--[[ Custom config of nvim-cmp ]]
local cmp = require 'cmp'
cmp.setup{
  mapping = cmp.mapping.preset.insert{
    --[[ Custom mapping ]]
    --Return j and k for scrolling the items.
    ['<C-j>'] = cmp.mapping.select_next_item(),
    ['<C-k>'] = cmp.mapping.select_prev_item(),
  }
}


--[[ Custome options ]]
vim.wo.number = true
vim.wo.relativenumber = true
vim.opt.colorcolumn = '79,120'

--[[ Python set up ]]
-- refer to https://neovim.io/doc/user/provider.html#provider-python
vim.g.python3_host_prog = '~/.pyenv/versions/pynvim/bin/python'
