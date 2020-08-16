while(<>){
push(@e,$_);
}
for($j=0;$j<@e;$j++)
{
        @q=split(/\t/,$e[$j]); $l=@q;
	@mb=split(/\,/,$q[$l-1]);
        if($q[$l-2]=~/^B-(.*)/)
{
        $tag=$1;
}
if($q[$l-2]=~/B-.*/){
@temp=split(/\t/,$e[$j+1]);$ne=$mb[0];
                @mt=split(/\,/,$temp[$l-1]);
        if($temp[$l-2]=~/I-.*/)
        {
        while($temp[$l-2]=~/I-.*/){
        $ne=$ne." ".$mt[0];$j++;
        @temp=split(/\t/,$e[$j+1]);
	@mt=split(/\,/,$temp[$l-1]);
        }
        }
        	$out=$ne."~".$tag;
		#print"$out\n";
		if( exists($hash_ne{$ne})){
			$hash_ne{$ne}=$hash_ne{$ne}."~".$tag;
			#print"$ne=>$hash_ne{$ne}\n";
		}
		else{
			$hash_ne{$ne}=$tag;
			#print"$ne=>$hash_ne{$ne}\n";
		}
		$hash_tag{$out}++;
 }
}


foreach $k(sort keys %hash_ne)
{
	#print"HAI:$k:$hash_ne{$k}\n";
	if($hash_ne{$k}!~/\~/)
	{
		$n1=$k;$t1=$hash_ne{$k};$occur=1;$tagg=$t1;
		print"$k=>$hash_ne{$k}\n";
		$temp=$k;
                $temp_t1=$t1;
                $temp_occur=$occur;
	}
	foreach $m(sort keys %hash_tag)
	{
		if($m=~/(.*)~(.*)/)
		{
			#print"HI:$m\n";
			$n1=$1;$t1=$2;$occur=$hash_tag{$m};$tagg=$t1;
			if($k eq $n1){
				#print"HI:N1=$n1:TEMP:$temp\t$k\tM=$m\t$hash_ne{$k}\tTAG=$t1:PREV_TAG:$temp_t1\t$occur==$temp_occur\n";
				#print"$k\t$n1\t$t1\n";
				#print"$k:$hash_ne{$k}\n";
				if(($temp eq $n1)&&($occur<$temp_occur)){
				#	print"$n1=>$temp_t1\n";
					$tagg=$temp_t1;
					print"$n1=>$temp_t1\n";
					$ne_tag=$n1."=>".$tagg;
	                                $hashn{$ne_tag}++;
				}
				if(($temp eq $n1)&&($occur>$temp_occur)){
                                        $tagg=$t1;
					print"$n1=>$t1\n";
					$ne_tag=$n1."=>".$tagg;
	                                $hashn{$ne_tag}++;
                                }

				#$temp=$k;
				
				$temp_t1=$t1;
				$temp_occur=$hash_tag{$m};
			}
				
				$temp=$k;
                                #$temp_t1=$t1;
                                #$temp_occur=$hash_tag{$m};
		}
	}
}

