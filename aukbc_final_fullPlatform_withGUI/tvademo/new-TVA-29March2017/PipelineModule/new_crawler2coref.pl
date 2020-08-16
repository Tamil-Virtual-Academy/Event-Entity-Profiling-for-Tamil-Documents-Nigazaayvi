#!/usr/bin/perl

$date=`date`;
##print "$date\n";
@arr=split(/\s+/,$date);
$appendate="$arr[1]_$arr[2]_$arr[3]_$arr[5]";
$appendate=~s/://g;
##print "$appendate\n";

$folder="crawl-$appendate";
system("mkdir $folder");

$cnt=1;
open(FH,$ARGV[0]);
while(<FH>){
	chomp;
	$url=$_;
	if($url=~/thehindu/){
		$outfile="theHindu_tamil_".$cnt."_".$appendate;
		$cmd1="perl crawl.pl $url > temp_store";
		$cmd2="perl hindu-tamil-extract.pl temp_store >$folder/$outfile";
		system($cmd1);
		system($cmd2);
	}

	elsif ($url=~/makkalkural/){
		$outfile="makkalkural_".$cnt."_".$appendate;
		$cmd1="perl crawl.pl $url > temp_store1";
		$cmd2="perl  makkalkural1-extract.pl temp_store1 >$folder/$outfile";
		system($cmd1);
		system($cmd2);
		
	}
	elsif ($url=~/dinamani/){
		$outfile="dinamani_".$cnt."_".$appendate;
		$cmd1="perl crawl.pl $url > temp_store2";
		$cmd2="perl dinamani1-extract.pl temp_store2 >$folder/$outfile";
		system($cmd1);
		system($cmd2);
		
	}

	elsif ($url=~/oneindia/){
		$outfile="oneindia_".$cnt."_".$appendate;
		$cmd1="perl crawl.pl $url > temp_store3";
		$cmd2="perl 2oneindia.pl temp_store3 >$folder/$outfile";
		system($cmd1);
		system($cmd2);
		
	}

	elsif ($url=~/maalaimalar/){
		$outfile="maalaimalar_".$cnt."_".$appendate;
		$cmd1="perl crawl.pl $url > temp_store4";
		$cmd2="perl malai-malar-extract.pl temp_store4 >$folder/$outfile";
		system($cmd1);
		system($cmd2);
		
	}
	elsif ($url=~/dailythanthi/){
                $outfile="dailythanthi_".$cnt."_".$appendate;
                $cmd1="perl crawl.pl $url > temp_store6";
                $cmd2="perl daily-thanthi-extract.pl temp_store6 >$folder/$outfile";
                system($cmd1);
                system($cmd2);

        }

	else{
		$outfile="others_".$cnt."_".$appendate;
		$cmd1="perl crawl.pl $url > temp_general";
		$cmd2="perl generic-scrapper.pl temp_general >$folder/$outfile";
		system($cmd1);
		system($cmd2);
		
	}

	$cnt++;
}
close(FH);

$filepath=$folder;
@file=glob("$filepath/*");

