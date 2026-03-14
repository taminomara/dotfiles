function fish_prompt
    set -g _fish_prompt_sep ''

    set color_normal "$(set_color normal)$(set_color $fish_color_normal_prompt)"
    set color_cwd "$(set_color normal)$(set_color $fish_color_cwd)"
    set color_cwd_last "$(set_color normal)$(set_color $fish_color_cwd_last)"
    set color_cwd_sep "$(set_color normal)$(set_color $fish_color_cwd_sep)"
    set color_user "$(set_color normal)$(set_color $fish_color_user)"
    set color_host "$(set_color normal)$(set_color $fish_color_host)"
    set suffix "$fish_prompt_suffix"

    set show_host 0
    set show_user 0

    if test -n "$SSH_TTY"
        set show_host 1
        set show_user 1
        set color_host "$(set_color normal)$(set_color $fish_color_host_remote)"
    end

    if fish_is_root_user
        set show_user 1
        set color_cwd "$(set_color normal)$(set_color $fish_color_cwd_root)"
        set color_user "$(set_color normal)$(set_color $fish_color_user_root)"
        set suffix "$fish_prompt_suffix_root"
    end

    echo -n "$color_normal"

    if test $show_user -ne 0
        echo -n "$color_user$USER$color_normal"
    end
    if test $show_host -ne 0
        echo -n "@$color_host"(prompt_hostname)"$color_normal"
    end
    if test $show_user -ne 0 -o $show_host -ne 0
        echo -n ' '
    end

    set formatted_pwd $color_cwd(
        prompt_pwd \
            | string replace -r '(.*/)?(.*)' '$1'"$color_cwd_last"'$2' \
            | string replace -a '/' "$color_cwd_sep/$color_cwd"
    )

    echo -n "$formatted_pwd$color_normal $suffix"

    echo -n (set_color normal)
end
