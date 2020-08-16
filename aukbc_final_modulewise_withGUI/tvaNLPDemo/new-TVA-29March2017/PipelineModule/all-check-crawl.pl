#!/usr/bin/perl -w
        use LWP::Simple;
	use LWP::UserAgent;
	use HTTP::Request;
	use HTTP::Response;
	#use HTML::LinkExtor;
	use utf8;
$browser = LWP::UserAgent->new();
$browser->agent('Mozilla/4.0 (compatible; MSIE 5.12; Mac_PowerPC)');
$browser->timeout(10);
@str=("http://www.dailythanthi.com/News/India","http://www.dailythanthi.com/News/India/2","http://www.dailythanthi.com/News/World","http://www.dailythanthi.com/News/World/2","http://www.dailythanthi.com/News/State","http://www.dailythanthi.com/News/State/2","http://www.dailythanthi.com/Sports/Cricket","http://www.dailythanthi.com/Sports/Tennis","http://www.dailythanthi.com/Sports/Football","http://www.dailythanthi.com/Sports/Hockey","http://www.dailythanthi.com/Sports/Basketball","http://www.dailythanthi.com/Sports/2","http://www.dailythanthi.com/News/Puducherry","http://www.dailythanthi.com/News/Puducherry/2","http://www.dailythanthi.com/News/Maharashtra/Mumbai","http://www.dailythanthi.com/News/Maharashtra/Mumbai/2","http://tamil.oneindia.com","http://www.dinamani.com/tamilnadu","http://www.dinamani.com/india","http://www.dinamani.com/world","http://www.dinamani.com/sports/sports-news","http://www.dinamani.com/business","http://www.maalaimalar.com/News/National","http://www.maalaimalar.com/News/World","http://www.maalaimalar.com/News/State","http://www.maalaimalar.com/News/Sports");
for($j=0;$j<@str;$j++)
{
	my $request = HTTP::Request->new(GET => $str[$j]);
	my $response = $browser->request($request);
	if ($response->is_error())
	{}
	$contents = $response->content();
	@arr=split(/\n/,$contents);
	for($i=0;$i<@arr;$i++)
	{
		if($arr[$i]=~/(http\:\/\/www\.dailythanthi\.com\/.*\/.*\/\d+\/\d+\/\d+\/.*vpf)/)
		{
			$hash{$1}++;
		}
	
		while($arr[$i]=~/(http\:\/\/tamil.oneindia.com\/news\/(.+?)html)/g)
                {
                        $match=$&;
                        $hash{$match}++;
                        $i++;
                }
#http://www.dinamani.com/tamilnadu/2017/jun/09/%E0%AE%9C%E0%AF%82%E0%AE%B2%E0%AF%88-1-%E0%AE%87%E0%AE%B2%E0%AF%8D-%E0%AE%AA%E0%AF%81%E0%AE%A4%E0%AF%81%E0%AE%B5%E0%AF%88%E0%AE%AF%E0%AE%BF%E0%AE%B2%E0%AF%8D-%E0%AE%B5%E0%AE%BE%E0%AE%95%E0%AF%8D%E0%AE%95%E0%AE%BE%E0%AE%B3%E0%AE%B0%E0%AF%8D-%E0%AE%AA%E0%AE%9F%E0%AF%8D%E0%AE%9F%E0%AE%BF%E0%AE%AF%E0%AE%B2%E0%AF%8D-%E0%AE%9A%E0%AE%BF%E0%AE%B1%E0%AE%AA%E0%AF%8D%E0%AE%AA%E0%AF%81-%E0%AE%9A%E0%AF%87%E0%AE%B0%E0%AF%8D%E0%AE%95%E0%AF%8D%E0%AE%95%E0%AF%88-%E0%AE%AA%E0%AE%A3%E0%AE%BF-%E0%AE%A4%E0%AF%8A%E0%AE%9F%E0%AE%95%E0%AF%8D%E0%AE%95%E0%AE%AE%E0%AF%8D-2717394.html
		
		if($arr[$i]=~/(http\:\/\/www\.dinamani\.com\/((tamilnadu)|(india)|(sports)|(world)|(business))\/\d+\/\w+\/\d+\/.*html)/)
                {
                        $hash{$1}++;
                }

		if($arr[$i]=~/(http\:\/\/www\.dinamani\.com\/sports\/sports-news\/\d+\/\w+\/\d+\/.*html)/)
                {
                        $hash{$1}++;
                }
		#http://www.maalaimalar.com/News/National/2017/06/09141233/1089885/Chhota-Shakeel-aide-arrested-was-planning-to-target.vpf
		if($arr[$i]=~/(http\:\/\/www\.maalaimalar\.com\/News\/(National|World|State|Sports)\/\d+\/\d+\/\d+\/\d+\/.*vpf)/)
                {
                        $hash{$1}++;
                }




	}
}


foreach $k(keys %hash)
{
	print"$k\n";

}
