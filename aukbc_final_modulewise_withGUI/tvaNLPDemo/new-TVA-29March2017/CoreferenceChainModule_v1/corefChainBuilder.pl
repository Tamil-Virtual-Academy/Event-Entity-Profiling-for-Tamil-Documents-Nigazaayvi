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
                $fileContent[$sentId][$wordId] = $_;
                @ttt = split(/\s+/,$fileContent[$sentId][$wordId]);
                $ll = @ttt;
                if($ll == 11) { $fileContent[$sentId][$wordId] = $fileContent[$sentId][$wordId]." -";}
                #print "$ll ~~~ $fileContent[$sentId][$wordId]\n";
                $wordId++;
        }
}
close(RE);

undef @collectionArray;

for($i = 0;$i< @fileContent;$i++) {
        for($j = 0; $j < @{$fileContent[$i]};$j++) {

                @ttt = split(/\s+/,$fileContent[$i][$j]);
		pop(@ttt);
		$nnAna = pop(@ttt);
		$pnAna = pop(@ttt);

		undef $B_nnAna;
		undef $B_pnAna;

		if($nnAna ne "-") {
			#print "$i\-$j\n";
			##print "~~~ $nnAna\n";
			#collect all B

			undef @tempNN;
			@tempNN = split(/\;/,$nnAna);
			undef $B_nnAna;
			undef %tempHash;
			foreach $tA (@tempNN) {
				next if($tA =~ /I\-/);
				if(!exists $tempHash{$tA}) {
					$B_nnAna = $B_nnAna.";".$tA;
				}
				$tempHash{$tA}++;
			}
			$B_nnAna =~ s/^\;//;
			#print "$B_nnAna\n";
		}
		if($pnAna ne "-") {
			#print "~11~~ $pnAna\n";
			undef @tempPN;
			@tempPN = split(/\;/,$pnAna);
			undef $B_pnAna;
			undef %tempHash;
			foreach $tA (@tempPN) {
				next if($tA =~ /I\-/);
				if(!exists $tempHash{$tA}) {
					$B_pnAna = $B_pnAna.";".$tA;
				}
				$tempHash{$tA}++;
				#print "56 $B_pnAna\n";
			}
			$B_pnAna =~ s/^\;//;
			#print "!~!~ $B_pnAna\n";
		}
		# combining both the ids
			
		undef $totalIds;
		if($B_nnAna ne undef) {$totalIds = $totalIds.";".$B_nnAna;}
		if($B_pnAna ne undef) {$totalIds = $totalIds.";".$B_pnAna;}


		#print "$totalIds\n" if($totalIds ne undef);
		if($totalIds ne undef) {
			$totalIds =~ s/^\;//;
			$totalIds = $totalIds.";";
			push(@collectionArray,$totalIds);
		}
	}
}

#print join "\n", @collectionArray,"\n";

$matchedFlag = 0;
for($j = 0;$j < @collectionArray;$j++) {
        @ids = split(/\;/,$collectionArray[$j]);

        $matchedFlag = 0;
        for($i = 0;$i < @collectionArray;$i++) {
                next if($i == $j);
                foreach $id (@ids) {
                        $matchedFlag = 0;
                        if($collectionArray[$i] =~ /$id\;/) {
				#print "matched lines are \n$collectionArray[$j]\n$collectionArray[$i]\n\n";
                                $collectionArray[$j] = $collectionArray[$j]."".$collectionArray[$i];
                                delete $collectionArray[$i];
				#print "After deleting the array\n$collectionArray[$i]\n";
                                $matchedFlag = 1;
                                last;
                        }
                }
                if($matchedFlag == 1) {last;}
        }
}
#print "~~~~~~~~~~~~\n";
#print join "\n", @collectionArray,"\n";

for($i = 0;$i< @collectionArray;$i++) {
	if($collectionArray[$i] !~ /^\s*$/) {
		#print "$collectionArray[$i]\n";
		undef @ids;undef $id;
		@ids = split(/\;/, $collectionArray[$i]);
		undef $uniqueIds;
		undef %tempHash;
		
		foreach $id(@ids) {
			if(!exists $tempHash{$id}) {
				$uniqueIds = $uniqueIds.";".$id;
			}
			$tempHash{$id}++;
		}
		$uniqueIds =~ s/^\;//;
		#print "$uniqueIds\n";
		push(@myCopyArray, $uniqueIds);
	}
}


