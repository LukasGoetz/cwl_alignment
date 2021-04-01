#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
hints:
  DockerRequirement:
    dockerPull: biomagician/gatk:3.8
baseCommand: [java, -jar, /opt/gatk/GenomeAnalysisTK.jar, -T, RealignerTargetCreator ]
arguments:
- valueFrom: $(inputs.bam.nameroot).bam.list
  prefix: -o
  position: 4

inputs:
  n_threads:
    type: int
    inputBinding:
      prefix: -nt
      position: 1
  bam:
    type: File
    inputBinding:
      prefix: -I
      position: 2
    secondaryFiles:
      - .bai
  ref_genome:
    type: File
    inputBinding:
      prefix: -R
      position: 3
    secondaryFiles:
      - .fai
      - .amb
      - .ann
      - .bwt
      - .pac
      - .sa
      - ^.dict

outputs:
  bam_list:
    type: File
    outputBinding:
      glob: $(inputs.bam.nameroot).bam.list
