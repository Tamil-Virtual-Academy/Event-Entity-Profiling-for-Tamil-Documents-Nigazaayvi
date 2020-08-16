while(<>){
	chomp;
	if($_=~/,(ADV,\d+)/){
		print "$1\n";
	}
}

