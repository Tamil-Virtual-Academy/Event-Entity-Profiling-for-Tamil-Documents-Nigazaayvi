#!/usr/bin/perl

open(RE,$ARGV[0]);
while(<RE>) {
	chomp;
	push(@fileNames,$_);
}
close(RE);

foreach $file1 (@fileNames) {

	$newfile =  $file1."._1";
	$cmd = "cp $file1 $newfile";
	system($cmd);

	undef @array;
	open(RE,$newfile);
	while(<RE>) {
		chomp;
		#$_ =~ s/\/root\/apache-tomcat-6.0.13\//$ARGV[1]\//g;
		$_ =~ s/\/home\/nlp\/apache-tomcat-8.5.23\/+/$ARGV[1]\//g;
		#$_ =~ s/\/\//\//g;
		push(@array,$_);
	}
	close(RE);

	open(WR,">$file1");
	foreach $ar (@array) {
		print WR "$ar\n";
	}
	close(WR);

	$cmd = "rm $newfile";
	system($cmd);
}
