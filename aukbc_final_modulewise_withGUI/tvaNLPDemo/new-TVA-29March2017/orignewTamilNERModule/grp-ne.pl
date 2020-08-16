while(<>){
push(@e,$_);
}
#$out=" ";
        for($j=0;$j<@e;$j++)
{
        @q=split(/\t/,$e[$j]); $l=@q;
        if($q[$l-1]=~/^B-(.*)/)
{
        $p=$1;
}
if($q[$l-1]=~/B-.*/){
@temp=split(/\t/,$e[$j+1]);$ne=$q[0];
        if($temp[$l-1]=~/I-.*/)
        {
        while($temp[$l-1]=~/I-.*/){
        $ne=$ne." ".$temp[0];$j++;
        @temp=split(/\t/,$e[$j+1]);
        }
        }
	#if($ne=~/-/){
        	$out=$ne."=>".$p."\n";
        	#$out=$p." ".$ne."\n";
		$hash{$out}++;
		#print"$out";
	#}
        #print"$out";
 }
}

foreach $k(keys %hash)
{
	#if($k!~/TIME|PERIOD|DATE|YEAR|COUNT|DISTANCE|QUANTITY|MONEY|GROUP|address|phoneno/i){
	if($k=~/DATE/)
		print"$k\n";
	}
}

