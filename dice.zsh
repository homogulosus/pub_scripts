#!/bin/zsh
#########################
# DND Style Dice Roller #
#########################

# Colors
RED=$(printf '\033[31m')
GREEN=$(printf '\033[32m')
YELLOW=$(printf '\033[33m')
BLUE=$(printf '\033[34m')
BOLD=$(printf '\033[1m')
RESET=$(printf '\033[m')

# This is the dice itself which takes arguments.
rolldie()
{
   local result=$1 sides=$2
   rolled=$(( ( $RANDOM % $sides ) + 1 ))
   eval $result=$rolled
}

usage()
{
    echo "$RED Usage: $RESET $0 Nunber d Number Sides {NdM}\n\t dice NdM"
    exit 1
}

# Get options - Learn about getop -
while getopts "h" arg; do
  case "$arg" in
      h) usage
         exit 2
         ;;
      *) echo "Invalid option $1"
         usage
         exit 3
         ;;
  esac
done
shift $(( $OPTIND - 1 ))

for request in $* ; do
    echo "\n$RED Rolling: $request $RESET"
done

# This is the output
for request in $* ; do
  dice=$(echo $request | cut -dd -f1)
  sides=$(echo $request | cut -dd -f2)
  echo "\tRolling $dice $sides-sided dice"
  sum=0  # reset
  counter=1 # reset too
  while [ ${dice:=1} -gt 0 ] ; do
    rolldie die $sides
    echo "\t\tdice $counter roll = $die"
    sum=$(( $sum + $die ))
    dice=$(( $dice - 1 ))
    counter=$(( $counter + 1 ))
  done
  echo "$YELLOW\t\tsum total = $sum $RESET\n"
done

exit 0
