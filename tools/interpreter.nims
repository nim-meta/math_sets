#!/usr/bin/env -S nim --hints:off
import std/macros
import std/os

const
  AsSetCall = "asSet"
  MathSetsDevCwd{.booldefine.} = true
  SetsLib = 
    when MathSetsDevCwd: currentSourcePath().parentDir /../ "/src/math_sets"
    else: "pkg/math_sets"


proc rewriteSetDep1(stmts: var NimNode, asSetCallProc = ident AsSetCall) =
  for i in 0..<stmts.len:
    let n = stmts[i]
    case n.kind
    of nnkAsgn:
      var rhs = n[1]
      if rhs.kind == nnkCurly:
        let bracket = newNimNode(nnkBracket, lineInfoFrom=rhs)
        for i in rhs:
          bracket.add i
        let nRhs = newCall(asSetCallProc, bracket)
        rhs = nRhs
        n[1] = nRhs
      let lhs = n[0]
      let varDecl = newVarStmt(lhs, rhs)
      let newN = quote do:
        when declared(`lhs`):
          `n`
        else:
          `varDecl`
      
      stmts[i] = newN
      
    
    else:
      discard


template SS: untyped = static[string]
proc parse*(content: string,
    setsLibPath: SS = SetsLib,
    asSetCallName: SS = AsSetCall, fnForHint = ""): NimNode{.compileTime.} =
  result = newStmtList()
  let pre = nnkImportStmt.newTree newLit setsLibPath
  result.add pre
  var nnodes = parseStmt(content, fnForHint)
  rewriteSetDep1 nnodes, asSetCallProc = ident asSetCallName
  result.add nnodes

macro mathSetsStmt*(content: untyped,
    setsLibPath: SS = SetsLib,
    asSetCallName: SS = AsSetCall): untyped =
  parse repr content

macro load*(fn: static[string],
    setsLibPath: SS = SetsLib,
    asSetCallName: SS = AsSetCall
    ): untyped =
  let content = readFile fn
  parse content

when isMainModule:
  when defined(nimscript):
    const s = static:
      let argn = paramCount()
      if argn == 0:
        quit "Usage: ./<file> <inputFile> on Unix or nimr <inputFile> on Windows"
      paramStr argn
    load s  # load last param
  else:
    {.error: "please run via nimvm (e.g. `nim e`)".}

