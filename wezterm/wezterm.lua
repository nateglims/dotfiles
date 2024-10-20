local wezterm = require 'wezterm'
local config = {}

wezterm.on('update-right-status', function(window, pane)
  local name = window:active_key_table()
  if name then
    name = 'TABLE: ' .. name
  end
  window:set_right_status(name or '')
end)

config.color_scheme = 'Tokyo Night'

config.font = wezterm.font('FiraCode Nerd Font Mono')

if wezterm.target_triple == 'x86_64-unknown-linux-gnu' then
  config.font_size = 16
else
  config.font_size = 20
end

-- config.leader = { key = 'a', mods = 'CTRL', timeout_millisecond = 1000 }
config.keys = {
  {
    key = 'a',
    mods = 'CTRL',
    action = wezterm.action.ActivateKeyTable { name = 'tmux_like', timeout_millisecond = 1000 },
  },
}

config.key_tables = {
  tmux_like = {
    {
      key = '"',
      mods = 'SHIFT',
      action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    {
      key = '%',
      mods = 'SHIFT',
      action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
      key = 'c',
      action = wezterm.action.SpawnTab('CurrentPaneDomain'),
    },
    {
      key = 'n',
      action = wezterm.action.ActivateTabRelative(1),
    },
    {
      key = 'p',
      action = wezterm.action.ActivateTabRelative(-1),
    },
    {
      key = 'x',
      action = wezterm.action.CloseCurrentTab { confirm = true },
    },
  },
}

return config
