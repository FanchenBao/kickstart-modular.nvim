local telescope = {}

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

end

return telescope
