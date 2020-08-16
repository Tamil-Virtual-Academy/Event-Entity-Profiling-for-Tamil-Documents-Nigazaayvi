open(F1,$ARGV[0]);
while(<F1>)
{
chomp;
$line_file1=$_;
push(@file1,$line_file1);
}

open(F2,$ARGV[1]);
while(<F2>)
{
chomp;
$line_file2=$_;
push(@file2,$line_file2);
}

	#print"LINES EQUAL IN ALL FILES\n";
	for($i=0;$i<@file2;$i++)
	{
		@f1=split(/\t/,$file1[$i]);$l1=@f1;
		@f2=split(/\t/,$file2[$i]);$l2=@f2;
		if($f1[0]!~/^\s*$/)
		{
			if($f1[0] eq $f2[0])
			{
				#print"$f2[0]\t$f2[1]\t$f2[2]\t$f1[$l1-1]\n";
				$file2[$i]=$file2[$i]."\t".$f1[3];
				print"@file2[$i]\n";
			}
		}
		else
		{
			print"@file2[$i]\n";
		}	
		
	}
