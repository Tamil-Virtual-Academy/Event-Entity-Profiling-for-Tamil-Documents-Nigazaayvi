open(F,$ARGV[0]);
while(<F>)
{
	chomp;
	push(@line,$_);
}


for($i=0;$i<@line;$i++)
{

	if($line[$i] =~ /^\s*$/) {
              print "\n";
              next;
        }

	next if($line[$i] eq undef);

	@arr=split(/\t/,$line[$i]);
	$l=@arr;
	if(($line[$i]=~/\tN_NNP\t/)&&($line[$i+1]=~/\tV_VM_/))
	{
		$v=1;
	}
	else
	{
		$v=0;
	}
	print"$arr[0]\t$arr[1]\t$arr[2]\t$arr[3]\t$arr[4]\t$arr[5]\t$arr[6]\t$arr[7]\t$v\t$arr[8]\n";

}

=c
foreach $k(keys %hash)
{
	if($k=~/B-.*/){
	print"$k\n";}

}
