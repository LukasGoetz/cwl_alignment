#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
hints:
  DockerRequirement:
    dockerPull: biomagician/picard:2.25.1
baseCommand: [java, -jar, /opt/picard/picard.jar, FixMateInformation,
              SO=coordinate, VALIDATION_STRINGENCY=LENIENT, CREATE_INDEX=true]
arguments:
- valueFrom: Output=$(inputs.bam.nameroot)_fixed.bam
  position: 2

inputs:
  bam:
    type: File
    inputBinding:
      prefix: Input=
      position: 3

outputs:
  fixed_bam:
    type: File
    outputBinding:
      glob: $(inputs.bam.nameroot)_fixed.bam
