# X-ray flux scripts
This repository provides scripts for the assembly and maintenance of datasets on X-ray fluxes emitted by the Sun. The datasets on which these scripts work are available in the [National Oceanic and Atmospheric Administration - NOAA site](https://www.ngdc.noaa.gov/stp/spaceweather.html), specifically in [https://satdat-vip.ngdc.noaa.gov/sem/goes/data/new_full](https://satdat-vip.ngdc.noaa.gov/sem/goes/data/new_full).

The data already processed is available on the Zenodo website available at [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.840402.svg)](https://doi.org/10.5281/zenodo.840402).

## Motivation for collecting this data
The main motivation for collecting this data is use it as a time series for X-ray flux forecasting.

## Scripts language
We wrote the scripts for the Bourne Again Shell (bash) and try our best to document them well. The scripts use common bash commands like awk, cat, echo, read and rm. Therefore, you should not have any problem running them on Linux operating system.

## Sample datasets
This repository also contains some sample datasets to run the scripts. Do not forget to download all data you need from the NOAA site indicated in the [first section of this text](#x-ray-flux-scripts). 

## How to use the scripts
To use the scripts available in this repository, you must perform the following steps:
1. Create a list of files to download and save into a file. Be sure to include the full address for each file.

2. Run the script `downloadDataFiles.sh` with the file with the list that you create in the last step. For instance:
..* `downloadDataFiles.sh fileList2017.txt`

3. The previous step download files from NOAA. The files names follow a standard, which has the satellite and the date information. Now, you have to run the script `assemblySolarData_v1.sh` or `assemblySolarData_v2.sh`. Choose v2 if you download data from year 2009 or beyond (the contents of the files change a little after 2009). You will run the script like the following example:
..* `assemblySolarData_v2.sh g15 2007`. In this example, the script will assembly all data files from the satellite goes-15in 2007 into the standard output. If you specify a file, the script will output to the file specified.


## About the HighPIDS research group
The owner of this repository belongs to the High Performance Intelligent Decision Systems - [HighPIDS research group](http://highpids.ft.unicamp.br). To contact the author, send an email for <gradvohl@ieee.org> or <gradvohl@ft.unicamp.br>.
