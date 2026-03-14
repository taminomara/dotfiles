set -x _ZO_ECHO 1
set -x _ZO_FZF_OPTS "
    --height 40%
    --layout reverse
    --prompt '        '
    --info right
    --bind backward-eof:abort
"

zoxide init --cmd=z fish | source

# function __zoxide_z_complete
#     set -l tokens (builtin commandline --current-process --tokenize)
#     set -l curr_tokens (builtin commandline --cut-at-cursor --current-process --tokenize)

#     if test (builtin count $tokens) -eq 2 -a (builtin count $curr_tokens) -eq 1
#         # If there are < 2 arguments, use `cd` completions.
#         complete --do-complete "'' "(builtin commandline --cut-at-cursor --current-token) | string match --regex -- '.*/$'
#     else
#         # If the last argument is empty, use interactive selection.
#         set -l query $tokens[2..-1]
#         set -l result (command zoxide query --exclude (__zoxide_pwd) --interactive -- $query)
#         and __zoxide_cd $result
#         and builtin commandline --function cancel-commandline repaint
#     end
# end

function __on_space_bar
    set tokens (builtin commandline --current-process)
    set curr_tokens (builtin commandline --cut-at-cursor --current-process)
    if [ $tokens = "z " -a $curr_tokens = "z " ]
        set -l result (command zoxide query --exclude (__zoxide_pwd) --interactive)
        and __zoxide_cd $result
        and builtin commandline --function clear-commandline repaint
        or builtin commandline --function repaint
    else
        builtin commandline -i ' '
    end
end

bind space __on_space_bar
