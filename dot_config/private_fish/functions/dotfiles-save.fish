function dotfiles-save
    if test (count $argv) -eq 0
        set msg "Update dotfiles"
    else
        set msg (string join " " $argv)
    end
    set ts (date "+%H:%M")
    set final_msg "$msg ($ts)"
    
    # skip if nothing changed
    set changes (chezmoi git -- status --porcelain)
    if test -z "$changes"
        echo "chezmoi: nothing to commit."
        return 0
    end
    
    chezmoi git -- add -A
    chezmoi git -- commit -m "$final_msg"
    chezmoi git -- push
end
