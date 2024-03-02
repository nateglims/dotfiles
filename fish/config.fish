fish_config theme choose "Dracula Official"

if command -v eza > /dev/null
    alias ls="eza"
end

if command -v starship > /dev/null
    starship init fish | source
else
    function fish_prompt
        set_color purple
        date "+%m/%d/%y"
        set_color F00
        echo (pwd) '>' (set_color normal)
    end
end

if command -v brazil-build > /dev/null
    alias bb="brazil-build"
    alias bbr="brazil-build release"
end

if command -v brazil > /dev/null
    alias bw="brazil ws"
end

alias cdg="cdk --profile glimsdal"
alias cdo="cdk --profile glimsdal-old"
