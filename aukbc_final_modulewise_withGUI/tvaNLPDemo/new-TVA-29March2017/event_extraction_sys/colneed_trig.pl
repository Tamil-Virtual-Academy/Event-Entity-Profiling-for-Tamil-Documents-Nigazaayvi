open(F,$ARGV[0]);
while(<>)
{
	chomp;
	if($_=~/^\s*$/)
	{
		print "\n";
		next;
	}
	@a=split(/\t/,$_);
	print "$a[3]\t$a[4]\t$a[5]\t$a[6]\t$a[7]\t$a[1]\t$a[2]\n";

}
