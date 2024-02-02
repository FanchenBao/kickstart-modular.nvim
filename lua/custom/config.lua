local config = {}  -- namespace
-- [[ Custom Keymaps ]]
local opts = { noremap = true, silent = true }
local opts_expr = { noremap = true, silent = true, expr = true }
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

--- Auxiliary function to build as set
--- Taken from https://www.lua.org/pil/11.5.html
---@param list Array a list of values to turn into a set
---@return table # table pretending as set
function Set (list)
  local set = {}
  for _, l in ipairs(list) do set[l] = true end
  return set
end

-- Autocomplete matching braces, brackets, parentheses, and quotations
local matching_symbols = Set{ '()', '{}', '[]', }

---@param rel number relative position to the current cursor. Can be negative 
---@return string # the character at rel position to cursor
function config.get_char_relative_to_cursor(rel)
  local col = vim.api.nvim_win_get_cursor(0)[2]
  local char = vim.api.nvim_get_current_line():sub(col + rel, col + rel)
  return char
end

--- Determine whether the cursor is in between matching symbols
---@return boolean # true => cursor is between matching symbols, otherwise false
function config.is_cursor_between_matching_symbols()
  local chars = config.get_char_relative_to_cursor(0) .. config.get_char_relative_to_cursor(1)
  if matching_symbols[chars] then
    return true
  end
  return false
end

for symbols, _ in pairs(matching_symbols) do
  local left = symbols:sub(1, 1)
  local right = symbols:sub(2, 2)
  -- type a left matching symbol, if nothing is on the right, auto fill the
  --  right symbol and move the cursor in between. If there is something on
  --  the right, only input the left matching symbol
  vim.keymap.set('i', left, symbols .. '<Esc>ha', opts)
  vim.keymap.set('i', right, function ()
    return config.get_char_relative_to_cursor(1) == right and '<Esc>la' or right
  end, opts_expr)
end

-- when cursor is in between matching symbols and we press Enter, automatically
-- add a line in between and format its indent according to the indent
-- convention set for the key press of 'o'
vim.keymap.set('i', '<CR>', function()
   return config.is_cursor_between_matching_symbols() and '<CR><Esc>ko' or '<CR>'
end, opts_expr)
-- when cursor is in between matching symbols and we press BS, automatically
-- delete both matching symbols
vim.keymap.set('i', '<BS>', function ()
  return config.is_cursor_between_matching_symbols() and '<Esc>la<BS><BS>' or '<BS>'
end, opts_expr)



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
vim.wo.linebreak = true

--[[ Python set up ]]
-- refer to https://neovim.io/doc/user/provider.html#provider-python
vim.g.python3_host_prog = '~/.pyenv/versions/pynvim/bin/python'

--[[ Automatic tab width based on file type ]]
vim.opt.expandtab = true;
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'javascript', 'python' },
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

--[[ Configure lualine ]]
require('lualine').setup {
  options = { theme = 'monokai-pro' },
  sections = {
    lualine_c = {
      {
        'filename',
        file_status = true, -- displays file status (readonly status, modified status)
        path = 2 -- 0 = just filename, 1 = relative path, 2 = absolute path
      }
    }
  }
}

