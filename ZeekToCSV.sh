#!/bin/bash


FILEPATH=/"path_to_the _input_logs_directory"/
OUTPATH=/"path_to_the _output_logs_directory"/

echo "Transforming to csv ..."
for log in $(ls $FILEPATH); do

	FILEIN=$FILEPATH$log
	FILEOUT=$OUTPATH$log

	# -d option in zeek-cut convert time values into 
	#human-readable format. %Y-%m-%dTH%:%M:%S
	cat $FILEIN | zeek-cut -c -d > $FILEOUT

	# Remove line 8
	sed -i '8d' $FILEOUT

	# Remove lines 1 to 6
	sed -i '1,6d' $FILEOUT

	# Delete #fields
	sed -i 's/#fields\t//' $FILEOUT

	# Replace '\t' with ','
	sed -i 's/\t/,/g' $FILEOUT
done
echo "Done"
