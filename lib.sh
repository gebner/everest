# The return value of Bash function is the exit status of their last command;
# therefore, you can do things like [if is_osx; then ...].
is_osx () {
  [[ $(uname) == "Darwin" ]]
}

is_windows () {
  [[ $OS == "Windows_NT" ]]
}

# If a command [cmd] is not found in path, then [success_or cmd msg] prints
# [msg] if non-empty, then aborts with a non-zero exit status.
success_or ()
{
  if ! command -v $1 >/dev/null 2>&1; then
    echo "ERROR: $1 not found"
    if [[ $2 != "" ]]; then
      echo "Hint: $2"
    fi
    exit 1
  fi
  echo $1 found
}

# [ifyes cmd] prompts the user, and runs [cmd] if user approved, and aborts
# otherwise
ifyes ()
{
  echo "Do you want to run: $1? [Y/n]"
  read ans
  case "$ans" in
    [Yy]|"")
      $1
      ;;

    *)
      exit 1
      ;;
  esac
}
