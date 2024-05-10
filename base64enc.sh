#!/bin/bash

# Global Variables
ARGS="$@"  # Store all command line arguments
STRING=""   # Initialize empty string variable
ITEM=""     # Initialize empty item variable

# Functions

## Heavy Lifter
LIFT(){
  STRING=$ITEM
  BINARY=$(echo -n "$STRING" | xxd -p -b)         # Convert string to binary
  BINSTRIP=$(echo -n "$BINARY" | cut -d" " -f2-7) # Strip the first byte
  CONC=$(echo -n "$BINSTRIP" | sed 's/ //g')      # Remove spaces
  DELNL=$(echo "$CONC" | tr -d '\n')              # Remove newlines
  SIXES=$(echo "$DELNL" | sed 's/.\{6\}/& /g')    # Group binary into 6 bits
  LAST=$(echo "$SIXES" | awk '{print $NF}' | wc -m)  # Count number of characters in the last group

  # Determine padding based on the number of characters in the last group
  case "$LAST" in
    3)
      FULL="$SIXES"0000
      ;;
    5)
      FULL="$SIXES"00
      ;;
    *)
      FULL="$SIXES"
      ;;
  esac

  # Convert binary groups to Base64 characters
  LETTERS=""
  for GROUP in $FULL; do
    DECIMAL=$((2#$GROUP))
    case "$DECIMAL" in
      0)  LETTERS+="A" ;;
      1)  LETTERS+="B" ;;
      2)  LETTERS+="C" ;;
      3)  LETTERS+="D" ;;
      4)  LETTERS+="E" ;;
      5)  LETTERS+="F" ;;
      6)  LETTERS+="G" ;;
      7)  LETTERS+="H" ;;
      8)  LETTERS+="I" ;;
      9)  LETTERS+="J" ;;
      10) LETTERS+="K" ;;
      11) LETTERS+="L" ;;
      12) LETTERS+="M" ;;
      13) LETTERS+="N" ;;
      14) LETTERS+="O" ;;
      15) LETTERS+="P" ;;
      16) LETTERS+="Q" ;;
      17) LETTERS+="R" ;;
      18) LETTERS+="S" ;;
      19) LETTERS+="T" ;;
      20) LETTERS+="U" ;;
      21) LETTERS+="V" ;;
      22) LETTERS+="W" ;;
      23) LETTERS+="X" ;;
      24) LETTERS+="Y" ;;
      25) LETTERS+="Z" ;;
      26) LETTERS+="a" ;;
      27) LETTERS+="b" ;;
      28) LETTERS+="c" ;;
      29) LETTERS+="d" ;;
      30) LETTERS+="e" ;;
      31) LETTERS+="f" ;;
      32) LETTERS+="g" ;;
      33) LETTERS+="h" ;;
      34) LETTERS+="i" ;;
      35) LETTERS+="j" ;;
      36) LETTERS+="k" ;;
      37) LETTERS+="l" ;;
      38) LETTERS+="m" ;;
      39) LETTERS+="n" ;;
      40) LETTERS+="o" ;;
      41) LETTERS+="p" ;;
      42) LETTERS+="q" ;;
      43) LETTERS+="r" ;;
      44) LETTERS+="s" ;;
      45) LETTERS+="t" ;;
      46) LETTERS+="u" ;;
      47) LETTERS+="v" ;;
      48) LETTERS+="w" ;;
      49) LETTERS+="x" ;;
      50) LETTERS+="y" ;;
      51) LETTERS+="z" ;;
      52) LETTERS+="0" ;;
      53) LETTERS+="1" ;;
      54) LETTERS+="2" ;;
      55) LETTERS+="3" ;;
      56) LETTERS+="4" ;;
      57) LETTERS+="5" ;;
      58) LETTERS+="6" ;;
      59) LETTERS+="7" ;;
      60) LETTERS+="8" ;;
      61) LETTERS+="9" ;;
      62) LETTERS+="+" ;;
      63) LETTERS+="/" ;;
      *)  echo "Invalid decimal input" ;;
    esac
  done

  # Group Base64 characters into sets of four
  FOURS=$(echo "$LETTERS" | sed 's/.\{4\}/& /g')
  LASTLET=$(echo -n "$FOURS" | awk '{print $NF}' | wc -m)

  # Determine padding based on the number of characters in the last group
  case "$LASTLET" in
    3)
      FOURSPAD="$FOURS"== ;;
    4)
      FOURSPAD="$FOURS"= ;;
    *)
      FOURSPAD="$FOURS" ;;
  esac

  # Remove spaces from the final result
  REGROUP=$(echo "$FOURSPAD" | tr -d ' ')

  # Print the result
  if [[ -n $COUNTER ]]; then
    echo -e "\e[4m$COUNTER:\e[0m\n  $REGROUP"
  else
    echo -e "  $REGROUP\n"
  fi
}

## Determine encoding method if multiple words are provided
MULTIPLE(){
  read -p "You have entered more than one word.

Would you like me to encode the entire string as one cipher
or encode each word individually?

Enter '1' to encode entire string at once
Enter '2' to encode each word individually.

Your choice [1]: " CHOICE
  CHOICE=${CHOICE:-1}
  case "$CHOICE" in
    1)
      ITEM="$ARGS"
      echo -e "\n  Encoding \`$ITEM\` as a single string\n  ========\n"
      LIFT "$ITEM"
      ;;
    2)
      echo -e "\n  Encoding each word individually\n  ========\n"
      LOOPSTRING="$ARGS"
      COUNTER="0"
      for ITEM in $LOOPSTRING
      do
        ((COUNTER++))
        LIFT $ITEM $COUNTER
        echo ""
      done
      ;;
    *)
      echo -e"  Error detected, please check your command and try again\n"; exit 2
      ;;
  esac
}

# Start

# Check if no arguments provided
if [[ $(echo "$ARGS" | awk '{print NF}') -eq 0 ]]; then
  # Prompt for input if no arguments provided
  read -p "Enter the string you want to encode:
>   " ITEM
  if [[ $(echo $ITEM | awk '{print NF}') -eq 0 ]]; then
    echo "No string detected, exiting."
    exit 1
  elif [[ $(echo $ITEM | awk '{print NF}') -eq 1 ]]; then
    echo -e "\n  Encoding "$ARGS"\n  ========\n"
    LIFT "$ITEM"
  else
    ARGS="$ITEM"
    MULTIPLE "$ARGS"
  fi
# Check if only one argument provided
elif [[ $(echo "$ARGS" | awk '{print NF}') -eq 1 ]]; then
  echo -e "\n  Encoding "$ARGS"\n  ========\n"
  ITEM="$ARGS"
  LIFT "$ITEM"
# Otherwise, process multiple arguments
else
  MULTIPLE "$ARGS"
fi
