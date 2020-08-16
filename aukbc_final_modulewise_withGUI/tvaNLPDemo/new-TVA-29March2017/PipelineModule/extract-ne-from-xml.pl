open(F,$ARGV[0]);
while(<F>)
{
	chomp;
	$line=$_;
	if($line=~/<field name="person">(.+?)<\/field>/)
	{
		@per=split(/#/,$1);
		foreach $k(@per)
		{
			$k=~s/^\s*//g;
			$k=~s/\s*$//g;
			print"$k=>INDIVIDUAL\n";
		}
	}

	if($line=~/<field name="location">(.+?)<\/field>/)
        {
                @loc=split(/#/,$1);
                foreach $k(@loc)
                {
			$k=~s/^\s*//g;
                        $k=~s/\s*$//g;
                        print"$k=>LOCATION\n";
                }
        }

}
