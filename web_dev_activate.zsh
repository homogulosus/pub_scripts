#!/bin/zsh

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

# Start with a clean screen
clear

# Functions
function build_directories() {
    touch index.html
    mkdir scss css
    echo ".gitignore\nnohup.out" > .gitignore
    touch scss/style.scss
    touch css/style.css
    touch README.md
    echo
}

# Logic
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
    if [[ -s $FILE3 ]]; then
        echo $RED "style.css is present and not empty! $RESET"
    else
        echo $YELLOW "sytyle.css is present and is empty! $RESET"
    fi
fi

if [[ -f $FILE1 ]]; then
    if [[ -s $FILE1 ]]; then
        echo $RED "index.html is present and not empty! $RESET"
    else
        echo $YELLOW "index.html is present and is empty! $RESET"
    fi
else

    # Executions
    build_directories
    git init
    git add .

    echo "Directories initialized in `pwd` :-) "
    tree -aC -I '.git' --dirsfirst "$@" | less -FRNX
   fi

# Sass Activate
echo $YELLOW
echo "SASS Adtivated with nohup, remember to run sassout when you are done."
nohup sass --watch scss:css &

# Implement some user interaction. Ask if user wants sassyness
#  Ask user if a http server would be nice.
#  which one? Options: PHP, python, node.
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
