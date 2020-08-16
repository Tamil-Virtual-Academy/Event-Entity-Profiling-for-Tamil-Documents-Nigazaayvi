open(F,$ARGV[0]);
while(<F>)
{
$val=$_;
push(@arr,$_);
}

for($i=0;$i<=@arr;$i++)
{
	if($arr[$i]=~/URL:http:/i)
        {
                #$value=$value.$arr[$i];
                print"$arr[$i]\n";

        }
#"headline": "வருமானத்தில் கணக்கு காட்டிய பணத்தில் தங்கம் வாங்கினால் வரி செலுத்த தேவையில்லை..! "
	if($arr[$i]=~/<title>(.*)\|(.*)<\/title>/)
        {
               	print"<title>$1<\/title>\n";
                #$value=$value.$1."\n";
        }	

	#elsif($arr[$i]=~/heading">(.*)<\/h1>/)
        #{
		#print"$1\n";
	#	print"<title>$1<\/title>\n";
		#$value=$value.$1."\n";
        #}


	if($arr[$i]=~/<h2 itemprop="description">(.*)<\/h2>/)
        {
                #print"$1\n";
                $value=$value.$1."\n";
        }
	
	if($arr[$i]=~/<article itemprop="articleBody">/)
        {
                #print"CONTENT:$1\n";
		$m=$arr[$i];
		while($m=~/articleBody(.*?)/)
                {
			#print"HAI $1\n";
			$value=$1;
			#$value=~s/<//g;
			$value=~s/<(?:[^>'"]*|(['"]).*?\1)*>/ /gs;
			$value=~s/">//g;
                        $value=~s/-->//g;
			$value=~s/^\s*//g;
			$value=~s/\s*\$//g;
			$value=~s/^\s*\$//g;
			$value =~s/\cM//g;
			$value=~s/\&;//g;
			if($value=~/(.+?)(Read more about:.*)/){$value=$1;}
			print"$value\n";
               		#$value=$value.$1;

               		$m=$';
		}
        }

=c
	if($arr[$i]=~/<div class="para_head"><h2>([^>]*)<\/h2><\/div> <p>([^>]*)<\/p>/)
        {
		$k=$arr[$i];
		while($k=~/<div class="para_head"><h2>([^>]*)<\/h2><\/div> <p>([^>]*)<\/p>/)
        	{
                	print"$1\n$2\n";
                	#$value=$value.$1;
			$k=$';
		}
        }

=cut
	if(($arr[$i]=~/"keywords"/)&&($arr[$i+1]=~/"articleBody":"(.*)/))
        {
		$value=$1;
		$value=~s/<(?:[^>'"]*|(['"]).*?\1)*>/ /gs;
                        $value=~s/">//g;
                        $value=~s/-->//g;
                        $value=~s/^\s*//g;
                        $value=~s/\s*\$//g;
                        $value=~s/^\s*\$//g;
                        $value =~s/\cM//g;
			$value=~s/\&\#\d+\;! "//g;
			$value=~s/\&\#\d+\; ?//g;
			$value=~s/\&\#\d+\;//g;
			$value=~s/[A-Z]//g;
			$value=~s/[a-z]//g;
			$value=~s/\&;//g;
		#print"$1\n";
		print"$value\n";

	}


}
=c
$value=~s/<(?:[^>'"]*|(['"]).*?\1)*>/ /gs;
$value=~s/^\s*//g;
$value=~s/\s*\$//g;
$value=~s/^\s*\$//g;
$value =~s/\cM//g;
####print"$value\n";

