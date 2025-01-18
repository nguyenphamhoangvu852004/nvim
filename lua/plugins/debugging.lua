return {
  "mfussenegger/nvim-dap",
  dependencies = { "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" } },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    local portForJsServer = 8081
    local port = portForJsServer
    dapui.setup()

    require("java").setup({})
    require("lspconfig").jdtls.setup({})
    require("dap-python").setup(
      "C:\\Users\\nphv8\\AppData\\Local\\nvim-data\\mason\\packages\\debugpy\\venv\\Scripts\\python.exe"
    )
    dap.adapters["pwa-node"] = {
      type = "server",
      host = "localhost",
      port = port,
      executable = {
        command = "node",
        -- 💀 Make sure to update this path to point to your installation
        args = {
          "C:\\Users\\nphv8\\AppData\\Local\\nvim-data\\mason\\packages\\js-debug-adapter\\js-debug\\src\\dapDebugServer.js",
          port,
        },
      },
    }
    dap.configurations.javascript = {
      {
        type = "pwa-node",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        cwd = "${workspaceFolder}",
      },
    }
    -- If using the above, then `/path/to/venv/bin/python -m debugpy --version`
    -- must work in the shell
    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
      dapui.open()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
      dapui.open()
    end

    vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, {})
    vim.keymap.set("n", "<Leader>dc", dap.continue, {})
    vim.keymap.set("n", "<Leader>do", require("dapui").open, {})
    vim.keymap.set("n", "<Leader>dc", require("dapui").close, {})
    vim.keymap.set("n", "<Leader>dd", require("dapui").toggle, {})
  end,
}
