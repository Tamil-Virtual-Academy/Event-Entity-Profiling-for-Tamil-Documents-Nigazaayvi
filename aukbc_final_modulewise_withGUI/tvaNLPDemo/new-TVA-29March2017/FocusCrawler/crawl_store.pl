#!/usr/bin/perl


$date=`date`;
print "$date\n";
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
		$cmd2="perl makkalkural-extract.pl temp_store1 >$folder/$outfile";
		system($cmd1);
		system($cmd2);
		
	}
	elsif ($url=~/dinamani/){
		$outfile="dinamani_".$cnt."_".$appendate;
		$cmd1="perl crawl.pl $url > temp_store2";
		$cmd2="perl dinamni-extract.pl temp_store2 >$folder/$outfile";
		system($cmd1);
		system($cmd2);
		
	}
	elsif ($url=~/dailythanthi/){
		$outfile="dailythanthi_".$cnt."_".$appendate;
		$cmd1="perl crawl.pl $url > temp_store3";
		$cmd2="perl daily-thanthi-extract.pl temp_store3 >$folder/$outfile";
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
	else{
		$outfile="others_".$cnt."_".$appendate;
		$cmd1="perl crawl.pl $url > $folder/$outfile.html";
		system($cmd1);
		
	}

	$cnt++;
}

