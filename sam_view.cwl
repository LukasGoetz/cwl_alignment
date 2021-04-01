#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
hints:
  DockerRequirement:
    dockerPull: biomagician/samtools:1.12
baseCommand: [samtools, view]
arguments:
  - valueFrom: -h
    position: 1
  - valueFrom: -b
    position: 1

inputs:
  n_threads:
    type: int
    inputBinding:
      position: 2
      prefix: -@
  sam:
    type: File
    inputBinding:
      position: 3

stdout: $(inputs.sam.nameroot).bam

outputs:
  unsorted_bam:
    type: stdout
