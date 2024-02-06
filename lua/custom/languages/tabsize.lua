local tabsize = {}

function tabsize.setup()
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
end

return tabsize
