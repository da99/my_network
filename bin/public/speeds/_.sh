
# === {{CMD}}
# === {{CMD}} --with-localhost
# === {{CMD}} --localhost
# === First line: down speed. Second line: up speed.
speeds () {
  PATH="$PATH:$THIS_DIR/../sh_string/bin"
  PATH="$PATH:$THIS_DIR/../my_fs/bin"

  local +x TMP_DIR="/tmp/network-speeds"
  mkdir -p "$TMP_DIR"

  local +x ONE="$TMP_DIR/1.txt"

  if test -f "$ONE" && my_fs is-older-than 2 "$ONE" ; then
    rm -f "$ONE"
  fi

  if [[ ! -f "$ONE" ]]; then
    get-data "$@" > "$ONE"
    echo 0
    echo 0
    return 0
  fi

  local +x FIRST_DATA="$( cat "$ONE" )"
  local +x SECOND_DATA="$( get-data "$@" )"

  local +x DOWNLOAD_FIRST="$(echo "$FIRST_DATA" | sum-column 2)"
  local +x DOWNLOAD_SECOND="$(echo "$SECOND_DATA" | sum-column 2)"
  echo $(( $DOWNLOAD_SECOND - $DOWNLOAD_FIRST ))

  local +x UP_FIRST="$(echo "$FIRST_DATA" | sum-column 10)"
  local +x UP_SECOND="$(echo "$SECOND_DATA" | sum-column 10)"
  echo $(( $UP_SECOND - $UP_FIRST  ))
  echo "$SECOND_DATA" > "$ONE"
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

