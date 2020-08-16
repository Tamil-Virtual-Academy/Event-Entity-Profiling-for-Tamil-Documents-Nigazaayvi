#!/usr/bin/perl -w

        use LWP::Simple;
	#use LWP::UserAgent;
	#use HTTP::Request;
	#use HTTP::Response;
	#use HTML::LinkExtor;
	use utf8;
#$browser = LWP::UserAgent->new();
#$browser->agent('Mozilla/4.0 (compatible; MSIE 5.12; Mac_PowerPC)');
#$browser->timeout(10);
$str=$ARGV[0];
#$str="http:\/\/tamil.thehindu.com\/tamilnadu\/?\/article?\.ece";
#my $request = HTTP::Request->new(GET => $str);
#my $response = $browser->request($request);
#if ($response->is_error()){}
#######$contents = $response->content();
$contents = get $str;
print"URL:$str\n";
print"$contents";
