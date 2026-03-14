function fish_right_prompt
    set cmd_status $status

    set color_normal "$(set_color normal)$(set_color $fish_color_normal_prompt)"
    set color_err_code "$(set_color normal)$(set_color $fish_color_err_code)"

    set -g _fish_prompt_sep ''

    echo -n "$color_normal"

    if test $cmd_status -ne 0
        echo -n "$_fish_prompt_sep$color_err_code$fish_prompt_errcode_symbol$cmd_status$color_normal"
        set -g _fish_prompt_sep "$fish_prompt_separator"
    end

    fish_venv_prompt
    fish_vcs_prompt

    echo -n (set_color normal)
end
