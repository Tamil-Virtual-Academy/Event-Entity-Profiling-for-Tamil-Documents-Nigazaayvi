#!/usr/bin/perl

undef @tempArr;
##Read Morph Output File
open(RD,"/home/nlp/apache-tomcat-8.5.23//webapps/tvademo/new-TVA-29March2017/MorphanalyzerModule/morph_only_out.txt");
while(<RD>){
	chomp;
	push(@tempArr,$_);
}
close(RD);

##write to HTML file
open(HR,">/home/nlp/apache-tomcat-8.5.23//webapps/tvademo/Morph_Output.html");
print HR "<html>\n";
print HR "<meta http-equiv=\"Content-Type\" content=\"text\/html; charset=utf-8\">\n";
print HR "<head><title>Event - Entity Profiling System<\/title>\n";
print HR "<style type=\"text\/css\"> body \{ \n";
print HR "margin-top\: 0px\; padding-top\: 10px\; \} <\/style>\n";

print HR "<\/head>\n";
print HR "<body>\n";

#$morph_Out =~ s/\n/<br>\n/g;
#$morph_Out =~ s/\s/&nbsp;/g;

####@tempArr = split(/\n/,$morph_Out);

##print HR "<table>\n";
##print HR "<tr><td><b>Word<\/b><\/td><td><b>Morph-Analysis<\/b><\/td><\/tr>\n";
foreach $lineO (@tempArr) {
	if($lineO =~ /^\s*$/) {
		##print HR "<tr><br><\/tr>\n";
		print HR "<br>\n";
		next;
	}
	@tempA1 = split(/\t/,$lineO);

	##print HR "<tr>\n";
	print HR "<pre>\n";
	#print HR "$lineO\n";
	#foreach $ele (@tempA1) {
		print HR "$tempA1[0] \&nbsp\;\&nbsp\; \&lt\;$tempA1[1]\&gt\;";
	#}
	###print HR "<\/tr>\n";
	print HR "<\/pre>\n";
}
##print HR "<\/table>\n";

print HR "<\/body><\/html>\n";
close(HR);
