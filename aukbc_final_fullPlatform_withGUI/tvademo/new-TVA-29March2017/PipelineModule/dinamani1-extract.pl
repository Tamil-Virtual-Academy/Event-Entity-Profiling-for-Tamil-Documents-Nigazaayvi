open(F,$ARGV[0]);
while(<F>)
{
$_=~s/\cM//g;
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
	if($arr[$i]=~/<meta property\=\"og:title\" content=\"(.*)\"\/>/)
	{
		print"<title>$1<\/title>\n";
		#$value=$value.$1;
	}
	if($arr[$i]=~/<title>/)
        {
		#print "\n$arr[$i]\n";	
        }
	
	if($arr[$i]=~/<div id="storyContent">/)
        {
                while($arr[$i]!~/<\/div>/){
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
