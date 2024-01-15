return {
  "ixru/nvim-markdown",
  config = function()
    vim.g.vim_markdown_conceal = 0
    vim.g.vim_markdown_math = 1
    vim.g.vim_markdown_frontmatter = 1
    vim.g.vim_markdown_toml_frontmatter = 1
    vim.g.vim_markdown_json_frontmatter = 1
  end
}

