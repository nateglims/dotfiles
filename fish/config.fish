#function fish_prompt
#    set_color purple
#    date "+%m/%d/%y"
#    set_color F00
#    echo (pwd) '>' (set_color normal)
#end

# status is-login; and pyenv init --path | source
# status is-interactive; and pyenv init - | source

if command -v exa > /dev/null
    alias ls="exa"
end

starship init fish | source
