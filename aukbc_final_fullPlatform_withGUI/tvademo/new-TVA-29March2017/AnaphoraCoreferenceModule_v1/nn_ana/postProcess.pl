#!/usr/bin/perl

undef @array;
while(<>) {
	chomp;

	if($_ =~ /^\s*$/) {
		@changedArray = process(@array);
		undef @array;

		if($changedArray[1] =~ /\s+yes$/) {
			print join "\n", @changedArray,"\n";
		}
		undef @changedArray;
	}else{
		push(@array, $_);
	}
}

sub process {
	my @newArray = @_;

		@tempArra = split(/<dim>/,$newArray[0]);
 
		@tempPart1 = split(/\s+/,$tempArra[0]);
		@tempPart2 = split(/\s+/,$tempArra[1]);

		#if last word of both the NP matches 
	if($newArray[1]  =~ /\s+yes$/) {
		if($tempPart1[3] eq $tempPart2[3]) {
			if(($tempPart1[2] =~ /\_/) && ($tempPart2[2] =~ /\_/)) {
				#print join "\n", @tempArra, "\n";
				@word1 = split(/\_/,$tempPart1[2]);
				@word2 = split(/\_/,$tempPart2[2]);

				if($word1[0] ne $word2[0]) {
					$newArray[1]  =~ s/\s+yes$/\tno/;
				}
			}
		}
	}elsif($newArray[1]  =~ /\s+no$/) {
		if($tempPart1[3] ne $tempPart2[3]) {
			@word1 = split(/\_/,$tempPart1[2]);
			@word2 = split(/\_/,$tempPart2[2]);

			if($word1[0] eq $word2[0]) {
				$newArray[1]  =~ s/\s+no$/\tyes/;
			}
		}
	}
	return(@newArray);
}
