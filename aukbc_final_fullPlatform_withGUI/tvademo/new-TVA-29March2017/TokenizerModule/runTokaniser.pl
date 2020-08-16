#!/usr/bin/perl

undef @tempArr;
##Read Tokenizer Output File
open(RD,"/home/nlp/apache-tomcat-8.5.23//webapps/tvademo/new-TVA-29March2017/TokenizerModule/tokenized_output.txt");
while(<RD>){
        chomp;
        push(@tempArr,$_);
}
close(RD);


	
##write to HTML file
open(HR,">/home/nlp/apache-tomcat-8.5.23//webapps/tvademo/Tokenizer_Output.html");
print HR "<html>\n";
print HR "<meta http-equiv=\"Content-Type\" content=\"text\/html; charset=utf-8\">\n";
print HR "<head><title>Event - Entity Profiling System<\/title><\/head>\n";
print HR "<body>\n";
$tokeniseOut = join("\n",@tempArr);
$tokeniseOut =~ s/\n/<br>\n/g;

print HR "$tokeniseOut";
print HR "<\/body><\/html>\n";
close(HR);
