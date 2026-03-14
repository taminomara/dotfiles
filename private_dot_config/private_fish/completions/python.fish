# These completions are similar to to builtin ones,
# except they don't check python version and they assume
# that we're always completing for `python 3`.
# This speeds up python completions signficantly,
# because now we don't call slow `pyenv` machinery
# on every tab.

complete -c python -s B -d 'Don\'t write .py[co] files on import'
complete -c python -s c -x -d "Execute argument as command"
complete -c python -l check-hash-based-pycs -a "default always never" -d "Control validation behaviour of pyc files"
complete -c python -s d -d "Debug on"
complete -c python -s E -d "Ignore all PYTHON* env vars"
complete -c python -s h -s '?' -l help -d "Display help and exit"
complete -c python -s i -d "Interactive mode after executing commands"
complete -c python -s m -d 'Run library module as a script (terminates option list)' -xa '(python -c "import pkgutil; print(\'\n\'.join([p[1] for p in pkgutil.iter_modules()]))")'
complete -c python -s O -d "Enable optimizations"
complete -c python -o OO -d "Remove doc-strings in addition to the -O optimizations"
complete -c python -s s -d 'Don\'t add user site directory to sys.path'
complete -c python -s S -d "Disable import of site module"
complete -c python -s u -d "Unbuffered input and output"
complete -c python -s v -d "Verbose mode"
complete -c python -o vv -d "Even more verbose mode"
complete -c python -s V -l version -d "Display version and exit"
complete -c python -s W -x -d "Warning control" -a "ignore default all module once error"
complete -c python -s x -d 'Skip first line of source, allowing use of non-Unix forms of #!cmd'
complete -c python -f -n "__fish_is_nth_token 1" -k -a "(__fish_complete_suffix .py)"
complete -c python -f -n "__fish_is_nth_token 1" -a - -d 'Read program from stdin'

# These used to be conditional.
complete -c python -s q -d 'Don\'t print version and copyright messages on interactive startup'
complete -c python -s X -x -d 'Set implementation-specific option'
complete -c python -s b -d 'Warn when comparing bytes with str or int'
complete -c python -o bb -d 'Error when comparing bytes with str or int'
complete -c python -s R -d 'Turn on hash randomization'
complete -c python -s I -d 'Run in isolated mode'
complete -c python -o VV -d 'Print further version info'
