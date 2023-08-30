local t = require 'telescope.builtin'
local te = require 'telescope'.extensions
local td = te.dap
local tf = te.file_browser
local g = require 'gitsigns'
local d = require 'dap'
vim.keymap.set('n', 'gb', t.buffers)
vim.keymap.set('n', 'g/', t.search_history)
vim.keymap.set('n', 'gh', function() vim.cmd("ClangdSwitchSourceHeader") end)
vim.keymap.set('v', '<c-[>', vim.lsp.buf.definition)
vim.keymap.set({ 'o', 'x' }, 'ih', ':<c-u>Gitsigns select_hunk<cr>')
vim.keymap.set({ 'n', 'v' }, '<c-/>', '<Plug>NERDCommenterToggle')
vim.keymap.set({ 'n', 'v' }, '<leader>c', '<Plug>NERDCommenterToggle')
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
    S = g.stage_buffer,
    V = g.preview_hunk,
    X = g.reset_buffer,
    ['/'] = t.search_history,
    ['1'] = t.keymaps,
    ['2'] = t.registers,
    [';'] = t.command_history,
    ['['] = t.current_buffer_tags,
    [']'] = t.current_buffer_fuzzy_find,
    a = t.tags,
    b = d.toggle_breakpoint,
    tc = t.colorscheme,
    dC = d.reverse_continue,
    dc = d.continue,
    dd = d.run_to_cursor,
    dh = d.step_back,
    dl = d.step_into,
    dn = d.down,
    dp = d.pause,
    dq = d.close,
    dr = d.run,
    du = d.up,
    dx = d.terminate,

    rf = t.oldfiles,
    fb = tf.file_browser,
    ff = t.find_files,

    gb = t.git_branches,
    gc = t.git_commits,
    gd = g.diffthis,
    gf = t.git_files,
    gg = t.live_grep,
    gh = t.git_stash,
    gk = g.toggle_current_line_blame,
    gl = t.git_commits,
    gs = t.git_status,
    gv = g.preview_hunk,
    h = t.help_tags,
    i = t.jumplist,
    j = d.step_over,
    k = d.step_out,
    la = t.lsp_dynamic_workspace_symbols,
    lb = td.list_breakpoints,
    ld = t.lsp_document_symbols,
    li = t.lsp_incoming_calls,
    lo = t.lsp_outgoing_calls,
    lr = vim.lsp.buf.rename,
    ls = t.lsp_workspace_symbols,
    lt = t.lsp_type_definitions,
    m = t.marks,
    n = td.configurations,
    o = t.jumplist,
    q = t.quickfix,
    s = g.stage_hunk,
    td = t.diagnostics,
    tf = t.oldfiles,
    to = t.vim_options,
    tp = t.pickers,
    tq = t.quickfixhistory,
    tr = t.resume,
    ts = t.symbols,
    tt = t.builtin,
    u = g.undo_stage_hunk,
    w = t.grep_string,
    x = g.reset_hunk,
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

vim.api.nvim_create_autocmd('DirChanged', {
    group = vim.api.nvim_create_augroup('git', { clear = true }),
    callback = function ()
        if vim.fs.dir('.git') then
            vim.keymap.set('n', 'gs', t.git_status) -- default go to sleep
        else
            vim.keymap.set('n', 'gs', function () end)
            vim.keymap.del('n', 'gs') -- default go to sleep
        end
    end,
})

