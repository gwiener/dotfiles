export UV_PYTHON_INSTALL_DIR=/opt/Lang/Python/uv
export VIRTUAL_ENV_DISABLE_PROMPT=1

# Activate project virtual environment
alias pp="[ -d .venv ] && source .venv/bin/activate"

# Claude code with venv
alias cc="pp; claude"
