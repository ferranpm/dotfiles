# When the current working directory changes, run a method that checks for a .env file, then sources it. Happy days.

autoload -U add-zsh-hook

load-local-conf() {
  if [[ -f .env && -r .env ]]; then
    source .env
  fi
  if [[ -f .envrc && -r .envrc ]]; then
    source .envrc
  fi
}

add-zsh-hook chpwd load-local-conf
