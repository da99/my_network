#
# === {{CMD}}
#

url-is-up () {
  curl --silent -i $@ | head -n 1 | grep -P "HTTP/[0-9\.]+ [1-3][0-9][0-9] "
} # url-is-up ()
