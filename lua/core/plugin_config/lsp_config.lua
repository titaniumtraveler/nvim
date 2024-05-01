require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "tsserver", "clangd" },
  lazy = false,
  opts = {
    auto_install = true,
  },
})

local langservers = {
  'html',
  'cssls',
  'clangd',
  'tsserver',
  'lua_ls',
  "pyright",
}

local on_attach = function(client, bufnr)
  vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, {})
  vim.keymap.set("n", "<S-K>", vim.lsp.buf.hover, {})
end
local capabilities = require('cmp_nvim_lsp').default_capabilities()

for _, server in ipairs(langservers) do
  require'lspconfig'[server].setup{
    on_attach = on_attach,
    capabilities = capabilities
  }
end

require'lspconfig'.lua_ls.setup{
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim", "opt", "cmd" }
      },
    },
    runtime = {
      version = "LuaJIT"
    }
  }
}
