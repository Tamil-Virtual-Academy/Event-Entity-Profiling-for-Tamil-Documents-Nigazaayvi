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

		if(($fileC =~ /\-GEN/i) || ($fileC =~ /\s+wanY\s+.+PR_P/) || ($fileC =~ /\s+eVnY\s+.+PR_P/i))  {
			$prevGEN = 1;
		}else{
			$prevGEN = 0;
		}

		$wordId++;
	}
}
close(RE);
#read pronoun and its png
open(RE2,"pronominalSingular/singularPn.txt");
while(<RE2>) {
	chomp;
	@temp123 = split(/\t/,$_);

	$png123 = "$temp123[1]\-$temp123[2]\-$temp123[3]";

	$sgPnHash{$temp123[0]} = $png123;
	if($temp123[4] eq "possesive") {
		$sgPnHash_type{$temp123[0]} = "possesive";
		#print "$_\n";
	}
}
close(RE2);

#make clause in detail
for($i = 0;$i< @fileContent;$i++) {
	undef %clauseCount;
	undef $clauseTag;
        for($j = 0; $j < @{$fileContent[$i]};$j++) {

		@temp = split(/\t/, $fileContent[$i][$j]);

		if($temp[7] =~ /\{(\w+)\}/) {
			$clause = $1;
			$clauseCount{$clause}++;
			$clauseTag = $clause.$clauseCount{$clause};
		}
		if($clauseTag ne undef) {
			$temp[7] = $clauseTag;
		}

		$line = join "\t", @temp;
		$line =~ s/\t$//;

		$fileContent[$i][$j] = $line;
	}
	#No_of_clause = keys%clauseCount;
}	


for($i = 0;$i< @fileContent;$i++) {
        for($j = 0; $j < @{$fileContent[$i]};$j++) {
		@temp = split(/\t/, $fileContent[$i][$j]);
		#print "$fileContent[$i][$j]\n";

		if(($temp[3] =~ /PR\_/)  && ($fileContent[$i][$j] =~ /TRUE$/)) {

			($p,$n,$g,$req, $type,$actPronoun) = getPNGPrList($temp[2]);

			$tag = "B\-$temp[0]\.$temp[1]";

			if($temp[2] =~ /^avarYrY/) {$req = 0;}

			if($req == 1) {
			#	if($temp[8] !~ /$tag/) {
					print "Pronoun: $fileContent[$i][$j] - $inpFile\n";
					print STDERR "Pronoun: $fileContent[$i][$j] - $inpFile\n";
			#	}else{
			#		print "Pronoun: $fileContent[$i][$j] - Anaphora - $inpFile\n";
			#	}
			
				($p,$n,$g,$case) = getPNGInfo($temp[5]);
				($p,$n,$g,$req, $type,$actPronoun) = getPNGPrList($temp[2]);


				if($case =~ /gen/i) {$type = "poss";}

				#print "Proun p:$p --- n:$n --- g:$g --- $case --- $type --- $actPronoun\n";
				$possesive_type = "-";
				$non_possesive_type = "-";

				if($type eq "poss") {$possesive_type = "poss";}
				if($type eq "nposs") {$non_possesive_type = "nposs";}

				$forFM = "$actPronoun;$possesive_type;$non_possesive_type;$case;";

				#@fmCurrentSent = collectNPCurrentSentence($i,$j,$temp[7],$p,$n,$g,$case,$forFM);

				undef @npCurrentSentence;
				@npCurrentSentence = collectNPCurrentSentence($i,$j,$temp[7],$p,$n,$g,$case,$forFM);
				#print join "\n", @npCurrentSentence,"\n";

				undef @arrayOne;undef @arrayTwo;
				foreach $arrNP (@npCurrentSentence) {
					undef $oneAr; undef $twoAr;
					($oneAr,$twoAr) = split(/<dim>/,$arrNP);
					push(@arrayOne,$oneAr);
					$twoAr =~ s/\;/\t/g;
					push(@arrayTwo,$twoAr);
				}				

				undef @npPreviousSentence;
				@npPreviousSentence = collectNPPreviousSentence($i,$j,$p,$n,$g,$case,$forFM);
				#print join "\n", @npPreviousSentence,"\n";

				foreach $arrNP (@npPreviousSentence) {
					undef $oneAr; undef $twoAr;
					($oneAr,$twoAr) = split(/<dim>/,$arrNP);
					push(@arrayOne,$oneAr);
					$twoAr =~ s/\;/\t/g;
					push(@arrayTwo,$twoAr);
				}
				#run crf 
				#print STDERR join "\n", @arrayOne,"\n";

				open(WR,">testFile.txt");
				foreach $k_fm (@arrayTwo) {
					print WR "$k_fm\n";
				}
				close(WR);

				$outputCRF = `crf_test -m pronominalSingular/newModel_singularPronouns testFile.txt`;
				#print STDERR "$outputCRF\n";
				@outArra = split(/\n/, $outputCRF);

				for($ijk123 = 0;$ijk123 < @outArra;$ijk123++) {
					print STDERR "~~~ $arrayOne[$ijk123]\n";
					print STDERR "--- $outArra[$ijk123]\n";
				}

				for($ijk123 = 0;$ijk123 < @outArra;$ijk123++) {
					if($outArra[$ijk123] =~ /\t\w+\tAnte$/) {
						$result = $&;
						print "$arrayOne[$ijk123]\n";
						last;
					}
					#rint "$arrayOne[$ijk123]\n$outArra[$ijk123]\n\n";
				}
				#print join "\n", @outArra, "\n";

				print "____________________\n";
				print STDERR "____________________\n";
			}
		}
	}
}

