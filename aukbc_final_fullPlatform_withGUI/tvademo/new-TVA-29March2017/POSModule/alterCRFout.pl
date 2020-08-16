#!/usr/bin/perl

undef @array;

while(<>) {
	chomp;
	
	next if($_ =~ /^\#/);

	if($_ =~ /^\s*$/) {
		process(@array);
		undef @array;
	}else{
		push(@array,$_);
	}
}

sub process {

	#print join "\n", @array,"~~~~~~~~~~~~~~~~~~~~~~\n";
	foreach $k (@array) {
		#print "$k\n";
		@temp = split(/\s+/,$k);

		undef %hashScore;

		foreach $kk (@temp) {
			if($kk =~ /(.+)\/(\d+\.\d+)/) {
				$tag = $1;
				$score = $2;
				$hashScore{$tag} = $score; 
			}
		}

		undef @tempArra;
		@tempArra = sort{$hashScore{$b}<=>$hashScore{$a}} keys%hashScore;

		$tag1 = $tempArra[0];
		$tag2 = $tempArra[1];

		undef $finaltag;
		
		if(($tag1 =~ /^N\_NN$/) && ($tag2 =~ /^N\_NNP$/) && ($hashScore{$tag1} < 0.85)) {
			$finaltag = $tag2;
		}else{
			$finaltag = $tag1;
		}


		undef $newLine;
		for($i = 0;$i <=15;$i++) {
			$newLine = $newLine."\t".$temp[$i];
		}
		$newLine =~ s/^\t//;

		print "$newLine\t$finaltag\n";
	}
	print "\n";
}
