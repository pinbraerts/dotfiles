vim.keymap.set('n', 'gh', '<cmd>ClangdSwitchSourceHeader<cr>', { desc = 'Switch beetween source and header files by clangd' })
vim.keymap.set({ 'n', 'v' }, '<c-/>', '<Plug>NERDCommenterToggle', { desc = 'Toggle comment' })
vim.keymap.set({ 'n', 'v' }, '<leader>/', '<Plug>NERDCommenterToggle', { desc = 'Toggle comment' })

local t = require 'telescope.builtin'
vim.keymap.set('i', '<c-s>', t.symbols, { desc = 'Open unicode symbols picker' })
vim.keymap.set('n', '<leader>]', t.current_buffer_fuzzy_find, { desc = 'Fuzzy find' })
vim.keymap.set('n', '<leader>t/', t.search_history, { desc = 'Search history' })
vim.keymap.set('n', '<leader>t;', t.command_history, { desc = 'Command history' })
vim.keymap.set('n', '<leader>h', t.help_tags, { desc = '[L]ist [h]elp tags' })
vim.keymap.set('n', '<leader>m', t.marks, { desc = '[L]ist marks' })
vim.keymap.set('n', '<leader>q', t.quickfix, { desc = '[L]ist [q]uickfix' })
vim.keymap.set('n', '<leader>tb', t.buffers, { desc = '[L]is[t] [b]uffers' })
vim.keymap.set('n', '<leader>tc', t.colorscheme, { desc = '[L]is[t] [c]olorscheme' })
vim.keymap.set('n', '<leader>td', t.diagnostics, { desc = '[L]is[t] [d]iagnostics' })
vim.keymap.set('n', '<leader>tk', t.keymaps, { desc = '[L]is[t] [k]eymaps' })
vim.keymap.set('n', '<leader>tl', t.jumplist, { desc = 'Jump[l]is[t]' })
vim.keymap.set('n', '<leader>to', t.vim_options, { desc = '[L]is[t] [o]ptions' })
vim.keymap.set('n', '<leader>tp', t.pickers, { desc = '[L]is[t] [p]ickers' })
vim.keymap.set('n', '<leader>tq', t.quickfixhistory, { desc = '[L]is[t] [q]uckfix history' })
vim.keymap.set('n', '<leader>tr', t.registers, { desc = '[L]is[t] [r]egisters' })
vim.keymap.set('n', '<leader>ts', t.symbols, { desc = '[L]is[t] [s]ymbols' })
vim.keymap.set('n', '<leader>tj', t.builtin, { desc = '[L]is[t] builtin pickers' })
vim.keymap.set('n', '<leader>tt', t.resume, { desc = 'Reopen last picker' })

local te = require 'telescope'.extensions
local tf = te.file_browser
vim.keymap.set('n', '<leader>fb', tf.file_browser, { desc = '[F]ile [b]rowser' })
vim.keymap.set('n', '<leader>fd', t.find_files, { desc = 'Find files (with [fd])' })
vim.keymap.set('n', '<leader>gf', t.git_files, { desc = '[L]ist [g]it [f]iles' })
vim.keymap.set('n', '<leader>gg', t.live_grep, { desc = '[G]rep' })
vim.keymap.set('n', '<leader>gw', t.grep_string, { desc = '[G]rep [w]ord' })
vim.keymap.set('n', '<leader>rf', t.oldfiles, { desc = '[L]ist [r]ecent [f]iles' })

vim.keymap.set('v', '<c-[>', vim.lsp.buf.definition, { desc = 'Get definition with lsp' })
vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, { desc = '[L]SP code [a]ction' })
vim.keymap.set('n', '<leader>ld', t.current_buffer_tags, { desc = '[L]ist [L]SP buffer [t]ags' })
vim.keymap.set('n', '<leader>lf', t.tags, { desc = '[L]ist [L]SP [f]ull tags' })
vim.keymap.set('n', '<leader>li', t.lsp_incoming_calls, { desc = '[L]ist [L]SP [i]ncoming calls' })
vim.keymap.set('n', '<leader>lo', t.lsp_outgoing_calls, { desc = '[L]ist [L]SP [o]outgoing calls' })
vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, { desc = '[L]SP rename' })
vim.keymap.set('n', '<leader>ls', t.tagstack, { desc = '[L]SP tag[s]tack' })
vim.keymap.set('n', '<leader>lt', t.lsp_type_definitions, { desc = '[L]ist [L]SP [t]ype definitions' })

