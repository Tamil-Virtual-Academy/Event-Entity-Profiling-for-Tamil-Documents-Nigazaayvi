#!/usr/bin/perl

$sentId = 0;
$wordId = 0;
$prevGEN = 0;

$inpFile = $ARGV[0];

open(RE,$inpFile);

while(<RE>) {
        chomp;

        if($_ =~ /^\s*$/) {
                $sentId++;
                $wordId = 0;
        }else{
                $_ =~ s/^\s*//;
                @temp = split(/\s+/,$_);

                shift(@temp);

                $fileC = join "\t", @temp;

                $fileC =~ s/^\t//;
                $fileC =~ s/\t$//;

                $fileContent[$sentId][$wordId] = $fileC;

                if(($prevGEN == 1) && ($fileContent[$sentId][$wordId] =~ /\tI\-NP/)) {
                        $fileContent[$sentId][$wordId] =~ s/\tI\-NP/\tB-NP/;
                }

                #if(($fileC =~ /\-GEN/i) || ($fileC =~ /\s+wanY\s+.+PR_P/) || ($fileC =~ /\s+eVnY\s+.+PR_P/i))  {
                #        $prevGEN = 1;
                #}else{
                #        $prevGEN = 0;
                #}

                $wordId++;
        }
}
close(RE);

undef @npArray;
undef $npText;

for($i = 0;$i< @fileContent;$i++) {
        for($j = 0; $j < @{$fileContent[$i]};$j++) {
                if($fileContent[$i][$j] =~ /B\-NP/)  {
			if($npText ne undef) {
				#$npHash{$npText}++;
				push(@npArray,$npText);
				undef $npText;
			}
			$npText = $fileContent[$i][$j];
		}elsif(($fileContent[$i][$j] =~ /I\-NP/) && ($npText ne undef)){
			$npText = $npText."<br>".$fileContent[$i][$j];
		}else{
			if($npText ne undef) {
				push(@npArray,$npText);
				#$npHash{$npText}++;
				undef $npText;
			}
		}
        }
	#print "\n";
}

#foreach $k (sort keys%npHash) {
foreach $k (@npArray) {
#	@temp = split(/<br>/,$k);
#	print join "\n", @temp,"\n";
	analyseNP($k);
}


sub analyseNP {
	my $newNp = $_[0];

	if(($newNp !~ /<br>/) && ($newNp =~ /\tPR\_/)) {
		#print "$newNp\n";
	}else{
		#print "$newNp\n";
		my @tempNP = split(/<br>/,$k);

		undef $neDetails; undef $ddDetails; $n_n_info ="-"; undef $sent_no;undef $word_no;
		foreach $np_w (@tempNP) {
			@tempW = split(/\t/,$np_w);

			if($sent_no eq undef) {$sent_no = $tempW[0];}
			if($word_no eq undef) {$word_no = $tempW[1];}
	
			$neDetails = $neDetails."##".$tempW[6];
			$ddDetails = $ddDetails."##".$tempW[7];
			$n_n_info = $tempW[10] if($tempW[10] =~ /B\-/);
		}
		# collect info on word

		undef $word; $gender = "n";$person = "-"; $number="-"; $case = "nom"; undef $headNP;

		$l = @tempNP;$l--;
		for($j = $l;$j >=0;$j--) {
			@tempW = split(/\t/,$tempNP[$j]);
			if($tempW[2] !~ /[A-Za-z\.]+/){next;}

			if($word eq undef) {
				$morphO = $tempW[5];
				@tempMorph = split(/\,/,$morphO);
				$word = $tempMorph[0];

				if($tempMorph[4] !~ /^\s*$/) {$person = $tempMorph[4];}  
				if($tempMorph[3] !~ /^\s*$/) {$number = $tempMorph[3];}
				if($tempMorph[5] !~ /^\s*$/) {$gender = $tempMorph[5];}
				
				if($tempMorph[2] =~ /\-/) {
					($suf,$tag) = split(/\-/, $tempMorph[2]);
					$case = $tag;
				}
				$headNP = $tempMorph[0];
			}else{
				$word = $tempW[2]."_".$word;
			}
		}	

		$word =~ s/\_$//;

		$neFlag = "no";	if($neDetails =~ /[BI]\-/) {$neFlag = "yes";}
		$ddFlag = "no"; if($ddDetails =~ /[BI]\-/) {$ddFlag = "yes";}

		#print "Wrd: $word\n";
		#print "NE: $neDetails\n";
		#print "DD: $ddDetails\n";
		#print "N_N: $n_n_info\n";
		#print "Sent_no: $sent_no\n";
		#print "Word_no: $word_no\n";
		#print "gender: $gender\n";
		#print "number: $number\n";
		#print "Person: $person\n";
		#print "case: $case\n";
		#print "\n";

		if(($neDetails =~ /[BI]\-/) ||($ddDetails =~ /[BI]\-/)) {
			print "$sent_no\t$word_no\t$word\t$headNP\t$neFlag\t$ddFlag\t$case\t$gender\t$number\t$person\t$n_n_info\n" if($word !~ /^\s*$/);
		}
	}
}
