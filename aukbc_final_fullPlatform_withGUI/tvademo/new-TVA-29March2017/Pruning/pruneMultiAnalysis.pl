#!/usr/bin/perl

undef @array;

while(<>) {
	chomp;
	
	s/^\s*//;	
	s/\s*$//;

	if($_ =~ /^\s*$/) {
		process(@array);
		undef @array;
	}else{
		push(@array,$_);
	}
}

sub process {
	@newArra = @_;

	for($i = 0;$i < @newArra;$i++) {
		@temp = split(/\t/,$newArra[$i]);
		if($temp[2] =~ /\|/) {
			#print "$temp[1] --- $temp[3]\n";
			$morphResolved = getItResolved($temp[1],$temp[2]);

			print "$temp[0]\t$temp[1]\t$morphResolved\n";
		}else{
			print "$newArra[$i]\n";
		}
	}
	print "\n";
}


sub getItResolved {
	($posTag,$maAnalysis) = @_;

	@maOut = split(/\|/,$maAnalysis);

	
	undef $selecetedAnalysis;
	if($posTag =~ /\_RP/) {
		foreach $maO (@maOut) {	if($maO =~ /\,RP/) {$selecetedAnalysis = $maO;last;}}
	}elsif($posTag =~ /\_COND/) {
		foreach $maO (@maOut) {	if($maO =~ /\,COND/) {$selecetedAnalysis = $maO;last;}}
	}elsif($posTag =~ /N\_/) {
		foreach $maO (@maOut) {	if($maO =~ /,N,/) {$selecetedAnalysis = $maO;last;}}
	}elsif($posTag =~ /RB/) {
		foreach $maO (@maOut) {	if($maO =~ /ADV/i) {$selecetedAnalysis = $maO;last;}}
		foreach $maO (@maOut) {	if($maO =~ /,N,/i) {$selecetedAnalysis = $maO;last;}}
		foreach $maO (@maOut) {	if($maO =~ /,RP-PRP/i) {$selecetedAnalysis = $maO;last;}}
	}elsif($posTag =~ /CC_CCD/) {
		foreach $maO (@maOut) {	if($maO =~ /,conj,/i) {$selecetedAnalysis = $maO;last;}}
	}elsif($posTag =~ /DM_DMQ/) {
		foreach $maO (@maOut) {	if($maO =~ /,wq,/i) {$selecetedAnalysis = $maO;last;}}
		foreach $maO (@maOut) {	if($maO =~ /,adv,/i) {$selecetedAnalysis = $maO;last;}}
		foreach $maO (@maOut) {	if($maO =~ /,n/i) {$selecetedAnalysis = $maO;last;}}
	}elsif($posTag =~ /PR/) {
		foreach $maO (@maOut) {	if($maO =~ /,PN,/i) {$selecetedAnalysis = $maO;last;}}
	}elsif($posTag =~ /JJ/) {
		foreach $maO (@maOut) {	if($maO =~ /,adj,/i) {$selecetedAnalysis = $maO;last;}}
		foreach $maO (@maOut) {	if($maO =~ /,N,/i) {$selecetedAnalysis = $maO;last;}}
	}elsif($posTag =~ /INTF/) {
		foreach $maO (@maOut) {	if($maO =~ /,INTF,/i) {$selecetedAnalysis = $maO;last;}}
		foreach $maO (@maOut) {	if($maO =~ /,adj,/i) {$selecetedAnalysis = $maO;last;}}
	}elsif($posTag =~ /QT_QTC/) {
		foreach $maO (@maOut) {	if($maO =~ /,adj,/i) {$selecetedAnalysis = $maO;last;}}
		foreach $maO (@maOut) {	if($maO =~ /,N,/i) {$selecetedAnalysis = $maO;last;}}
	}elsif($posTag =~ /QT_QTO/) {
		foreach $maO (@maOut) {	if($maO =~ /,N,/i) {$selecetedAnalysis = $maO;last;}}
		foreach $maO (@maOut) {	if($maO =~ /,adj,/i) {$selecetedAnalysis = $maO;last;}}
	}elsif($posTag =~ /PSP/) {
		foreach $maO (@maOut) {	if($maO =~ /,psp,/i) {$selecetedAnalysis = $maO;last;}}
		foreach $maO (@maOut) {	if($maO =~ /,adv,/i) {$selecetedAnalysis = $maO;last;}}
		foreach $maO (@maOut) {	if($maO =~ /,N,/i) {$selecetedAnalysis = $maO;last;}}
	}elsif($posTag =~ /VBN/) {
		foreach $maO (@maOut) {	if($maO =~ /VBP/i) {$selecetedAnalysis = $maO;last;}}
	}elsif($posTag =~ /INF/) {
		foreach $maO (@maOut) {	if($maO =~ /INF/i) {$selecetedAnalysis = $maO;last;}}
	}elsif($posTag =~ /VF/) {
		foreach $maO (@maOut) {	if(($maO =~ /V.*/i) && ($maO !~ /\,\,/) && ($maO !~ /\+RP/)){$selecetedAnalysis = $maO;last;}}
		foreach $maO (@maOut) {	if($maO =~ /,V,/i) {$selecetedAnalysis = $maO;last;}}
	}elsif($posTag =~ /RP\_NEG/) {
		foreach $maO (@maOut) {	if(($maO =~ /V.*/i) && ($maO !~ /\+RP_NEG/i)){$selecetedAnalysis = $maO;last;}}
		foreach $maO (@maOut) {	if($maO =~ /V.*/i) {$selecetedAnalysis = $maO;last;}}
	}elsif($posTag =~ /RD\-INTF/) {
		foreach $maO (@maOut) {	if($maO =~ /ADJ/i) {$selecetedAnalysis = $maO;last;}}
		foreach $maO (@maOut) {	if($maO =~ /,N,/i) {$selecetedAnalysis = $maO;last;}}
	}elsif($posTag =~ /CC\_CCS/) {
		foreach $maO (@maOut) {	if($maO =~ /conj/i) {$selecetedAnalysis = $maO;last;}}
		foreach $maO (@maOut) {	if($maO =~ /,UT,/i) {$selecetedAnalysis = $maO;last;}}
	}
	
	if($selecetedAnalysis eq undef) {
		#print "$temp[1] --- $temp[3]\n";
		#print "choosen = $selecetedAnalysis\n";
		$selecetedAnalysis = $maOut[0];
	}
	return($selecetedAnalysis);
}
