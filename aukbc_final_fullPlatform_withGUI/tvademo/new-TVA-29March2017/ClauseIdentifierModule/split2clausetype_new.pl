#!/usr/bin/perl

while(<>) {
	chomp;
	
	if($_ eq undef) {
		process(@array);
		print "\n";
		undef @array;
		next;
	}
	
	push(@array,$_);
}

sub process {
	my @filearray1 = @_;
	#print join "\n", @filearray,"\n";
	
	($componudSent,$position) = checkForCompoundSentence(@filearray1);

	#print "$componudSent , $position\n";
	if($componudSent == 1) {
		undef @tempArray;

		for($ijk = 0;$ijk <= $position;$ijk++) {
			push(@tempArray,$filearray1[$ijk]);
		}
		#print "I am sending  part1\n";
		#print join "\n", @tempArray, "\n";

		processFurther(@tempArray);
		undef @tempArray;

		$position++;
		for($ijk = $position;$ijk < @filearray1;$ijk++) {
			push(@tempArray,$filearray1[$ijk]);
		}
		#print "I am sending  part2\n";
		processFurther(@tempArray);	
		undef @tempArray;
	}else{
		processFurther(@filearray1);
	}
}

sub checkForCompoundSentence {
	my @newArray = @_;

	$compundF = 0;

	$text = "";
	for($ii = 0;$ii < @newArray;$ii++) {
		$text = $text."###".$newArray[$ii];
	}
	
	$text =~ s/^\#\#\#//;

#	print "$text\n";

	if($text =~ /B\-VGF.*?\#\#\#\,\t/) {
		$remaining = $';
		$starting = $`;
		if($remaining =~ /B\-VGF/) {
			$startingOfRemaining = $`;
			#print "$startingOfRemaining\n";
			if($startingOfRemaining !~ /\#(eVnYrYu|eVnYa|eVnYrYAr)\t/) {
				$compundF = 1;		
				#print "I am here\n";
			}
		}
	}

	if($compundF == 1) {
		@temp4 = split(/\#\#\#/,$starting);

		$l1 = @temp4;
		if($newArray[$l1+1] =~ /\tB\-/) {
			return(1,$l1);
		}else{
			return(0,0);
		}
	}else{
		return(0,0);
	}

}


#####################################################################################

sub processFurther {
	my @filearray = @_;


	#print join "\n", @filearray,"\n";
	#print "\n";
	#check for simple Sentence
	$simpleSent = checkForSimpleSentence(@filearray);
	#print "print State =$simpleSent\n";
	if($simpleSent == 1) {
		for($i = 0;$i < @filearray;$i++) {$filearray[$i] = $filearray[$i]."\to";}
		$l = @filearray;
		$l--;
		$filearray[0] =~ s/\to$/\t{MCL}/;
		$filearray[$l] =~ s/\to$/\t{\/MCL}/;

		foreach $k(@filearray) {print "$k\n";}
	}elsif($simpleSent == 0) {
		for($i = 0;$i < @filearray;$i++) {$filearray[$i] = $filearray[$i]."\to";}
		foreach $k(@filearray) {print "$k\n";}
     }else{

	$nfcount=0;
	for($i = 0;$i < @filearray;$i++) {
		#@linarr=split(/\t/,$filearray[$i]);
		if(($filearray[$i]=~/\tV_VM_VNF_(INF|RP|COND|VBN)\t/) && ($filearray[$i+1]!~/\tV_VM_VNF/)){
			$nfcount++;
		}
		if($filearray[$i] =~ /^(eVnYrYu|eVnYa).*CC_CCS\t/) {$nfcount++;	} 
		if($filearray[$i] =~ /^(eVnYAr)\t/) {$nfcount++;	} 
	}

	#print "NFCount --- $nfcount\n";
	if($nfcount >2){
		markMCE(@filearray);
	}else{
		markSCE(@filearray);

	}
    }
}

sub checkForSimpleSentence {
	my @newFileArray = @_;
	$nfFlag = 0;
	$verbFlag = 0;
	foreach $k (@newFileArray) {
		if($k =~ /B\-VGNF/) {$nfFlag++;}
		if($k =~ /B\-VG/) {$verbFlag++;}
	}	

	if(($nfFlag == 0) && ($verbFlag == 1)) {
		return(1);
	}elsif($verbFlag == 0) {
		return(0);
	}else{
		return(2);
	}
}

sub markMCE {
	my @newFileArray = @_;

	open(WR1,">MCEClause_sents.txt");
	print WR1 join "\n", @newFileArray,"\n";
	close(WR1);

	undef @newFileArray;

	$cmd = "cp MCEClause_sents.txt qaz";system($cmd);
	$cmd = "perl createInput_prg1_testing.pl qaz > qaz_step0"; system($cmd);
	$cmd = "perl markNonfiniteMarkers_testing.pl < qaz_step0 > qaz_step1";system($cmd);
	$cmd = "crf_test -m new_model_MCE_endMarking qaz_step1 > qaz_step2";system($cmd);
	$cmd = "perl tagStarting_v1.pl qaz_step2 > qaz_step3";system($cmd);
	$cmd = "perl reconstruct.pl qaz qaz_step3 > qaz_step4";system($cmd);
	$cmd = "perl alterRP.pl qaz_step4 > qaz_out";system($cmd);

	open(RE,"qaz_out");
	while(<RE>) {chomp;
		next if($_ =~ /^\s*$/);
		print "$_\n";
	}
	close(RE);	
}

sub markSCE {

	#print "I came here tttyytjdj\n";
	my @newFileArray = @_;

	open(WR2,">SCEClause_sents.txt");
	print WR2 join "\n", @newFileArray,"\n";
	close(WR2);
	
	undef @newFileArray;

	$cmd = "cp SCEClause_sents.txt qaz";system($cmd);
	$cmd = "perl createInput_prg1_testing.pl qaz > qaz_step0"; system($cmd);
	$cmd = "perl markNonfiniteMarkers_testing.pl < qaz_step0 > qaz_step1";system($cmd);
	$cmd = "crf_test -m new_model_SCE_endMarking qaz_step1 > qaz_step2";system($cmd);
	$cmd = "perl tagStarting_v1.pl qaz_step2 > qaz_step3";system($cmd);
	$cmd = "perl reconstruct.pl qaz qaz_step3 > qaz_step4";system($cmd);
	$cmd = "perl alterRP.pl qaz_step4 > qaz_out";system($cmd);

	open(RE,"qaz_out");
	while(<RE>) {chomp;
		next if($_ =~ /^\s*$/);
		print "$_\n"; 
	}
	close(RE);
}
