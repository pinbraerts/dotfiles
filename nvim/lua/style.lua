vim.cmd.set("background=dark")
vim.cmd.colorscheme('tokyonight')
vim.g.airline_theme = 'zenburn'
vim.fn.sign_define('DapBreakpoint'         , { text = '🔴', texhl = 'DapBreakpoint' })
vim.fn.sign_define('DapBreakpointCondition', { text = '🟤', texhl = 'DapBreakpoint' })
vim.fn.sign_define('DapBreakpointRejected' , { text = '⭕', texhl = 'DapBreakpoint' })
vim.fn.sign_define('DapLogPoint'           , { text = '🟣', texhl = 'DapLogPooint'  })
vim.fn.sign_define('DapStopped'            , { text = '🟡', texhl = 'DapStopped'    })
vim.fn.sign_define('DiagnosticSignError'   , { text = '❗' })
vim.fn.sign_define('DiagnosticSignWarn'    , { text = '⚠️ ' })
vim.fn.sign_define('DiagnosticSignInfo'    , { text = 'ℹ️' })
vim.fn.sign_define('DiagnosticSignHint'    , { text = '💡' })

if vim.fn.has('g:neovide') then
    vim.g.neovide_cursor_vfx_mode = 'ripple'
    vim.g.neovide_cursor_animate_command_line = false
end
