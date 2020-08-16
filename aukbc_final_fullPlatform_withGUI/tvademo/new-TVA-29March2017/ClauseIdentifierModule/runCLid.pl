#!/usr/bin/perl



undef @tempArr;
##Read Clause Output File
open(RD,"/home/nlp/apache-tomcat-8.5.23//webapps/tvademo/new-TVA-29March2017/ClauseIdentifierModule/Clause_output.txt");
while(<RD>){
        chomp;
        push(@tempArr,$_);
}
close(RD);

	
##write to HTML file
open(HR,">/home/nlp/apache-tomcat-8.5.23//webapps/tvademo/Clause_Output.html");
print HR "<html>\n";
print HR "<meta http-equiv=\"Content-Type\" content=\"text\/html; charset=utf-8\">\n";
print HR "<head><title>Event - Entity Profiling System<\/title><\/head>\n";
print HR "<body>\n";


foreach $lineO (@tempArr) {
	if($lineO =~ /^\s*$/) {
		print HR "<br>\n";
		next;
	}
	@tempA1 = split(/\t/,$lineO);

	if(($tempA1[4]=~/o/) || ($tempA1[4]=~/O/) || ($tempA1[4]=~/0/)){
		print HR " $tempA1[0]"
	}
	elsif($tempA1[4]=~/\{\/\w+/){
		print HR " $tempA1[0] $tempA1[4]";
	}
	elsif($tempA1[4]=~/\{\w+/){
		print HR " $tempA1[4] $tempA1[0]";
	}
}

print HR "<\/body><\/html>\n";
close(HR);
