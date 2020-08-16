open(F,$ARGV[0]);
while(<F>)
{
	chomp;
	$r="O";
	if($_=~/^\s*$/)
	{
		print "\n";
		next;
	}
	@a=split(/\t/,$_);
	@b=split(/\,/,$a[4]);
	if ($b[0]=~/^\s*$/)
	{
		$b[0]="O";
	}
	if ($b[2]=~/^\s*$/)
        {
                $b[2]="O";
        }
	if ($a[2]=~/((N_NN)|(V_))/)
	{
		$a[4]=~s/.*/$b[0]\t$b[2]/;
	}
	else
	{
		$a[4]="$r\t$r";
	}
	print "$a[0]\t$a[1]\t$a[2]\t$a[3]\t$a[4]\n";

}
