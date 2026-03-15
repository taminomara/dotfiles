set -e

cd $(git rev-parse --show-toplevel)

if git diff --staged --exit-code > /dev/null; then
    has_staged_files=0
else
    has_staged_files=1
    git commit -q --no-gpg-sign -m 'WIP -- STAGED'
fi

git add --all

if git diff --staged --exit-code > /dev/null; then
    has_unstaged_files=0
else
    has_unstaged_files=1
    git commit -q --no-gpg-sign -m 'WIP -- UNSTAGED'
fi

if [[ "$has_staged_files" -eq 1 ]] || [[ "$has_unstaged_files" -eq 1 ]]; then
    echo "Shelved repository state"
else
    echo "Repository is clean, nothing to shelve"
    exit 5
fi
