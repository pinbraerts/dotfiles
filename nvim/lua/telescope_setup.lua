local telescope = require 'telescope'
local fba = telescope.extensions.file_browser.actions
local a = require 'telescope.actions'
local as = require 'telescope.actions.state'

local function select_and_save(prompt_bufnr)
    a.select_default(prompt_bufnr)
    local file = io.open('C:/Users/pinbraerts/config/nvim/Lua/colorscheme.vim', 'w+')
    if file == nil then
        return
    end
    file:write('colorscheme '..as.get_selected_entry().value)
    file:close()
end

telescope.setup {
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
            mappings = {
                n = {
                    ['<enter>'] = select_and_save,
                },
            },
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
            hijack_netrw = true,
            respect_gitignore = false,
            auto_depth = 2,
            layout_config = {
                preview_width = 0.5,
            },
        },
    },
}
telescope.load_extension 'dap'
telescope.load_extension 'shell'
telescope.load_extension 'file_browser'

