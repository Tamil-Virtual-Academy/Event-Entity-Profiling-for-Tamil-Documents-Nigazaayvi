while(<>){
push(@e,$_);
}
#$out=" ";
for($j=0;$j<@e;$j++)
{
	@q=split(/\t/,$e[$j]); $l=@q;
	@mb=split(/\,/,$q[$l-1]);
        if($q[$l-1]=~/^B-(.*)/)
	{
        	$p=$1;
	}
	if($q[$l-1]=~/B-.*/)
	{
		@temp=split(/\t/,$e[$j+1]);$ne=$mb[0];
		@mt=split(/\,/,$temp[$l-1]);
	        if($temp[$l-1]=~/I-.*/)
        	{
		        while($temp[$l-1]=~/I-.*/){
		        $ne=$ne." ".$mt[0];$j++;
		        @temp=split(/\t/,$e[$j+1]);
			@mt=split(/\,/,$temp[$l-1]);
        	}
        }
	#if($ne=~/-/){
        	$out=$ne."=>".$p;
		#if($out eq $hash{$ne}){print"$out\n";}
		#print "$out\n"    if exists $hash{$ne};
		#print "Key $ne exists $p\n" if ( exists($hash{$ne}) );
		#$hash{$ne}=$p;
		push( @{$hash{$ne}}, $p );
		#print "$out\n"    if exists $hash{$ne};
		#print"$hash{$ne}\t$ne\n";
	#}
        #print"$out";
 }
}

$t="";

foreach $k(sort keys %hash)
{
		print"$k=>@{$hash{$k}}\t$hash->[1]\n";
}
