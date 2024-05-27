
import ./types
export types.`$`

import std/macros


macro asSet*(lit): Set =
  runnableExamples:
    let S = asSet {1, 2}
    let s = $S
    assert '1' in s and '2' in s
  result = newCall bindSym"toSet"
  var bracket = newNimNode nnkBracket
  for i in lit:
    bracket.add i
  result.add bracket

