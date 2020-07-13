#!/usr/bin/env zsh

# Idea taken from: github.com/tylerneylon/dotfiles/blob/master/.bash_profile
function encrypt() {
  if [[ -z "$1" ]]; then
    echo Usage: encrypt '<infile>' '[outfile]'
    return
  fi
  if [[ -z "$2" ]]; then
    out="$1".des3
  else
    out="$2".des3
  fi
  if [[ "$1" == "$out" ]]; then
    echo Filenames must be different.
    return
  fi

  openssl des3 -salt -in "$1" -out "$out"
}

function decrypt() {
  if [[ -z "$1" ]]; then
    echo Usage: decrypt '<infile>' '[outfile]'
    return
  fi
  if [[ -z "$2" ]]; then
    out="${1%.*}"
  else
    out="$2"
  fi
  if [[ "$1" == "$out" ]]; then
    echo Two filenames are required.
    return
  fi
  if [[ -e "$out" ]]; then
    echo Output file already exists.
    return
  fi

  openssl des3 -d -salt -in "$1" -out "$out"
}

function help() {
  # Print help
cat << "Help"
  -E encrypt
  -D decrypt
  anything else returns this help

  cript -[ED] <file_to_encript/decript> [output_file]
Help
}

function main() {
# -E = encrypt
# -D = decrypt
while getopts ":E:D:" opt; do
  case $opt in
    E)
        shift
        encrypt "$@"
        ;;
    D)
        shift
        decrypt "$@"
        ;;
    *)
        help
        exit 1
        ;;
  esac
done
}

main "$@"
