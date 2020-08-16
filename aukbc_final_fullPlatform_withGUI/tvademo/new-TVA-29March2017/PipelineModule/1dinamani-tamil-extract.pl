use HTML::Entities;
open(F,$ARGV[0]);
while(<F>)
{
$val=$_;
push(@arr,$_);
}
for($i=0;$i<=@arr;$i++)
{
@str=("latest-news","business","india","world","sports","health","education","junction","travel");	

for($j=0;$j<@str;$j++){
	while($arr[$i]=~/href="(http\:\/\/www.dinamani.com\/$str[$j]\/2017\/\w+\/\d+\/(.+?)html)/g)
        {
		$match=$1;
		$hash{$1}++;
        }
	}
}
my $html = "$value";
foreach $k(sort keys %hash)
{
 	if($cnt<=10){
	print"$k\n";
	}
	$cnt++;

}
