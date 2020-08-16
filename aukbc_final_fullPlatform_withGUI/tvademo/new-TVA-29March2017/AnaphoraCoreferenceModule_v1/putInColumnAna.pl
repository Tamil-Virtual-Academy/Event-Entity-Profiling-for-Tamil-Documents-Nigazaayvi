#!/usr/bin/perl

$count = 0;

while(<>) {
	chomp;

	if($_ =~ /^\s*$/) {
		process(@array);
		undef @array;
	}else{
		push(@array,$_);
	}
}


sub process {
	$startF = 0;
	for($i = 0;$i < @array;$i++) {
		$ar = $array[$i];
		@tempA = split(/\s+/,$ar);
		if($tempA[9] =~ /B\-/) { 
			if($startF == 1) {
				print " <\/$tag> ";
				undef $tag;
			}
			$tag = generateTag($tempA[9],$tempA[1],$tempA[2]);
			#print " <$tag> ";
			print " &lt;$tag&gt;";
			$startF = 1;
		}

		print "<iitk>$tempA[3]<\/iitk> ";
		#print "$tempA[3] ";

		@tempA1 = split(/\s+/,$array[$i+1]);

		if(($tempA1[9] =~ /B\-/) || ($tempA1[9] =~ /^\-$/) ) {
			if($startF == 1) {
				print " &lt;\/$tag&gt; ";
				undef $tag;	
				$startF = 0;
			}
		}
	}
	print "<br>\n";
}

#foreach $kk (keys%counterHash) {
#	print "$kk => $counterHash{$kk}\n";
#}

sub generateTag {
	$posS = $_[1];
	$posW = $_[2];

	$tempTag = $_[0];
	$origTag = $tempTag;

	$tempTag = $tempTag.";" if($tempTag !~ /\;$/);

	$cptempTag = $tempTag;


	while($tempTag =~ /B\-(\d+\.\d+)\;/g) {
		$ind = $1; 
		if(!exists $counterHash{$ind}) {
			$counterHash{$ind} = $count;
			$count++;
		}
	}

	while($tempTag =~ /B\-$posS\.$posW\;/g) {
		$cptempTag =~ s/B\-($posS\.$posW)\;/ana\_$1\;/;
	}
	
	$tempTag = $cptempTag;

	while($tempTag =~ /B\-(\d+\.\d+);/g) {
		$index = $1;
		$cptempTag =~ s/B\-$index\;/ante\_$index\;/;
	}
	#$cptempTag =~ s/\;$//;

	#print "\n~!~!~ $origTag -- $cptempTag\n";

	$ccptempTag = $cptempTag;

	while($cptempTag =~ /\_(\d+\.\d+)\;/g) {
		$indd = $1;
		$ccptempTag =~ s/$indd/$counterHash{$indd}/;
	}
	#print "~~~~ $ccptempTag\n\n";

	$ccptempTag =~ s/\;$//;

	return($ccptempTag);
}
