while(<>){
	chomp;
	$line=$_;
	$line=~s/^\s+$//;
	if($line eq undef) { print "\n"; next;}
	@arrline=split(/\t/,$line);
	if($line=~/<ARG1-START>/){
		print "$arrline[0]\t$arrline[1]\t$arrline[2]\t$arrline[3]\t$arrline[4]\t$arrline[5]\t<ARG1-START>\n";
	}
	elsif($line=~/<ARG2-START>/){
		print "$arrline[0]\t$arrline[1]\t$arrline[2]\t$arrline[3]\t$arrline[4]\t$arrline[5]\t<ARG2-START>\n";
	}
	elsif($line=~/<ARG1-END>/){
		print "$arrline[0]\t$arrline[1]\t$arrline[2]\t$arrline[3]\t$arrline[4]\t$arrline[5]\t<ARG1-END>\n";
	}
	elsif($line=~/<ARG2-END>/){
		print "$arrline[0]\t$arrline[1]\t$arrline[2]\t$arrline[3]\t$arrline[4]\t$arrline[5]\t<ARG2-END>\n";
	}
	else{
		print "$arrline[0]\t$arrline[1]\t$arrline[2]\t$arrline[3]\t$arrline[4]\t$arrline[5]\tO\n";
	}
}
