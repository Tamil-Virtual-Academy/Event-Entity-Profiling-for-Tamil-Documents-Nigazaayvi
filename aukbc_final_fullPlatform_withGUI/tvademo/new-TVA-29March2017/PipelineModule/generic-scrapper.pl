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
                #$value=$value.$arr[$i];
		print"$arr[$i]\n";

        }
	if($arr[$i]=~/<meta name="twitter:title" content="(.*)"\/>/)
        {
		print"<title>$1<\/title>\n";
		#$value=$value.$1."\n";
        }
	elsif($arr[$i]=~/<meta name="title" content="(.*)"\/>/)
        {
		print"<title>$1<\/title>\n";
		#$value=$value.$1."\n";
        }
	else{
	$value= $arr[$i];
	$value=~s/<(?:[^>'"]*|(['"]).*?\1)*>/ /gs;
	$value =~s/\cM//g;
	$value=~s/&hellip;//g;
	$value=~s/&nbsp;//g;
	$value=~s/^\s*//g;
	$value=~s/\s*\$//g;
	$value=~s/^\s*\$//g;
	
	print"$value\n";
	}

}
