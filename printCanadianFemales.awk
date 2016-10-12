{
FS=","
if (length($4) == 0) 
	$4="waldo@weber.edu"; 
if ($5=="Female"&&$6=="Canada")
	print $2","$3","$4;
}
