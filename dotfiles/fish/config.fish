# Abbreviations
abbr -a c clear
abbr -a du dust
abbr -a ps procs
abbr -a neofetch fastfetch
abbr -a lolcat dotacat

# Aliases (long flags)
alias cat='bat --paging=never --style=plain --color=always'
alias less='bat --paging=always --style=plain --color=always'
alias cargo-update='cargo install-update -a'
alias icat='kitten icat'
alias ls='eza -g --icons --header --group-directories-first --color=always'
alias lr='eza -lTg -L 2 --icons --header --group-directories-first  --color=always'
alias lR='eza -lTg --icons --header --group-directories-first  --color=always'
alias la='eza -ag --icons --header --group-directories-first  --color=always'
alias git-remove-local='git fetch -p ; git branch -r | awk '\''{print $1}'\'' | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '\''{print $1}'\'' | xargs git branch -d'

# Environment variables
set -gx EDITOR nvim
set -gx DIRENV_LOG_FORMAT ''
set -gx fish_greeting # Suppress fish greeting
set -gx MINIMAL_FZF_PREVIEW 1
set -gx BAT_THEME whiskers
set -gx DELTA_PAGER "less --mouse"

fish_add_path ~/.local/bin
fish_add_path ~/.cargo/bin
fish_add_path ~/go/bin

# No green "❯" and space transient prompt with 1 newline
function starship_transient_prompt_func
    echo ''
    starship module character
end

# Initialize tools
zoxide init --cmd cd fish | source
starship init fish | source
fzf --fish | source

# Starship transient prompt for fish
enable_transience

# Override tab completion using a custom function
bind \t __fzf_complete

# Issues on NixOS with commands not found
function __fish_command_not_found_handler --on-event fish_command_not_found
    # /path/to/command-not-found $argv
    echo "not found: $argv[1]"
end

# Syntax highlighting
set -g fish_color_normal normal
set -g fish_color_command blue
set -g fish_color_param cyan
set -g fish_color_keyword red
set -g fish_color_quote green
set -g fish_color_redirection magenta
set -g fish_color_end yellow
set -g fish_color_comment brblack
set -g fish_color_error red
set -g fish_color_gray brblack
set -g fish_color_option green
set -g fish_color_operator magenta
set -g fish_color_escape yellow
set -g fish_color_autosuggestion brblack
set -g fish_color_cancel red

# Selection & search
set -g fish_color_selection --background=brblack
set -g fish_color_search_match --background=brblack

# Prompt
set -g fish_color_cwd yellow
set -g fish_color_user cyan
set -g fish_color_host blue
set -g fish_color_host_remote green
set -g fish_color_status red

# Pager
set -g fish_pager_color_progress brblack
set -g fish_pager_color_prefix magenta
set -g fish_pager_color_completion normal
set -g fish_pager_color_description brblack
