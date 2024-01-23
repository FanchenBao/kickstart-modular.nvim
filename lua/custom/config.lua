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
-- Map ctrl-w v to open a new buffer
vim.keymap.set('n', '<C-w>v', '<esc>:vnew<cr>', opts)

--[[ Custom LSP is configured in lsp-setup.lua ]]


--[[ Custom config of nvim-cmp ]]
local cmp = require 'cmp'
cmp.setup{
  mapping = cmp.mapping.preset.insert{
    --[[ Custom mapping ]]
    --Return j and k for scrolling the items.
    ['<C-j>'] = cmp.mapping.select_next_item(),
    ['<C-k>'] = cmp.mapping.select_prev_item(),
  },
  enabled = function()
    -- Disable autocomplete inside comments
    local context = require("cmp.config.context")
    return not context.in_treesitter_capture("comment") or not context.in_syntax_group("Comment") or not context.in_treesitter_capture("string") or not context.in_syntax_group("String")
  end,
  sources = {
    { name = 'nvim_lsp' },
    {
      name = 'luasnip',
      entry_filter = function()
        -- Disable snippet inside string
        local context = require("cmp.config.context")
        return not context.in_treesitter_capture("string") and not context.in_syntax_group("String") and not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
      end,
    },
    { name = 'path' },
  },
}


--[[ Custome options ]]
vim.wo.number = true
vim.wo.relativenumber = true
vim.opt.colorcolumn = '79,120'
vim.opt.splitright = true  --when a panel is vertically split, it appears on the right side

--[[ Python set up ]]
-- refer to https://neovim.io/doc/user/provider.html#provider-python
vim.g.python3_host_prog = '~/.pyenv/versions/pynvim/bin/python'

--[[ Automatic tab width based on file type ]]
vim.opt.expandtab = true;
vim.api.nvim_create_autocmd('FileType', {
  pattern = {'js', 'py'},
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
  end
})
vim.api.nvim_create_autocmd('FileType', {
  pattern = {'sh', 'json'},
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
  end
})

--[[ Transparent NeoVim ]]
vim.api.nvim_set_hl(0, "Normal", { guibg=NONE, ctermbg=NONE })

