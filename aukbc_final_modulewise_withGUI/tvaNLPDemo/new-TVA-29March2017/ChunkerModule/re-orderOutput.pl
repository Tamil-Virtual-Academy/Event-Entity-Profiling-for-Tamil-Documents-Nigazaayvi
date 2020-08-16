#!/urs/bin/perl

open(RE,"$ARGV[0]");
while(<RE>){
	chomp;
	push(@array1,$_);
}
close(RE);

open(RE,"$ARGV[1]");
while(<RE>){
	chomp;
	push(@array2,$_);
}
close(RE);

for($i = 0;$i <@array1;$i++) {

	if($array1[$i] !~ /^\s*$/) {
		@element1 = split(/\t/,$array1[$i]);
		@element2 = split(/\t/,$array2[$i]);

		print "$element1[0]\t$element2[1]\t$element2[2]\t$element1[2]\n";
	}else{
		print "\n";
	}
}
