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
        "prettier",
        "eslint-lsp",
      },
      automatic_installation = true,
    })

    local null_ls = require("null-ls")
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    null_ls.setup({
      sources = {
        -- null_ls.builtins.diagnostics.eslint,  --eslint seems to have been already set up
        null_ls.builtins.formatting.prettier,
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
