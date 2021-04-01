#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
hints:
  DockerRequirement:
    dockerPull: biomagician/bwa2:2.2.1
baseCommand: [bwa-mem2, mem]
arguments:
  - valueFrom: '@RG\\tID:$(inputs.reads1.nameroot)\\tSM:$(inputs.reads1.nameroot)\\tPL:illumina\\tLB:lib1\\tPU:unit1'
    prefix: -R
    position: 1

inputs:
  n_threads:
    type: int
    inputBinding:
      position: 2
      prefix: -t
  ref_genome:
    type: File
    inputBinding:
      position: 3
    secondaryFiles:
      - .fai
      - .amb
      - .ann
      - .bwt
      - .pac
      - .sa
  reads1:
    type: File
    inputBinding:
      position: 4
  reads2:
    type: File
    inputBinding:
      position: 5

stdout: $(inputs.reads1.nameroot)_unsorted.sam

outputs:
  unsorted_sam:
    type: stdout
