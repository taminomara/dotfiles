if command -sq git
    function git
        switch $argv[1]
            case status st graph log diff help
                command git $argv
            case '*'
                command git $argv
                and emit _tm_git_update
        end
    end
end
