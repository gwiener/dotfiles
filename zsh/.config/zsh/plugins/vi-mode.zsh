bindkey -v

# Change cursor shape on vi mode switch
function zle-keymap-select {
  if [[ $KEYMAP == vicmd ]]; then
    # Normal mode → block cursor
    print -n -- $'\e[2 q'
  else
    # Insert mode → beam cursor
    print -n -- $'\e[6 q'
  fi
}

function zle-line-init {
  zle-keymap-select
}

zle -N zle-keymap-select
zle -N zle-line-init
