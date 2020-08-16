#!/usr/bin/perl

$count = 1;

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
		if($tempA[11] =~ /B\-/) { 
			if($startF == 1) {
				print " &lt;\/$tag&gt; ";
				undef $tag;
			}
			$tag1 = $tempA[11];

			if($tag1 =~ /B\-(\d+)/) {
				$corefId = $1; 
				if(!exists $corefId_hash{$corefId}) {
					$corefId_hash{$corefId} = $count;
					$count++;
				}
				$tag = "coref\-$corefId_hash{$corefId}";	
			}
			#$tag =~ s/^B\-/coref\-/g;

			print " &lt;$tag&gt; ";
			$startF = 1;
		}

		#print "<iitk>$tempA[3]<\/iitk> ";
		print "$tempA[3] ";

		@tempA1 = split(/\s+/,$array[$i+1]);

		if(($tempA1[11] =~ /B\-/) || ($tempA1[11] =~ /^\-$/) ) {
			if($startF == 1) {
				print " &lt;\/$tag&gt; ";
				undef $tag;	
				$startF = 0;
			}
		}
	}
	print "<br>\n";
}
