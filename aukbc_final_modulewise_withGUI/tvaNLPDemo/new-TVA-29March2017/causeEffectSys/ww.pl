while(<>){
	$conatt="O";
	$arg2endatt="O";
	$arg2startatt="O";
	$arg1startatt="O";
	$arg1endatt="O";
	chomp;
	$line=$_;
	$line=~s/^\s+//;
	$line=~s/\s+$//;
	$line=~s/^\t+$//;
	if($line eq undef) { print "\n"; next;}
	if($line=~/<CON>/){
		$conatt="<CON>";
	}
	if($line=~/<ARG2-END>/){
		$arg2endatt="<ARG2-END>";
	}
	if($line=~/<ARG2-START>/){
		$arg2startatt="<ARG2-START>";
	}
	if($line=~/<ARG1-START>/){
		$arg1startatt="<ARG1-START>";
	}
	if($line=~/<ARG1-END>/){
		$arg1endatt="<ARG1-END>";
	}
	@aa=split(/\t/,$line);
	$len=@aa;
	print "$aa[0]\t$aa[1]\t$aa[2]\t$aa[3]\t$aa[4]\t$aa[5]\t$aa[6]\t$aa[7]\t$conatt\t$arg2startatt\t$arg1endatt\t$arg2endatt\t$arg1startatt\n";
	
}
