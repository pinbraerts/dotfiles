local d = require 'dap'
local dui = require 'dap.ui.widgets'
require 'rust-tools'.setup {
    single_file_support = true,
    server = {
        standalone = true,
    },
}
-- d.set_log_level('trace')
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
vim.keymap.set('n', '<leader>dx', d.terminate, { desc = '[D]ebug terminate' })
vim.keymap.set('n', '<leader>j', d.step_over, { desc = 'Step over' })
vim.keymap.set('n', '<leader>k', d.step_out, { desc = 'Step out' })
vim.keymap.set('n', '<leader>l', d.step_into, { desc = 'Step into' })
vim.keymap.set('n', 'K', function ()
    if d.status() ~= "" then
        dui.hover()
    else
        vim.lsp.buf.hover()
    end
end, { desc = 'LSP or DAP hover' })

local function pre_launch (adapter)
   return function (callback, config)
        if config.preLaunchTask then
            if type(config.preLaunchTask) == 'string' then
                vim.fn.system(config.preLaunchTask)
            else
                config.preLaunchTask()
            end
        end
        return callback(adapter)
    end
end

local function lldb_compiling (compiler)
    return {
        type = 'codelldb',
        request = 'launch',
        name = 'Compile and run standalone ("'..compiler..'")',
        program = '${fileDirname}/${fileBasenameNoExtension}.exe',
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        preLaunchTask = function ()
            local filename = vim.fs.normalize(vim.api.nvim_buf_get_name(0))
            local executable = filename:gsub('%..*$', '.exe')
            if not vim.fn.executable(executable) or vim.fn.getftime(executable) < vim.fn.getftime(filename) then
                local command = compiler..' '..executable..' '..filename
                print("Compililng: "..command)
                vim.fn.system(command)
            end
        end
    }
end

d.adapters.python = pre_launch {
    id = 'python',
    type = 'server',
    port = '${port}',
    executable = {
        command = 'python',
        args = { '-m', 'debugpy.adapter', '--port', '${port}',  },
        detached = false,
    },
}

d.adapters.codelldb = pre_launch {
    id = 'codelldb',
    type = 'server',
    port = '${port}',
    executable = {
        command = 'D:\\vscode\\codelldb\\extension\\adapter\\codelldb.exe',
        args = { '--port', '${port}', },
        detached = false,
    },
}

d.adapters.lldb = {
    type = 'executable',
    command = '/usr/bin/lldb-vscode-11',
    name = 'lldb',
}

d.configurations.cpp = {
    lldb_compiling('clang++ -O0 -g -o')
}

d.configurations.c = {
    lldb_compiling('clang -O0 -g -o')
}

d.configurations.rust = {
    lldb_compiling('rustc -C opt-level=0 -g -o')
}

d.configurations.python = {
    {
        type = 'python',
        request = 'launch',
        name = 'Launch python standalone',
        program = '${file}',
        cwd = '${workspaceFolder}',
    },
}

