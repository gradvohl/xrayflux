# X-ray flux scripts
This repository provides scripts for the assemble and maintenance of datasets on X-ray flux emitted by the Sun. The datasets on which these scripts work is available in the [National Oceanic and Atmospheric Administration - NOAA site](https://www.ngdc.noaa.gov/stp/spaceweather.html), specifically in [https://satdat-vip.ngdc.noaa.gov/sem/goes/data/new_full](https://satdat-vip.ngdc.noaa.gov/sem/goes/data/new_full).

The data already processed is available on the Zenodo website with the following [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.1035945.svg)](https://doi.org/10.5281/zenodo.1035945).

## Motivation for collecting this data
The main motivation for collecting this data is to use it as a time series for X-ray flux forecasting.

## Scripts language
We wrote the scripts for the Bourne Again Shell (bash) and try our best to document them well. The scripts use common bash commands like awk, cat, echo, read and rm. Therefore, you should not have any problem running them on Linux operating system.

## Sample datasets
This repository also contains some sample datasets to run the scripts. Do not forget to download all data you need from the NOAA site indicated in the [first section of this text](#x-ray-flux-scripts). 

## How to use the scripts
To use the scripts available in this repository, you must perform the following steps:
1. Create a list of files to download and save into a file. Be sure to include the full address for each file.

2. Run the script `downloadDataFiles.sh` with the file with the list that you create in the last step. For instance:

  * `downloadDataFiles.sh fileList2017.txt`

3. The previous step download files from NOAA. The files names follow a standard, which has the satellite and the date information. Now, you have to run the script `assembleSolarData_v1.sh` or `assembleSolarData_v2.sh`. Choose v2 if you download data from the year 2009 or beyond (the contents of the files change a little after 2009). You will run the script like the following example:

  * `assembleSolarData_v2.sh g15 2007`. In this example, the script will assemble all data files from the satellite goes-15 in 2007 into the standard output. If you specify a file, the script will output to the specified file.

4. Now, you will have a file for a specific satellite in a specific year. The next step is to assemble all the specific files into a single one. In this case, you will run the following example:

  * `nohup ./assembleSolarData_years.sh g10_2001.arff g10_2002.arff g10_2003.arff > 2001_2003.arff &`. This script will assemble all files indicated as arguments into a single one. The output file will have a header. 


## About the HighPIDS research group
The owner of this repository belongs to the High Performance Intelligent Decision Systems - [HighPIDS research group](http://highpids.ft.unicamp.br). To contact the author, send an email for <gradvohl@ieee.org> or <gradvohl@ft.unicamp.br>.
