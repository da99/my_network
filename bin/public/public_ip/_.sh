#
# === {{CMD}}
#

public_ip () {
  local +x args="$@"
  case "$args" in
    ""|"default")
      # https://askubuntu.com/questions/95910/command-for-determining-my-public-ip
      wget -qO- http://ipecho.net/plain && echo
      ;;

    "save")
      local +x public_ip="$(my_network public_ip)"
      if [[ -z "$public_ip" ]] ; then
        echo "!!! error in getting public ip" >&2
        exit 1
      fi
      if my_network is-vpn-up ; then
        echo "!!! VPN is up" >&2
        exit 1
      fi
      cd "$THIS_DIR"
      mkdir -p tmp
      echo "$public_ip" > tmp/origin
      echo "$public_ip"
      ;;

    is-changed)
      cd "$THIS_DIR"
      if [[ ! -s "tmp/origin" ]]; then
        echo "!!! origin ip not found" >&2
        exit 1
      fi
      local +x origin="$(cat tmp/origin)"
      [[ "$origin" != "$(my_network public_ip)" ]]
      ;;

    *)
      echo "!!! Invalid arguments: $args" >&2
      exit 1
      ;;
  esac
} # _.sh ()

