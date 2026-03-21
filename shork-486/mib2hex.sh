#!/bin/bash



PHYSICAL_START=""
PHYSICAL_ALIGN=0x2000



while [ $# -gt 0 ]; do
    case "$1" in
        --mib=*)
            PHYSICAL_START="${1#*=}"
            ;;
    esac
    shift
done



if [ -n "$PHYSICAL_START" ]; then
    if [[ "$PHYSICAL_START" != 0x* ]]; then
        BYTES=$(echo "$PHYSICAL_START * 1048576" | bc)
        BYTES=${BYTES%.*}
    else
        BYTES=$((PHYSICAL_START))
    fi
    CLEAN_ALIGN=${PHYSICAL_ALIGN#0x}
    ALIGN_DEC=$((16#$CLEAN_ALIGN))
    PHYSICAL_START=$(((BYTES + ALIGN_DEC - 1) / ALIGN_DEC * ALIGN_DEC))
    PHYSICAL_START=$(printf "0x%X" "$PHYSICAL_START")
fi

echo $PHYSICAL_START
