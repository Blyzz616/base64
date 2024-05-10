#!/bin/bash

if [[ "$1" == "" ]]; then
  echo "Enter something after the command"
  exit 1
fi

STRING=$1

BINARY=$(echo -n "$STRING" | xxd -p -b)

#echo -e "$BINARY\n"

BINSTRIP=$(echo -n "$BINARY" | cut -d" " -f2-7)

#echo "$BINSTRIP"

CONC=$(echo -n "$BINSTRIP" | sed 's/ //g')

#echo "$CONC"

DELNL=$(echo "$CONC" | tr -d '\n')

#echo "$DELNL"

SIXES=$(echo "$DELNL" | sed 's/.\{6\}/& /g')

#echo "$SIXES"

LAST=$(echo "$SIXES" | awk '{print $NF}' | wc -m)

#echo "$LAST"

case "$LAST" in
  3)
    FULL=$(echo "$SIXES"0000)
    ;;
  5)
    FULL=$(echo "$SIXES"00)
    ;;
  *)
    FULL="$SIXES"
    ;;
esac

#echo "$FULL"

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

#echo "$LETTERS"

FOURS=$(echo "$LETTERS" | sed 's/.\{4\}/& /g')

#echo "$FOURS"

LASTLET=$(echo -n "$FOURS" | awk '{print $NF}' | wc -m)

#echo "$LASTLET"

case "$LASTLET" in
  3)
    FOURSPAD=$(echo "$FOURS"==)
    ;;
  4)
    FOURSPAD=$(echo "$FOURS"=)
    ;;
  *)
    FOURSPAD="$FOURS"
    ;;
esac

#echo "$FOURSPAD"

REGROUP=$(echo "$FOURSPAD" | tr -d ' ')

echo "$REGROUP"
