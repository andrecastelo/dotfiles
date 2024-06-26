alias ll="ls -lha"
alias zshcustom="nvim ~/.oh-my-zsh/custom/alias.zsh"
alias activate_poetry="source \"\$(poetry env list --full-path | grep Activated | cut -d' ' -f1 )/bin/activate\""
alias nvim-config="cd ~/.config/nvim && nvim ."

# git aliases
alias gs="git status"

# project aliases
alias p="cd ~/Projects"
alias cap="cd ~/Projects/parade/capacity-ui-v2/parade-capacity-portal"
alias radar="cd ~/Projects/parade/public-carriers-api/"
alias codriver="cd ~/Projects/parade/codriver/"

alias dotfiles="nvim ~/dotfiles/"
alias stage-db="$CLOUD_SQL_PROXY parade-capacity-stage:us-central1:capacity-api-stage-pg15 --port 2345 capi_stage:i91ArXnHKDp3W9EDCa"

