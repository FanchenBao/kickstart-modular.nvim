local python = {}

function python.setup()
  --[[ Python set up ]]
  -- refer to https://neovim.io/doc/user/provider.html#provider-python
  vim.g.python3_host_prog = '~/.pyenv/versions/pynvim/bin/python'
end

return python


