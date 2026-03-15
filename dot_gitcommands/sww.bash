set -e

cd $(git rev-parse --show-toplevel)

hash="$(git log -n1 --format='format:%H')"
branch="$(git branch --show-current)"

if bash ~/.gitcommands/wip.bash; then
    has_wip_commit=1
else
    wip_exit_code="$?"
    if [[ "$wip_exit_code" -eq 5 ]]; then
        has_wip_commit=0
    else
        exit "$wip_exit_code"
    fi
fi

git checkout -q "$hash"

if git switch "$@"; then
    bash ~/.gitcommands/unwip.bash
else
    switch_exit_code="$?"
    if [[ -n "$branch" ]]; then
        git checkout -q "$branch"
    fi
    if [[ "$has_wip_commit" -eq 1 ]]; then
        bash ~/.gitcommands/unwip.bash > /dev/null && echo "Unshelved repository state due to error" || :
    fi
    exit "$switch_exit_code"
fi
