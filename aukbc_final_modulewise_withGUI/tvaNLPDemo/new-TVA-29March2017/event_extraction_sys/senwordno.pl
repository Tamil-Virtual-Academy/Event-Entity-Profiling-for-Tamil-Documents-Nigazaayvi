open(F,$ARGV[0]);
while(<>)
{
	chomp;
	$line=$_;$lin++;
	if($line=~/^\s*$/)
	{
		print "\n";
		$sen++;$lin=0;
		next;
	}
	@a=split(/\t/,$line);
	$doc=$a[0];
	if($doc ne $prevdoc)
	{
		$docno++;
		$sen=1;
	}
		$line=~s/$a[0]\t/$a[0]\t$sen\t$lin\t/g;
	
	$prevdoc=$doc;
	print"$line\n";
}

