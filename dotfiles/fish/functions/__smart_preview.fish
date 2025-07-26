# Preview files with cat, directories with ls, images with icat
function __smart_preview
    set -l file "$argv[1]"
    if test -d "$file"
        ls "$file"
    else if test -f "$file"
        set -l extension (string lower (path extension "$file"))

        switch "$extension"
            case .jpg .jpeg .png .gif
                icat --clear --transfer-mode=memory --stdin=no --place={$FZF_PREVIEW_COLUMNS}x{$FZF_PREVIEW_LINES}@0x0 "$file"
            case '*'
                cat "$file"
        end
    end
end
