
import ./types
import std/sequtils

iterator combinations[T](iterable: seq[T], r: int): Set[T] =
  ## translated from
  ## https://docs.python.org/3/library/itertools.html#itertools.combinations
  
  # TODO: rewrite the following as runnableExamples
  # combinations('ABCD', 2) → AB AC AD BC BD CD
  # combinations(range(4), 3) → 012 013 023 123

  template pool: untyped = iterable  # alias
  # as `combinations` will be called multiply times on the same set,
  # so we use toSeq only once before calling this and pass a seq in.
  let n = len(pool)
  block doYield:
    if r > n:
      break doYield

    var indices = toSeq 0..<r  # its length won't change.
    let lenInd = r
    template yieldPoolByIndices =
      var res = initSet[T](lenInd)
      for i in indices:
        res.incl pool[i]
      yield res
    yieldPoolByIndices
    while true:
      var i = -1
      for ii in countdown(r-1, 0):
        if indices[ii] != ii + n - r:
          i = ii
          break
      if i == -1:
        break doYield
      indices[i] += 1
      for j in i+1..<r:
        indices[j] = indices[j-1] + 1
      yieldPoolByIndices

func pow2(n: int): int =
  ## 2^n (assuming n>0)
  result = 1 shl n
  # or: result = 1; for _ in 1..n: result *= 2

func P*[T](s: Set[T]): Set[Set[T]] =
  ##[ Power set of `s`
  
  If in Python, with the help of `itertools`, the code is
  incredictiable short:
  
  ```Python
  from itertools import combinations
  def power_set(s):
    return {frozenset(c) for i in range(len(s)+1) for c in combinations(s, i)}
    # use frozenset as element as `set`'s element in Python must be hashable.
  ]##

  let lenS = len(s)
  result = initSet[Set[T]](pow2(lenS))
  let sequ = s.toSeq
  for i in 0..lenS:
    for c in combinations(sequ, i):
      result.incl c
  
