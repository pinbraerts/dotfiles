local cmp_capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')
lspconfig.lua_ls.setup {
	settings = {
		Lua = {
			runtime = {
				version = 'LuaJIT',
			},
			diagnostics = {
				globals = {'vim'},
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
			telemetry = { enable = false },
		},
	},
    single_file_support = true,
	capabilities = cmp_capabilities,
}
lspconfig.pylsp.setup {
	capabilities = cmp_capabilities,
}
lspconfig.clangd.setup {
	capabilities = cmp_capabilities,
}
lspconfig.powershell_es.setup {
    capabilities = cmp_capabilities,
    single_file_support = true,
    bundle_path = 'D:/PowerShellEditorServices',
}
require 'rust-tools'.setup {
    single_file_support = true,
    server = {
        standalone = true,
    },
}

local t = require 'telescope.builtin'
local d = require 'dap'
local dui = require 'dap.ui'
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('lsp', { clear = true }),
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
        local options = { buffer = args.buf }
		local capabilities = client.server_capabilities
		if capabilities.completionProvider then
			vim.bo[args.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
		end
		if capabilities.definitionProvider then
			vim.bo[args.buf].tagfunc = "v:lua.vim.lsp.tagfunc"
            vim.keymap.set('n', '<c-]>', vim.lsp.buf.definition, options)
		end
        if capabilities.declarationProvider then
            vim.keymap.set('n', '<c-[>', vim.lsp.buf.declaration, options)
        end
        if capabilities.implementationProvider then
            vim.keymap.set('n', '<c-p>', vim.lsp.buf.implementation, options)
        end
        if capabilities.documentSymbolProvider then
            vim.keymap.set('n', '<leader>[', t.lsp_document_symbols, options)
        end
        if capabilities.workspaceSymbolProvider then
            vim.keymap.set('n', '<leader>p', t.lsp_dynamic_workspace_symbols, options)
            vim.keymap.set('n', '<leader>a', t.lsp_workspace_symbols, options)
        end
        if capabilities.referencesProvider then
            vim.keymap.set('n', '<leader>]', t.lsp_references, options)
        end
        if capabilities.codeActionProvider then
            vim.keymap.set('n', '<leader><space>', function ()
                vim.lsp.buf.code_action {
                    filter = function(action) return action.isPreferred end,
                    apply = true,
                }
            end, options)
        end
        if capabilities.hoverProvider then
            vim.keymap.set('n', 'K', function ()
                if d.status() ~= "" then
                    dui.hover()
                else
                    vim.lsp.buf.hover()
                end
            end, options)
        end
        if capabilities.documentFormattingProvider then
            vim.bo[args.buf].formatexpr = "v:lua.vim.lsp.formatexpr()"
            vim.keymap.set({ 'n', 'v' }, '=', 'gq', { remap = true, buffer = args.buf })
        end
	end,
})

vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('lsp', { clear = true }),
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
        local options = { buffer = args.buf }
		local capabilities = client.server_capabilities
		if capabilities.completionProvider then
			vim.bo[args.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
		end
		if capabilities.definitionProvider then
			vim.bo[args.buf].tagfunc = "v:lua.vim.lsp.tagfunc"
            vim.keymap.set('n', '<c-]>', vim.lsp.buf.definition, options)
		end
        if capabilities.declarationProvider then
            vim.keymap.set('n', '<c-[>', vim.lsp.buf.declaration, options)
        end
        if capabilities.implementationProvider then
            vim.keymap.set('n', '<c-p>', vim.lsp.buf.implementation, options)
        end
        if capabilities.documentSymbolProvider then
            vim.keymap.set('n', '<leader>[', t.lsp_document_symbols, options)
        end
        if capabilities.workspaceSymbolProvider then
            vim.keymap.set('n', '<leader>p', t.lsp_dynamic_workspace_symbols, options)
            vim.keymap.set('n', '<leader>a', t.lsp_workspace_symbols, options)
        end
        if capabilities.referencesProvider then
            vim.keymap.set('n', '<leader>]', t.lsp_references, options)
        end
        if capabilities.codeActionProvider then
            vim.keymap.set('n', '<leader><space>', function ()
                vim.lsp.buf.code_action {
                    filter = function(action) return action.isPreferred end,
                    apply = true,
                }
            end, options)
        end
        if capabilities.hoverProvider then
            vim.keymap.set('n', 'K', function ()
                if d.status() ~= "" then
                    dui.hover()
                else
                    vim.lsp.buf.hover()
                end
            end, options)
        end
        if capabilities.documentFormattingProvider then
            vim.bo[args.buf].formatexpr = "v:lua.vim.lsp.formatexpr()"
            vim.keymap.set({ 'n', 'v' }, '=', 'gq', { remap = true, buffer = args.buf })
        end
	end,
})

local luasnip = require('luasnip')
local cmp = require('cmp')
local function snip_next (fallback)
    if cmp.visible() then
        cmp.select_next_item()
    elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
    else
        fallback()
    end
end
snip_next = cmp.mapping(snip_next)
local function snip_prev (fallback)
    if cmp.visible() then
        cmp.select_prev_item()
    elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
    else
        fallback()
    end
end
snip_prev = cmp.mapping(snip_prev)
cmp.setup {
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
	},
	mapping = cmp.mapping.preset.insert {
		['<c-u>'] = cmp.mapping.scroll_docs(-4),
		['<c-d>'] = cmp.mapping.scroll_docs(4),
		['<tab>'] = snip_next,
		['<s-tab>'] = snip_prev,
		['<c-n>'] = snip_next,
		['<c-p>'] = snip_prev,
		['<c-space>'] = cmp.mapping.complete(),
		['<cr>'] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		},
    },
}