sub getPNGPrList {
	my $pronoun_1 = $_[0];

	#print "$pronoun_1\n";	
	$temp123_p = "";
	$temp123_n = "";
	$temp123_g = "";
	$temp123_req = 0;
	$temp123_type = "nposs";
	$temp123_pr = "";

	foreach $pr (keys%sgPnHash) {
		#print "$pronoun_1 -- $pr\n";
		if(($pronoun_1 =~ /^$pr/) && ($pronoun_1 !~ /kalY/)) {
			@temp234 = split(/\-/,$sgPnHash{$pr});

			$temp123_p = $temp234[0];
			$temp123_n = $temp234[1];
			$temp123_g = $temp234[2];
		
			if(exists $sgPnHash_type{$pr}) {
				$temp123_type = "poss";	
			}
			$temp123_req = 1;

			$temp123_pr = $pr;

			return($temp123_p, $temp123_n, $temp123_g, $temp123_req, $temp123_type, $temp123_pr);
			last;
		}
	}
}
1;

sub getPNGInfo {
	my $tempMorph1 = $_[0];

	#print "~@@~@ $tempMorph1\n";
	my @tempA_morph1 = split(/\,/, $tempMorph1);

	my $temp_p = $tempA_morph1[4];
	my $temp_g = $tempA_morph1[5];
	my $temp_n = $tempA_morph1[3];
	my $temp_case = $tempA_morph1[2]; 

	if($temp_p =~ /^\s*$/) {$temp_p = 3;}
	if($temp_n =~ /^\s*$/) {$temp_n = "sg";}
	if($temp_g =~ /^\s*$/) {$temp_g = "n";}

	$temp_case =~ s/^.+\-//;

	if($temp_case =~ /^\s*$/) {$temp_case = "nom";}

	return($temp_p,$temp_n,$temp_g,$temp_case);
}

