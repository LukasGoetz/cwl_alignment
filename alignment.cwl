#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
requirements:
 - class: StepInputExpressionRequirement
 - class: MultipleInputFeatureRequirement
inputs:
  reads1:
    type: File
    format:
      - edam:format_1930 # FASTA
      - edam:format_1931 # FASTQ
  reads2:
    type: File
    format:
      - edam:format_1930 # FASTA
      - edam:format_1931 # FASTQ
  ref_genome:
    type: File
    format:
      - edam:format_1930 # FASTA
    secondaryFiles:
      - .fai
      - .amb
      - .ann
      - .bwt
      - .pac
      - .sa
      - ".0123"
      - .bwt.2bit.64
      - ^.dict
  n_threads:
    type: int
  
steps:
  trimming:
    run: trimmomatic.cwl
    in:
      read_type:
        valueFrom: "PE"
      n_threads: n_threads
      base_qual_encoding:
        valueFrom: "-phred33"
      reads1: reads1
      reads2: reads2
      clip:
        valueFrom: "ILLUMINACLIP:/opt/Trimmomatic/adapters/TruSeq3-PE-2.fa:2:30:10"
      crop:
        valueFrom: "HEADCROP:3"
      trailing:
        valueFrom: "TRAILING:10"
      minlen:
        valueFrom: "MINLEN:25"
    out:
      - reads1_trimmed_paired
      - reads2_trimmed_paired

  bwa_mem2:
    run: bwa_mem2.cwl
    in:
      n_threads: n_threads
      ref_genome: ref_genome
      reads1: trimming/reads1_trimmed_paired
      reads2: trimming/reads2_trimmed_paired
    out:
      - unsorted_sam

  sam_view:
    run: sam_view.cwl
    in:
      n_threads: n_threads
      sam: bwa_mem2/unsorted_sam
    out:
      - unsorted_bam

  sam_sort:
    run: sam_sort.cwl
    in:
      n_threads: n_threads
      bam: sam_view/unsorted_bam
    out:
      - sorted_bam

  sam_view_filter:
    run: sam_view_filter.cwl
    in:
      n_threads: n_threads
      sam: sam_sort/sorted_bam
    out:
      - filtered_bam

  sam_index:
    run: sam_index.cwl
    in:
     n_threads: n_threads
     sorted_bam: sam_view_filter/filtered_bam
    out:
      - bam_bai

  gatk_realigner:
    run: gatk_realigner.cwl
    in:
      n_threads: n_threads
      bam: sam_index/bam_bai
      ref_genome: ref_genome
    out:
      - bam_list

  gatk_indelrealigner:
    run: gatk_indelrealigner.cwl
    in:
      bam: sam_index/bam_bai
      ref_genome: ref_genome
      bam_list: gatk_realigner/bam_list
    out:
      - realigned_bam

  picard:
    run: picard.cwl
    in:
      bam: gatk_indelrealigner/realigned_bam
    out:
      - fixed_bam

outputs:
   output_bam:
     type: File
     outputSource: picard/fixed_bam
