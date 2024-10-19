local wezterm = require 'wezterm'
local config = {}

config.color_scheme = 'Tokyo Night'

config.font = wezterm.font('FiraCode Nerd Font Mono')

if wezterm.target_triple == 'x86_64-unknown-linux-gnu' then
  config.font_size = 16
else
  config.font_size = 20
end

return config
