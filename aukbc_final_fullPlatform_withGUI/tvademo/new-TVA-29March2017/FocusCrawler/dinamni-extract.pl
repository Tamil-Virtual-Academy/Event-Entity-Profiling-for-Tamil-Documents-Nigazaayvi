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
                $value=$value.$arr[$i];

        }
	if($arr[$i]=~/<title>/)
        {
		$i++;
		while($arr[$i]!~/Dinamani - Tamil Daily News/){
			#print"$arr[$i]\n";
			$value=$value.$arr[$i];
			$i++;
		}
        }

	if($arr[$i]=~/<div class="body ">/)
        {
                
                while($arr[$i]!~/<\/body>/){
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
$value=~s/\&nbsp\;//g;
print"$value\n";
