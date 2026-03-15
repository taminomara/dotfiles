set -e

IFS=$'\n'
hash=''
n='0'
for i in $(git log --format='format:%s%x07%H' HEAD); do
    msg=$(printf '%s' "$i" | cut -f 1 -d $'\7' | tr '[:upper:]' '[:lower:]')
    if [[ "$msg" == 'wip' ]]; then
        hash=$(printf '%s' "$i" | cut -f 2 -d $'\7')
        (( n += 1 )) || :
    else
        break
    fi
done

if [[ -n "$hash" ]]; then
    s=$((( n != 1 )) && echo -n 's' || :)
    echo "Resetting $n WIP commit$s"
    git reset --soft "$hash~1"
else
    echo "Noting to unwip"
    exit 1
fi
