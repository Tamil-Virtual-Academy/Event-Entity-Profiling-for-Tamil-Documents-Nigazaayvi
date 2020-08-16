#!/usr/bin/perl

$content = "";
$url = "";
$title = "";

while(<>) {
	chomp;

	if($_ =~ /^URL/i) {
		$url = $_;
		$url =~ s/URL\://;
		next;
	}elsif($_ =~ /<title>(.*?)<\/title>/) {
		$title = $1;
		next;
	}else{
		$content = $content."\n".$_;
	}
}

$content =~ s/\<br \/\>//ig;
$content =~ s/\<\/?br\/\>//ig;
$content =~ s/<\/?p>//ig;
$content =~ s/\&quot\;/"/ig;
$content =~ s/\&\#39\;/ /g;
$content =~ s/<content>//ig;

#print "url: $url\n";
#print "title: $title\n";
#print "Content: $content\n";

#write to a file
open(WR,">inputFile.txt");
print WR "$content";
close(WR);

#run Syntactic, Semantic and Event prepeocessing and collect person, location
$cmd = "sh TamilSyntactic-Semanticbench_v1.sh inputFile.txt > corefOut.txt";
system($cmd);

$NEsList = `perl collectNEs.pl corefOut.txt`;

($person,$location) = split(/<dim>/,$NEsList);

$content=~s/\n/ /g;
$person=~s/\n//g;
$location=~s/\n//g;

$date=`date`;
print "$date\n";
@arr=split(/\s+/,$date);
$appendate="$arr[1]_$arr[2]_$arr[3]_$arr[5]";
$appendate=~s/://g;


$id="text".$appendate;
print "<doc>\n";
print "<field name=\"id\">$id<\/field>\n";
print "<field name=\"title\">$title<\/field>\n";
print "<field name=\"content\">$content<\/field>\n";
print "<field name=\"url\">$url<\/field>\n"; 
#print "<field name=\"event\"><\/field>\n"; 
#print "<field name=\"causeeffect\"><\/field>\n"; 
print "<field name=\"person\">$person<\/field>\n";
print "<field name=\"location\">$location<\/field>\n";
#print "<field name=\"domain\"><\/field>\n";
print "<\/doc>\n";

# read eventTaggedOut.txt and get the event 
 
