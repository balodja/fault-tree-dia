#!/bin/bash

# Quick and dirty way to make icon files for shapes from shapes themselves
# The shapes should be in dia path.

function makeDiagram() {
    DIAFILE=`mktemp`;
    PNGFILE=`mktemp`;
    echo "\
<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<dia:diagram xmlns:dia=\"http://www.lysator.liu.se/~alla/dia/\">
  <dia:layer name=\"Background\" visible=\"true\" active=\"true\">
    <dia:object type=\"$1\" version=\"1\" id=\"O0\">
    </dia:object>
  </dia:layer>
</dia:diagram>" | gzip -c > "$DIAFILE";
    dia -e "$PNGFILE" -t cairo-alpha-png "$DIAFILE";
    convert -resize 22x22 "$PNGFILE" -background none -gravity center -extent 22x22 "$2";
    rm "$DIAFILE";
    rm "$PNGFILE";
}

makeDiagram "Fault Tree AND" "FaultTreeAnd.png";
makeDiagram "Fault Tree OR" "FaultTreeOr.png";
makeDiagram "Fault Tree XOR" "FaultTreeXor.png";
makeDiagram "Fault Tree Priority AND 1" "FaultTreePriorityAnd1.png";
makeDiagram "Fault Tree Priority AND 2" "FaultTreePriorityAnd2.png";
makeDiagram "Fault Tree Basic Event" "FaultTreeBasicEvent.png";
makeDiagram "Fault Tree Input Event" "FaultTreeInputEvent.png";
makeDiagram "Fault Tree External Event" "FaultTreeExternalEvent.png";
