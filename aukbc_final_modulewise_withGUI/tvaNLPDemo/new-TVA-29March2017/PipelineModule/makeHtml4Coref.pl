#!/ursr/bin/perl


print "<html><title><\/title><body>\n";
while(<>) {
	chomp;

	print "$_<br>";
}
close(RE);

print "<\/body><\/html>\n";
