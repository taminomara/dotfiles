function fish_venv_prompt
    # Reset cached prompt if current venv changed.
    if set -q _cached_fish_venv_prompt_root && test ! -e "$_cached_fish_venv_prompt_root" -o "$(date -r $_cached_fish_venv_prompt_root '+%s')" -gt "$_cached_fish_venv_prompt_time"
        _reset_cached_fish_venv_prompt
    end

    # Generate and cache prompt.
    if not set -q _cached_fish_venv_prompt
        set -g _cached_fish_venv_prompt "$(_gen_fish_venv_prompt)"
        set -g _cached_fish_venv_prompt_time "$(date '+%s')"
    end

    # Echo cached prompt.
    if test -n $_cached_fish_venv_prompt
        echo -n "$_fish_prompt_sep$_cached_fish_venv_prompt"
        set -g _fish_prompt_sep "$fish_prompt_separator"
    end
end

function _gen_fish_venv_prompt
    set color_normal "$(set_color normal)$(set_color $fish_color_normal_prompt)"
    set color_venv "$(set_color normal)$(set_color $fish_color_venv)"

    if test -n "$VIRTUAL_ENV"
        set venv (basename "$VIRTUAL_ENV")
        if test "$venv" = ".venv"
            set venv (basename (dirname "$VIRTUAL_ENV"))
        end
        echo -n "$color_normal$color_venv$venv"
    else if command -sq pyenv && command pyenv --version &>/dev/null
        set venv_name "$(command pyenv version-name)"
        set global_venv_name "$(command pyenv global)"

        if test "$venv_name" != "$global_venv_name"
            echo -n "$color_normal$color_venv$venv_name$color_normal"
        end

        set version_file (pyenv version-file)
        if test -e "$version_file"
            set -g _cached_fish_venv_prompt_root (pyenv version-file)
        end
    end
end

function _reset_cached_fish_venv_prompt --on-variable PWD --on-variable VIRTUAL_ENV --on-event _tm_venv_update
    set -e _cached_fish_venv_prompt
    set -e _cached_fish_venv_prompt_root
    set -e _cached_fish_venv_prompt_time
end
