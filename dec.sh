#! /bin/bash

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

for OCTS in $TRIMMED
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

#echo "$TRIMMED"
}


GETIT(){
  read -rp "Enter your base64-encoded string here
>  " BASE
  if  [[ "$BASE" =~ ^([A-Za-z0-9+/]{4})*([A-Za-z0-9+/]{2}[AEIMQUYcgkosw048]=|[A-Za-z0-9+/][AQgw]==)?$ ]]; then
    TEXTTOHEX
  else
    echo "nope"
  fi
}

GETIT

# Lets check to see if it's actaull base64

if [[ "$BASE" = "" ]]; then
  echo "
  Please paste in your string and press [Enter]

> "
fi
