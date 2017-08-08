#
# === {{CMD}}
#

public_ip () {
  # https://askubuntu.com/questions/95910/command-for-determining-my-public-ip
  wget -qO- http://ipecho.net/plain && echo
} # _.sh ()

