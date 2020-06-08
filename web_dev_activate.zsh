#!/usr/bin/env zsh

############################################
# Scrip to build up folders and some files #
# Aim at Simple Web Development            #
############################################

# Variables
FILE1=index.html
FILE2=scss/style.scss
FILE3=css/style.css
DIR1=scss
DIR2=css

# Colors
LIGHT_GREEN="\e[92m"
RESET="\e[97m"
YELLOW="\e[33m"
RED="\e[31m"

main() {
    # Start with a clean screen rest is self explanatory
    clear
    create_directories
    sass
}

# Functions #

function build_directories() {
    touch index.html
    mkdir scss css
    echo ".gitignore\nnohup.out" > .gitignore
    touch scss/style.scss
    touch css/style.css
    touch README.md
    echo
}

function create_directories() {
    if [[ -d $DIR1 || -d $DIR2 ]]; then
        echo "css or scss directory already present!\n"
        if [[ -z $(ls -A $DIR1) ]]; then
            echo $YELLOW "$DIR1 is empty! $RESET"
        else
            echo $RED "$DIR1 is not empty! $RESET"
        fi
        if [[ -z $(ls -A $DIR2) ]]; then
            echo $YELLOW "$DIR2 is empty! $RESET"
        else
            echo $RED "$DIR2 is not empty! $RESET"
        fi

        # scss
        if [[ -s $FILE2 ]]; then
            echo $RED "$FILE2 is present and not empty! $RESET"
        else
            echo $YELLOW "$FILE2 is present and is empty! $RESET"
        fi

        # css
        if [[ -s $FILE3 ]]; then
            echo $RED "$FILE3 is present and not empty! $RESET"
        else
            echo $YELLOW "$FILE3 is present and is empty! $RESET"
        fi
    fi
    # index present? Empty?
    if [[ -f $FILE1 ]]; then
        if [[ -s $FILE1 ]]; then
            echo $RED "$FILE1 is present and not empty! $RESET"
        else
            echo $YELLOW "$FILE1 is present and is empty! $RESET"
        fi
    else

        # Get things done
        build_directories
        git init
        git add .

        echo "Directories initialized in `pwd` :-) "
        tree -aC -I '.git' --dirsfirst "$@" | less -FRNX
    fi
}

# Sass Activate
function sass() {
    read -k "input?Do you want to activate sass in the background [Y/n] "
    if [[ "$input" =~ ^[Yy]$ ]]; then
        nohup sass --watch scss:css &
        echo $YELLOW
        echo "Sass compiler adtivated with nohup, remember to run sassout when you are done."
        banner
    elif [[  "$input" =~ [Nn]$ ]]; then
        banner
    else
        echo
        sass
    fi
}

# BANNER
function banner() {
echo $LIGHT_GREEN
cat << "EOF"

        █╗░░░░░░░██╗███████╗██████╗░  ██████╗░███████╗██╗░░░██╗
      ░██║░░██╗░░██║██╔════╝██╔══██╗  ██╔══██╗██╔════╝██║░░░██║
      ░╚██╗████╗██╔╝█████╗░░██████╦╝  ██║░░██║█████╗░░╚██╗░██╔╝
      ░░████╔═████║░██╔══╝░░██╔══██╗  ██║░░██║██╔══╝░░░╚████╔╝░
      ░░╚██╔╝░╚██╔╝░███████╗██████╦╝  ██████╔╝███████╗░░╚██╔╝░░
      ░░░╚═╝░░░╚═╝░░╚══════╝╚═════╝░  ╚═════╝░╚══════╝░░░╚═╝░░░

      ░█████╗░░█████╗░████████╗██╗██╗░░░██╗░█████╗░████████╗███████╗██████╗░
      ██╔══██╗██╔══██╗╚══██╔══╝██║██║░░░██║██╔══██╗╚══██╔══╝██╔════╝██╔══██╗
      ███████║██║░░╚═╝░░░██║░░░██║╚██╗░██╔╝███████║░░░██║░░░█████╗░░██║░░██║
      ██╔══██║██║░░██╗░░░██║░░░██║░╚████╔╝░██╔══██║░░░██║░░░██╔══╝░░██║░░██║
      ██║░░██║╚█████╔╝░░░██║░░░██║░░╚██╔╝░░██║░░██║░░░██║░░░███████╗██████╔╝
      ╚═╝░░╚═╝░╚════╝░░░░╚═╝░░░╚═╝░░░╚═╝░░░╚═╝░░╚═╝░░░╚═╝░░░╚══════╝╚═════╝░

EOF
echo $RESET
}

main "$@"
