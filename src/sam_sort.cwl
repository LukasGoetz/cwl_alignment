#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
hints:
  DockerRequirement:
    dockerPull: biomagician/samtools:1.12
baseCommand: [samtools, sort]
arguments:
  - valueFrom: $(inputs.bam.nameroot)_output.sort
    prefix: -T
    position: 3
  - valueFrom: $(inputs.bam.nameroot)_output.sort.bam
    prefix: -o
    position: 4

inputs:
  bam:
    type: File
    inputBinding:
      position: 1
  n_threads:
    type: int
    inputBinding:
      position: 2
      prefix: -@

outputs:
  sorted_bam:
    type: File
    outputBinding:
      glob: $(inputs.bam.nameroot)_output.sort.bam
