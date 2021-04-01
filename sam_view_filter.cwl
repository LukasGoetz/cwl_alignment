#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
hints:
  DockerRequirement:
    dockerPull: biomagician/samtools:1.12
baseCommand: [samtools, view]
arguments:
  - valueFrom: '-b'
    position: 1
  - valueFrom: '0x2'
    prefix: -f
    position: 2
  - valueFrom: '20'
    prefix: -q
    position: 3

inputs:
  n_threads:
    type: int
    inputBinding:
      position: 4
      prefix: -@
  sam:
    type: File
    inputBinding:
      position: 5

stdout: $(inputs.sam.nameroot)_filtered.bam

outputs:
  filtered_bam:
    type: stdout
