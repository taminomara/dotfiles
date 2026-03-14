set PATH $HOME/.local/bin $PATH

# pnpm
set -gx PNPM_HOME "/home/taminomara/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
