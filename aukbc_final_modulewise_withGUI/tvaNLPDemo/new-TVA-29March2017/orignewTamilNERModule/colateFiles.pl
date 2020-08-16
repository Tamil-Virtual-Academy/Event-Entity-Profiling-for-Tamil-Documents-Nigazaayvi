#!/usr/bin/perl

undef @array1;
undef @array2;

open(RE1,"$ARGV[0]");
while(<RE1>) {
	chomp;
	push(@array1,$_);
}
close(RE1);

open(RE2,"$ARGV[1]");
while(<RE2>) {
	chomp;
	push(@array2,$_);
}
close(RE2);

$fileId = 1;
$sentId = 0;
$wordId = 0;

for($i = 0;$i < @array1;$i++) {
	if($array1[$i] =~ /^\s*$/) {
		$sentId++;
		$wordId = 0;
		print "\n";
		next;
	}

	@temp1 = split(/\t/,$array1[$i]);
	@temp2 = split(/\t/,$array2[$i]);


	print "$fileId\t$sentId\t$wordId\t$temp1[0]\t$temp1[1]\t$temp1[2]\t$temp1[3]\t$temp2[3]\t$temp1[4]\n";
	$wordId++;
}
