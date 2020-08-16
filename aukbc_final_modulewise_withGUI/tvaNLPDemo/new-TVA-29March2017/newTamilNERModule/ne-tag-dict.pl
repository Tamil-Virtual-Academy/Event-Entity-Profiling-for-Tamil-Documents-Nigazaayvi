#DICTIONARY
open(F1,$ARGV[0]);
while(<F1>)
{
chomp;
@arr=split(/=>/,$_);
$hash{$arr[0]}=$arr[1];
}
#print"@patn\n";

open(F,$ARGV[1]);
while(<F>)
{
chomp;
push(@line,$_);
}

for($i=0;$i<@line;$i++)
{
	@current=split(/\t/,$line[$i]);
	@next1=split(/\t/,$line[$i+1]);
	@next2=split(/\t/,$line[$i+2]);
	@next3=split(/\t/,$line[$i+3]);
	@next4=split(/\t/,$line[$i+4]);
	$len=@current;
	$word1=$current[0];
	$word2=$current[0]." ".$next1[0];
	$word3=$current[0]." ".$next1[0]." ".$next2[0];
	$word4=$current[0]." ".$next1[0]." ".$next2[0]." ".$next3[0];
	$word5=$current[0]." ".$next1[0]." ".$next2[0]." ".$next3[0]." ".$next4[0];
=c
	if(exists $hash{$word5})
        {
	if($current[$len-1]=~/^o$/){
                $current[$len]="B-".$hash{$word5};
                $next1[$len]="I-".$hash{$word5};
                $next2[$len]="I-".$hash{$word5};
                $next3[$len]="I-".$hash{$word5};
		$next4[$len]="I-".$hash{$word5};
                &line_initailise($i,@current);
                &line_initailise($i+1,@next1);
                &line_initailise($i+2,@next2);
                &line_initailise($i+3,@next3);
		&line_initailise($i+4,@next4);
	}
        }
	elsif(exists $hash{$word4})
        {
		if($current[$len-1]=~/^o$/){
                $current[$len]="B-".$hash{$word4};
                $next1[$len]="I-".$hash{$word4};
                $next2[$len]="I-".$hash{$word4};
		$next3[$len]="I-".$hash{$word4};
                &line_initailise($i,@current);
                &line_initailise($i+1,@next1);
                &line_initailise($i+2,@next2);
		&line_initailise($i+3,@next3);
		}
        }
=cut
	if(exists $hash{$word3})
        {
		if($current[$len-1]=~/^o$/){
		$current[$len]="B-".$hash{$word3};
		$next1[$len]="I-".$hash{$word3};
		$next2[$len]="I-".$hash{$word3};
		&line_initailise($i,@current);
		&line_initailise($i+1,@next1);
		&line_initailise($i+2,@next2);
		}
        }

	elsif(exists $hash{$word2})
        {
		if($current[$len-1]=~/^o$/){
		$current[$len]="B-".$hash{$word2};
                $next1[$len]="I-".$hash{$word2};
		&line_initailise($i,@current);
                &line_initailise($i+1,@next1);
		}
        }

	elsif(exists $hash{$word1})
	{
		if($current[$len-1]=~/^o$/){
		$current[$len]="B-".$hash{$word1};
		#print"HAI:$len $current[$len]\n";
		&line_initailise($i,@current);
		}
	}

}

sub line_initailise()
{
        $n=$_[0];
        $line[$n]=@_[1]."\t".@_[2]."\t".@_[3]."\t".@_[4]."\t".@_[5]."\t".@_[6]."\t".@_[7]."\t".@_[8]."\t".@_[9]."\t".@_[10]."\t".@_[11]."\t".@_[12];
	#print"$line[$n]\n";
}



foreach $k(@line)
{

	@lin=split(/\t/,$k);
	$l=@lin;
	if($l==12)
	{
		$lin[10]=$lin[11];
	}
	if($lin[0]!~/^\s*$/){
        	print"$lin[0]\t$lin[1]\t$lin[2]\t$lin[3]\t$lin[4]\t$lin[5]\t$lin[6]\t$lin[7]\t$lin[8]\t$lin[9]\t$lin[10]\n";
	}
	else
	{
		print"\n";
	}


}
