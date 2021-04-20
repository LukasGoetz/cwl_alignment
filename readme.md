# cwl_alignment

'cwl_alignment' is a basic cwl workflow to perform a sequence alignment based on paired-end read sets using docker images.
![alt text](graph.ps)

## Prerequisites

* cwl-runner (https://pypi.org/project/cwltool/)
* docker

## Getting Started

```bash
./alignment.cwl --reads1 <read set 1> --reads2 <read set 2> --ref_genome <reference genome with index created by bwa-mem2> --n_threads <number of threads>
```

## License

GNU General Public License v3.0
