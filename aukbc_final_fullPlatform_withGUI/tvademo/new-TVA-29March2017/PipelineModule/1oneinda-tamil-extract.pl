use HTML::Entities;
open(F,$ARGV[0]);
while(<F>)
{
$val=$_;
push(@arr,$_);
}
for($i=0;$i<=@arr;$i++)
{
@str=("tamilnadu","business","india","world","sports","cinema","health","education","junction");	
$true=1;

for($j=0;$j<@str;$j++){
	while($arr[$i]=~/(http\:\/\/tamil.oneindia.com\/news\/$str[$j]\/(.+?)html)/g)
        {
		$match=$&;
		#print"$&\n";
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