#print "The final array\n";
#print join "\n", @myCopyArray,"\n";

#for($i = 0;$i < @myCopyArray;$i++) {
#}



undef %entityIdCorefId;

for($i = 0;$i < @myCopyArray;$i++) {
	undef @tempArra;

	@tempArra = split(/\;/,$myCopyArray[$i]);

	foreach $tA (@tempArra) {
		if(!exists $entityIdCorefId{$tA}) {
			$entityIdCorefId{$tA} = $i;
		}else{
			print STDERR "there is some error\n";
		}
		$entityIdCorefId{$tA}++;
	}
}


#foreach $tA (keys%entityIdCorefId) {
#	print "$tA -> $entityIdCorefId{$tA}\n";
#}

undef %corefElementsAll;

foreach $tA (keys%entityIdCorefId) {
	#print "$tA -> $entityIdCorefId{$tA}\n";

	undef $corefId; 
	$corefId = $entityIdCorefId{$tA};

	for($i = 0;$i< @fileContent;$i++) {
        	for($j = 0; $j < @{$fileContent[$i]};$j++) {
			if($fileContent[$i][$j] =~ /$tA/) {
				undef $neeeR;
				undef @colwiseA;
				@colwiseA = split(/\s+/,$fileContent[$i][$j]);
			
				$position = $colwiseA[1]."\_".$colwiseA[2];	
				$neeeR = $position."\_".$colwiseA[3];
				if($fileContent[$i][$j] =~ /\-$/) {
					$fileContent[$i][$j] =~ s/\-$/B\-$corefId/;
				}else{
					$fileContent[$i][$j] = $fileContent[$i][$j].";B\-$corefId";
				}

				$itA = $tA;
				$itA =~ s/B\-/I\-/;

				$true = 1;
				$d = $j;
				$d++;
				while($true) {
					if($fileContent[$i][$d] =~ /$itA/) {
						undef @colwiseA;
						@colwiseA = split(/\s+/,$fileContent[$i][$d]);
						
						$neeeR = $neeeR."_".$colwiseA[3];

						
						if($fileContent[$i][$d] =~ /\-$/) {
							$fileContent[$i][$d] =~ s/\-$/I\-$corefId/;
						}else{
							$fileContent[$i][$d] = $fileContent[$i][$d].";I\-$corefId";
						}
						$d++;
					}else{
						$true = 0;
					}
				}
				
				if(exists $corefElementsAll{$corefId}) {
					$corefElementsAll{$corefId} = $corefElementsAll{$corefId}.";".$neeeR;
				}else{
					$corefElementsAll{$corefId} = $neeeR;
				}	
			}
		}
	}
}

foreach $kkk123 (keys%corefElementsAll) {
	@corefElementss = split(/\;/,$corefElementsAll{$kkk123});

	undef %corefElementssHash;
	#print join "\n", @corefElementss,"\n";

	foreach $kk123 (@corefElementss) {
		$len123 = length($kk123); 
		$corefElementssHash{$kk123} = $len123;
	}

	foreach $k123 (sort{$corefElementssHash{$b} <=>$corefElementssHash{$a}} keys%corefElementssHash) {
		print STDERR "$k123\n";
	}
	print STDERR "\n";
}



for($i = 0;$i< @fileContent;$i++) {
       	for($j = 0; $j < @{$fileContent[$i]};$j++) {
		$fileContent[$i][$j] =~ s/\s*$//;

		@temp = split(/\s+/,$fileContent[$i][$j]);

		$corefId = pop(@temp);
		if($corefId =~ /\;/) {
			#print "$fileContent[$i][$j]\n";
			undef $uniqueCorefId;

			@corefIds = split(/\;/,$corefId);
			undef %tempHash;

			foreach $idd (@corefIds) {
				if(!exists $tempHash{$idd}) {
					$uniqueCorefId = $uniqueCorefId.";".$idd;
				}
				$tempHash{$idd}++;
			}
			$uniqueCorefId =~ s/^\;//;
			push(@temp,$uniqueCorefId);

			$newLine = join "   ", @temp;
			$newLine =~ s/^\s*//;
			$newLine =~ s/\s*$//;
			print "$newLine\n";
		}else{
			print "$fileContent[$i][$j]\n";
		}
	}
	print "\n";
}


