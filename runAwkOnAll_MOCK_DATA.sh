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



# works if this script is in same folder as the MOCK_DATA files.

for file in $(ls MOCK*)
do
	awk -f testHw.awk $file
done

exit 0
