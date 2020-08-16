use HTML::Entities;
open(F,$ARGV[0]);
while(<F>)
{
$val=$_;
push(@arr,$_);
}

for($i=0;$i<=@arr;$i++)
{

	if($arr[$i]=~/URL:/)
        {
                $value1=$value1.$arr[$i];

        }

	if($arr[$i]=~/<title>/)
        {
		#print"$1\n";
		$value1=$value1.$arr[$i+1];
        }

	if($arr[$i]=~/(<div class="article-body">)|(<div class="article-text">)/)
        {
		$i++;
                while($arr[$i]!~/<script type=/){
                        $value=$value.$arr[$i];
			$i++;
                }
        }

}
$value=~s/<(?:[^>'"]*|(['"]).*?\1)*>/ /gs;
$value=~s/^\s*//g;
$value=~s/\s*\$//g;
$value=~s/^\s*\$//g;
$value =~s/\cM//g;
my $html = "$value";
print"$value1\n";
print decode_entities($html), "\n";
