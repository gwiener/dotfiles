# File SELECT with a trick to allow for FROM .
fsl() {
  local args=()
  for arg in "$@"; do
    if [[ "$arg" == "." ]]; then
      args+=("$PWD")
    else
      args+=("$arg")
    fi
  done
  fselect "${args[@]}"
}