local g = require 'gitsigns'
vim.keymap.set({ 'o', 'x' }, 'ih', g.select_hunk, { desc = 'Select hunk movement' })
vim.keymap.set('n', '<leader>s', g.stage_hunk, { desc = 'Git stage hunk' })
vim.keymap.set('n', '<leader>x', g.reset_hunk, { desc = 'Git reset hunk' })
vim.keymap.set('v', '<leader>s', function() g.stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end, { desc = 'Git stage selection' })
vim.keymap.set('v', '<leader>x', function() g.reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end, { desc = 'Git reset selection' })
vim.keymap.set({ 'v', 'n' }, '<leader>u', g.undo_stage_hunk, { desc = 'Git unstage hunk' })
vim.keymap.set('n', '<leader>S', g.stage_buffer, { desc = 'Git stage buffer' })
vim.keymap.set('n', '<leader>X', g.reset_buffer, { desc = 'Git reset buffer' })
vim.keymap.set('n', '<leader>U', g.reset_buffer_index, { desc = 'Git unstage buffer' })
vim.keymap.set('n', '<leader>gb', t.git_branches, { desc = '[L]ist [g]it [b]ranches' })
vim.keymap.set('n', '<leader>gc', t.git_bcommits, { desc = '[L]ist [g]it [c]ommits in the branch' })
vim.keymap.set('n', '<leader>gd', g.diffthis, { desc = '[G]it [d]iff this' })
vim.keymap.set('n', '<leader>gk', g.toggle_current_line_blame, { desc = '[G]it toggle blame' })
vim.keymap.set('n', '<leader>gv', g.preview_hunk, { desc = '[G]it pre[v]iew' })
vim.keymap.set('n', '<leader>gh', t.git_stash, { desc = '[G]it stas[h]' })
vim.keymap.set('n', '<leader>gl', t.git_commits, { desc = '[G]it [l]og commits' })
vim.keymap.set('n', '<leader>gs', t.git_status, { desc = '[G]it [s]tatus' })

local d = require 'dap'
local td = te.dap
vim.keymap.set('n', '<leader>db', td.list_breakpoints, { desc = '[L]ist [d]ebug [b]reakpoints' })
vim.keymap.set('n', '<leader>dd', td.configurations, { desc = '[L]ist [d]ebug [c]onfigurations' })
vim.keymap.set('n', '<leader>df', td.frames, { desc = '[List] [d]ebug [f]rames' })
vim.keymap.set('n', '<leader>b', d.toggle_breakpoint, { desc = 'Toggle breakpoint' })
vim.keymap.set('n', '<leader>dc', d.continue, { desc = '[D]ebug [c]ontinue' })
vim.keymap.set('n', '<leader>dC', d.reverse_continue, { desc = '[D]ebug reverse [c]ontinue' })
vim.keymap.set('n', '<leader>dh', d.step_back, { desc = '[D]ebug step back' })
vim.keymap.set('n', '<leader>dj', d.run_to_cursor, { desc = '[D]ebug run to cursor' })
vim.keymap.set('n', '<leader>dn', d.down, { desc = '[D]ebug dow[n]' })
vim.keymap.set('n', '<leader>dp', d.pause, { desc = '[D]ebug [p]ause' })
vim.keymap.set('n', '<leader>dq', d.close, { desc = '[D]ebug [q]iut' })
vim.keymap.set('n', '<leader>dr', d.run, { desc = '[D]ebug [r]un' })
vim.keymap.set('n', '<leader>du', d.up, { desc = '[D]ebug [u]p' })
vim.keymap.set('n', '<leader>dv', td.variables, { desc = '[L]ist [d]ebug [v]ariables' })
vim.keymap.set('n', '<leader>dx', d.terminate, { desc = '[D]ebug terminate' })
vim.keymap.set('n', '<leader>j', d.step_over, { desc = 'Step over' })
vim.keymap.set('n', '<leader>k', d.step_out, { desc = 'Step out' })
vim.keymap.set('n', '<leader>l', d.step_into, { desc = 'Step into' })

local v = vim.diagnostic
local vs = v.severity
vim.keymap.set('n', '[d', v.goto_prev, { desc = 'Go to previous diagnostic' })
vim.keymap.set('n', ']d', v.goto_next, { desc = 'Go to next diagnostic' })
vim.keymap.set('n', '[e', function () v.goto_prev { severity = vs.ERROR } end, { desc = 'Go to previous error' })
vim.keymap.set('n', ']e', function () v.goto_next { severity = vs.ERROR } end, { desc = 'Go to next error' })
vim.keymap.set('n', '[w', function () v.goto_prev { severity = vs.WARNING } end, { desc = 'Go to previous warning' })
vim.keymap.set('n', ']w', function () v.goto_next { severity = vs.WARNING } end, { desc = 'Go to next warning' })
vim.keymap.set('n', '[i', function () v.goto_prev { severity = vs.INFO } end, { desc = 'Go to previous information' })
vim.keymap.set('n', ']i', function () v.goto_next { severity = vs.INFO } end, { desc = 'Go to next information' })

vim.keymap.set('n', 'cd', function ()
    if vim.b.gitsigns_status_dict and vim.b.gitsigns_status_dict.root then
        vim.cmd.cd(vim.b.gitsigns_status_dict.root)
    elseif #vim.lsp.get_active_clients() then
        vim.cmd.cd(vim.lsp.get_active_clients()[1].config.root_dir)
    else
        vim.cmd.cd(vim.fn.dirname(vim.fn.bufname()))
    end
end)

g.setup {
    on_attach = function(buffer)
        vim.o.signcolumn = 'yes'

        vim.keymap.set('n', '<esc>', function ()
            for _, id in ipairs(vim.api.nvim_list_wins()) do
                if vim.api.nvim_win_get_config(id).relative ~= "" then
                    vim.api.nvim_win_close(id, false)
                end
            end
            vim.cmd.nohls()
        end, { buffer = buffer, desc = 'close relative window' })

        vim.keymap.set('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(g.next_hunk)
            vim.schedule(g.preview_hunk_inline)
            return '<Ignore>'
        end, { expr = true, buffer = buffer, desc = 'Go to next hunk' })
        vim.keymap.set('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(g.prev_hunk)
            vim.schedule(g.preview_hunk_inline)
            return '<Ignore>'
        end, { expr = true, buffer = buffer, desc = 'Go to previous hunk' })
    end
}

