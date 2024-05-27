
import ./types
export types
import std/sugar

func `[]`*[T](R: Relation[T], S: Set[T]): Set[T] =
  ## image (像)
  runnableExamples:
    let R: Relation[int] = toSet [
      (1, 2),
      (3, 4),
      (5, 6)
    ]
    
    let S: Set[int] = toSet [3, 5]
    assert R[S] == toSet [4, 6]

  collect:
    for t in R:
      if t[0] in S:
        {t[1]}

func `/`*[T](A: Set[T], R: Relation[T]): Set[Set[T]] =
  ## quotient set (商集)
  runnableExamples:
    let A = toSet [1, 5]  # {1, 5}
    let R: Relation[int] = toSet [
      (1, 2),
      (3, 4),
      (5, 6),
      (1, 6)
    ]
    # {<1,2>, <3,4>, <5,6>, <1,6>}

    let res = A/R
    assert res == toSet [
      toSet [2, 6],
      toSet [6]
    ]
    # A/R = {{6}, {2, 6}}
  
  collect:
    for a in A:
      {R[ toSet [a] ]}
  
