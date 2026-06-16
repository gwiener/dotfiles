export UV_PYTHON_INSTALL_DIR=/opt/Lang/Python/uv
export VIRTUAL_ENV_DISABLE_PROMPT=1

# Activate project virtual environment
alias pp="[ -d .venv ] && source .venv/bin/activate"

# Claude code with venv
alias cc="pp; claude"

# Run debugger
alias debugpy_attach="uv run --with debugpy -m debugpy --listen 5678 --wait-for-client"

# Ctrl-P: pick a pytest test ID (including parametrize variants) and insert at cursor
_fzf_pytest_id() {
  local selected
  selected=$(pytest -q --collect-only 2>/dev/null | grep '::' | fzf --height 40% --reverse)
  [[ -n "$selected" ]] && LBUFFER+="$selected"
  zle reset-prompt
}
zle -N _fzf_pytest_id
bindkey -M viins '^P' _fzf_pytest_id
bindkey -M vicmd '^P' _fzf_pytest_id
