open(F,$ARGV[0]);
while(<F>)
{
	chomp;
	if($_=~/^\s*$/)
	{
		print "\n";
		next;
	}
	@a=split(/\t/,$_);
	print "$a[0]\t$a[1]\t$a[2]\t$a[5]\t$a[6]\t$a[9]\n";

}
