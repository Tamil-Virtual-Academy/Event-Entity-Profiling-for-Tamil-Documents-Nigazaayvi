open(F,$ARGV[0]);
while(<F>)
{
	push(@line,$_);
}

foreach $k(@line)
{
	if($k=~/<field name="title">(.+?)<\/field>/)
        {
                print"$1\n";
        }
	if($k=~/<field name="content">(.+?)<\/field>/)
	{
		print"$1\n";
	}
}
