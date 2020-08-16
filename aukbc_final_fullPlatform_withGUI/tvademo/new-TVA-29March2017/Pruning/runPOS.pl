#!/usr/bin/perl



undef @tempArr;
##Read POS Prune Output File
open(RD,"/home/nlp/apache-tomcat-8.5.23//webapps/tvademo/new-TVA-29March2017/Pruning/prune_output.txt");
while(<RD>){
        chomp;
        push(@tempArr,$_);
}
close(RD);

	
##write to HTML file
open(HR,">/home/nlp/apache-tomcat-8.5.23//webapps/tvademo/POS_Output.html");
print HR "<html>\n";
print HR "<meta http-equiv=\"Content-Type\" content=\"text\/html; charset=utf-8\">\n";
print HR "<head><title>Event - Entity Profiling System<\/title><\/head>\n";
print HR "<body>\n";

#$morph_Out =~ s/\n/<br>\n/g;
#$morph_Out =~ s/\s/&nbsp;/g;


###print HR "<table>\n";
##print HR "<tr><td><b>Word<\/b><\/td><td><b>POS<\/b><\/td><td><b>Morph-Analysis<\/b><\/td><\/tr>\n";
foreach $lineO (@tempArr) {
	if($lineO =~ /^\s*$/) {
		###print HR "<tr><br><\/tr>\n";next;
		print HR "<br>\n";next;
	}
	@tempA1 = split(/\t/,$lineO);

	####print HR "<tr>\n";
	##foreach $ele (@tempA1) {
		##print HR "<td>$ele<\/td>";
	 
	##}
	print HR "$tempA1[0]\/$tempA1[1] &nbsp\;&nbsp\;\n";
	####print HR "<\/tr>\n";
}
##print HR "<\/table>\n";

print HR "<\/body><\/html>\n";
close(HR);
