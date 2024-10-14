local jdtls = require("jdtls")
local dap = require("dap")
local on_attach = require("lsp").on_attach

local root_dir = require("jdtls.setup").find_root({ "packageInfo" }, "Config")
local home = os.getenv("HOME")
local eclipse_workspace = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

local ws_folders_jdtls = {}
if root_dir then
  local file = io.open(root_dir .. "/.bemol/ws_root_folders")
  if file then
    for line in file:lines() do
      table.insert(ws_folders_jdtls, "file://" .. line)
    end
    file:close()
  else
    vim.notify("No Bemol workspace file found.", vim.log.levels.WARN)
  end
end

local bundles = {
  vim.fn.glob(home .. '/.local/java/com.microsoft.java.debug.plugin-*.jar'),
}

local config = {
  on_attach = on_attach,
  cmd = {
    "jdtls",
    '-Xmx8g',
    -- "--jvm-arg=-javaagent:" .. home .. "/Developer/lombok.jar", -- need for lombok magic
    "-data",
    eclipse_workspace,
  },
  root_dir = root_dir,
  init_options = {
    workspaceFolders = ws_folders_jdtls,
    bundles = bundles,
  },
}

-- DAP Keybindings.
local bufopts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>bb", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", bufopts)
vim.keymap.set("n", "<leader>bc", "<cmd>lua require'dap'.continue()<cr>", bufopts)
vim.keymap.set("n", "<leader>bl",
  "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>", bufopts)
vim.keymap.set("n", "<leader>bn", function() require('dap').step_over() end)
vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
  require('dap.ui.widgets').hover()
end)
vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
  require('dap.ui.widgets').preview()
end)
vim.keymap.set('n', '<Leader>df', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end)
vim.keymap.set('n', '<Leader>ds', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end)

dap.configurations.java = {
  {
    type = 'java',
    request = 'attach',
    name = 'Debug (Attach) - Remote',
    hostName = "localhost",
    port = 5005,
  },
}

jdtls.start_or_attach(config)
