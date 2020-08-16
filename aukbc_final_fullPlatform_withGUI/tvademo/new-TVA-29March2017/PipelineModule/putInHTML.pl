#!/usr/bin/perl

print "\<?xml version=\"1.0\" encoding=\"UTF-8\"?\>\n";
print "<DOCUMENT><P>";
while(<>) {
	chomp;
	s/^\s*//;
	s/\s*$//;

	if($_ =~ /^\s*$/) {	
		print "<\/P>\n";
		print "\n";
		print "<P>";
	}else{
		@array = split(/\s+/,$_);

		#foreach $wrd (@word) {
			print "<W> $array[3] <\/W>";
		#}
	}
}
print "<\/P><\/DOCUMENT>";
