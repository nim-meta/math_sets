# Package

version       = "0.1.1"
author        = "litlighilit"
description   = "A sets library that provides notations of set theory (discrete math)"
license       = "MIT"
srcDir        = "src"


# Dependencies

requires "nim >= 1.6.12"

# Tasks

task docs, "gen doc":
  let mainFile = srcDir & "/math_sets.nim"
  exec "nim doc --outdir:docs --project " & mainFile
