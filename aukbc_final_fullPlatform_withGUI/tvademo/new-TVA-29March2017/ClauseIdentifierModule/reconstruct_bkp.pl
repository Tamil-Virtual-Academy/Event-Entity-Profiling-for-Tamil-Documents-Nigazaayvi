#!/usr/bin/perl

# get the orginal senntence

open(RE,"$ARGV[0]");

while(<RE>) {
	chomp;
	next if($_ eq undef);
	#@ARRA = split(/\t/,$_);
	#pop(@ARRA);
	#$remain = join "\t",@ARRA; 
	push(@orginalA,$_);
}
 
close(RE);
# get the clause tagged sentence

open(RE,"$ARGV[1]");

while(<RE>) {
	chomp;
	next if($_ eq undef);
	if(($_ =~ /SYM\tI\-NP/) || ($_ =~ /SYM\tI\-VG/)) {
		next;
	}
	push(@cl_taggedA,$_);
}

close(RE);

$i = 0;
$j = 0;

#print STDERR join "QAZ", @cl_taggedA,"\n";
#to handle first sym occurance

if(($orginalA[$j] =~ /\tSYM\t/) && ($orginalA[$j] !~ /B\-NP/)) {
	print "$orginalA[$j]\to\n";
	$j++;
}

while($i < @cl_taggedA) {
	#check is there any clause tagging
	
	undef $cl_tag;
	undef $cl_taggedA;

	if($cl_taggedA[$i] =~ /(\{\/\w+\})/) {
		$cltagged = "E";
		$cl_tag = $1;
	}elsif($cl_taggedA[$i] =~ /(\{\w+\})/) {
		$cltagged = "S";
		$cl_tag = $1;
	}else{
		$cltagged = "o";
	}

	#print "qwedsazxc $cltagged ---> $cl_tag\n";
# if start tag handle in the chunk starting and if there is end tag then handle in the chunk ending

	if($cl_taggedA[$i] =~ /np/) {
		#check is np starts in the orginalA and then keep printing till np ends
		if($orginalA[$j] =~ /B\-NP/) {
			print "$orginalA[$j]\t";
			
			if($cltagged eq "S") {
				print "$cl_tag\n";
			}elsif(($cltagged eq "E") && ($orginalA[$j+1] !~ /I\-NP/)){
				print "$cl_tag\n";
			}else{
				print "o\n";
			}
			$j++;

			$true = 1;
			while($true) {
				if($orginalA[$j] !~ /I\-NP/) {
					$true = 0;
				}else{
					print "$orginalA[$j]\t";

					if(($cltagged eq "E") && ($orginalA[$j+1] !~ /\I\-NP/)) {
						print "$cl_tag\n";
					}else{
						print "o\n";
					}
					$j++;
				}
			}
		}
	}else{
		my @ele1 = split(/\t+/,$orginalA[$j]);
		my @ele2 = split(/\t+/,$cl_taggedA[$i]);
	
		#print STDERR "1111111111 $orginalA[$j] qazzaqqzzaq $cl_taggedA[$i]\n\n";	
		# check is the tokens are same
		#print STDERR "$ele1[0]\n$ele2[0]\n";
		if($ele1[0] eq $ele2[0]) {

			print "$orginalA[$j]\t";
			#print STDERR "3333333333 $orginalA[$j]\t";
			
			if($cltagged eq "o") {
				print "o\n";
			}else{
				print "$cl_tag\n";
			}
			$j++;
			#print STDERR "222222222 $orginalA[$j]\n";
			if(($orginalA[$j] =~ /\tSYM\t/) && ($orginalA[$j] !~ /B-(.*?)\t/)) {
				print "$orginalA[$j]","\to\n";
				$j++;
			}
		}
	}
	if(($orginalA[$j] =~ /\tSYM\t/)  && ($orginalA[$j] !~ /B\-(.*?)\t/) ){
		print "$orginalA[$j]","\to\n";
		$j++;
	}
	$i++;
}

print "\n";
