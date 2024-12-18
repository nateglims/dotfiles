# fish_config theme choose "Dracula Official"
# fish_config theme choose Tomorrow

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

    alias brc="brazil-recursive-cmd"
    alias bbb="brc --allPackages brazil-build release"
    alias bbr="brc brazil-build release"
end

if command -v brazil > /dev/null
    alias bw="brazil ws"
end

if command -v git > /dev/null
    alias gsc="git show --color --pretty=format:%b"
end

alias cdg="cdk --profile glimsdal"
alias cdo="cdk --profile glimsdal-old"
