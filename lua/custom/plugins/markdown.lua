return {
  'plasticboy/vim-markdown',
  branch = 'master',
  require = {'godlygeek/tabular'},
  config = function()
    vim.g.vim_markdown_folding_disabled = 1
    vim.g.vim_markdown_conceal = 0
    vim.g.vim_markdown_conceal_code_blocks = 0
    vim.g.vim_markdown_math = 1
    vim.g.vim_markdown_frontmatter = 1
    vim.g.vim_markdown_toml_frontmatter = 1
    vim.g.vim_markdown_json_frontmatter = 1
  end
}

