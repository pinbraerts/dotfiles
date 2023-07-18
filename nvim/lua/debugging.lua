local dap = require 'dap'
dap.set_log_level('trace')

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

dap.adapters.python = pre_launch {
    id = 'python',
    type = 'server',
    port = '${port}',
    executable = {
        command = 'python',
        args = { '-m', 'debugpy.adapter', '--port', '${port}',  },
        detached = false,
    },
}

dap.adapters.codelldb = pre_launch {
    id = 'codelldb',
    type = 'server',
    port = '${port}',
    executable = {
        command = 'D:\\vscode\\codelldb\\extension\\adapter\\codelldb.exe',
        args = { '--port', '${port}', },
        detached = false,
    },
}

dap.configurations.cpp = {
    lldb_compiling('clang++ -O0 -g -o')
}

dap.configurations.c = {
    lldb_compiling('clang -O0 -g -o')
}

dap.configurations.rust = {
    lldb_compiling('rustc -C opt-level=0 -g -o')
}

dap.configurations.python = {
    {
        type = 'python',
        request = 'launch',
        name = 'Launch python standalone',
        program = '${file}',
        cwd = '${workspaceFolder}',
    },
}

