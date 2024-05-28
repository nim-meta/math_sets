
import std/sets except initSet
export sets except initSet


type
  Set*[T] = HashSet[T]  ## 集合

  Pair*[T] = (T, T)  ## 有序对 Ordered Pair

  Relation*[T] = Set[Pair[T]]  ## 关系


template toSet*(x): Set = toHashSet(x)
converter bracketLiteralToSet*[T](S: set[T]): Set[T] =
  result = initHashSet(card S)
  for i in S: result.incl(i)


func initSet*[T](initialSize = defaultInitialSize): Set[T] =
  ## init a Set with given initialSize
  ## 
  ## Set can be used in `var`,
  ## calling this func is not necessary
  initHashSet[T](initialSize)

func initRelation*[T](initialSize = defaultInitialSize): Relation[T] =
  ## init a Relation with given initialSize
  ## 
  ## Set can be used in `var`,
  ## calling this func is not necessary
  ## inti a Set with given initialSize
  initSet[Pair[T]](initialSize)
