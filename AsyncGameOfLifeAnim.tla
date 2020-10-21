------------------------ MODULE AsyncGameOfLifeAnim ------------------------
EXTENDS SVG, SequencesExt, Toolbox, TLC, AsyncGameOfLife\*Distributed

\*CellColor(cell) == 
\*  CASE cell[1] = TRUE /\ cell[2] = TRUE  -> "lightblue"
\*    [] cell[1] = TRUE /\ cell[2] = FALSE -> "lightgray"
\*    [] cell[1] =FALSE /\ cell[2] = TRUE  -> "yellow"
\*    [] cell[1] =FALSE /\ cell[2] = FALSE -> "lightyellow"

CellColor(cell) == 
  CASE cell[1] = TRUE /\ cell[2] =TRUE -> "blue"                      \* Alive cell for r \in {0,1}
    [] cell[1] = TRUE /\ cell[2] =FALSE -> "lightblue"                \* Alive cell for r \in {0}
    [] cell[1] =FALSE /\ cell[2] =TRUE -> "yellow"                    \* Alive cell for r \in {1}
    [] cell[1] =FALSE /\ cell[2] =FALSE /\cell[3] = 0 -> "lightgray"  \* Dead cell for r = 0
    [] cell[1] =FALSE /\ cell[2] =FALSE /\cell[3] = 1  -> "gray"      \* Dead cell for r = 1
    [] cell[1] =FALSE /\ cell[2] =FALSE /\cell[3] = 2 -> "darkgray"   \* Dead cell for r = 2

\* Gap between cells.
AnimPos == [ x |-> 4, y |-> 4 ]

\* Dimensions of a single rectangle.
GAnimPos == [w |-> 40, h |-> 40]

\* Grid
Grid ==
   SetToSeq(
     { Group(<<
         Rect(coordinate[1] * (GAnimPos.w + AnimPos.x), 
              coordinate[2] * (GAnimPos.h + AnimPos.y), 
              GAnimPos.w, 
              GAnimPos.h, 
              [fill |-> CellColor(grid[coordinate]) ]),
         Text(coordinate[1] * (GAnimPos.w + AnimPos.x),
              coordinate[2] * (GAnimPos.h + AnimPos.y),
              ToString(grid[coordinate][3]), [font |-> "Arial"])>>, <<>>) : 
                          coordinate \in DOMAIN grid })

\* Grid converted to SVG.
Animation == SVGElemToString(Group(Grid, <<>>))

=============================================================================
