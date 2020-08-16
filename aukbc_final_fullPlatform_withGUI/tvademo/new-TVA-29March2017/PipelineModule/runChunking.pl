#!/usr/bin/perl


$morph_Out=`sh runChunking.sh $ARGV[0]`;

undef @tempArr;
##Read Chunk Output File
open(RD,"/home/nlp/apache-tomcat-8.5.23//webapps/tvademo/new-TVA-29March2017/ChunkerModule/Chunk_output.txt");
while(<RD>){
        chomp;
        push(@tempArr,$_);
}
close(RD);
	
##write to HTML file
open(HR,">/home/nlp/apache-tomcat-8.5.23//webapps/tvademo/Chunk_Output.html");
print HR "<html>\n";
print HR "<head><title>Event - Entity Profiling System<\/title><\/head>\n";
	#print HR "<link rel=\"stylesheet\" type=\"text/css\" href=\"simple.css\"/>\n";
print HR "<body>\n";
##print HR "<table>\n";
###print HR "<tr>\n";
####print HR "<td align=\"left\"><img src=\"cwhome.jpeg\" height=\"150\" width=\"120\"><\/td>\n";
####print HR "<td align=\"center\" width=\"1050\">\n";
####print HR "<font size=\"5\">Tamil Syntactic - Semantic Processing Bench<\/font><br>\n";
####print HR "<font size=\"3\"><b>(Project funded by Tamil Virtual Academy)<\/b><br><\/font>\n";
####print HR "<font size=\"5\"><b>கணினி மொழியியல் ஆராய்ச்சிக் குழு<\/b><br><\/font>\n";
####print HR "<b>Computational Linguistics Research Group,<\/b><br>\n";
###print HR "<b>AU-KBC Research Centre</b><\/font><br>\n";
####print HR "<\/td>\n";
###print HR "<td align=\"right\"><img src=\"AnnaLogo3.png\" height=\"150\" width=\"120\"><\/td>\n";
###print HR "<\/tr>";
###print HR "<\/table>\n";
###print HR "<hr>\n";

#$morph_Out =~ s/\n/<br>\n/g;
#$morph_Out =~ s/\s/&nbsp;/g;


print HR "<table>\n";
print HR "<tr><td><b>Word<\/b><\/td><td><b>POS<\/b><\/td><td><b>Chunk<\/b><\/td><td><b>Morph-Analysis<\/b><\/td><\/tr>\n";
foreach $lineO (@tempArr) {
	if($lineO =~ /^\s*$/) {print HR "<tr><br><\/tr>\n";next;}
	@tempA1 = split(/\t/,$lineO);

	print HR "<tr>\n";
	foreach $ele (@tempA1) {print HR "<td>$ele<\/td>";}
	print HR "<\/tr>\n";
}
print HR "<\/table>\n";

print HR "<\/body><\/html>\n";
close(HR);
