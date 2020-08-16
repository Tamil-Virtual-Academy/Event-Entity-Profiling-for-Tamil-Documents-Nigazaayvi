while(<>){
	chomp;
        $line=$_;
        $line=~s/^\s+//;
        $line=~s/\s+$//;
        $line=~s/^\t+$//;
        if($line eq undef) { print "\n"; next;}
	@arr=split(/\t/,$line);
	print "$arr[0]\t$arr[1]\t$arr[2]\t$arr[3]\t$arr[4]\n";
	#print "$arr[5]\t$arr[6]\t$arr[7]\t$arr[8]\t$arr[9]\n";
	#print "$arr[5]\n";
	
}
