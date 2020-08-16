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

	if(($arr[$i]=~/<div class="entry-content".+?>/)&&($arr[$i]!~/<\/div>/))
        {
		$i++;
                while($arr[$i]!~/<\/div|<div class/){
                        $value=$value.$arr[$i];
                        $i++;
                }
        }
	elsif($arr[$i]=~/<div class="entry-content">(.+?)<\/div>/)
	{
		
		$value=$value.$arr[$i];

	}

#<div id="ContentPlaceHolder1_ArticleDescription"
}
$value=~s/<(?:[^>'"]*|(['"]).*?\1)*>/ /gs;
$value =~s/\cM//g;
$value=~s/&hellip;//g;
$value=~s/&nbsp;//g;
$value=~s/^\s*//g;
$value=~s/\s*\$//g;
$value=~s/^\s*\$//g;
print"$value\n";
