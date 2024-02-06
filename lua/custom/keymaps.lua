-- [[ Custom Keymaps ]]
local keymaps = {}

local Set = require('custom.util').Set

--[[ Constants ]]
local opts = { noremap = true, silent = true }
local opts_expr = { noremap = true, silent = true, expr = true }
-- Autocomplete matching braces, brackets, parentheses, and quotations
local matching_symbols = Set{ '()', '{}', '[]', }

---@param rel number relative position to the current cursor. Can be negative 
---@return string # the character at rel position to cursor
function keymaps.get_char_relative_to_cursor(rel)
  local col = vim.api.nvim_win_get_cursor(0)[2]
  local char = vim.api.nvim_get_current_line():sub(col + rel, col + rel)
  return char
end

--- Determine whether the cursor is in between matching symbols
---@return boolean # true => cursor is between matching symbols, otherwise false
function keymaps.is_cursor_between_matching_symbols()
  local chars = keymaps.get_char_relative_to_cursor(0) .. keymaps.get_char_relative_to_cursor(1)
  if matching_symbols[chars] then
    return true
  end
  return false
end


function keymaps.setup()
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

  -- Set up behavior when matching symbols are typed
  for symbols, _ in pairs(matching_symbols) do
    local left = symbols:sub(1, 1)
    local right = symbols:sub(2, 2)
    -- type a left matching symbol, if nothing is on the right, auto fill the
    --  right symbol and move the cursor in between. If there is something on
    --  the right, only input the left matching symbol
    vim.keymap.set('i', left, symbols .. '<Esc>ha', opts)
    vim.keymap.set('i', right, function ()
      return keymaps.get_char_relative_to_cursor(1) == right and '<Esc>la' or right
    end, opts_expr)
  end
  -- when cursor is in between matching symbols and we press Enter, automatically
  -- add a line in between and format its indent according to the indent
  -- convention set for the key press of 'o'
  vim.keymap.set('i', '<CR>', function()
     return keymaps.is_cursor_between_matching_symbols() and '<CR><Esc>ko' or '<CR>'
  end, opts_expr)
  -- when cursor is in between matching symbols and we press BS, automatically
  -- delete both matching symbols
  vim.keymap.set('i', '<BS>', function ()
    return keymaps.is_cursor_between_matching_symbols() and '<Esc>la<BS><BS>' or '<BS>'
  end, opts_expr)
end






return keymaps
