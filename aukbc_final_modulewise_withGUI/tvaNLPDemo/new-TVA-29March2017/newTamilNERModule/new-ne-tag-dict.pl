#DICTIONARY
open(F1,$ARGV[0]);
while(<F1>)
{
chomp;
@arr=split(/=>/,$_);
$hash{$arr[0]}=$arr[1];
}

open(F,$ARGV[1]);
while(<F>)
{
chomp;
push(@line,$_);
}

for($i=0;$i<@line;$i++)
{
	if($line[$i]!~/^\s*$/){
	@current=split(/\t/,$line[$i]);$l=@current;
	@c1=split(/\,/,$current[$l-1]);
	@next1=split(/\t/,$line[$i+1]);
	@n1=split(/\,/,$next1[$l-1]);
	@next2=split(/\t/,$line[$i+2]);
	@n2=split(/\,/,$next2[$l-1]);
	@next3=split(/\t/,$line[$i+3]);
	@n3=split(/\,/,$next3[$l-1]);
	@next4=split(/\t/,$line[$i+4]);
	@n4=split(/\,/,$next4[$l-1]);
	$len=@current;
	$word1=$c1[0];
	$word2=$c1[0]." ".$n1[0];
	$word3=$c1[0]." ".$n1[0]." ".$n2[0];
	$word4=$c1[0]." ".$n1[0]." ".$n2[0]." ".$n3[0];
	$word5=$c1[0]." ".$n1[0]." ".$n2[0]." ".$n3[0]." ".$n4[0];
	if($current[1]=~/N_NN|N_NNP/){
	if(exists $hash{$word5})
        {
	if($current[$len-2]=~/^o$/){
		$line[$i]=~s/$current[$len-2]\t$current[$len-1]/\B-$hash{$word5}/g;
                $line[$i+1]=~s/$next1[$len-2]\t$next1[$len-1]/\I-$hash{$word5}/g;
                $line[$i+2]=~s/$next2[$len-2]\t$next2[$len-1]/\I-$hash{$word5}/g;
                $line[$i+3]=~s/$next3[$len-2]\t$next3[$len-1]/\I-$hash{$word5}/g;
		$line[$i+4]=~s/$next4[$len-2]\t$next4[$len-1]/\I-$hash{$word5}/g;
		$i=$i+4;
	}
        }
	elsif(exists $hash{$word4})
        {
		if($current[$len-2]=~/^o$/){
		$line[$i]=~s/$current[$len-2]\t$current[$len-1]/\B-$hash{$word4}/g;
                $line[$i+1]=~s/$next1[$len-2]\t$next1[$len-1]/\I-$hash{$word4}/g;
                $line[$i+2]=~s/$next2[$len-2]\t$next2[$len-1]/\I-$hash{$word4}/g;
		$line[$i+3]=~s/$next3[$len-2]\t$next3[$len-1]/\I-$hash{$word4}/g;
		$i=$i+3;
		}
        }


	if(exists $hash{$word3})
        {
		#print"$hash{$word2}\n";
		if($current[$len-2]=~/^o$/){
			$line[$i]=~s/$current[$len-2]\t$current[$len-1]/\B-$hash{$word3}/g;
                        $line[$i+1]=~s/$next1[$len-2]\t$next1[$len-1]/\I-$hash{$word3}/g;
			$line[$i+2]=~s/$next2[$len-2]\t$next2[$len-1]/\I-$hash{$word3}/g;
			$i=$i+2;
		}
        }

	elsif(exists $hash{$word2})
        {
		#print"$hash{$word2}\n";
		if($current[$len-2]=~/^o$/){
			$line[$i]=~s/$current[$len-2]\t$current[$len-1]/\B-$hash{$word2}/g;
                	$line[$i+1]=~s/$next1[$len-2]\t$next1[$len-1]/\I-$hash{$word2}/g;
			$i=$i+1;
		}
        }

	elsif(exists $hash{$word1})
	{
		if($current[$len-2]=~/^o$/){#print"HAI\n";
			$line[$i]=~s/$current[$len-2]\t$current[$len-1]/\B-$hash{$word1}/g;
		}
	}
		#@current=split(/\t/,$line[$i]);
		#$line[$i]=$current[0]."\t".$current[1]."\t".$current[2]."\t".$current[3]."\t".$current[4]."\t".$current[5]."\t".$current[6]."\t".$current[7]."\t".$current[8]."\t".$current[9]."\t".$current[10];
	}
	}
	#print"$line[$i]\n";
}

for($i=0;$i<@line;$i++)
{
	$line[$i]=~s/B-/B-/g;
        $line[$i]=~s/I-/I-/g;
	@current=split(/\t/,$line[$i]);
	if($line[$i]!~/^\s*$/){
	if($line[$i]!~/B-|I-/){
	@current=split(/\t/,$line[$i]);
        #$line[$i]=$current[0]."\t".$current[1]."\t".$current[2]."\t".$current[3]."\t".$current[4]."\t".$current[5]."\t".$current[6]."\t".$current[7]."\t".$current[8]."\t".$current[9]."\t".$current[10];
	#$line[$i]=$current[0]."\t".$current[1]."\t".$current[2]."\t".$current[3]."\t".$current[4]."\t".$current[5]."\t".$current[6]."\t".$current[7]."\t".$current[8]."\t".$current[9];
	$line[$i]=$current[0]."\t".$current[1]."\t".$current[2]."\t".$current[3]."\t".$current[4]."\t".$current[5]."\t".$current[6]."\t".$current[7];
	}
	else
	{
		#$line[$i]=$current[0]."\t".$current[1]."\t".$current[2]."\t".$current[3]."\t".$current[4]."\t".$current[5]."\t".$current[6]."\t".$current[7]."\t".$current[8]."\t".$current[9];
		$line[$i]=$current[0]."\t".$current[1]."\t".$current[2]."\t".$current[3]."\t".$current[4]."\t".$current[5]."\t".$current[6]."\t".$current[7];
	}
	}
	print"$line[$i]\n";

}
