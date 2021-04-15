#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
hints:
  DockerRequirement:
    dockerPull: biomagician/trimmomatic:0.39
baseCommand: [java, -jar, /opt/trimmomatic/trimmomatic.jar]
arguments:
  - valueFrom: $(inputs.reads1.nameroot).trimmed.fastq
    position: 6
  - valueFrom: $(inputs.reads1.nameroot).trimmed.unpaired.fastq
    position: 7
  - valueFrom: $(inputs.reads2.nameroot).trimmed.fastq
    position: 8
  - valueFrom: $(inputs.reads2.nameroot).trimmed.unpaired.fastq
    position: 9

inputs:
  read_type:
    type: string
    inputBinding:
      position: 1
  n_threads:
    type: int
    inputBinding:
      position: 2
      prefix: -threads
  base_qual_encoding:
    type: string
    inputBinding:
      position: 3
  reads1:
    type: File
    inputBinding:
      position: 4
  reads2:
    type: File
    inputBinding:
      position: 5
  clip:
    type: string
    inputBinding:
      position: 10
  crop:
    type: string
    inputBinding:
      position: 11
  trailing:
    type: string
    inputBinding:
      position: 12
  minlen:
    type: string
    inputBinding:
      position: 13

outputs:
  reads1_trimmed_paired:
    type: File
    outputBinding:
      glob: $(inputs.reads1.nameroot).trimmed.fastq
  reads1_trimmed_unpaired:
    type: File
    outputBinding:
      glob: $(inputs.reads1.nameroot).trimmed.unpaired.fastq
  reads2_trimmed_paired:
    type: File
    outputBinding:
      glob: $(inputs.reads2.nameroot).trimmed.fastq
  reads2_trimmed_unpaired:
    type: File
    outputBinding:
      glob: $(inputs.reads2.nameroot).trimmed.unpaired.fastq
