#!/usr/bin/perl

undef @fullArray;
undef @array;
$eventFlag = 0;
undef $eventSentence;

while(<>) {
	chomp;

	if($_ =~ /^\s*$/) {
		
		$line = join "L_END", @array;

		if(($line =~ /EVENTSTART/) && ($line =~ /EVENTEND/)) {
			$eventSentence = $line;
			$eventFlag = 1;
			last;
		}
		push(@fullArray,$line);
		undef @array;
	}else{
		push(@array,$_);
	}
}
if($eventFlag == 0) {
#print "$eventSentence\n";
#}else{
#look for sentence withEventTrigger
	for($j = 0;$j< 5;$j++) {
		if($fullArray[$j] =~/\tB\-T\t/) {
			$eventSentence = $fullArray[$j];
                        $eventFlag = 1;
			last;
		}
	}
}

if($eventFlag == 0) {
	foreach $kk2 (@fullArray) {
		if($kk2 =~ /EVENTSTART/) {
			$eventSentence = $kk2;
			$eventFlag = 1;
			last;
		}
	}
}

if($eventFlag == 0) {
	foreach $kk2 (@fullArray) {
		if($kk2 =~ /EVENTEND/) {
			$eventSentence = $kk2;
			$eventFlag = 1;
			last;
		}
	}	
}

undef $eventSent;

if($eventFlag == 0) {
	$eventSentence = $fullArray[0];
	$eventFlag = 1;
}

if($eventFlag == 1) {
	#print "$eventSentence\n";
	@tempEventSent = split(/L_END/,$eventSentence);

	foreach $kk (@tempEventSent) {
		@temmmp = split(/\t/,$kk);
		$eventSent = $eventSent." ".$temmmp[0];
	}
	$eventSent =~ s/^\s+//;
	print "$eventSent\n";
}
