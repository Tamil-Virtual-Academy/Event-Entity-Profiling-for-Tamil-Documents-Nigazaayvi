#!/usr/bin/perl

undef @tempArr;
##Read Anaphora Output File
open(RD,"/home/nlp/apache-tomcat-8.5.23//webapps/tvademo/new-TVA-29March2017/AnaphoraCoreferenceModule_v1/anaphora_resolveOut.txt");
while(<RD>){
        chomp;
        push(@tempArr,$_);
}
close(RD);


	
##write to HTML file
open(HR,">/home/nlp/apache-tomcat-8.5.23//webapps/tvademo/Anaphora_Output.html");
print HR "<html>\n";
print HR "<meta http-equiv=\"Content-Type\" content=\"text\/html; charset=utf-8\">\n";
print HR "<head><title>Event - Entity Profiling System<\/title><\/head>\n";
print HR "<body>\n";
print HR "<P align=\"left\"><b>Pn-AR: Pronominal Anaphora Resolution<\/b> <\/P>";
print HR "<P align=\"left\"><b>N-N_AR: Noun Noun Anaphora Resolution <\/b><\/P>";
print HR "<table>\n";
print HR "<tr><td><b>Word<\/b><\/td><td><b>POS<\/b><\/td><td><b>Chunk<\/b><\/td><td><b>Morph-Analysis<\/b><\/td><td><b>NETag<\/b><\/td><td><b>ClauseTag<\/b><\/td><td><b>Pn-AR<\/b><\/td><td><b>N-N_AR<\/b><\/td><\/tr>\n";

foreach $lineO (@tempArr) {
	if($lineO =~ /^\s*$/) {print HR "<tr><br><\/tr>\n";next;}
	@tempA1 = split(/\s+/,$lineO);

	print HR "<tr>\n";
	shift @tempA1;
	shift @tempA1;
	shift @tempA1;
	foreach $ele (@tempA1) {print HR "<td>$ele<\/td>";}
	print HR "<\/tr>\n";
}
print HR "<\/table>\n";

print HR "<\/body><\/html>\n";
close(HR);
