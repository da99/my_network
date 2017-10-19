#
# === {{CMD}} http://url/...
#

inspect () {
  local +x HEADERS="$(curl --silent -I $@)"
  if echo "$HEADERS" | grep -P "HTTP/... 2.." &>/dev/null ; then
    sh_color GREEN "{{$@}}"
  else
    if echo "$HEADERS" | grep -P "HTTP/... 3.." &>/dev/null ; then
      sh_color ORANGE "{{$@}}"
    else
      sh_color RED "{{$@}}"
    fi
  fi

  echo "$HEADERS"
  curl $@
  echo
} # inspect ()
