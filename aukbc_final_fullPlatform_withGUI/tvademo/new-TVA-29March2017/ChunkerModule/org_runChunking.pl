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
print HR "<meta http-equiv=\"Content-Type\" content=\"text\/html; charset=utf-8\">\n";
print HR "<head><title>Event - Entity Profiling System<\/title><\/head>\n";
print HR "<body>\n";


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
