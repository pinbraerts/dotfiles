local t = require 'telescope.builtin'
local td = require 'telescope'.extensions.dap
local g = require 'gitsigns'
local d = require 'dap'
vim.keymap.set('n', 'gb', t.buffers)
vim.keymap.set('n', 'g/', t.search_history)
vim.keymap.set('n', 'gh', function() vim.cmd("ClangdSwitchSourceHeader") end)
vim.keymap.set('v', '<c-[>', vim.lsp.buf.definition)
vim.keymap.set({ 'o', 'x' }, 'ih', ':<c-u>Gitsigns select_hunk<cr>')
vim.keymap.set({ 'n', 'v' }, '<c-/>', '<Plug>NERDCommenterToggle')
vim.keymap.set('v', 'gs', function() g.stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end)
vim.keymap.set('v', 'gx', function() g.reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end)
vim.keymap.set('i', '<c-s>', t.symbols)
vim.keymap.set('n', 'cd', function ()
    if vim.b.gitsigns_status_dict and vim.b.gitsigns_status_dict.root then
        vim.cmd.cd(vim.b.gitsigns_status_dict.root)
    elseif #vim.lsp.get_active_clients() then
        vim.cmd.cd(vim.lsp.get_active_clients()[1].config.root_dir)
    end
end)
for key, func in pairs {
    ['/'] = t.search_history,
    ['1'] = t.keymaps,
    ['2'] = t.registers,
    [';'] = t.command_history,
    ['['] = t.current_buffer_tags,
    [']'] = t.current_buffer_fuzzy_find,
    a = t.tags,
    c = t.colorscheme,
    r = vim.lsp.rename,

    s = g.stage_hunk,
    x = g.reset_hunk,
    u = g.undo_stage_hunk,
    v = function ()
        local current_line = vim.api.nvim_win_get_cursor(0)[1]
        for _, hunk in ipairs(g.get_hunks()) do
            if current_line >= hunk.added.start and current_line <= hunk.added.start + hunk.added.count then
                if hunk.added.count + hunk.removed.count > 4 then
                    g.preview_hunk()
                else
                    g.preview_hunk_inline()
                end
            end
        end
    end,
    V = g.preview_hunk,
    S = g.stage_buffer,
    X = g.reset_buffer,
    gv = g.preview_hunk,
    gb = t.git_branches,
    gc = t.git_bcommits,
    gs = t.git_status,
    gg = t.live_grep,
    gl = t.git_commits,
    gh = t.git_stash,
    gd = g.diffthis,
    gk = g.toggle_current_line_blame,
    F = t.find_files,

    la = t.lsp_dynamic_workspace_symbols,
    ld = t.lsp_document_symbols,
    li = t.lsp_incoming_calls,
    lo = t.lsp_outgoing_calls,
    lr = t.lsp_references,
    ls = t.lsp_workspace_symbols,
    lt = t.lsp_type_definitions,
    lb = td.list_breakpoints,

    b = d.toggle_breakpoint,
    j = d.step_over,
    k = d.step_out,
    dl = d.step_into,
    dc = d.continue,
    dC = d.reverse_continue,
    dr = d.run,
    dx = d.terminate,
    dh = d.step_back,
    dp = d.pause,
    dn = d.down,
    du = d.up,
    dd = d.run_to_cursor,
    dq = d.close,

    f = t.find_files,
    h = t.help_tags,
    i = t.jumplist,
    m = t.marks,
    n = td.configurations,
    o = t.jumplist,
    q = t.quickfix,
    tt = t.builtin,
    tc = t.commands,
    tf = t.oldfiles,
    to = t.vim_options,
    tp = t.pickers,
    tq = t.quickfixhistory,
    td = t.diagnostics,
    tr = t.resume,
    ts = t.symbols,
    w = t.grep_string,
} do
    vim.keymap.set('n', '<leader>'..key, func)
end

local v = vim.diagnostic
local vs = v.severity
vim.keymap.set('n', '[d', v.goto_prev)
vim.keymap.set('n', ']d', v.goto_next)
vim.keymap.set('n', '[e', function () v.goto_prev { severity = vs.ERROR } end)
vim.keymap.set('n', ']e', function () v.goto_next { severity = vs.ERROR } end)
vim.keymap.set('n', '[w', function () v.goto_prev { severity = vs.WARNING } end)
vim.keymap.set('n', ']w', function () v.goto_next { severity = vs.WARNING } end)

g.setup {
    on_attach = function(buffer)
        vim.o.signcolumn = 'yes'
        local options = { buffer = buffer }

        vim.keymap.set('n', '<esc>', function ()
            for _, id in ipairs(vim.api.nvim_list_wins()) do
                if vim.api.nvim_win_get_config(id).relative ~= "" then
                    vim.api.nvim_win_close(id, false)
                end
            end
            vim.cmd.nohls()
        end, options)

        options.expr = true
        vim.keymap.set('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(g.next_hunk)
            return '<Ignore>'
        end, options)
        vim.keymap.set('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(g.prev_hunk)
            return '<Ignore>'
        end, options)
    end
}

vim.api.nvim_create_autocmd('DirChanged', {
    group = vim.api.nvim_create_augroup('git', { clear = true }),
    callback = function ()
        if vim.fs.dir('.git')() then
            vim.keymap.set('n', '<leader>f', t.git_files)
            vim.keymap.set('n', 'gs', t.git_status) -- default go to sleep
        else
            vim.keymap.set('n', '<leader>f', t.find_files)
            vim.keymap.set('n', 'gs', function () end)
            vim.keymap.del('n', 'gs') -- default go to sleep
        end
    end,
})

