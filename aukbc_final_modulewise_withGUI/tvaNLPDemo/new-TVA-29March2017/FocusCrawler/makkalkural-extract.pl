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
	if($arr[$i]=~/<meta name="twitter:title" content="(.*)"\/>/)
        {
		#print"$1\n";
		$value=$value.$1."\n";
        }

	if($arr[$i]=~/<div id="mycontent">/)
        {
		$i++;
                while($arr[$i]!~/<div/){
                        $value=$value.$arr[$i];
                        $i++;
                }
        }

#<div id="ContentPlaceHolder1_ArticleDescription"
}
$value=~s/<(?:[^>'"]*|(['"]).*?\1)*>/ /gs;
$value =~s/\cM//g;
$value=~s/^\s*//g;
$value=~s/\s*\$//g;
$value=~s/^\s*\$//g;
print"$value\n";