foreach $k(@file)
{
        @arr=split(/\//,$k);$l=@arr;
        if($k=~/(.+?)\/($arr[$l-1])$/){$dir=$1;$filen=$2;}
        $out=$arr[$l-1]."_corefout.txt";
        $outxml=$arr[$l-1]."_out.xml";
	
	$content = "";
	$url = "";
	$title = "";
	###check
	$event="";
	$newNEsList="";
	###check
	open(RH,"$k");
	while(<RH>) {
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
	close(RH);

	$content =~ s/\<br \/\>//ig;
	$content =~ s/\<\/?br\/\>//ig;
	$content =~ s/<\/?p>//ig;
	$content =~ s/\&quot\;/"/ig;
	$content =~ s/\&\#39\;/ /g;
	$content =~ s/<content>//ig;

	#print "url: $url\n";
	#print "title: $title\n";
	#print "Content: $content\n";
	
	$content1 = $title."\n".$content;
	#write to a file
	open(WR,">inputFile.txt");
	print WR "$content1";
	close(WR);

        $cmd = "sh morph-to-coref.sh inputFile.txt >  $dir\/$out";
	$ofname="$dir\/$out";
	$oxml="$dir\/$outxml";
        ###print "$cmd\n";
        system($cmd);

	$NEsList = `perl collectNEs-withID.pl $ofname`;
	open(WR1,">NEsFile.txt");
	print WR1 "$NEsList\n";
	close(WR1);

	$cmd1="perl combineNElist_DD.pl /home/nlp/apache-tomcat-8.5.23//webapps/tvademo/new-TVA-29March2017/AnaphoraCoreferenceModule_v1/interDD /home/nlp/apache-tomcat-8.5.23//webapps/tvademo/new-TVA-29March2017/PipelineModule/NEsFile.txt >/home/nlp/apache-tomcat-8.5.23//webapps/tvademo/new-TVA-29March2017/PipelineModule/newNEsFile.txt";
	system($cmd1);

	$cmd="java convert_WX_UTF_tam -i newNEsFile.txt -o NEsFile_UTF.txt";
	system($cmd);
	
	$newsNEsList="";
	open(EH,"/home/nlp/apache-tomcat-8.5.23//webapps/tvademo/new-TVA-29March2017/PipelineModule/NEsFile_UTF.txt");
	while(<EH>){
		chomp; 
		next if($_ =~ /^\s*$/);
		$newNEsList.=$_;
	}
	close(EH);

	$causeeffect="<ol>";
	open(ED,"/home/nlp/apache-tomcat-8.5.23//webapps/tvademo/new-TVA-29March2017/causeEffectSys/causeEffectOut_utf8.txt");
	while(<ED>){
		#chomp;
		next if($_=~ /^\s*$/);
		$causeeffect.="<li>$_<\/li>";
	}
	close(ED);
	$causeeffect.="<\/ol>";

	$causeeffect=~s/\n/<br>/g;
	
	($person,$location) = split(/<dim>/,$newNEsList);
	
	open(EV,"../event_extraction_sys/eventTaggedOut.txt");
	while(<EV>){
		chomp;
		next if($_ =~ /^\s*$/);
		$event.=$_;
	}
	close(EV);

	$content=~s/\n/ /g;
	$person=~s/\n//g;
	$location=~s/\n//g;

	$date=`date`;
	##print "$date\n";
	@arr=split(/\s+/,$date);
	$appendate="$arr[1]_$arr[2]_$arr[3]_$arr[5]";
	$appendate=~s/://g;

	#write to XML file
	open(XR,">$oxml");
	$id="text".$appendate;
	print XR "<doc>\n";
	print XR "<field name=\"id\">$id<\/field>\n";
	print XR "<field name=\"title\">$title<\/field>\n";
	print XR "<field name=\"content\">$content<\/field>\n";
	print XR "<field name=\"url\">$url<\/field>\n";
	# read eventTaggedOut.txt and get the event 
	print XR "<field name=\"event\">$event<\/field>\n"; 
	print XR "<field name=\"causeeffect\">$causeeffect<\/field>\n"; 
	print XR "<field name=\"person\">$person<\/field>\n";
	print XR "<field name=\"location\">$location<\/field>\n";
	#print "<field name=\"domain\"><\/field>\n";
	print XR "<\/doc>\n";
	close(XR);

	$person=~s/#/<br>&nbsp;&nbsp;&nbsp;&nbsp;/g;
	$location=~s/#/<br>&nbsp;&nbsp;&nbsp;&nbsp;/g;
	$content=~s/\n/<br>/g;
	###write to HTML file
	open(HR,">/home/nlp/apache-tomcat-8.5.23//webapps/tvademo/final_Output.html");
	print HR "<html>\n";
	print HR "<head><title>Event - Entity Profiling System<\/title><\/head>\n";
	print HR "<body>\n";
	###print HR "<table>\n";
	###print HR "<tr>\n";
	###print HR "<td align=\"left\"><img src=\"cwhome.jpeg\" height=\"150\" width=\"120\"><\/td>\n";
	###print HR "<td align=\"center\" width=\"1050\">\n";
	###print HR "<font size=\"5\"><b>நிகழ்வு உருப்பொருள் சுயவிவரமாக்கல் கருவி<\/b><br>\n";
	###print HR "<b>Event - Entity Profiling System <\/b><br><\/font>\n";
	###print HR "<font size=\"3\"><b>(Project funded by Tamil Virtual Academy)<\/b><br><\/font>\n";
	###print HR "<font size=\"5\"><b>கணினி மொழியியல் ஆராய்ச்சிக் குழு<\/b><br>\n";
	###print HR "<b>Computational Linguistics Research Group,<\/b><br>\n";
	###print HR "<b>AU-KBC Research Centre</b><\/font><br>\n";
	###print HR "<\/td>\n";
	###print HR "<td align=\"right\"><img src=\"AnnaLogo3.png\" height=\"150\" width=\"120\"><\/td>\n";
	###print HR "<\/tr>";
	###print HR "<\/table>\n";
	###print HR "<hr>\n";
	
	print HR "<font size=\"3\">\n";
	print HR "<font color=\"#cc00ff\"><br><b> நிகழ்வுகள்   : <\/b><\/font>\n";
	print HR "<br><font color=\"#000000\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b> $event </b> <\/font>\n";
	print HR "<br><font color=\"#cc00ff\"><b> நபர்  :<\/b><\/font>";
	print HR "<br><font color=\"#000000\">&nbsp;&nbsp;&nbsp;&nbsp;$person<\/font>\n";
	print HR "<br><font color=\"#cc00ff\"><b> இடம் : <\/b><\/font>\n";
	print HR "<br><font color=\"#000000\">&nbsp;&nbsp;&nbsp;&nbsp;$location<\/font>\n";
	print HR "<br><font color=\"#cc00ff\"><b>காரணம்-விளைவு : </b></font>\n"; 
	print HR "<font color=\"#000000\">$causeeffect <\/font>\n";
	print HR "<\/font>\n";
	#print "<field name=\"domain\"><\/field>\n";
	#
	print HR "<\/body><\/html>\n";
	close(HR);
	open(CW, ">/home/nlp/apache-tomcat-8.5.23//webapps/tvademo/url_content.html");
	print CW "<html><head><title>Event Profiling<\/title><\/head><body>\n";
	print CW "<font size=\"3\">\n";
	print CW "<b> <font color=\"#cc00ff\"> URL: <\/font> </b>&nbsp;&nbsp; <font color=\"#000000\"> $url <\/font>\n";
	print CW "<br><font color=\"#cc00ff\"><b>Content: </b><\/font><br>\n";
	print CW "<font color=\"#000000\">&nbsp;&nbsp;&nbsp;&nbsp; $content<\/font><\/font><br>";
	print CW "<\/body><\/html>\n";
	close(CW);
	

}

