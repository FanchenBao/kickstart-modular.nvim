-- [[ Custom Keymaps ]]
vim.keymap.set("i", "jj", "<Esc>", { noremap = true })
vim.keymap.set("t", "<C-w>h", "<C-\\><C-n><C-w>h", { silent = true, noremap = true})


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
