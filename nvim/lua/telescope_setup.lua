local a = require 'telescope.actions'
local as = require 'telescope.actions.state'
local function delete_file(prompt_bufnr)
    local picker = as.get_current_picker(prompt_bufnr)
    picker:delete_selection(function (selection)
        vim.fn.delete(selection.path)
    end)
end

local telescope = require 'telescope'
telescope.load_extension('dap')
telescope.setup {
    defaults = {
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
                d = delete_file,
                v = 'select_vertical',
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
        colorscheme = { enable_preview = true, },
        builtin = { include_extensions = true, },
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
}

