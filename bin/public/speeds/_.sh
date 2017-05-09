
# === {{CMD}}
# === {{CMD}} --with-localhost
# === {{CMD}} --localhost
# === First line: down speed. Second line: up speed.
speeds () {
  PATH="$PATH:$THIS_DIR/../sh_string/bin"
  local +x FIRST_DATA="$( get-data "$@" )"
  sleep 1
  local +x SECOND_DATA="$( get-data "$@" )"

  local +x DOWNLOAD_FIRST="$(echo "$FIRST_DATA" | sum-column 2)"
  local +x DOWNLOAD_SECOND="$(echo "$SECOND_DATA" | sum-column 2)"
  echo $(( $DOWNLOAD_SECOND - $DOWNLOAD_FIRST ))

  local +x UP_FIRST="$(echo "$FIRST_DATA" | sum-column 10)"
  local +x UP_SECOND="$(echo "$SECOND_DATA" | sum-column 10)"
  echo $(( $UP_SECOND - $UP_FIRST  ))

} # === end function

get-data () {
  case "$@" in
    --with-localhost)
      cat /proc/net/dev
      ;;

    --localhost)
      cat /proc/net/dev | grep --extended-regexp "^\ +lo:"
      ;;

    "")
      cat /proc/net/dev | grep -v --extended-regexp "^\ +lo:"
      ;;
  esac
}

sum-column () {
  local +x COL="$1"; shift
  awk '$'$COL' ~ /^[0-9]+$/ {sum += $'$COL'} END { print sum }'
}

