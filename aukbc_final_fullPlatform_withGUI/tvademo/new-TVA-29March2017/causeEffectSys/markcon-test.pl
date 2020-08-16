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
		if($line=~/<CON>$/) {
		 print "$line\n";
		}else{
			$line=~s/\tO$/\t<CON>/;
			print "$line\n";
		}
	}
	elsif($linarr[0]=~/($constr)$/){
		if($line=~/<CON>$/) {
		 print "$line\n";
		}else{
			$line=~s/\tO$/\t<CON>/;
			print "$line\n";
		}
	}
	else{
		print "$line\n";
	}
	
}
