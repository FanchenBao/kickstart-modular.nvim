--[[ Custom config of nvim-cmp ]]
local cmp = {}

function cmp.setup()
  local _cmp = require 'cmp'
  _cmp.setup{
    mapping = _cmp.mapping.preset.insert{
      --[[ Custom mapping ]]
      --Return j and k for scrolling the items.
      ['<C-j>'] = _cmp.mapping.select_next_item(),
      ['<C-k>'] = _cmp.mapping.select_prev_item(),
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
end


return cmp
