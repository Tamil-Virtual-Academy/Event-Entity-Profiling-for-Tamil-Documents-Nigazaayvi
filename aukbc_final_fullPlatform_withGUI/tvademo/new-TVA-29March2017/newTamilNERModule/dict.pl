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
	@next5=split(/\t/,$line[$i+5]);
        @n5=split(/\,/,$next5[$l-1]);
	@next6=split(/\t/,$line[$i+6]);
        @n6=split(/\,/,$next6[$l-1]);
	@next7=split(/\t/,$line[$i+7]);
        @n7=split(/\,/,$next7[$l-1]);
	@next8=split(/\t/,$line[$i+8]);
        @n8=split(/\,/,$next8[$l-1]);
	@next9=split(/\t/,$line[$i+9]);
        @n9=split(/\,/,$next9[$l-1]);
	$len=@current;
	$word1=$c1[0];
	$word2=$c1[0]." ".$n1[0];
	$word3=$c1[0]." ".$n1[0]." ".$n2[0];
	$word4=$c1[0]." ".$n1[0]." ".$n2[0]." ".$n3[0];
	$word5=$c1[0]." ".$n1[0]." ".$n2[0]." ".$n3[0]." ".$n4[0];
	$word6=$c1[0]." ".$n1[0]." ".$n2[0]." ".$n3[0]." ".$n4[0]." ".$n5[0];
	$word7=$c1[0]." ".$n1[0]." ".$n2[0]." ".$n3[0]." ".$n4[0]." ".$n5[0]." ".$n6[0];
	$word8=$c1[0]." ".$n1[0]." ".$n2[0]." ".$n3[0]." ".$n4[0]." ".$n5[0]." ".$n6[0]." ".$n7[0];
	$word9=$c1[0]." ".$n1[0]." ".$n2[0]." ".$n3[0]." ".$n4[0]." ".$n5[0]." ".$n6[0]." ".$n7[0]." ".$n8[0];
	$word10=$c1[0]." ".$n1[0]." ".$n2[0]." ".$n3[0]." ".$n4[0]." ".$n5[0]." ".$n6[0]." ".$n7[0]." ".$n8[0]." ".$n9[0];

	if(exists $hash{$word10})
        {
        #if($current[$len-2]=~/^o$/){
                $line[$i]=~s/$current[$len-2]\t$current[$len-1]/B-$hash{$word5}\t$current[$len-1]/g;
                $line[$i+1]=~s/$next1[$len-2]\t$next1[$len-1]/I-$hash{$word5}\t$next1[$len-1]/g;
                $line[$i+2]=~s/$next2[$len-2]\t$next2[$len-1]/I-$hash{$word5}\t$next2[$len-1]/g;
                $line[$i+3]=~s/$next3[$len-2]\t$next3[$len-1]/I-$hash{$word5}\t$next3[$len-1]/g;
                $line[$i+4]=~s/$next4[$len-2]\t$next4[$len-1]/I-$hash{$word5}\t$next4[$len-1]/g;
                $line[$i+5]=~s/$next5[$len-2]\t$next5[$len-1]/I-$hash{$word6}\t$next5[$len-1]/g;
                $line[$i+6]=~s/$next6[$len-2]\t$next6[$len-1]/I-$hash{$word7}\t$next6[$len-1]/g;
                $line[$i+7]=~s/$next7[$len-2]\t$next7[$len-1]/I-$hash{$word8}\t$next7[$len-1]/g;
                $line[$i+8]=~s/$next8[$len-2]\t$next8[$len-1]/I-$hash{$word9}\t$next8[$len-1]/g;
		$line[$i+9]=~s/$next9[$len-2]\t$next9[$len-1]/I-$hash{$word10}\t$next9[$len-1]/g;
                $i=$i+9;
        #}
        }
	elsif(exists $hash{$word9})
        {
        #if($current[$len-2]=~/^o$/){
                $line[$i]=~s/$current[$len-2]\t$current[$len-1]/B-$hash{$word5}\t$current[$len-1]/g;
                $line[$i+1]=~s/$next1[$len-2]\t$next1[$len-1]/I-$hash{$word5}\t$next1[$len-1]/g;
                $line[$i+2]=~s/$next2[$len-2]\t$next2[$len-1]/I-$hash{$word5}\t$next2[$len-1]/g;
                $line[$i+3]=~s/$next3[$len-2]\t$next3[$len-1]/I-$hash{$word5}\t$next3[$len-1]/g;
                $line[$i+4]=~s/$next4[$len-2]\t$next4[$len-1]/I-$hash{$word5}\t$next4[$len-1]/g;
                $line[$i+5]=~s/$next5[$len-2]\t$next5[$len-1]/I-$hash{$word6}\t$next5[$len-1]/g;
                $line[$i+6]=~s/$next6[$len-2]\t$next6[$len-1]/I-$hash{$word7}\t$next6[$len-1]/g;
                $line[$i+7]=~s/$next7[$len-2]\t$next7[$len-1]/I-$hash{$word8}\t$next7[$len-1]/g;
		$line[$i+8]=~s/$next8[$len-2]\t$next8[$len-1]/I-$hash{$word9}\t$next8[$len-1]/g;
                $i=$i+8;
        #}
        }	
	elsif(exists $hash{$word8})
        {
        #if($current[$len-2]=~/^o$/){
                $line[$i]=~s/$current[$len-2]\t$current[$len-1]/B-$hash{$word5}\t$current[$len-1]/g;
                $line[$i+1]=~s/$next1[$len-2]\t$next1[$len-1]/I-$hash{$word5}\t$next1[$len-1]/g;
                $line[$i+2]=~s/$next2[$len-2]\t$next2[$len-1]/I-$hash{$word5}\t$next2[$len-1]/g;
                $line[$i+3]=~s/$next3[$len-2]\t$next3[$len-1]/I-$hash{$word5}\t$next3[$len-1]/g;
                $line[$i+4]=~s/$next4[$len-2]\t$next4[$len-1]/I-$hash{$word5}\t$next4[$len-1]/g;
                $line[$i+5]=~s/$next5[$len-2]\t$next5[$len-1]/I-$hash{$word6}\t$next5[$len-1]/g;
                $line[$i+6]=~s/$next6[$len-2]\t$next6[$len-1]/I-$hash{$word7}\t$next6[$len-1]/g;
		$line[$i+7]=~s/$next7[$len-2]\t$next7[$len-1]/I-$hash{$word8}\t$next7[$len-1]/g;
                $i=$i+7;
        #}
        }
	elsif(exists $hash{$word7})
        {
        #if($current[$len-2]=~/^o$/){
                $line[$i]=~s/$current[$len-2]\t$current[$len-1]/B-$hash{$word5}\t$current[$len-1]/g;
                $line[$i+1]=~s/$next1[$len-2]\t$next1[$len-1]/I-$hash{$word5}\t$next1[$len-1]/g;
                $line[$i+2]=~s/$next2[$len-2]\t$next2[$len-1]/I-$hash{$word5}\t$next2[$len-1]/g;
                $line[$i+3]=~s/$next3[$len-2]\t$next3[$len-1]/I-$hash{$word5}\t$next3[$len-1]/g;
                $line[$i+4]=~s/$next4[$len-2]\t$next4[$len-1]/I-$hash{$word5}\t$next4[$len-1]/g;
                $line[$i+5]=~s/$next5[$len-2]\t$next5[$len-1]/I-$hash{$word6}\t$next5[$len-1]/g;
		$line[$i+6]=~s/$next6[$len-2]\t$next6[$len-1]/I-$hash{$word7}\t$next6[$len-1]/g;
                $i=$i+6;
        #}
        }
	elsif(exists $hash{$word6})
        {
        #if($current[$len-2]=~/^o$/){
                $line[$i]=~s/$current[$len-2]\t$current[$len-1]/B-$hash{$word5}\t$current[$len-1]/g;
                $line[$i+1]=~s/$next1[$len-2]\t$next1[$len-1]/I-$hash{$word5}\t$next1[$len-1]/g;
                $line[$i+2]=~s/$next2[$len-2]\t$next2[$len-1]/I-$hash{$word5}\t$next2[$len-1]/g;
                $line[$i+3]=~s/$next3[$len-2]\t$next3[$len-1]/I-$hash{$word5}\t$next3[$len-1]/g;
                $line[$i+4]=~s/$next4[$len-2]\t$next4[$len-1]/I-$hash{$word5}\t$next4[$len-1]/g;
		$line[$i+5]=~s/$next5[$len-2]\t$next5[$len-1]/I-$hash{$word6}\t$next5[$len-1]/g;
                $i=$i+5;
        #}
        }	

	elsif(exists $hash{$word5})
        {
	#if($current[$len-2]=~/^o$/){
		$line[$i]=~s/$current[$len-2]\t$current[$len-1]/B-$hash{$word5}\t$current[$len-1]/g;
                $line[$i+1]=~s/$next1[$len-2]\t$next1[$len-1]/I-$hash{$word5}\t$next1[$len-1]/g;
                $line[$i+2]=~s/$next2[$len-2]\t$next2[$len-1]/I-$hash{$word5}\t$next2[$len-1]/g;
                $line[$i+3]=~s/$next3[$len-2]\t$next3[$len-1]/I-$hash{$word5}\t$next3[$len-1]/g;
		$line[$i+4]=~s/$next4[$len-2]\t$next4[$len-1]/I-$hash{$word5}\t$next4[$len-1]/g;
		$i=$i+4;
	#}
        }
	elsif(exists $hash{$word4})
        {
		#if($current[$len-2]=~/^o$/){
		$line[$i]=~s/$current[$len-2]\t$current[$len-1]/B-$hash{$word4}\t$current[$len-1]/g;
                $line[$i+1]=~s/$next1[$len-2]\t$next1[$len-1]/I-$hash{$word4}\t$next1[$len-1]/g;
                $line[$i+2]=~s/$next2[$len-2]\t$next2[$len-1]/I-$hash{$word4}\t$next2[$len-1]/g;
		$line[$i+3]=~s/$next3[$len-2]\t$next3[$len-1]/I-$hash{$word4}\t$next3[$len-1]/g;
		$i=$i+3;
		#}
        }


	elsif(exists $hash{$word3})
        {
		#if($current[$len-2]=~/^o$/){
			$line[$i]=~s/$current[$len-2]\t$current[$len-1]/B-$hash{$word3}\t$current[$len-1]/g;
                        $line[$i+1]=~s/$next1[$len-2]\t$next1[$len-1]/I-$hash{$word3}\t$next1[$len-1]/g;
			$line[$i+2]=~s/$next2[$len-2]\t$next2[$len-1]/I-$hash{$word3}\t$next2[$len-1]/g;
			$i=$i+2;
		#}
        }

	elsif(exists $hash{$word2})
        {
		#if($current[$len-2]=~/^o$/){
			$line[$i]=~s/$current[$len-2]\t$current[$len-1]/B-$hash{$word2}\t$current[$len-1]/g;
                	$line[$i+1]=~s/$next1[$len-2]\t$next1[$len-1]/I-$hash{$word2}\t$next1[$len-1]/g;
			$i=$i+1;
		#}
        }

	elsif(exists $hash{$word1})
	{
		if($next1[$len-2]=~/I-(.*)/){#print"HAI\n";
			$next_tag=$1;
			$t1=$hash{$word1};
			if($t1!~/(LOCATION|PLACE|CITY|DISTRICT|TOWN|STATE|NATION|COUNTRY|STNAME|ROAD)/)	{
			if($t1 eq $next_tag){		
				$line[$i]=~s/$current[$len-2]\t$current[$len-1]/B-$hash{$word1}\t$current[$len-1]/g;
			}}
			else
			{
				$line[$i]=~s/$current[$len-2]\t$current[$len-1]/B-$hash{$word1}\t$current[$len-1]/g;
				$line[$i+1]=~s/$next1[$len-2]\t$next1[$len-1]/B-$next_tag\t$next1[$len-1]/g;
			}
		}
		else
		{
			$line[$i]=~s/$current[$len-2]\t$current[$len-1]/B-$hash{$word1}\t$current[$len-1]/g;
		}
	}

	}
}

for($i=0;$i<@line;$i++)
{
	print"$line[$i]\n";

}
