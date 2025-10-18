# Small script to complete commands and files using fzf in fish shell, in a minimalist way.

# Check if all args are existing files or folders
function __are_all_files_or_folders
    for arg in $argv
        if not test -e "$arg"
            return 1
        end
    end
    return 0
end

function __fzf_complete
    # Get the current command line input and get its completions
    set -l cmd (string join -- ' ' (commandline -co) (commandline -ct))
    set -l complist (complete -C"$cmd")
    set -f --export SHELL (command --search fish)
    test -z "$complist"; and return # early exit if no completions

    # Check if we show completions in command mode or filesystem mode
    if __are_all_files_or_folders $complist
        # Show completions in filesystem mode

        # If only one completion, complete it directly, with escaped spaces
        if test (count $complist) -eq 1
            commandline -tr -- (string escape --no-quoted $complist[1])
            commandline -f repaint
            return
        end

        # If the command is "cd", we can show a smart preview
        set -l MINIMAL_FZF_PREVIEW $MINIMAL_FZF_PREVIEW
        if test "$cmd" = "cd "
            set MINIMAL_FZF_PREVIEW 0
        end

        # Remove base path from completions so that only the folder / file being completed is shown
        set -l basepath (string escape --no-quoted (dirname $complist[1]))
        set -l basenames
        for file in $complist
            set basenames $basenames (path basename "$file")
        end

        # Run fzf
        set -l fzf_args
        if test "$MINIMAL_FZF_PREVIEW" = 1
            set fzf_args --cycle --reverse --height 40%
        else
            set fzf_args --cycle --reverse --height 40% --preview "__smart_preview $basepath/{}"
        end

        set -l result (printf "%s\n" $basenames | fzf $fzf_args)

        # If the selection is not empty, add it to the command line, spaces escaped
        set -l trailing_slash ""
        if test -d "$basepath/$result"
            set trailing_slash /
        end

        # Remove "./" if it is the base path
        if test "$basepath" = '.'
            set basepath ""
        else
            set basepath "$basepath/"
        end

        if test -n "$result"
            commandline -tr -- $basepath(string escape --no-quoted $result)$trailing_slash
        end
        commandline -f repaint

        return
    end

    # Else, run in command mode, with "command -- description" display

    # First, split into command/description pairs
    set -l commands
    set -l descriptions
    for line in $complist
        set -l key (string match -r '^\S+' -- "$line")
        set -l val (string replace -- "$key" "" "$line" | string trim)
        set commands $commands $key
        set descriptions $descriptions $val
    end

    # If only one completion, complete it directly
    if test (count $commands) -eq 1
        commandline -t -- $commands[1]
        commandline -f repaint
        return
    end

    # Compute max command width
    set -l max_width 0
    for key in $commands
        set -l len (string length -- "$key")
        if test $len -gt $max_width
            set max_width $len
        end
    end

    # Format lines with aligned " -- " followed by description
    # only when the description is not empty
    set -l formatted
    for i in (seq (count $commands))
        if test -z "$descriptions[$i]"
            set formatted $formatted $commands[$i]
            continue
        end
        set -l padded (printf "%-*s" $max_width $commands[$i])
        set formatted $formatted "$padded  --  $descriptions[$i]"
    end

    # Run fzf and extract the selected command (first field)
    set -l result (printf "%s\n" $formatted | fzf --cycle --reverse --height 40% --accept-nth 1 --nth 1 --tiebreak=length)

    # If the selection is not empty, add it to the command line
    if test -n "$result"
        commandline -t -r -- $result
    end
    commandline -f repaint

end
