set -g _auto_activate_venv_enabled false
set -g _in_auto_activated_env false
set -g _in_auto_activate_venv_function false

function auto_activate_venv -d "Find and activate the nearest .venv"
    argparse "h/help" "enable" "disable" -- $argv || return

    if set -ql _flag_h
        echo "Usage: "(set_color -o)"auto_activate_venv"(set_color normal)" [-h|--enable|--disable]"
        echo ""
        echo "Locates nearest .venv and activates it. If no .venv can be found,"
        echo "deactivates the current one, unless it was activated manually,"
        echo "in which case it does nothing."
        echo ""
        echo (set_color -o)"Options:"(set_color normal)
        echo ""
        echo (set_color -o)"-h|--help"(set_color normal)
        echo "    Print this message and exit."
        echo ""
        echo (set_color -o)"--enable|--disable"(set_color normal)
        echo "    Enable or disable automatic venv switching"
        echo "    on current directory change"

        return
    end

    if set -ql _flag_enable
        set -g _auto_activate_venv_enabled true
    end
    if set -ql _flag_disable
        set -g _auto_activate_venv_enabled false
    else
        _do_auto_activate_venv
    end
end

function _auto_activate_venv --on-variable PWD
    if test $_auto_activate_venv_enabled != true
        return
    end

    _do_auto_activate_venv
end

function _do_auto_activate_venv
    if test -n "$VIRTUAL_ENV" && test $_in_auto_activated_env != true
        return
    end

    set -g _in_auto_activate_venv_function true

    set dir $PWD
    while true
        if test -f $dir/.venv/bin/activate.fish
            . $dir/.venv/bin/activate.fish
            set -g _in_auto_activated_env true
            break
        end
        if not set dir (path dirname $dir)
            if test -n "$VIRTUAL_ENV" && functions -q deactivate && test $_in_auto_activated_env = true
                deactivate
                set -g _in_auto_activated_env false
            end
            break
        end
    end

    set -g _in_auto_activate_venv_function false
end

function _on_manual_venv_activation --on-variable VIRTUAL_ENV
    if test $_in_auto_activate_venv_function != true
        set -g _in_auto_activated_env false
    end
end
