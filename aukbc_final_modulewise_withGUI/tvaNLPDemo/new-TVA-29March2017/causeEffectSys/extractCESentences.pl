#!/usr/bin/perl

undef $line;
undef @array;

while(<>) {
        chomp;

        if($_ =~ /^\s*$/) {
                $line = join "L_END", @array;
                push(@fullArray,$line);
                undef @array;
        }else{
                push(@array,$_);
        }
}


for($i = 0;$i < @fullArray;$i++) {
	if(($fullArray[$i] =~ /ARG1-START/) && ($fullArray[$i] =~ /ARG2-START/) && ($fullArray[$i] =~ /ARG1-END/) && ($fullArray[$i] =~ /ARG2-END/)) {
		#print "case 1\n";
		undef @tempW;
		print "<iitk>";
		@tempW = split(/L_END/,$fullArray[$i]);
		for $k (@tempW) {
			@temp = split(/\s+/,$k);
			print "$temp[0] ";
		}
		print "<\/iitk>";
		print "\n\n";	
#	}elsif(($fullArray[$i-1] =~ /ARG1-START/) && ($fullArray[$i] =~ /ARG2-START/) && ($fullArray[$i-1] =~ /ARG1-END/) && ($fullArray[$i] =~ /ARG2-END/)) {
#		print "case 2\n";
##		undef @tempW; undef @tempW_prev;
#		@tempW_prev = split(/L_END/,$fullArray[$i-1]);
#		@tempW = split(/L_END/,$fullArray[$i]);
#		for $k (@tempW_prev) {
#			@temp = split(/\s+/,$k);
#			print "$temp[0] ";
#		}
#		for $k (@tempW) {
#			@temp = split(/\s+/,$k);
#			print "$temp[0] ";
#		}
#		print "\n\n";
	}elsif(($fullArray[$i] =~ /ARG1-START/) && ($fullArray[$i+1] =~ /ARG2-START/) && ($fullArray[$i] =~ /ARG1-END/) && ($fullArray[$i+1] =~ /ARG2-END/)) {
		#print "case 3\n";
		print "<iitk>";
		undef @tempW; undef @tempW_prev;
		@tempW_prev = split(/L_END/,$fullArray[$i]);
		@tempW = split(/L_END/,$fullArray[$i+1]);
		for $k (@tempW_prev) {
			@temp = split(/\s+/,$k);
			print "$temp[0] ";
		}
		for $k (@tempW) {
			@temp = split(/\s+/,$k);
			print "$temp[0] ";
		}
		print "<\/iitk>";
		print "\n\n";	
	}
}

