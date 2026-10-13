# Load the claude completions shipped with fish, then add the wrapper's own flag.
status get-file completions/claude.fish | source
complete -c claude -f -n __fish_use_subcommand -l no-nono -d 'Run claude directly, without the nono sandbox'
