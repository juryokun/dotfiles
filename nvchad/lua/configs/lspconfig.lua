require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "rust_analyzer", "intelephense" }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers

-- my setting
local lspconfig = require "lspconfig"
local mason_registry = require "mason-registry"
-- local on_attach = require("custom.lsp.on_attach").on_attach

for _, lsp in ipairs(servers) do
  -- 利用可能なら有効化
  if mason_registry.is_installed(lsp) then
    lspconfig[lsp].setup {
      on_attach = on_attach,
      -- capabilities = capabilities,
    }
  end
end
