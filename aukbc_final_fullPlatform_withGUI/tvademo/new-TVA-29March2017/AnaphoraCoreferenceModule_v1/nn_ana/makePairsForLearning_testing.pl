#!/usr/bin/perl

while(<>) {
	chomp;
	push(@mentionArray,$_);
}

undef @readAbleArray;
undef @MreadAbleArray;

for($ii = 0;$ii < @mentionArray;$ii++) {
	#for($jj = 0;$jj < @mentionArray;$jj++) {
	$startFlag = 0;
	for($jj = 0;$jj < $ii;$jj++) {
		next if($ii == $jj);
		if($ii > $jj) {
			compareMentions($mentionArray[$ii],$mentionArray[$jj]);
		}
	}
}

#$l99 = @MreadAbleArray;
#$l88 = @readAbleArray;

#print "$l99 --- $l88\n";

open(WR,">CRF_input.txt");
#foreach $arrNN (@MreadAbleArray) {
for($ijk89 = 0;$ijk89 < @MreadAbleArray;$ijk89++) {
	@temp123 = split(/\s+/,$MreadAbleArray[$ijk89]);
	
	$l000 = @temp123;
	if($l000 == 14) {
		print WR "$MreadAbleArray[$ijk89]\t$ijk89\n\n";
		#print STDERR "$MreadAbleArray[$ijk89]\t$ijk89\n";
	}else{
		spice(@readAbleArray, $ijk89, 1);
	}
}

#$l88 = @readAbleArray;
#print "$l88 --- I came here\n";

#run CRF
$n_n_output = `crf_test -m nn_ana/n_n_model_big CRF_input.txt`;

$n_n_output =~ s/\n\n/\n/g;

#print "$n_n_output\n";
@crf_output  = split(/\n/, $n_n_output);

#$l333 = @MreadAbleArray;
#$l444 = @crf_output;

#print "$l333 -- $l444\n";

undef @newArray;
foreach $crf_o (@crf_output) {
	if($crf_o =~ /^\s*$/) {next;}
	#rint "$crf_o\n";
	push(@newArray,$crf_o);
}

#$l111 = @readAbleArray;
#$l222 = @newArray;

#print "$l111 -- $l222\n";

for($ijk45 = 0;$ijk45 < @newArray;$ijk45++) {
	if($newArray[$ijk45] =~ /\tyes$/) {
		print "$readAbleArray[$ijk45]\n";
		print "$newArray[$ijk45]\n\n";
	}
}


sub compareMentions {
	($ana1,$ante1) = @_;

	#print "$ana1 --- $ante1\n";
	@tempAna1 = split(/\t/,$ana1);
	@tempAnte1 = split(/\t/,$ante1);

	#print join "\t", @tempAna1,"\n";
	#print join "\t", @tempAnte1,"\n\n";

	$matchStatus = "no";
	$matchStatus = check4MatchStatus($tempAna1[10],$tempAnte1[10]);

	if($matchStatus eq "yes") {$startFlag = 1;}

	$gender_match = check4GenderMatch($tempAna1[7],$tempAnte1[7]);

	if($tempAna1[2] eq $tempAnte1[2]) {$complete_match = "yes"}else{$complete_match = "no";}
	if($tempAna1[3] eq $tempAnte1[3]) {$head_match = "yes"}else{$head_match = "no";}
	if($tempAna1[0] == $tempAnte1[0]) {$sameSentence = "yes"; $distance = "0";}else{
		$sameSentence ="no";
		$distance = $tempAna1[0] - $tempAnte1[0];
	}
	#$matchPercentage = check4MatchPercentage($tempAna1[2],$tempAnte1[2]);

	#if($startFlag == 1) {
		#print join "~~", @tempAna1,"\n";
		#print join "~~", @tempAnte1,"\n";

		$line = "$tempAna1[2]\t$tempAna1[3]\t$tempAna1[4]\t$tempAna1[5]\t$tempAnte1[2]\t$tempAnte1[3]\t$tempAnte1[4]\t$tempAnte1[5]\t$gender_match\t$complete_match\t$head_match\t$sameSentence\t$distance\t$matchStatus";

		@dummyArr = split(/\t+/,$line);

		$line4ReadAble = $ana1."<dim>$ante1";

		if(@dummyArr == 14) {
			push(@readAbleArray,$line4ReadAble);
			push(@MreadAbleArray,$line);
		}
}

sub check4GenderMatch {
	my ($details1, $details2) = @_;

	$match_gender = "no";

	if(($details1 =~ /[mf]/) || ($details1 =~ /[mf]/)) {
		if($details1 eq $details2) {
			$match_gender = "yes";
		}elsif(($details1 eq "mf") && ($details2 =~ /[mf]/)) {
			$match_gender = "yes";	
		}elsif(($details2 eq "mf") && ($details1 =~ /[mf]/)) {
			$match_gender = "yes";	
		}else{
			$match_gender =  "no";
		}
	}else{
		$match_gender = "no";
	}
	return($match_gender);
}

sub check4MatchStatus {
	my ($details1, $details2) = @_;
	my $status = "no";

	if(($details1 =~ /^\-$/) || ($details2 =~ /^\-$/)) {
		return($status);
	}
	#print "$details1 --- $details2\n";

	$details2 = $details2.";";

	@arrayRef = split(/\;/,$details1);

	foreach $ar (@arrayRef) {
		#print "$ar -- $details2\n";
		if($details2 =~ /\Q$ar\E\;/) {$status = "yes";}
	}
	return($status);
}

