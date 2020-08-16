#!/usr/bin/perl 

use LWP::Simple;
use LWP::UserAgent;
use HTTP::Request;
use HTTP::Response;
use HTML::LinkExtor;
use utf8;



###my @urls= ('http://timesofindia.indiatimes.com/who-is-ucla-shooter-mainak-sarkar/listshow/52570024.cms?');
my @urls = ('http://tamil.thehindu.com/tamilnadu/','http://makkalkural.net/news/', 'http://www.dailythanthi.com/', 'http://www.dinamani.com/', 'http://www.maalaimalar.com/');
my %visited;  # The % sigil indicates it's a hash
my $browser = LWP::UserAgent->new();
$browser->agent('Mozilla/4.0 (compatible; MSIE 5.12; Mac_PowerPC)');
$browser->timeout(10);
undef @urls2dep;

while (@urls) {
  my $url = shift @urls;
  my $cnt=1;

	
  my $request = HTTP::Request->new(GET => $url);
  my $response = $browser->request($request);

  # No real need to invoke printf if we're not doing
  # any formatting
  if ($response->is_error()) {
	print STDERR "2DPT -- $url\n";
	print STDERR "2Dep -- ", $response->status_line, "\n";
   }
  my $contents = $response->content();




  my ($page_parser) = HTML::LinkExtor->new(undef, $url);
  $page_parser->parse($contents)->eof;
  my @links = $page_parser->links;

     foreach my $link (@links) {
  	if($cnt <=100){
	if($$link[2] !~/\.(jpg|jpeg|pdf|js|gif|css|bmp|png|tiff|tif|mid|mp2|mp3|mp4|wav|avi|mov|mpeg|ram|m4v|pdf|wmv|swf|wma|zip|rar|gz|tar|rss|ico|jsapi|xml)|(jsapi|rss|xml)/){
		print "$$link[2]\n";
		push @urls2dep, $$link[2];
  		$cnt++;
	}
	}
     }
}



undef @urls3dep;
while (@urls2dep) {
  my $url = shift @urls2dep;
  my $cnt=1;
	
  my $request = HTTP::Request->new(GET => $url);
  my $response = $browser->request($request);

  # No real need to invoke printf if we're not doing
  # any formatting
  if ($response->is_error()) {
	print "3DPT -- $url\n";
	print "3Dep -- ",$response->status_line, "\n";
  }
  my $contents = $response->content();


  my ($page_parser) = HTML::LinkExtor->new(undef, $url);
  $page_parser->parse($contents)->eof;
  my @links = $page_parser->links;
     foreach my $link (@links) {
  	if($cnt <=30){
	if($$link[2] !~/\.(jpg|jpeg|pdf|js|gif|css|bmp|png|tiff|tif|mid|mp2|mp3|mp4|wav|avi|mov|mpeg|ram|m4v|pdf|wmv|swf|wma|zip|rar|gz|tar|rss|ico|jsapi|xml)|(jsapi|rss|xml)/){
		print "$$link[2]\n";
		push @urls3dep, $$link[2];
  		$cnt++;
	}
	}
     
     }
}


