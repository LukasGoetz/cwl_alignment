#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: /home/lukas/work/umm/gacs/test/cwl_pipeline/tools/bwa/bwa
arguments:
- valueFrom: "index"
  position: 1

inputs:
  genome:
    type: File
    inputBinding:
      position: 2

outputs:
  log_out:
    type: stdout