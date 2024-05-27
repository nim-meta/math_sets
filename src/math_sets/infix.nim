
import ./types
export types


func `∩`*[T](a, b: Set[T]): Set[T] =
  ##
  ## `\N{intersection}`
  intersection a,  b


func `∪`*[T](a, b: Set[T]): Set[T] =
  ##
  ## `\N{union}`
  union a, b

func `⊕`*[T](a, b: Set[T]): Set[T] =
  ## 
  ## `\N{circled plus}`
  symmetricDifference a, b


func `×`*[T](a, b: Set[T]): Relation[T] =
  ## Cartesian product (卡氏积)
  ##
  ## `\N{multiplication sign}`
  runnableExamples:
    let
      A = toSet [1, 2]
      B = toSet [3, 4]
      res = A×B
    assert res == toSet [
      (2, 3), (1, 3), (2, 4), (1, 4)
    ]
    # {<2, 3>, <1, 3>, <2, 4>, <1, 4>}

  result = initRelation[T](card(a) * card(b))
    
  for i in a:
    for j in b:
      result.incl (i, j)

  
