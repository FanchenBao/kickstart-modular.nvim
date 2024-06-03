local telescope = {}
local actions = require('telescope.actions')

function telescope.setup()
  -- Allow live grep to include hidden files
  -- require('telescope').setup{
  --   defaults = {
  --     vimgrep_arguments = { 'rg', '--hidden', '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case' },
  --   },
  -- }

  -- vim.keymap.set('n', '<leader>sg', function ()
  --   require('telescope.builtin').live_grep {
  --     additional_args = {"--hidden"},
  --   }
  -- end, { desc = '[S]earch by [G]rep' })
  --
  -- -- Allow telescope to show hidden files
  --  vim.keymap.set('n', '<leader>sf', function ()
  --   require('telescope.builtin').find_files {
  --     find_command = { 'rg', '--files', '--iglob', '!.git', '--hidden' },
  --   }
  -- end, { desc = '[S]earch [F]iles' })
  require('telescope').setup{
    defaults = {
      mappings = {
        i = {
          ["<C-j>"] = actions.cycle_history_next,
          ["<C-k>"] = actions.cycle_history_prev,
        }
      },
      history = {
        cycle_wrap = true,
      },
    },
    pickers = {
      find_files = {
        find_command = { 'rg', '--files', '--iglob', '!.git', '--hidden' },
      },
      grep_string = {
        additional_args = {'--hidden'}
      },
      live_grep = {
        additional_args = {'--hidden'}
      }
    }
  }

  local builtin = require('telescope.builtin')
  vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = "Find Buffers"})
  vim.keymap.set('n', '<leader>gs', '<cmd>AdvancedGitSearch<CR>', { desc = 'AdvancedGitSearch' })

end

return telescope
