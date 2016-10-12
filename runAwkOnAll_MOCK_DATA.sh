#!/bin/bash - 
#===============================================================================
#
#          FILE: testHw.sh
# 
#         USAGE: ./testHw.sh 
# 
#   DESCRIPTION: 
# 
#        AUTHOR: GISELA CHODOS (), giselachodos@mail.weber.edu
#  ORGANIZATION: 
#       CREATED: 10/11/2016 19:42
#      REVISION:  ---
#===============================================================================

#set -o nounset                              # Treat unset variables as an error




for file in $(ls temp/MOCK*)
do
	awk -f printCanadianFemales.awk $file
done

exit 0
