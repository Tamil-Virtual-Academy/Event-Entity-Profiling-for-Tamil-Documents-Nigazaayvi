#!/usr/bin/perl

undef @arrayOne;
undef @arrayTwo;

while(<>) {
	chomp;

	if($_ =~ /^\s*$/) {
		process(@array);
		undef @array;
	}else{
		push(@array,$_);
	}
}


if(@arrayTwo ne undef) {

	#print "Hai\n";
	open(WR,">testDD.txt");
	foreach $arrT (@arrayTwo) {
		print WR "$arrT\n";
	}
	close(WR);

	#run CRFs 
	#$outputt = `crf_test -m DDEngine/dd_model testDD.txt`;
	$outputt = `crf_test -m DDEngine/dd_model_new testDD.txt`;
	#print "$outputt\n";
	undef @outputLines;
	@outputLines = split(/\n/,$outputt);

	for($iii = 0;$iii < @outputLines;$iii++) {
		if($outputLines[$iii] =~ /yes$/i) {
			print "$arrayOne[$iii]\n";
			print "$arrayTwo[$iii]\n\n";
		}
	}
}else{
	print "";
}

sub process {
	my @newSent = @_;

	$chunkPattern = "";	
	for($i = 0;$i < @newSent;$i++) {
		@temp = split(/\s+/,$newSent[$i]);
		$chunkPattern = $chunkPattern.";".$temp[5];
	}
	$chunkPattern =~ s/^;//;
	#print "$chunkPattern\n";

	while($chunkPattern =~ /B\-NP\;(I\-NP;)*B\-NP\;(I\-NP\;)*/g) {
		$matched = $&;
		$precedingS = $`;
		$followingS = $';

		@precedingArray = split(/\;/,$precedingS);
		@followingArray = split(/\;/,$followingS);
		@matchedArray = split(/\;/,$matched);

		$matchedLen = @matchedArray;
		$precedingLen = @precedingArray;
		$followingLen = @followingArray;

		$limit = $precedingLen + $matchedLen;		
		$firstNP = $precedingLen;

		for($i = $precedingLen+1;$i < $limit;$i++) {if($newSent[$i] =~ /B\-NP/) {$secondNP = $i;last;}}
		$secondNP_NNP = 0;
		if($newSent[$secondNP] =~ /NNP/) {$secondNP_NNP = 1;}

		if($secondNP_NNP == 1) {
			$firstNP_lastWrd = "";
			$firstNP_lastWrd_pos = "";

			@temppA = split(/\s+/,$newSent[$secondNP-1]);

			#print "$newSent[$secondNP-1]\n";

			$firstNP_lastWrd = $temppA[3];
			$firstNP_lastWrd_pos = $temppA[4];

			$firstNP_case = "-";
			if($firstNP_lastWrd =~ /[a-z]+/) {$firstNP_case = getPNGInfo($temppA[6]);}
	
			if($precedingLen -2 >= 0) {
				@temppAP2 = split(/\s+/,$newSent[$precedingLen-2]);
				$np1_p2_pos = $temppAP2[4];
			}else{
				$np1_p2_pos = "-";;
			}

			if($precedingLen -1 >= 0) {
				@temppAP1 = split(/\s+/,$newSent[$precedingLen-1]);
				$np1_p1_pos = $temppAP1[4];
			}else{
				$np1_p1_pos = "-";
			}
		
			@temppB = split(/\s+/,$newSent[$limit-1]);
			$temppBF1_4 = "-"; 
			if($limit < @newSent) {
				@temppBF1 = split(/\s+/,$newSent[$limit]);	
				$temppBF1_4 = $temppBF1[4];
			}

			$temppBF2_4 = "-"; 
			if($limit+1 < @newSent) {
				@temppBF2 = split(/\s+/,$newSent[$limit+1]);
				$temppBF2_4 = $temppBF2[4];
			}

			@secondNPArray = split(/\s+/,$newSent[$secondNP]);
			#print "$newSent[$secondNP] -- $secondNPArray[7]\n";
			$np2_neF = 0;
			$np2_ne = "-";
		
			$ddFlag = "no";
			$np1NotWrd = "1";
			if($firstNP_lastWrd =~ /[a-z]+/) {$np1NotWrd = 0;}

			if($newSent[$secondNP-1] =~ /DEFINITE\-DESCRIPTION/) {$ddFlag = "yes";}
		
			if($secondNPArray[7] =~ /[BI]\-/) {$np2_neF = 1;$np2_ne = $secondNPArray[7];}

			if($temppB[3] !~ /[a-z\.]+/ ) {
				$np2_f1_pos = $temppB[4];
				$np2_f2_pos = $temppBF1_4;
			}else{
				$np2_f1_pos = $temppBF1_4;
				$np2_f2_pos = $temppBF2_4;
			}


			undef $np1_details;
			for($ijk = $precedingLen;$ijk < $secondNP;$ijk++) {
				@tempQAZ = split(/\s+/,$newSent[$ijk]);
				if($ijk == $precedingLen) {
					$np1_details = "$tempQAZ[1]\t$tempQAZ[2]\t$tempQAZ[3]";
				}else{
					$np1_details = $np1_details."\_$tempQAZ[3]";
				}
			}
			#print "NP1 details -- $np1_details\n";

			undef $np2_details;
			for($ijk = $secondNP;$ijk < $limit;$ijk++) {
				@tempQAZ = split(/\s+/,$newSent[$ijk]);
				if($ijk == $secondNP) {
					$np2_details = "$tempQAZ[1]\t$tempQAZ[2]\t$tempQAZ[3]";
				}else{
					$np2_details = $np2_details."\_$tempQAZ[3]";
				}
			}
			#rint "NP2 details -- $np2_details\n";

			$lineOne = $np2_details."<dim>".$np1_details;

			$total = $matchedLen + $precedingLen + $followingLen;

			$lineTwo = "$firstNP_lastWrd\t$firstNP_lastWrd_pos\t$firstNP_case\t$np1_p1_pos\t$np1_p2_pos\t$np2_neF\t$np2_ne\t$np2_f1_pos\t$np2_f2_pos\t$np1NotWrd\t$ddFlag";
			#print "$matchedLen -- $precedingLen -- $followingLen -- $total\n";
			#print "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n";

			@fmArra = split(/\t/,$lineTwo);
			$lenOfEle = @fmArra;
			
			if($lenOfEle == 11) {
				#rint "$lineOne\n$lineTwo\n\n";
				push(@arrayOne,$lineOne);
				push(@arrayTwo,$lineTwo);
			}
		}
	}
}

sub getPNGInfo {
        my $tempMorph1 = $_[0];

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

        return($temp_case);
}
