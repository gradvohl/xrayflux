#!/bin/bash
# Script for assembling an ARFF dataset with X-ray flux data.
# The script takes the satellite name and year and assembles
# all the files from that satellite and year into a single file.
#
# This version works for year 2008 and years before.
#
# Author: Andre Leon S. Gradvol, Dr.
# Last update: out 21 13:40:58 -02 2017
#
# Function to generate the header of the ARFF file in the variable HEADER.
# @param $1 = SATELLITE 
# @param $2 = YEAR
addHEADER() { 
 CURRENTDATE=`date +"%Y-%m-%d %T"`
 HEADER="% Title: X-ray flux observations"
 HEADER="${HEADER}\n% This dataset was assembled with data from NOAA"
 HEADER="${HEADER}\n% Author: Andre Leon Sampaio Gradvohl, Dr."
 HEADER="${HEADER}\n% The date (yyyy-mm-dd) hh:mm:ss)"
 HEADER="${HEADER} the data was assembled by the author: ${CURRENTDATE}\n%"
 HEADER="${HEADER}\n% Original data source: https://satdat-vip.ngdc.noaa.gov/sem/goes/data/new_full/$2"
 HEADER="${HEADER}\n% Originating_agency = \"DOC/NOAA/NCEP/NWS/SWPC\""
 HEADER="${HEADER}\n% Archiving_agency = \"DOC/NOAA/NESDIS/NCEI\""
 HEADER="${HEADER}\n% Year: $2"
 HEADER="${HEADER}\n% Satellite: $1\n%"
 HEADER="${HEADER}\n% Data description:"
 HEADER="${HEADER}\n%\ttime_tag: Date and time for each observation in the format YYYY-mm-dd hh:mm:ss.SSS UTC\""
 HEADER="${HEADER}\n%\txs: \"X-ray short wavelength channel irradiance (0.5 - 0.3 nm)\";"
 HEADER="${HEADER}\n%\txl: \"X-ray long wavelength channel irradiance  (0.1 - 0.8 nm)\";"
 HEADER="${HEADER}\n%\t\"-99999\" indicates missing values.\n%"
 HEADER="${HEADER}\n@RELATION x-ray_flux_$1_$2\n"
 HEADER="${HEADER}\n@ATTRIBUTE time_tag DATE YYYY-mm-dd hh:mm:ss.SSS"
 HEADER="${HEADER}\n@ATTRIBUTE xs NUMERIC"
 HEADER="${HEADER}\n@ATTRIBUTE xl NUMERIC\n"
 HEADER="${HEADER}\n@DATA"
 HEADER="${HEADER}\n%timetag,xs,xl"
 echo -e ${HEADER} > $3
}

# The main script starts here
NUMARGS=$#

if [[ ${NUMARGS} -lt 2 ]]; then
  echo -e "\nUsage:\n\t $0 <satellite> <year> [<outputfile>]"
  echo -e "\t<outputfile> is an optional argument"
  exit 0
fi

SATELLITE=$1
YEAR=$2

if [[ ${NUMARGS} -eq 3 ]]; then
   OUTPUTFILE=$3
   STDOUTPUTSET=0
   if [[ -f ${OUTPUTFILE} ]]; then
     echo "File ${OUTPUTFILE} exists!"
     read -p "Are you sure you want to overwrite it? " -n 1 -r
     if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo -e "\nQuitting the script"
        exit 1
     else
        echo -e "\nOverwriting file ${OUTPUTFILE}"
     fi
   else
     echo -e "\nAssembling file ${OUTPUTFILE}\n"
   fi
else # if ${NUMARGS} -eq 2
   OUTPUTFILE=$(mktemp /tmp/solarDataXXXX.arff)
   STDOUTPUTSET=1
fi

addHEADER ${SATELLITE} ${YEAR} ${OUTPUTFILE}

NUM=0

for ARQ in `ls ${SATELLITE}_xrs_*_${YEAR}*_${YEAR}*.csv`; do
    if [[ STDOUTPUTSET -eq 0 ]]; then
      echo "Adding the ${ARQ} file"
      ((NUM++))
    fi
    # Cleaning the in the input file and the ^M (\r) in the end of each line.
    awk -F, 'NR>157{sub(/\r/,""); print $1","$2","$3}' ${ARQ} >> ${OUTPUTFILE}
done

if [[ STDOUTPUTSET -eq 0 ]]; then
  echo "Operation complete! ${NUM} files assembled in ${OUTPUTFILE}"
else
  cat ${OUTPUTFILE}
  rm -f ${OUTPUTFILE}
fi
exit 0
