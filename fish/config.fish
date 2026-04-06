# fish_config theme choose "Dracula Official"
# fish_config theme choose Tomorrow

function vterm_printf;
    if begin; [  -n "$TMUX" ]  ; and  string match -q -r "screen|tmux" "$TERM"; end
        # tell tmux to pass the escape sequences through
        printf "\ePtmux;\e\e]%s\007\e\\" "$argv"
    else if string match -q -- "screen*" "$TERM"
        # GNU screen (screen, screen-256color, screen-256color-bce)
        printf "\eP\e]%s\007\e\\" "$argv"
    else
        printf "\e]%s\e\\" "$argv"
    end
end

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
eval "$(/opt/homebrew/bin/brew shellenv)"
# Set up mise for runtime management
mise activate fish | source

# string match -q "$TERM_PROGRAM" "kiro" and . (kiro --locate-shell-integration-path fish)

function vterm_prompt_end;
    vterm_printf '51;A'(whoami)'@'(hostname)':'(pwd)
end
functions --copy fish_prompt vterm_old_fish_prompt
function fish_prompt --description 'Write out the prompt; do not replace this. Instead, put this at end of your file.'
    # Remove the trailing newline from the original prompt. This is done
    # using the string builtin from fish, but to make sure any escape codes
    # are correctly interpreted, use %b for printf.
    printf "%b" (string join "\n" (vterm_old_fish_prompt))
    vterm_prompt_end
end
