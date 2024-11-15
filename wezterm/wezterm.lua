local wezterm = require 'wezterm'
local config = {}

config.tab_bar_at_bottom = true
config.colors = {
  tab_bar = {
    active_tab = {
      fg_color = '#48384c',
      bg_color = '#c678dd',
    },
    inactive_tab = {
      fg_color = '#c678dd',
      bg_color = '#48384c',
    }
  }
}


local function tab_title(tab_info)
  local title = tab_info.tab_title

  if title and #title > 0 then
    return title
  end

  return tab_info.active_pane.title
end

wezterm.on('update-right-status', function(window, pane)
  local name = window:active_key_table()
  if name then
    name = 'TABLE: ' .. name
  end
  window:set_right_status(name or '')
end)

wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local title = tab_title(tab)
  if tab.is_active then
    return {
      { Text = ' ' .. title .. ' ' },
    }
  end
end)

config.color_scheme = 'Tokyo Night'

config.font = wezterm.font('FiraCode Nerd Font Mono')

if wezterm.target_triple == 'x86_64-unknown-linux-gnu' then
  config.font_size = 16
  config.window_frame = {
    font_size = 16.0,
  }
else
  config.font_size = 22.0
  config.window_frame = {
    font_size = 16.0,
  }
end

config.leader = { key = ' ', mods = 'CTRL', timeout_millisecond = 1000 }
config.keys = {
  {
    key = 'f',
    mods = 'ALT',
    action = wezterm.action.TogglePaneZoomState,
  },
  {
    key = '"',
    mods = 'LEADER|SHIFT',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = '%',
    mods = 'LEADER|SHIFT',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'c',
    mods = 'LEADER',
    action = wezterm.action.SpawnTab('CurrentPaneDomain'),
  },
  {
    key = 'n',
    mods = 'LEADER',
    action = wezterm.action.ActivateTabRelative(1),
  },
  {
    key = 'p',
    mods = 'LEADER',
    action = wezterm.action.ActivateTabRelative(-1),
  },
  {
    key = 'x',
    mods = 'LEADER',
    action = wezterm.action.CloseCurrentPane { confirm = true },
  },
  {
    key = 'o',
    mods = 'LEADER',
    action = wezterm.action.ActivatePaneDirection('Next'),
  },
  {
    key = 'l',
    mods = 'LEADER',
    action = wezterm.action.ShowLauncherArgs { flags = 'WORKSPACES' },
  },
  {
    key = 'a',
    mods = 'LEADER',
    action = wezterm.action.AttachDomain 'unix',
  },
  {
    key = 'd',
    mods = 'LEADER',
    action = wezterm.action.DetachDomain { DomainName = 'unix' },
  },
  {
    key = 'b',
    mods = 'LEADER',
    action = wezterm.action_callback(function(window, pane)
      local overrides = window:get_config_overrides() or {}
      if not overrides.color_scheme then
        overrides.color_scheme = 'Solar Flare Light (base16)'
      else
        overrides.color_scheme = nil
      end
      window:set_config_overrides(overrides)
    end)
  },
  {
    key = 'r',
    mods = 'LEADER|SHIFT',
    action = wezterm.action.PromptInputLine {
      description = 'Enter new name for tab',
      action = wezterm.action_callback(function(window, pane, line)
        if line then
          window:active_tab():set_title(line)
        end
      end)
    },
  },
}

config.unix_domains = {
  {
    name = 'unix',
  },
}

return config
