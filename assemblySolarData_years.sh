#!/bin/bash
# Script for assembling an ARFF datasets with X-ray flux data.
# The script takes a list of files and concatenate them to the
# standard output.
#
# Author: Andre Leon S. Gradvol, Dr.
# Last version: Ter 24 Out 2017 10:56:08 -02

# Function to generate the header of the ARFF file in the variable HEADER.
addHEADER() { 
 CURRENTDATE=`date +"%Y-%m-%d %T"`
 HEADER="% Title: X-ray flux observations"
 HEADER="${HEADER}\n% This dataset was assembled with data from NOAA"
 HEADER="${HEADER}\n% Author: Andre Leon Sampaio Gradvohl, Dr."
 HEADER="${HEADER}\n% The date (yyyy-mm-dd) hh:mm:ss)"
 HEADER="${HEADER} the data was assembled by the author: ${CURRENTDATE}\n%"
 HEADER="${HEADER}\n% Original data source: https://satdat-vip.ngdc.noaa.gov/sem/goes/data/new_full"
 HEADER="${HEADER}\n% Originating_agency = \"DOC/NOAA/NCEP/NWS/SWPC\""
 HEADER="${HEADER}\n% Archiving_agency = \"DOC/NOAA/NESDIS/NCEI\""
 HEADER="${HEADER}\n% Data description:"
 HEADER="${HEADER}\n%\ttime_tag: Date and time for each observation in the format YYYY-mm-dd hh:mm:ss.SSS UTC\""
 HEADER="${HEADER}\n%\txs: \"X-ray short wavelength channel irradiance (0.5 - 0.3 nm)\";"
 HEADER="${HEADER}\n%\txl: \"X-ray long wavelength channel irradiance  (0.1 - 0.8 nm)\";"
 HEADER="${HEADER}\n%\t\"-99999\" indicates missing values.\n%"
 HEADER="${HEADER}\n@RELATION x-ray_flux\n"
 HEADER="${HEADER}\n@ATTRIBUTE time_tag DATE YYYY-mm-dd hh:mm:ss.SSS"
 HEADER="${HEADER}\n@ATTRIBUTE xs NUMERIC"
 HEADER="${HEADER}\n@ATTRIBUTE xl NUMERIC\n"
 HEADER="${HEADER}\n@DATA"
 HEADER="${HEADER}\n%timetag,xs,xl"
}

# The main script starts here
NUMARGS=$#

ARGS=$@

if [[ ${NUMARGS} -lt 1 ]]; then
  echo -e "\nUsage:\n\t $0 <list of files>"
  exit 0
fi


addHEADER 

NUM=0

for ARQ in ${ARGS}; do
    echo -e "${HEADER}"
    awk -F, 'NR>26{print $1","$2","$3}' ${ARQ}
    ((NUM++))
done

exit 0
