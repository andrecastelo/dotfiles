alias ll="ls -lha"
alias zshcustom="nvim ~/.oh-my-zsh/custom/alias.zsh"
alias activate_poetry="source \"\$(poetry env list --full-path | grep Activated | cut -d' ' -f1 )/bin/activate\""

# git aliases
alias gs="git status"
alias grbc="git rebase --continue"
alias lg="lazygit"
alias gm="git switch main && git pull && git switch -"

# project aliases
alias p="cd ~/Projects"

alias dotfiles="nvim ~/dotfiles/"
alias stage-db="cloud-sql-proxy parade-capacity-stage:us-central1:capacity-api-stage-pg15 --port 2345 capi_stage:i91ArXnHKDp3W9EDCa"

alias nvim-update="mise uninstall neovim@nightly && mise install neovim@nightly"
