function nono --wraps nono -d "nono with a unique per-invocation TMPDIR under /tmp"
    # Already inside a sandbox: keep the TMPDIR we were given.
    if set -q NONO_CAP_FILE
        command nono $argv
        return
    end

    # Must exist before nono starts: the profile grants r+w on "$TMPDIR" and
    # nono skips grants for paths that do not exist at launch.
    set -lx TMPDIR (mktemp -d /tmp/nono-XXXXXXXXXX)
    or return

    set -lx TEMPDIR $TMPDIR
    set -lx TMP $TMPDIR
    set -lx TEMP $TMPDIR
    set -lx TMPPREFIX $TMPDIR/tmp-
    set -lx TEMPPREFIX $TMPDIR/tmp-

    if set -q HERDR_AGENT
        # nono makes its environment unreadable, so herdr reads the hint from this foreground parent.
        sh -c 'env -u HERDR_AGENT nono "$@"; exit $?' sh $argv
    else
        command nono $argv
    end
    set -l st $status
    rm -rf -- $TMPDIR
    return $st
end
