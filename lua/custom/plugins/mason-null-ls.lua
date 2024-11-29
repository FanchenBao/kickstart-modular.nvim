--[[ Use this tool to just install linter and formatter that cannot be installed via mason-lspconfig ]]
--
return {
  "jay-babu/mason-null-ls.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "nvimtools/none-ls.nvim", -- replaces null-ls
  },
  config = function()
    require("mason-null-ls").setup({
      ensure_installed =
      {
        -- javascript
        "prettier",
        "eslint-lsp",
        -- python
        "mypy",
        "black",
        -- go
        "gofumpt",
        "goimports-reviser",
        "golines",
        -- cpp
        "clang-format",
      },
      automatic_installation = true,
    })

    local null_ls = require("null-ls")
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    null_ls.setup({
      sources = {
        -- null_ls.builtins.diagnostics.eslint,  -- seems to have been already set up by eslint-lsp
        null_ls.builtins.formatting.prettier.with {
          -- NOTE: I eventually choose not to set the following condition
          -- because it is too limiting. While my project can always have
          -- .prettierrc.js set up, other people's repo might not.
          --
          -- condition = function (utils)
          --   return utils.root_has_file {'.prettierrc.js'}
          -- end,
          prefer_local = 'node_modules/.bin',
        },

        -- python
        null_ls.builtins.diagnostics.mypy,
        null_ls.builtins.formatting.black,

        -- go
        null_ls.builtins.formatting.goimports_reviser,
        null_ls.builtins.formatting.golines.with {
          extra_args = {"-m", "79"},
        },

        -- cpp
        null_ls.builtins.formatting.clang_format,
      },
      on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({
            group = augroup,
            buffer = bufnr,
          })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ bufnr = bufnr })
            end,
          })
        end
      end,
    })
  end,
}

