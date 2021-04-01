#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
hints:
  DockerRequirement:
    dockerPull: biomagician/gatk:3.8
baseCommand: [java, -jar, /opt/gatk/GenomeAnalysisTK.jar, -T, IndelRealigner]
arguments:
  - valueFrom: $(inputs.bam.nameroot).realigned.bam
    prefix: -o
    position: 4

inputs:
  bam:
    type: File
    inputBinding:
      prefix: -I
      position: 1
    secondaryFiles:
      - .bai
  ref_genome:
    type: File
    inputBinding:
      prefix: -R
      position: 2
    secondaryFiles:
      - .fai
      - .amb
      - .ann
      - .bwt
      - .pac
      - .sa
      - ^.dict
  bam_list:
    type: File
    inputBinding:
      prefix: -targetIntervals
      position: 3


outputs:
  realigned_bam:
    type: File
    outputBinding:
      glob: $(inputs.bam.nameroot).realigned.bam
