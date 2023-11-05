local t = require 'telescope.builtin'
local te = require 'telescope'.extensions
local td = te.dap
local tf = te.file_browser
local g = require 'gitsigns'
local d = require 'dap'
vim.keymap.set('n', 'gh', function() vim.cmd("ClangdSwitchSourceHeader") end)
vim.keymap.set('v', '<c-[>', vim.lsp.buf.definition)
vim.keymap.set({ 'o', 'x' }, 'ih', ':<c-u>Gitsigns select_hunk<cr>')
vim.keymap.set({ 'n', 'v' }, '<c-/>', '<Plug>NERDCommenterToggle')
vim.keymap.set({ 'n', 'v' }, '<leader>/', '<Plug>NERDCommenterToggle')
vim.keymap.set('n', 'gs', g.stage_hunk)
vim.keymap.set('n', 'gx', g.reset_hunk)
vim.keymap.set({ 'v', 'n' }, 'gu', g.undo_stage_hunk)
vim.keymap.set('n', 'gS', g.stage_buffer)
vim.keymap.set('n', 'gX', g.reset_buffer)
vim.keymap.set('v', 'gs', function() g.stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end)
vim.keymap.set('v', 'gx', function() g.reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end)
vim.keymap.set('i', '<c-s>', t.symbols)
vim.keymap.set('n', 'cd', function ()
    if vim.b.gitsigns_status_dict and vim.b.gitsigns_status_dict.root then
        vim.cmd.cd(vim.b.gitsigns_status_dict.root)
    elseif #vim.lsp.get_active_clients() then
        vim.cmd.cd(vim.lsp.get_active_clients()[1].config.root_dir)
    else
        vim.cmd.cd(vim.fn.dirname(vim.fn.bufname()))
    end
end)
for key, func in pairs {
    [']'] = t.current_buffer_fuzzy_find,
    ['t/'] = t.search_history,
    ['t;'] = t.command_history,
    b = d.toggle_breakpoint,
    dC = d.reverse_continue,
    db = td.list_breakpoints,
    dc = d.continue,
    dd = td.configurations,
    df = td.frames,
    dh = d.step_back,
    dj = d.run_to_cursor,
    dn = d.down,
    dp = d.pause,
    dq = d.close,
    dr = d.run,
    du = d.up,
    dv = td.variables,
    dx = d.terminate,
    fb = tf.file_browser,
    ff = t.find_files,
    gb = t.git_branches,
    gc = t.git_bcommits,
    gd = g.diffthis,
    gf = t.git_files,
    gg = t.live_grep,
    gh = t.git_stash,
    gk = g.toggle_current_line_blame,
    gl = t.git_commits,
    gs = t.git_status,
    gv = g.preview_hunk,
    gw = t.grep_string,
    h = t.help_tags,
    j = d.step_over,
    k = d.step_out,
    l = d.step_into,
    la = vim.lsp.buf.action,
    ld = t.current_buffer_tags,
    lf = t.tags,
    li = t.lsp_incoming_calls,
    lo = t.lsp_outgoing_calls,
    lr = vim.lsp.buf.rename,
    ls = t.tagstack,
    lt = t.lsp_type_definitions,
    m = t.marks,
    q = t.quickfix,
    rf = t.oldfiles, -- recent files
    tb = t.buffers,
    tc = t.colorscheme,
    td = t.diagnostics,
    tk = t.keymaps,
    tl = t.jumplist,
    to = t.vim_options,
    tp = t.pickers,
    tq = t.quickfixhistory,
    tr = t.registers,
    ts = t.symbols,
    tj = t.builtin,
    tt = t.resume,
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
vim.keymap.set('n', '[i', function () v.goto_prev { severity = vs.INFO } end)
vim.keymap.set('n', ']i', function () v.goto_next { severity = vs.INFO } end)

g.setup {
    on_attach = function(buffer)
        vim.o.signcolumn = 'yes'
        local options = { buffer = buffer }

        options.expr = true
        vim.keymap.set('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(g.next_hunk)
            vim.schedule(g.preview_hunk_inline)
            return '<Ignore>'
        end, options)
        vim.keymap.set('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(g.prev_hunk)
            vim.schedule(g.preview_hunk_inline)
            return '<Ignore>'
        end, options)
    end
}

