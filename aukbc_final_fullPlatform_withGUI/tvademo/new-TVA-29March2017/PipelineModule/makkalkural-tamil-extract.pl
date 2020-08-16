use HTML::Entities;
open(F,$ARGV[0]);
while(<F>)
{
$val=$_;
push(@arr,$_);
}
for($i=0;$i<=@arr;$i++)
{
$true=1;

	while($arr[$i]=~/((http:\/\/makkalkural.net\/news\/blog\/.+?)")/g)
        {
		$match=$2;
		if($match!~/>|<|=/){
		#print"$match\n";
		$hash{$match}++;
		}
        }

}

foreach $k(sort keys %hash)
{
        if($cnt<=10){
        print"$k\n";
        }
        $cnt++;
}