sub collectNPCurrentSentence {
	my $new_sentId1 = $_[0];
	my $new_wordId1 = $_[1];
	my $clauseTag1 = $_[2];

	if($clauseTag1 =~ /(\d+)$/) {$clauseTag1_number = $1;}

	my $new_p1 = $_[3];
	my $new_n1 = $_[4];
	my $new_g1 = $_[5];
	#print "qaz -- new_p1:$new_p1 -- new_n1:$new_n1 -- new_g1:$new_g1\n";

	my $new_case = $_[6];

	my $anaphorFM_details = $_[7];

	undef @npBucket1;
	undef @fmBucket1;
	undef $nptext;
	undef $clHash;
	undef $No_of_clause;

	for($j1 = 0;$j1 <@{$fileContent[$new_sentId1]};$j1++) {
		@tempN = split(/\t/, $fileContent[$new_sentId1][$j1]);
		#print "$tempN[7] ";
		#print "$fileContent[$new_sentId1][$j1]\n";
		$clHash{$tempN[7]}++;
	}
	#print "\n";

	$No_of_clause = keys%clHash;

	#print "$new_sentId1 --- $No_of_clause\n";

	if($No_of_clause > 1) {
		$wrds_toConsider = @{$fileContent[$new_sentId1]};
		#print "Full Sentence -- $wrds_toConsider\n";
	}else{
		$wrds_toConsider = $new_wordId1;
	}


        for($j1 = 0; $j1 < $wrds_toConsider;$j1++) {
		if($j1 == $new_wordId1) {
			undef $nptext;
			next;
		}
		if($fileContent[$new_sentId1][$j1] =~ /B\-NP/) {
			$nptext = $nptext."<delim>".$fileContent[$new_sentId1][$j1];
		}elsif(($fileContent[$new_sentId1][$j1] =~ /I\-NP/) && ($nptext ne undef)){
			$nptext = $nptext."<delim>".$fileContent[$new_sentId1][$j1];	
		}

		if($nptext ne undef) {
			#print "NP-text: $nptext\n";
			if($fileContent[$new_sentId1][$j1+1] !~ /I\-NP/) {
				$nptext =~ s/^<delim>//;

				undef @temp1;
				undef $selectedWrd;

				if($fileContent[$new_sentId1][$j1] =~ /^\d+\t\d+\t[a-zA-Z]+/) {
					#print "selected: $fileContent[$new_sentId1][$j1]\n";
					$selectedWrd = $fileContent[$new_sentId1][$j1];
					@temp1 = split(/\t/, $fileContent[$new_sentId1][$j1]);
				}elsif($fileContent[$new_sentId1][$j1] !~ /B\-NP/) {
					if($fileContent[$new_sentId1][$j1-1] =~ /^\d+\t\d+\t[a-zA-Z]+/) {
						#print "selected: $fileContent[$new_sentId1][$j1-1]\n";
						$selectedWrd = $fileContent[$new_sentId1][$j1-1];
						@temp1 = split(/\t/, $fileContent[$new_sentId1][$j1-1]);
					}elsif($fileContent[$new_sentId1][$j1-1] !~ /B\-NP/){
						#print "selected: $fileContent[$new_sentId1][$j1-2]\n";
						$selectedWrd = $fileContent[$new_sentId1][$j1-2];
						@temp1 = split(/\t/, $fileContent[$new_sentId1][$j1-2]);
					}
				}

				if($selectedWrd eq undef) {undef $nptext; next;}

				$new_p2 eq undef;$new_n2 eq undef;$new_g2 eq undef;$new_case2 eq undef;

				#print join "\t", @temp1,"\n";

				$possibleAntePR = "-";
				if($temp1[3] =~ /PR\_/)	 {
					($new_p2,$new_n2,$new_g2,$new_req2, $new_type2,$new_actPronoun2) = getPNGPrList($temp1[2]);
				}else{
					 ($new_p2,$new_n2,$new_g2,$new_case2) = getPNGInfo($temp1[5]);
				}
				#print "~~~$fileContent[$new_sentId1][$j1]\n";
				#print "p:$new_p1, $new_p2 --- n:$new_n1, $new_n2 --- g:$new_g1, $new_g2 --- $new_case2\n";

				if($temp1[7] =~ /(\d+)$/) {$cl_tg_no = $1;}

				$sameCFlag = 0;
				$icFlag = 0;
				$nonICFlag = 0;
				$mclFlag = 0;
				$subClFlag = 0;

				if($temp1[7] =~ /(MCL)/i) {$mclFlag = "mcl";}else{$subClFlag = "subcl";}

				if($clauseTag1_number == $cl_tg_no) {
					$clausePosition = "same";
					$sameCFlag = "same";
				}elsif($clauseTag1_number == ($cl_tg_no+1)) {
					$clausePosition = "immediate";
					$icFlag = "IC";
				}else{
					$clausePosition = "non_immediate";
					$nonICFlag = "non_IC";
				}
				
				$nomFlag = 0;
				$accFlag = 0;
				$datFlag = 0;
				$otherFlag = 0;

				if($new_case2 =~ /nom/i) {
					$nomFlag = "nom";
				}elsif($new_case2 =~ /acc/i) {
					$accFlag = "acc";
				}elsif($new_case2 =~ /dat/i) {
					$datFlag = "dat";
				}else{
					$otherFlag = "other";
				}

				#print "clause position = $clausePosition\n";
				$pngMatch = 0;
				if($temp1[3] =~ /PR_/){
					$possibleAntePR = $temp1[2];
					if(($new_p1 =~ $new_p2) || ($new_p1 == 1 && $new_p2 == 3) || ($new_p1 == 3 && $new_p2 == 1)) {
                                		if (($new_n1 eq $new_n2) && ($new_g1 =~ /$new_g2/)) {
                                		        $pngMatch = 1;
                                		}
					}
				}else{
					if(($new_g1 =~ /$new_g2/)) {$pngMatch = 1;}
				}
				
				#print "~~~ $nptext\n";
				if($pngMatch == 1) {
					$FMline ="";
					$FMline = $anaphorFM_details."$possibleAntePR;yes;no;no;no;no;$nomFlag;$accFlag;$datFlag;$otherFlag;$sameCFlag;$icFlag;$nonICFlag;$mclFlag;$subClFlag";
					#if($fileContent[$new_sentId1][$j1] =~ /[BI]\-$new_sentId1\.$new_wordId1/) {
					$nptext = $nptext."<dim>$FMline;";
					if(($selectedWrd =~ /[BI]\-$new_sentId1\.$new_wordId1\s+/) || ($selectedWrd =~ /[BI]\-$new_sentId1\.$new_wordId1\;/)){
						$nptext = $nptext."Ante";
					}else{
						$nptext = $nptext."no";
					}	
					push(@npBucket1,$nptext);
				}
				undef $nptext;
				undef $FMline;
			}
		}
	}

	#print "NP in current sentence\n";
	#rint join "~~\n\n", @npBucket1,"\n";
	#return(@fmBucket1);
	return(@npBucket1);
}

