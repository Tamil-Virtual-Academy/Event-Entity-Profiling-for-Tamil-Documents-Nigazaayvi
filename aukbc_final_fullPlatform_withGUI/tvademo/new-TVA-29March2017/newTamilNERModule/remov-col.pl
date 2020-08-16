#DICTIONARY

open(F,$ARGV[0]);
while(<F>)
{
chomp;
push(@line,$_);
}


for($i=0;$i<@line;$i++)
{
	@current=split(/\t/,$line[$i]);$l=@current;
	if(($line[$i]!~/^\s*$/))
	{
		$line[$i]=~s/$current[$l-2]\t$current[$l-1]$/$current[$l-1]/g;
	}
	#$line[$i]=~s/#1\t$current[$l-1]/1\t$current[$l-1]/g;
	#$line[$i]=~s/#0\t$current[$l-1]/0\t$current[$l-1]/g;
	print"$line[$i]\n";
}
