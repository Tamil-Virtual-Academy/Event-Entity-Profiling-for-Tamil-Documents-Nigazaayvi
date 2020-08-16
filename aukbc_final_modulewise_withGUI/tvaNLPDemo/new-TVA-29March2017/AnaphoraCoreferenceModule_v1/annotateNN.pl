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
		if($ll == 10) { $fileContent[$sentId][$wordId] = $fileContent[$sentId][$wordId]." -";}
		#print "$ll ~~~ $fileContent[$sentId][$wordId]\n";
                $wordId++;
        }
}
close(RE);

undef @tempArra;

open(RE,"$ARGV[1]");
while(<RE>) {
	chomp;

	 if($_ =~ /^\s*$/){
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
		$nnInfo = pop(@ttt);
		
		if($nnInfo =~ /\;/) {
			undef @nnArray;
			undef %nnHash;

			@nnArray = split(/\;/,$nnInfo);

			foreach $nnI (@nnArray) {
				$nnHash{$nnI}++;
			}

			$new_nnInfo = join "\;", keys%nnHash;

			$new_nnInfo =~ s/^\;//;
			$new_nnInfo =~ s/\;$//;

			push(@ttt, $new_nnInfo);
		}else{
			push(@ttt, $nnInfo);	
		}
		$newLine = join "   ", @ttt;
		print "$newLine\n";
	}
	print "\n";
}


sub process {
	($readableLine,$m_readableline) = @_;

	#print "Anaphor: $ana\n";
	#print "Ante: $ante\n\n";

	($anaphorNP,$anteNP) = split(/<dim>/,$readableLine);

	@anaNPs = split(/\s+/,$anaphorNP);
	@anteNPs = split(/\s+/,$anteNP);	

	#print  "$anaNPs[0]\-$anaNPs[1]\-$anaNPs[2]\n";	
	#print  "$anteNPs[0]\-$anteNPs[1]\-$anteNPs[2]\n\n";	

	$key = "B\-$anaNPs[0]\.$anaNPs[1]";

	@wordAnnaArray = split(/\_/,$anaNPs[2]);
	$l1 = @wordAnnaArray;
	@wordAnteArray = split(/\_/,$anteNPs[2]);
	$l2 = @wordAnteArray;


	$limit = $anaNPs[1]+$l1;
	for($ijk = $anaNPs[1]; $ijk < $limit;$ijk++) {
		if($fileContent[$anaNPs[0]][$ijk] =~ /\-$/) {
			$fileContent[$anaNPs[0]][$ijk] =~ s/\-$/$key/;
			#print "~~ $fileContent[$anaNPs[0]][$ijk]\n";
		}else{
			$fileContent[$anaNPs[0]][$ijk] = $fileContent[$anaNPs[0]][$ijk].";$key";
			#print "~~ $fileContent[$anaNPs[0]][$ijk]\n";
		} 
		$key =~ s/B\-/I\-/;
	}

	$key =~ s/I\-/B\-/;
        $limit = $anteNPs[1]+$l2;
        for($ijk = $anteNPs[1]; $ijk < $limit;$ijk++) {
		#print "$anteNPs[0] --- $ijk\n";
                if($fileContent[$anteNPs[0]][$ijk] =~ /\-$/) {
                        $fileContent[$anteNPs[0]][$ijk] =~ s/\-$/$key/;
                        #print "# $fileContent[$anteNPs[0]][$ijk]\n";
                }else{
                        $fileContent[$anteNPs[0]][$ijk] = $fileContent[$anteNPs[0]][$ijk].";$key";
			#print "# $fileContent[$anteNPs[0]][$ijk]\n";
                }       
                $key =~ s/B\-/I\-/;
        }
	#print "~~~~~~~~~~~~~~~\n";
}
