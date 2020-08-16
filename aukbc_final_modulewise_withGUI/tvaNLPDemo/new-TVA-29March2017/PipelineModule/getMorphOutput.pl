#!/usr/bin/perl

@files = glob("$ARGV[0]/*preprocessed");

foreach $file (@files) {
	#print "$file\n";

	open(RE,"$file");
	while(<RE>) {
		chomp;
		 next if($_ =~ /^\s*$/);

		@temp = split(/\s+/,$_);
		if($temp[6] =~ /\,N\,/) {
			@tempMore = split(/\,/,$temp[6]);

			print "$tempMore[0]\n";
		}
	}
	close(RE);
}
