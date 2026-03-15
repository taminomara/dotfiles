source /usr/share/fish/completions/git.fish

# Override completion for `git sww`
# (alias to `git switch` with some bash harness around it).
set -g __fish_git_alias_sww switch switch
