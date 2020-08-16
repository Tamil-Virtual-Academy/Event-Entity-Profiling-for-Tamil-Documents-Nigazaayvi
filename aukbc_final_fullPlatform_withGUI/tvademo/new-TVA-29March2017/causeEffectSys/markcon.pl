open(LH,"ConList.txt");
while(<LH>){
	chomp;
	$conhash{$_}++;
	$constr.="($_)|";
}
close(LH);
$constr=~s/\|$//;

while(<>){
	chomp;
	if($_ eq undef) { print "\n"; next; }
	$line=$_;
	@linarr=split(/\t/,$line);
	$len=@linarr;
	if(exists($conhash{$linarr[0]})) {
		##print "$linarr[0]\t$linarr[1]\t$linarr[2]\t$linarr[3]\t$linarr[4]\t$linarr[5]\t<CON>\n";
		print "$linarr[0]\t$linarr[1]\t$linarr[2]\t$linarr[3]\t$linarr[4]\t<CON>\t$linarr[6]\t$linarr[7]\t$linarr[8]\t$linarr[9]\n";
	}
	elsif($linarr[0]=~/($constr)$/){
		##print "$linarr[0]\t$linarr[1]\t$linarr[2]\t$linarr[3]\t$linarr[4]\t$linarr[5]\t<CON>\n";
		print "$linarr[0]\t$linarr[1]\t$linarr[2]\t$linarr[3]\t$linarr[4]\t<CON>\t$linarr[6]\t$linarr[7]\t$linarr[8]\t$linarr[9]\n";
	}
	else{
		##print "$linarr[0]\t$linarr[1]\t$linarr[2]\t$linarr[3]\t$linarr[4]\t$linarr[5]\tO\n";
		print "$linarr[0]\t$linarr[1]\t$linarr[2]\t$linarr[3]\t$linarr[4]\tO\t$linarr[6]\t$linarr[7]\t$linarr[8]\t$linarr[9]\n";
	}
	
}
