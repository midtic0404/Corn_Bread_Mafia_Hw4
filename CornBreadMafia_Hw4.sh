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

# check number of parameters:  there need to be
# at least 4 to have both year and email
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
			if [[ $YEAR -ne 2015 && $YEAR -ne 2016 ]]
			then
				echo "Invalid year.  Enter 2015 or 2016."
				exit 3
			fi
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






# make temp directory if it doesn't already exist
tempDir=temp

if [[ ! -d $tempDir ]]
then
	mkdir $tempDir
fi

# change to temp directory for wget action
cd $tempDir


# remove anything that might already be in temp directory
if [[ $(ls | wc -l) -gt 0 ]]
then
	rm *
fi








# retrieve MOCK DATA files using wget
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

# unzip and extract tar.gz files in /temp
for file in $(ls)
do
	echo "Extracting $file"
	gunzip < $file | tar xvf -
done








# change to one directory level up from /temp
cd ..

# make output file
newOutput=newOutput.csv

# write filtered output to new output file (Canadian females)
./runAwkOnAll_MOCK_DATA.sh >> $newOutput 




echo "Writing output file $newOutput..."

# get date/time fields for naming zipped file in next step:

YYYY=`date +%Y`
MM=`date +%m`
DD=`date +%d`
HH=`date +%H`
mm=`date +%M`
zipFileName="MOCK_DATA_FEMALE_CANADA_${YYYY}_${MM}_${DD}_${HH}:${mm}.zip"



# zip the output file:
gzip -v newOutput.csv

# rename zipped file:
echo -n "renaming newOutput.csv.gz to "
mv newOutput.csv.gz $zipFileName
echo $zipFileName







# set user name, password, and target directory according to user's arguments
if [[ -n $user && -n $passwd ]]
then
	targetDir="~"
else
	user="anonymous"
	passwd="password"
	targetDir="MockData"
fi

# upload file to ftp server
ftp -inv 137.190.19.86 <<EOF
user $user $passwd
cd $targetDir
put $zipFileName
bye
EOF



# cleanup:  remove temp directory and copy of file in this directory
rm -r $tempDir
rm $zipFileName

# send email about successful file transfer

mail -s "Successful file transfer" $email <<< "Successfully transferred file to FTP 137.190.19.86 server."

exit 0
