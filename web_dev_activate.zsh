#!/usr/bin/env zsh

############################################
# Scrip to build up folders and some files #
# Aim at Simple Web Development            #
############################################

# Variables
INDEX=index.html
SCSS=scss/style.scss
CSS=css/style.css
DIR_SCSS=scss
DIR_CSS=css

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
    if [[ -d $DIR_SCSS || -d $DIR_CSS ]]; then
        echo "css or scss directory already present!\n"
        if [[ -z $(ls -A $DIR_SCSS) ]]; then
            echo $YELLOW "$DIR_SCSS is empty! $RESET"
        else
            echo $RED "$DIR_SCSS is not empty! $RESET"
        fi
        if [[ -z $(ls -A $DIR_CSS) ]]; then
            echo $YELLOW "$DIR_CSS is empty! $RESET"
        else
            echo $RED "$DIR_CSS is not empty! $RESET"
        fi

        # scss
        if [[ -s $SCSS ]]; then
            echo $RED "$SCSS is present and not empty! $RESET"
        else
            echo $YELLOW "$SCSS is present and is empty! $RESET"
        fi

        # css
        if [[ -s $CSS ]]; then
            echo $RED "$CSS is present and not empty! $RESET"
        else
            echo $YELLOW "$CSS is present and is empty! $RESET"
        fi
    fi
    # index present? Empty?
    if [[ -f $INDEX ]]; then
        if [[ -s $INDEX ]]; then
            echo $RED "$INDEX is present and not empty! $RESET"
        else
            echo $YELLOW "$INDEX is present and is empty! $RESET"
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