sub collectNPPreviousSentence {
	my $new_sentId1 = $_[0];
	my $new_wordId1 = $_[1];
	#$clauseTag1 = $_[2];

	my $new_p1 = $_[2];
	my $new_n1 = $_[3];
	my $new_g1 = $_[4];
	my $new_case = $_[5];
	my $anaphorFM_details = $_[6];

	#print "new_p1:$new_p1 -- new_n1:$new_n1 -- new_g1:$new_g1\n";

	$loop = 0;

	$newSentId2 = $new_sentId1;

	undef @npBucket_PreviousSents;
	undef @fmBucket_PreviousSents;

	while($loop < 4) {
	#while($newSentId2 >= 0) {
		undef $nptext;
		$newSentId2--;
	
		#print "Sentence number in Analysis -- $newSentId2\n";
		$sentPos = $loop;
		$sentPos++;
		if($newSentId2 >= 0) {
			undef $nptext;
			for($j1 = 0; $j1 < @{$fileContent[$newSentId2]};$j1++) {
				if($fileContent[$newSentId2][$j1] =~ /B\-NP/) {
					$nptext = $nptext."<delim>".$fileContent[$newSentId2][$j1];
				}elsif(($fileContent[$newSentId2][$j1] =~ /I\-NP/) && ($nptext ne undef)){
					$nptext = $nptext."<delim>".$fileContent[$newSentId2][$j1];	
				}

				if($nptext ne undef) {
					#print "~~~~~~~~~~~\nNP-text: $nptext\n";
					if($fileContent[$newSentId2][$j1+1] !~ /I\-NP/) {
						$nptext =~ s/^<delim>//;
						undef @temp1;
						undef $selectedWrd;
						#print "~Actual~~$fileContent[$newSentId2][$j1]\n";
						if($fileContent[$newSentId2][$j1] =~ /^\d+\t\d+\t[a-zA-Z]+/) {
							#print "selected: $fileContent[$newSentId2][$j1]\n";
							$selectedWrd =  $fileContent[$newSentId2][$j1];
							@temp1 = split(/\t/, $fileContent[$newSentId2][$j1]);
						}elsif($fileContent[$newSentId2][$j1] !~ /B\-NP/) {
							if($fileContent[$newSentId2][$j1-1] =~ /^\d+\t\d+\t[a-zA-Z]+/) {
								#print "selected: $fileContent[$newSentId2][$j1-1]\n";
								$selectedWrd = $fileContent[$newSentId2][$j1-1];
								@temp1 = split(/\t/, $fileContent[$newSentId2][$j1-1]);
							}elsif($fileContent[$newSentId2][$j1-1] !~ /B\-NP/) {
								#print "selected: $fileContent[$newSentId2][$j1-2]\n";
								$selectedWrd = $fileContent[$newSentId2][$j1-2];
								@temp1 = split(/\t/, $fileContent[$newSentId2][$j1-2]);
							}
						}

						#print join "\t", @temp1,"\n";

						if($selectedWrd eq undef) {undef $nptext; next;}

						$new_p2 eq undef;$new_n2 eq undef;$new_g2 eq undef;$new_case2 eq undef;
			
#						print "Intially -- p:$new_p1, $new_p2 --- n:$new_n1, $new_n2 --- g:$new_g1, $new_g2 --- $new_case2\n";								
						if($temp1[3] =~ /PR_/){
							($new_p2,$new_n2,$new_g2,$new_req2, $new_type2,$new_actPronoun2) = getPNGPrList($temp1[2]);
						}else{
							($new_p2,$new_n2,$new_g2,$new_case2) = getPNGInfo($temp1[5]);
						}
#						print "--1111-- $nptext\n";
#						print "p:$new_p1, $new_p2 --- n:$new_n1, $new_n2 --- g:$new_g1, $new_g2 --- $new_case2\n";								
						$mclFlag = 0;
						$subClFlag = 0;

						if($temp1[7] =~ /(MCL)/i) {$mclFlag = "mcl";}else{$subClFlag = "subcl";}

						$nomFlag = 0;
						$accFlag = 0;
						$datFlag = 0;
						$otherFlag = 0;
						if($new_case2 =~ /nom/i) {
							$nomFlag = "nom";
						}elsif($new_case2 =~ /acc/i) {
							$accFlag = "acc";
						}elsif($new_case2 =~ /dat/i) {
							$datFlag = "dat";
						}else{
							$otherFlag = "other";
						}

						$icFlag =0;$sameCFlag=0;$nonICFlag=0;
						$possibleAntePR = "-";

						$sentPosition = $loop+1;

						if($sentPosition == 1) {
							$sentPositionInfo = "no;yes;no;no;no";
						}elsif($sentPosition == 2) {
							$sentPositionInfo = "no;no;yes;no;no";
						}elsif($sentPosition == 3) {
							$sentPositionInfo = "no;no;no;yes;no";
						}elsif($sentPosition == 4) {
							$sentPositionInfo = "no;no;no;no;yes";
						}

						$pngMatch = 0;
						if($temp1[3] =~ /PR_/){
							$possibleAntePR = $temp1[2];
				                        if(($new_p1 =~ $new_p2) || ($new_p1 == 1 && $new_p2 == 3) || ($new_p1 == 3 && $new_p2 == 1)) {
                                				if (($new_n1 eq $new_n2) && ($new_g1 =~ /$new_g2/)) {
                                				        $pngMatch = 1;
                                				}
							}
                        			}else{
							if(($new_g1 =~ /$new_g2/)) {$pngMatch = 1;}
						}

						#print "png match => $pngMatch\n";


						$FMline ="";
						if($pngMatch == 1) {
							$FMline ="";
							
							$FMline = $anaphorFM_details."$possibleAntePR;$sentPositionInfo;$nomFlag;$accFlag;$datFlag;$otherFlag;$sameCFlag;$icFlag;$nonICFlag;$mclFlag;$subClFlag";
							#$FMline = $anaphorFM_details."$sentPos\t$nomFlag\t$accFlag\t$otherFlag\t$icFlag\t$sameCFlag\t$nonICFlag\t$mclFlag\t$subClFlag";
							#print "$FMline\n";                                     
							#if($fileContent[$newSentId2][$j1] =~ /[BI]\-$new_sentId1\.$new_wordId1/) {
							$nptext = $nptext."<dim>$FMline;";
							#print "---- $nptext\n";
							#print "~!~!~ $selectedWrd\n";
							if($selectedWrd =~ /[BI]\-$new_sentId1\.$new_wordId1\s+/)  {
								$nptext = $nptext."Ante";
							}elsif($selectedWrd =~ /[BI]\-$new_sentId1\.$new_wordId1\;/){
								$nptext = $nptext."Ante";
							}else{
								$nptext = $nptext."no";
							}
							
							push(@npBucket_PreviousSents,$nptext);
						}
						undef $nptext;
						undef $FMline;
					}
				}
			}
		}else{
			last;
		}
		$loop++;
	}

	#print "NP in previous sentence\n";
#	for($ijkk = 0;$ijkk < @npBucket_PreviousSents;$ijkk++) {
#		print STDERR "$npBucket_PreviousSents[$ijkk]\n";
#		print "~~~~~$fmBucket_PreviousSents[$ijkk]\n";:q	
#	}
#	print "~~~~~~~~~~~~~~~~\n";
	#return(@fmBucket_PreviousSents);
	#print join "~~~\n\n", @npBucket_PreviousSents,"\n";
	return(@npBucket_PreviousSents);
}
