# `nono run` flags the claude wrapper accepts as --nono-<flag>.
# One per line: name<TAB>kind<TAB>description; kind is bool, path, profile,
# theme or value (everything but bool takes an argument).
function __claude_nono_flags
    printf '%s\t%s\t%s\n' \
        allow path 'Allow read+write access to a directory' \
        read path 'Allow read-only access to a directory' \
        write path 'Allow write-only access to a directory' \
        allow-file path 'Allow read+write access to a file' \
        read-file path 'Allow read-only access to a file' \
        write-file path 'Allow write-only access to a file' \
        allow-unix-socket path 'Allow connect() to a unix socket' \
        allow-unix-socket-bind path 'Allow connect()+bind() on a unix socket' \
        allow-unix-socket-dir path 'Allow connect() to sockets in a directory' \
        allow-unix-socket-dir-bind path 'Allow connect()+bind() on sockets in a directory' \
        allow-unix-socket-subtree path 'Allow connect() to sockets in a subtree' \
        allow-unix-socket-subtree-bind path 'Allow connect()+bind() on sockets in a subtree' \
        bypass-protection path 'Override a deny rule for a path' \
        suppress-save-prompt path 'Suppress save-profile prompts under a path' \
        allow-cwd bool 'Allow CWD access without prompting' \
        workdir path 'Working directory for $WORKDIR in profiles' \
        block-net bool 'Block outbound network access' \
        network-profile value 'Proxy filtering with a named network profile' \
        allow-domain value 'Add a domain to the proxy allowlist' \
        deny-domain value 'Block a domain through the proxy' \
        listen-port value 'Allow listening on a TCP port' \
        open-port value 'Allow bidirectional localhost TCP on a port' \
        allow-connect-port value 'Allow outbound TCP connect to a port' \
        upstream-proxy value 'Chain traffic through an upstream proxy' \
        upstream-bypass value 'Route a domain direct, bypassing upstream proxy' \
        proxy-port value 'Fixed port for the credential proxy' \
        proxy-ca-validity value 'Proxy CA validity in days' \
        credential value 'Inject credentials via proxy for a service' \
        allow-endpoint value 'Restrict a credential service to method+path' \
        env-credential value 'Load credentials as env vars' \
        silent bool 'Suppress all nono output' \
        theme theme 'Color theme for nono output' \
        log-file path 'Write nono logs to a file' \
        profile profile 'Sandbox profile (default: claude)' \
        extends profile 'Extend the profile with an additional base' \
        allow-launch-services bool 'Allow LaunchServices opens (macOS)' \
        allow-gpu bool 'Allow GPU access' \
        strict-broker-path bool 'Refuse to start on grant/PATH overlap' \
        sandbox-policy value 'Linux enforcement: auto|landlock|external' \
        allow-http2 bool 'Allow HTTP/2 for upstream proxy connections' \
        verbose bool 'Verbose nono output' \
        dry-run bool 'Show what would be sandboxed without executing' \
        detached bool 'Start without attaching the terminal' \
        detach-timeout value 'Seconds to wait for a detached session' \
        skip-dir value 'Skip a directory name during trust scanning' \
        no-diagnostics bool 'Suppress diagnostic footer on failure' \
        diagnostics-json bool 'Print session diagnostics as JSON' \
        startup-timeout value 'Kill if no TUI after N seconds' \
        no-audit bool 'Disable the audit trail' \
        no-audit-integrity bool 'Disable the Merkleized audit log' \
        audit-integrity bool 'Hash filesystem state of writable paths' \
        audit-sign-key value 'Sign the audit Merkle root with a key' \
        trust-override bool 'Disable trust verification' \
        name value 'Session name shown in `nono ps`' \
        capability-elevation bool 'Enable runtime capability elevation' \
        memory value 'Max resident memory (e.g. 512M, 1Gi)' \
        max-processes value 'Max processes and threads' \
        rollback bool 'Enable rollback snapshots' \
        no-rollback-prompt bool 'Skip the post-exit rollback prompt' \
        no-rollback bool 'Disable rollback entirely' \
        rollback-exclude value 'Exclude a pattern from snapshots' \
        rollback-include value 'Force-include an auto-excluded directory' \
        rollback-all bool 'Include all directories in snapshots' \
        rollback-dest path 'Rollback snapshot destination'
end
