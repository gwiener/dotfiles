prjt() {
  if [[ -L ".mind" ]]; then
    CURR=$(realpath .mind)
  else
    CURR=$(pwd -P)
  fi
  BASE="$HOME/MIND/01_PRJT"
  [[ "$CURR" == "$BASE/"* ]] && echo "project:${CURR#$BASE/}" | cut -d'/' -f1 | tr '[:upper:] ' '[:lower:]-'
}

TW_CFG=~/.config/task
tw() {
  ln -sf ${TW_CFG}/$(appear)-256.theme ${TW_CFG}/curr.theme
  task $(prjt) "$@";
}
compdef tw=task
alias tt=taskwarrior-tui
