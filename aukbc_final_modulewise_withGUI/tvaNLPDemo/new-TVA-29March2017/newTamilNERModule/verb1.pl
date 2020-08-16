#DICTIONARY

open(F,$ARGV[0]);
while(<F>)
{
chomp;
push(@line,$_);
}

for($i=0;$i<@line;$i++)
{
	if($line[$i]!~/^\s*$/){
	@current=split(/\t/,$line[$i]);$l=@current;
	@next1=split(/\t/,$line[$i+1]);
	@next2=split(/\t/,$line[$i+2]);
	@next3=split(/\t/,$line[$i+3]);
	@next4=split(/\t/,$line[$i+4]);
	$len=@current;

	if(($line[$i]=~/Ar\t|AlY\t|AnY\t/)&&($line[$i-1]=~/N_NNP/)&&($line[$i]=~/\tV_/))
	{
		
		$n=$i-1;@nextn=split(/\t/,$line[$n]);
		while(($line[$n]=~/\tN_NNP\t/))
		{
			#print"HAI\n";
			if($line[$n]=~/N_NNP/)
                        {
				$line[$n]=~s/$nextn[$len-1]$/$nextn[$len-1]\t1/g;
			}
			$n--;
			@nextn=split(/\t/,$line[$n]);
		}
			
			#@nextn=split(/\t/,$line[$n]);
			#if($line[$n]=~/N_NN|N_NNP/)
			#{
			#	$line[$n]=~s/$nextn[$len-1]/#1\t$nextn[$len-1]/g;
			#}
			
	}


	}

}

for($i=0;$i<@line;$i++)
{
	@current=split(/\t/,$line[$i]);$l=@current;
        @next1=split(/\t/,$line[$i+1]);
	if(($line[$i]!~/\t1$/)&&($line[$i]!~/^\s*$/))
	{
		if($line[$i]=~/\(|\)/)
		{
			$current[$l-1]=~s/\(//g;
			$current[$l-1]=~s/\)//g;
			$line[$i]=~s/\($//g;
			$line[$i]=~s/\)$//g;
			#$line[$i]=~s/\t$current[$l-1]/\t$current[$l-1]\t0/g;
		}
		$line[$i]=~s/\t$current[$l-1]$/\t$current[$l-1]\t0/g;
		
	}
	#$line[$i]=~s/#1\t$current[$l-1]/1\t$current[$l-1]/g;
	#$line[$i]=~s/#0\t$current[$l-1]/0\t$current[$l-1]/g;
	print"$line[$i]\n";
}
