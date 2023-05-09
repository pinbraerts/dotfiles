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
	capabilities = cmp_capabilities,
}
lspconfig.pylsp.setup {
	capabilities = cmp_capabilities,
}
lspconfig.clangd.setup {
	capabilities = cmp_capabilities,
}

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)

local lsp_group = vim.api.nvim_create_augroup('lsp', { clear = false })
vim.api.nvim_create_autocmd('LspAttach', {
	group = lsp_group,
	callback = function(args)
		vim.treesitter.start(args.buf, args.filetype)
		local capabilities = vim.lsp.get_client_by_id(args.data.client_id).server_capabilities
		if capabilities.completionProvider then
			vim.bo[args.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
		end
		if capabilities.definitionProvider then
			vim.bo[args.buf].tagfunc = "v:lua.vim.lsp.tagfunc"
		end
		local maps = {
			{           'hover',  'K' },
			{          'rename', '/r' },
			-- {      'codeAction', '/a' },
			{      'definition', '/j' },
			-- {      'references', '/e' },
			{     'declaration', '/u' },
			{   'signatureHelp', '/k' },
			-- {  'documentSymbol', '/d' },
			{  'implementation', '/i' },
			{  'typeDefinition', '/o' },
			-- { 'workspaceSymbol', '/f' },
		}
		for _, map in ipairs(maps) do
			local key  = map[2]:gsub('/', '<leader>')
			local mode = map[4] or 'n'
			if not key or not mode then
				goto continue
			end
			local name = map[1]:gsub('([a-z])([A-Z])', '%1_%2'):lower()
			local func = map[3] or vim.lsp.buf[name]
			if not capabilities[map[1] .. 'Provider'] or not func then
				func = function ()
					print(map[1] .. " not supported")
				end
			end
			vim.keymap.set(mode, key, func, { buffer = args.buf })
			::continue::
		end
	end,
})

local luasnip = require('luasnip')
local cmp = require('cmp')
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
	mapping = cmp.mapping.preset.insert({
		['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
		['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
		-- C-b (back) C-f (forward) for snippet placeholder navigation.
		['<C-Space>'] = cmp.mapping.complete(),
		['<CR>'] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		},
		['<Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { 'i', 's' }),
		['<S-Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { 'i', 's' }),	}),
	}
