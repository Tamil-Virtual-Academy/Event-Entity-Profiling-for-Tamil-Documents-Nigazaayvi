open(F,$ARGV[0]);
$per1=0;
$sen=1;
$word=1;
print"<Sentence id=\"$sen\">\n";
while(<F>)
{
chomp;
        if($_ =~ /^\s*$/) {
		$sen++;
		$word=1;
               print"<\/Sentence>\n<Sentence id=\"$sen\">\n";
               next;
        }

next if($_ eq undef);

	@arr=split(/\t/,$_);$l=@arr;
        if($arr[3]=~/N_NNP/){$nnp=1;}else{$nnp=0;}
	print"$word\t$arr[0]\tunk\n";
	$word++;
}

