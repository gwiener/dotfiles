# Sort IDs numerically descending; compadd -V prevents ZSH from re-sorting
_task_ids() {
local -a ids descs
  local line
  while IFS= read -r line; do
    ids+=("${line%%:*}")
    descs+=("$line")
  done < <(task rc.hooks=0 _zshids | sort -t: -k1 -n -r)
  compadd -V 'task ids' -d descs -- "${ids[@]}"
}

# Override _task_default to include ID completion (upstream has it commented out)
_task_default() {
  local cmd ret=1
  integer i=1
  local _task_cmds=($(task rc.hooks=0 _commands; task _aliases))
  while (( i < $#words ))
  do
    cmd="${_task_cmds[(r)$words[$i]]}"
    if (( $#cmd )); then
      if (( $+functions[_task_${cmd}] )); then
        _task_${cmd}
        return ret
      fi
      _call_function ret _task_filter ||
        _message "No command remaining."
      return ret
    fi
    (( i++ ))
  done

  _task_ids
  _task_subcommands
  _task_aliases
  _call_function ret _task_filter

  return ret
}

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
