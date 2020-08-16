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
		if($ll == 9) { $fileContent[$sentId][$wordId] = $fileContent[$sentId][$wordId]." -";}
		#print "$ll ~~~ $fileContent[$sentId][$wordId]\n";
                $wordId++;
        }
}
close(RE);

undef @tempArra;

open(RE,"$ARGV[1]");
while(<RE>) {
	chomp;

	next if($_ =~ /^\s*$/);

	if($_ =~ /\_\_\_\_\_\_+/) {
		process(@tempArra);
		undef @tempArra;
	}else{
		push(@tempArra,$_);
	}
}
close(RE);

for($i = 0;$i< @fileContent;$i++) {
        for($j = 0; $j < @{$fileContent[$i]};$j++) {
		@ttt = split(/\s+/,$fileContent[$i][$j]);
		$ll = @ttt;
		#print "$ll\n";
		print "$fileContent[$i][$j]\n";
		#print "~3~ $fileContent[$i][$j]\n";
	}
	print "\n";
}

sub process {
	($ana,$ante) = @_;

	#print "Anaphor: $ana\n";
	#print "Ante: $ante\n\n";
		
	if($ante !~ /^\s*$/) {
		@tempAna = split(/\t/,$ana);
		$tempAna[0] =~ s/Pronoun\:\s*//;
		#print "~~~ $tempAna[0] --- $tempAna[1]\n";
		
		@ttt = split(/\s+/,$fileContent[$tempAna[0]][$tempAna[1]]);
		$ll = @ttt;

		$key = "B-$tempAna[0]\.$tempAna[1]";

		#print "$fileContent[$tempAna[0]][$tempAna[1]]\n";

		if( $fileContent[$tempAna[0]][$tempAna[1]] =~ /\-$/) {
			$fileContent[$tempAna[0]][$tempAna[1]] =~s/\-$/$key/;
		}else {
			$fileContent[$tempAna[0]][$tempAna[1]] = $fileContent[$tempAna[0]][$tempAna[1]].";$key";
		}

		#tag antecedent
		undef @wordsArray;
		@wordsArray = split(/<delim>/,$ante);

		foreach $wrdInfo (@wordsArray) {
			@wrdInfoArra = split(/\t/,$wrdInfo);

			@ttt = split(/\s+/, $fileContent[$wrdInfoArra[0]][$wrdInfoArra[1]]);
			$ll = @ttt;

			
			if( $fileContent[$wrdInfoArra[0]][$wrdInfoArra[1]] =~ /\-$/) {
				$fileContent[$wrdInfoArra[0]][$wrdInfoArra[1]] =~ s/\-$/$key/;
			}else{
				$fileContent[$wrdInfoArra[0]][$wrdInfoArra[1]] = $fileContent[$wrdInfoArra[0]][$wrdInfoArra[1]].";$key";
			}
			$key =~ s/B\-/I\-/;
			#print "$fileContent[$wrdInfoArra[0]][$wrdInfoArra[1]]\n";
		}
		#print "\n";
	}
}
