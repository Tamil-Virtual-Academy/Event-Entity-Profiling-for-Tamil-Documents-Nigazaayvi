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
	if($arr[$i]=~/<title>(.*)\|\|(.*)<\/title>/)
        {
		print"<title>$1<\/title>\n";
		#$value=$value.$1;
        }
	elsif($arr[$i-1]=~/ArticleDetailAbstract/)
	{
		while($arr[$i]!~/printcontentarea/){
			$value=$value.$arr[$i];	
			$i++;
		}

	}
	if($arr[$i]=~/<div id="ContentPlaceHolder1_ArticleDescription".*>/)
        {

                while($arr[$i]!~/<script src=/){
                        $value=$value.$arr[$i];
                        $i++;
                }
        }
	elsif($arr[$i-1]=~/ArticleDetailContent/)
	{
		while($arr[$i]!~/printcontentarea/){
			$value=$value.$arr[$i];	
			$i++;
		}

	}
	else{
		$tt=$arr[$i];
		$tt=~s/<.*?>//g;
		#$value=$value.$tt;
	}

#<div id="ContentPlaceHolder1_ArticleDescription"
}
$value=~s/<(?:[^>'"]*|(['"]).*?\1)*>/ /gs;
$value=~s/^\s*//g;
$value=~s/\s*\$//g;
$value=~s/^\s*\$//g;
$value =~s/\cM//g;
print"$value\n";
