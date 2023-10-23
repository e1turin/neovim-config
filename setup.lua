-- Settings
require('core.settings')
require('core.mappings') -- Make sure to set `mapleader` before Lazy (plugin manager) so your mappings are correct
require('core.plugin-manager')
require('core.theme')

-- Plugin settings
require('plugins.mason') -- IMPORTANT: After setting up mason-lspconfig you may set up servers via lspconfig
require('plugins.cmp') -- TODO: move imports to package manager
require("plugins.lspconfig")

-- startup configuration
require('core.on-startup')
