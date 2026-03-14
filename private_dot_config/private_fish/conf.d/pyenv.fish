if command -sq pyenv && command pyenv --version &>/dev/null
    pyenv init - fish | source

    functions -c pyenv _orig_pyenv
    function pyenv
        switch $argv[1]
            case commands completions help
                _orig_pyenv $argv
            case '*'
                _orig_pyenv $argv
                and emit _tm_venv_update
        end
    end
end

set -gx PYENV_VIRTUALENV_DISABLE_PROMPT 1
set -gx VIRTUAL_ENV_DISABLE_PROMPT 1
