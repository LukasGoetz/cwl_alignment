# cwl_alignment

'cwl_alignment' is a basic cwl workflow to perform a sequence alignment based on paired-end read sets using docker images.

## Prerequisites

* cwl-runner (https://pypi.org/project/cwltool/)
* docker

## Getting Started

* ./alignment.cwl --reads1 <read set 1> --reads2 <read set 2> --ref_genome <reference genome with index> --n_threads <number of threads>

## License

GNU General Public License v3.0
