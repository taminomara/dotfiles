set -e

cd $(git rev-parse --show-toplevel)

if [[ "$(git log -n1 --format=format:'%s')" == "WIP -- UNSTAGED" ]]; then
    git reset -q "HEAD~1"
    had_unstaged_files=1
else
    had_unstaged_files=0
fi

if [[ "$(git log -n1 --format=format:'%s')" == "WIP -- STAGED" ]]; then
    git reset -q --soft "HEAD~1"
    had_staged_files=1
else
    had_staged_files=0
fi

if [[ "$had_staged_files" -eq 1 ]] || [[ "$had_unstaged_files" -eq 1 ]]; then
    echo "Unshelved repository state"
    echo
    git status
else
    echo "Tree is clean, nothing to unshelve"
    exit 5
fi
