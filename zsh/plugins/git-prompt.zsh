git_prompt() {
  if git rev-parse --git-dir >/dev/null 2>&1; then
    ref=$(git symbolic-ref HEAD 2>/dev/null || git name-rev --name-only --no-undefined --always HEAD)
    ref=${ref#refs/heads/}
    # if ! git diff-index --quiet HEAD 2>/dev/null; then
    #   ref="$ref %{$fg[cyan]%}*"
    # fi
    echo " %{$reset_color%}[%{$fg[red]%}$ref%{$reset_color%}]"
  fi
}
