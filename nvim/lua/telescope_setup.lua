local t = require 'telescope'
local fba = t.extensions.file_browser.actions
local a = require 'telescope.actions'

t.setup {
    defaults = {
        path_display = { 'smart', },
        layout_config = {
            preview_width = 80,
        },
        mappings = {
            i = {
                ['<c-j>'] = {
                    a.move_selection_next,
                    type = 'action',
                    opts = { nowait = true, silent = true },
                },
                ['<c-k>'] = {
                    a.move_selection_previous,
                    type = 'action',
                    opts = { nowait = true, silent = true },
                },
                ['<c-l>'] = 'select_vertical',
                ['<c-v>'] = 'select_vertical',
                ['<c-h>'] = 'select_horizontal',
                ['<c-s>'] = { '<esc>S', type = 'command' },
            },
            n = {
                dd = fba.remove,
                v = 'toggle_selection',
                l = 'select_vertical',
                h = 'select_horizontal',
                q = 'close',
                ['<c-c>'] = 'close',
            },
        },
    },
    pickers = {
        pickers = {
            mappings = {
                i = {
                    ['<c-l>'] = 'select_default',
                },
                n = {
                    l = 'select_default',
                },
            },
        },
        lsp_references = { initial_mode = 'normal' },
        colorscheme = {
            enable_preview = true,
        },
        builtin = { include_extensions = true, },
        buffers = {
            mappings = {
                n = {
                    dd = 'delete_buffer',
                },
            },
        },
        help_tags = {
            mappings = {
                i = {
                    ['<enter>'] = 'select_vertical',
                },
                n = {
                    ['<c-enter>'] = 'select_vertical',
                },
            },
        },
        git_status = {
            initial_mode = 'normal',
            mappings = {
                n = {
                    s = 'git_staging_toggle',
                    u = 'git_staging_toggle',
                    c = { ':G commit<cr>', type = 'command', },
                },
            },
        },
    },
    extensions = {
        file_browser = {
            respect_gitignore = false,
            auto_depth = 2,
            layout_config = {
                preview_width = 0.5,
            },
        },
    },
}

local b = require 'telescope.builtin'
vim.keymap.set('n', '<leader>]', b.current_buffer_fuzzy_find, { desc = 'Fuzzy find' })
vim.keymap.set('n', '<leader>t/', b.search_history, { desc = 'Search history' })
vim.keymap.set('n', '<leader>t;', b.command_history, { desc = 'Command history' })
vim.keymap.set('n', '<leader>h', b.help_tags, { desc = '[L]ist [h]elp tags' })
vim.keymap.set('n', '<leader>m', b.marks, { desc = '[L]ist marks' })
vim.keymap.set('n', '<leader>q', b.quickfix, { desc = '[L]ist [q]uickfix' })
vim.keymap.set('n', '<leader>tb', b.buffers, { desc = '[L]is[t] [b]uffers' })
vim.keymap.set('n', '<leader>tc', b.colorscheme, { desc = '[L]is[t] [c]olorscheme' })
vim.keymap.set('n', '<leader>td', b.diagnostics, { desc = '[L]is[t] [d]iagnostics' })
vim.keymap.set('n', '<leader>tk', b.keymaps, { desc = '[L]is[t] [k]eymaps' })
vim.keymap.set('n', '<leader>tl', b.jumplist, { desc = 'Jump[l]is[t]' })
vim.keymap.set('n', '<leader>to', b.vim_options, { desc = '[L]is[t] [o]ptions' })
vim.keymap.set('n', '<leader>tp', b.pickers, { desc = '[L]is[t] [p]ickers' })
vim.keymap.set('n', '<leader>tq', b.quickfixhistory, { desc = '[L]is[t] [q]uckfix history' })
vim.keymap.set('n', '<leader>tr', b.registers, { desc = '[L]is[t] [r]egisters' })
vim.keymap.set('n', '<leader>ts', b.symbols, { desc = '[L]is[t] [s]ymbols' })
vim.keymap.set('n', '<leader>tj', b.builtin, { desc = '[L]is[t] builtin pickers' })
vim.keymap.set('n', '<leader>tt', b.resume, { desc = 'Reopen last picker' })

vim.keymap.set('n', '<leader>fd', b.find_files, { desc = 'Find files (with [fd])' })
vim.keymap.set('n', '<leader>gf', b.git_files, { desc = '[L]ist [g]it [f]iles' })
vim.keymap.set('n', '<leader>gg', b.live_grep, { desc = '[G]rep' })
vim.keymap.set('n', '<leader>gw', b.grep_string, { desc = '[G]rep [w]ord' })
vim.keymap.set('n', '<leader>rf', b.oldfiles, { desc = '[L]ist [r]ecent [f]iles' })

vim.keymap.set('n', '<leader>ld', b.current_buffer_tags, { desc = '[L]ist [L]SP buffer [t]ags' })
vim.keymap.set('n', '<leader>lf', b.tags, { desc = '[L]ist [L]SP [f]ull tags' })
vim.keymap.set('n', '<leader>li', b.lsp_incoming_calls, { desc = '[L]ist [L]SP [i]ncoming calls' })
vim.keymap.set('n', '<leader>lo', b.lsp_outgoing_calls, { desc = '[L]ist [L]SP [o]outgoing calls' })
vim.keymap.set('n', '<leader>ls', b.tagstack, { desc = '[L]SP tag[s]tack' })
vim.keymap.set('n', '<leader>lt', b.lsp_type_definitions, { desc = '[L]ist [L]SP [t]ype definitions' })

vim.keymap.set('n', '<leader>gb', b.git_branches, { desc = '[L]ist [g]it [b]ranches' })
vim.keymap.set('n', '<leader>gc', b.git_bcommits, { desc = '[L]ist [g]it [c]ommits in the branch' })
vim.keymap.set('n', '<leader>gh', b.git_stash, { desc = '[G]it stas[h]' })
vim.keymap.set('n', '<leader>gl', b.git_commits, { desc = '[G]it [l]og commits' })
vim.keymap.set('n', '<leader>gs', b.git_status, { desc = '[G]it [s]tatus' })
