#!/bin/bash - 
#===============================================================================
#
#          FILE: CornBreadMafia_Hw4.sh
# 
#         USAGE: ./CornBreadMafia_Hw4.sh 
# 
#   DESCRIPTION: Shell script for Assignment 4
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Chia Che Chang (), chiachechang@mail.weber.edu
#  ORGANIZATION: 
#       CREATED: 10/07/2016 16:26
#      REVISION:  ---
#===============================================================================

#set -o nounset                              # Treat unset variables as an error

#1 step 1 setting up getops

usage(){
	echo "Usage ./CornBreadMafia_Hw4.sh [-y YEAR] [-e email] [-u user] [-p passwd]"
	echo "YEAR and email options are required"
}

if [[ ${#} -lt 4 ]] || [[ $1 == "--help" ]]
then
	usage
	exit 1
fi



while getopts ":y:e:u:p:" opt;
do
	case $opt in
		y)
			YEAR=$OPTARG
			;;
		e)
			email=$OPTARG
			;;
		u)
			user=$OPTARG
			;;
		p)
			passwd=$OPTARG
			;;
		*)
			usage
			exit 2
			;;
	esac
done

if [[ $YEAR -eq 2015 ]]
then
	NEWYEAR=$((YEAR + 1)) 
	wget "icarus.cs.weber.edu/~hvalle/cs3030/MOCK_DATA_$YEAR.tar.gz"
	wget "icarus.cs.weber.edu/~hvalle/cs3030/MOCK_DATA_$NEWYEAR.tar.gz"
elif [[ $YEAR -eq 2016 ]]
then
	NEWYEAR=$((YEAR - 1))
	wget "icarus.cs.weber.edu/~hvalle/cs3030/MOCK_DATA_$YEAR.tar.gz"
	wget "icarus.cs.weber.edu/~hvalle/cs3030/MOCK_DATA_$NEWYEAR.tar.gz"
else
	echo "Error, file with year input not found"
fi

exit 0
