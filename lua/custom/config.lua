--[[ Custome options ]]
local config = {}

function config.setup()
  vim.wo.number = true
  vim.wo.relativenumber = true
  vim.opt.colorcolumn = '79,120'
  vim.opt.splitright = true  --when a panel is vertically split, it appears on the right side
  vim.wo.linebreak = true

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
end


return config

