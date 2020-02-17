# Will print a Y/n confirmation message.
# Pass the message as the first variable.
confirm_message() {
  read -p "$(printf "\n${1} [Y/n] ")" yn </dev/tty
  case $yn in
  [Yy]*) ;;
  [Nn]*) exit ;;
  *) exit ;;
  esac
}
