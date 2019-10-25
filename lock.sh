#!/bin/bash

rectangles=" "

SR=$(xrandr --query | grep ' connected' | grep -o '[0-9][0-9]*x[0-9][0-9]*[^ ]*')
for RES in $SR; do
  SRA=(${RES//[x+]/ })
  CX=$((${SRA[2]} + 30))
  CY=$((${SRA[1]} - 70))
  #rectangles="rectangle $CX,$CY $((CX+250)),$((CY-80)) "
  rectangles+="rectangle $CX,$CY $((CX+250)),$((CY-80)) "
done

TMPBG=/tmp/screen.png
scrot $TMPBG && convert $TMPBG -blur 0x15 -draw "fill black fill-opacity 0.4 $rectangles" $TMPBG

i3lock \
  -i $TMPBG -n -e \
  --datepos="tx:ty+25" \
  --timepos="x+150:h-125" \
  --clock --datestr="%A, %B %d" \
  --insidecolor=00000000 --ringcolor=ffffffff --line-uses-inside \
  --keyhlcolor=d23c3dff --bshlcolor=d23c3dff --separatorcolor=00000000 \
  --insidevercolor=fecf4dff --insidewrongcolor=d23c3dff \
  --ringvercolor=ffffffff --ringwrongcolor=ffffffff --indpos="x+280:h-125" \
  --radius=20 --ring-width=3 \
  --locktext="" --lockfailedtext="" \
  --veriftext="" --wrongtext="" --noinputtext="" \
  --timecolor="ffffffff" --datecolor="ffffffff" \

rm $TMPBG

# resume message display
pkill -u "$USER" -USR2 dunst
