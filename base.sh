#! /bin/bash

# Exit Codes
# =========
# 1 - User tried to decode a string that was not bas64.
# 2 - User entered a value that was not 1 (Full string) or 2 (Individual words) when decoding.
# 3 - User did not enter a string to encode.
# 3 - User entered a value that wasn't 1 (Encode) or 2 (Decode).

DECODE(){

  BASE=""

  TEXTTOHEX(){
    HEX=$(echo "$BASE" | sed -e 's/\(.\)/\1\n/g')
    for TEXT in $HEX
    do
      case $TEXT in
        A) BINARY+="000000" ;;
        B) BINARY+="000001" ;;
        C) BINARY+="000010" ;;
        D) BINARY+="000011" ;;
        E) BINARY+="000100" ;;
        F) BINARY+="000101" ;;
        G) BINARY+="000110" ;;
        H) BINARY+="000111" ;;
        I) BINARY+="001000" ;;
        J) BINARY+="001001" ;;
        K) BINARY+="001010" ;;
        L) BINARY+="001011" ;;
        M) BINARY+="001100" ;;
        N) BINARY+="001101" ;;
        O) BINARY+="001110" ;;
        P) BINARY+="001111" ;;
        Q) BINARY+="010000" ;;
        R) BINARY+="010001" ;;
        S) BINARY+="010010" ;;
        T) BINARY+="010011" ;;
        U) BINARY+="010100" ;;
        V) BINARY+="010101" ;;
        W) BINARY+="010110" ;;
        X) BINARY+="010111" ;;
        Y) BINARY+="011000" ;;
        Z) BINARY+="011001" ;;
        a) BINARY+="011010" ;;
        b) BINARY+="011011" ;;
        c) BINARY+="011100" ;;
        d) BINARY+="011101" ;;
        e) BINARY+="011110" ;;
        f) BINARY+="011111" ;;
        g) BINARY+="100000" ;;
        h) BINARY+="100001" ;;
        i) BINARY+="100010" ;;
        j) BINARY+="100011" ;;
        k) BINARY+="100100" ;;
        l) BINARY+="100101" ;;
        m) BINARY+="100110" ;;
        n) BINARY+="100111" ;;
        o) BINARY+="101000" ;;
        p) BINARY+="101001" ;;
        q) BINARY+="101010" ;;
        r) BINARY+="101011" ;;
        s) BINARY+="101100" ;;
        t) BINARY+="101101" ;;
        u) BINARY+="101110" ;;
        v) BINARY+="101111" ;;
        w) BINARY+="110000" ;;
        x) BINARY+="110001" ;;
        y) BINARY+="110010" ;;
        z) BINARY+="110011" ;;
        0) BINARY+="110100" ;;
        1) BINARY+="110101" ;;
        2) BINARY+="110110" ;;
        3) BINARY+="110111" ;;
        4) BINARY+="111000" ;;
        5) BINARY+="111001" ;;
        6) BINARY+="111010" ;;
        7) BINARY+="111011" ;;
        8) BINARY+="111100" ;;
        9) BINARY+="111101" ;;
        +) BINARY+="111110" ;;
        /) BINARY+="111111" ;;
        *) : ;;
      esac
    done
  EIGHTS=$(echo "$BINARY" | sed 's/.\{8\}/& /g')
  LAST=$(echo "$EIGHTS" | awk '{print $NF}' | wc -m)
  if [[ "$LAST" != 8 ]]; then
    TRIMMED=$(echo "$EIGHTS" | awk '{NF--; print}')
  else
    TRIMMED="$EIGHTS"
  fi

  for OCTS in $TRIMMED7
  do
    LOWERB+="0b$OCTS "
  done

  for LETTS in $LOWERB
  do
    OYSTER=$(perl -E "say $LETTS")
    PEARL=$(perl -E "say chr($OYSTER)")
    PLAIN+="$PEARL"
  done
  echo "$PLAIN"
  }

  GETIT(){
    read -rp "Enter your base64-encoded string here
  >  " BASE
    if  [[ "$BASE" =~ ^([A-Za-z0-9+/]{4})*([A-Za-z0-9+/]{2}[AEIMQUYcgkosw048]=|[A-Za-z0-9+/][AQgw]==)?$ ]]; then
      TEXTTOHEX
    else
      echo "That is not a valid Base64 string, please check and try again."
      exit 1
    fi
  }

  GETIT

  # Lets check to see if it's actaull base64
  if [[ "$BASE" = "" ]]; then
    echo "
    Please paste in your string and press [Enter]

  > "
  fi
}

ENCODE(){
  # Global Variables
  ARGS="$@"
  STRING=""
  ITEM=""


  # Functions
  ## Heavy Lifter
  LIFT(){
    STRING=$ITEM
    BINARY=$(echo -n "$STRING" | xxd -p -b)
    BINSTRIP=$(echo -n "$BINARY" | cut -d" " -f2-7)
    CONC=$(echo -n "$BINSTRIP" | sed 's/ //g')
    DELNL=$(echo "$CONC" | tr -d '\n')
    SIXES=$(echo "$DELNL" | sed 's/.\{6\}/& /g')
    LAST=$(echo "$SIXES" | awk '{print $NF}' | wc -m)

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

    FOURS=$(echo "$LETTERS" | sed 's/.\{4\}/& /g')

    LASTLET=$(echo -n "$FOURS" | awk '{print $NF}' | wc -m)

    case "$LASTLET" in
      3)
        FOURSPAD="$FOURS"== ;;
      4)
        FOURSPAD="$FOURS"= ;;
      *)
        FOURSPAD="$FOURS" ;;
    esac

    REGROUP=$(echo "$FOURSPAD" | tr -d ' ')

    if [[ -n $COUNTER ]]; then
      echo -e "\e[4m$COUNTER:\e[0m
    $REGROUP"
    else
      echo -e "  $REGROUP
  "
    fi
  }

  # More than one?
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
        echo -e"  Error detected, please check your command and try again
  "; exit 2
        ;;
    esac
  }

  # Start
  if [[ $(echo "$ARGS" | awk '{print NF}') -eq 0 ]]; then
    read -p "Enter the string you want to encode:
  >   " ITEM
    if [[ $(echo $ITEM | awk '{print NF}') -eq 0 ]]; then
      echo "No string detected, exiting."
      exit 3
    elif [[ $(echo $ITEM | awk '{print NF}') -eq 1 ]]; then
          echo -e "\n  Encoding "$ARGS"\n  ========\n"
      LIFT "$ITEM"
    else
      ARGS="$ITEM"
      MULTIPLE "$ARGS"
    fi
  elif [[ $(echo "$ARGS" | awk '{print NF}') -eq 1 ]]; then
    echo -e "\n  Encoding "$ARGS"\n  ========\n"
    ITEM="$ARGS"
    LIFT "$ITEM"
  else
    MULTIPLE "$ARGS"
  fi

}

read -rp "
  Are we Encoding or Decodiong?
  -----------------------------
  1) To Encode plaintext to Base64
  2) To Decode Base64 to plaintext

[1] >" ENCDE

ENCDE=${ENCDE:-1}

if [[ "$ENCDE" -eq 1 ]]; then
  ENCODE
elif [[ "$ENCDE" -eq 2 ]]; then
  DECODE
else
  echo -e "
Invalid choice, please try again.
"
  exit 4

fi
