#!/usr/bin/perl


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

$tag="";
$flag=0;
foreach $lineO (@tempArr) {
	if($lineO =~ /^\s*$/) {
		if($tag ne ""){
			print HR "\&lt\; \/$tag \&gt\;";
			$tag="";
		}	
		print HR "<br>\n";
		next;
	}
	@tempA1 = split(/\t/,$lineO);
	if($tempA1[2]=~/B-(\w+)/) {
		if($tag ne $1){ 
			$chflag=1;
			print HR "\&lt\; \/$tag \&gt\;" if($tag ne "");
		}
		elsif($tag eq $1){ 
			$chflag=1;
			print HR "\&lt\; \/$tag \&gt\;" if($tag ne "");
		}
		$tag=$1;
		$flag=1;
		print HR "\&lt\;$tag\&gt\; $tempA1[0] ";
	}
	elsif(($tempA1[2]=~/O/) || ($tempA1[2]=~/0/) || ($tempA1[2]=~/o/)){
		$flag=3;
		print HR "\&lt\; \/$tag \&gt\; $tempA1[0] " if($tag ne "");
		print HR " $tempA1[0] " if($tag eq "");
		$tag="";
	}
	elsif($tempA1[2]=~/I-$tag/){
		$flag=2;
		print HR " $tempA1[0]";
	}
}
print HR "<\/body><\/html>\n";
close(HR);
