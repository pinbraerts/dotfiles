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
        return
    end
    local clients = vim.lsp.get_active_clients()
    if clients ~= nil and #clients and clients[1].config ~= nil and clients[1].config.root_dir ~= nil then
        vim.cmd.cd(clients[1].config.root_dir)
    else
        vim.cmd.cd(vim.fs.dirname(vim.fn.bufname()))
    end
end, { desc = '[cd] git root or lsp root or current file directory' })
