function fish_git_prompt
    # Reset cached prompt if repo state changed.
    if set -q _cached_fish_git_prompt_root && test ! -e "$_cached_fish_git_prompt_root" -o "$(date -r $_cached_fish_git_prompt_root '+%s')" -gt "$_cached_fish_git_prompt_time"
        _reset_cached_fish_git_prompt
    end

    # Generate and cache prompt.
    if not set -q _cached_fish_git_prompt
        set -g _cached_fish_git_prompt "$(_gen_fish_git_prompt)"
        set -g _cached_fish_git_prompt_time "$(date '+%s')"
    end

    # Echo cached prompt.
    if test -n $_cached_fish_git_prompt
        echo -n "$_fish_prompt_sep$_cached_fish_git_prompt"
        set -g _fish_prompt_sep "$fish_prompt_separator"
    end
end

function _gen_fish_git_prompt
    if not command -sq git
        return
    end

    # Get the git directory for later use.
    # Return if not inside a Git repository work tree.
    if not set git_dir (command git rev-parse --git-dir 2>/dev/null)
        return
    end

    set -g _cached_fish_git_prompt_root "$git_dir/../"

    # Get the current action ("merge", "rebase", etc.)
    set action (fish_print_git_action "$git_dir")

    # Get the current commit.
    set commit (command git rev-parse HEAD 2> /dev/null | string sub -l 7)

    # Get the branch name.
    set branch_detached 0
    if not set branch (command git symbolic-ref --short HEAD 2>/dev/null)
        set branch_detached 1
    end

    # Get the commit difference counts between local and remote.
    command git rev-list --count --left-right 'HEAD...@{upstream}' 2>/dev/null \
        | read -d \t -l status_ahead status_behind
    if test $status -ne 0
        set status_ahead 0
        set status_behind 0
    end

    # Get repository status.
    set porcelain_status (command git status --porcelain | string sub -l2)
    set status_dirty 0
    if test -n "$porcelain_status"
        set status_dirty 1
    end
    set status_unmerged 0
    if string match -qr 'AA|DD|U' $porcelain_status
        set status_unmerged 1
    end
    set status_untracked 0
    if string match -qe '\?\?' $porcelain_status
        set status_untracked 1
    end

    set color_normal "$(set_color normal)$(set_color $fish_color_normal_prompt)"
    set color_git_branch "$(set_color normal)$(set_color $fish_color_git_branch)"
    set color_git_detached "$(set_color normal)$(set_color $fish_color_git_detached)"
    set color_git_action "$(set_color normal)$(set_color $fish_color_git_action)"
    set color_git_status "$(set_color normal)$(set_color $fish_color_git_status)"
    set color_git_status_info "$(set_color normal)$(set_color $fish_color_git_status_info)"

    if test -n "$branch"
        echo -n "$color_git_branch$branch$color_normal"
    else
        echo -n "$color_git_branch$commit$color_normal"
    end

    if test -n "$action" -o $branch_detached -ne 0
        echo -n " ("
        test $branch_detached -ne 0 && echo -n "$color_git_detached"'detached'"$color_normal" && set sep ', '
        test -n "$action" && echo -n "$sep$color_git_action$action$color_normal"
        echo -n ")"
    end

    if test $status_ahead -ne 0
        echo -n " $color_git_status↑$color_git_status_info$status_ahead$color_normal"
    end
    if test $status_behind -ne 0
        echo -n " $color_git_status↓$color_git_status_info$status_behind$color_normal"
    end

    if test $status_dirty -ne 0
        echo -n " $color_git_status"'✎'"$color_normal"
    end
    if test $status_unmerged -ne 0
        echo -n " $color_git_status"'⤭'"$color_normal"
    end
    if test $status_untracked -ne 0
        echo -n " $color_git_status"'?'"$color_normal"
    end
end

function _reset_cached_fish_git_prompt --on-variable PWD --on-event _tm_git_update
    set -e _cached_fish_git_prompt
    set -e _cached_fish_git_prompt_root
    set -e _cached_fish_git_prompt_time
end
