use strict;
use LWP::UserAgent;
use LWP::Simple;
use constant URL => 'http://tamil.oneindia.com/news/tamilnadu/pro-farmer-protest-held-like-army-surgical-strike-chennai-279654.html';

main();
exit(0);

sub main
{
   print "Fetching '" . URL . "' with LWP::UserAgent\n";

   my $ua = LWP::UserAgent->new();
   my $response = $ua->get(URL);
	$contents = $response->content();
	print"$contents\n";
   if ( $response->is_success )
   {
      my $len = length($response->content);
      print "Retrieved $len bytes\n";
   }
   else
   {
      my $code = $response->code;
      print "Failed to retrieve URL: $code\n";
   }

   print "Fetching '" . URL . "' with LWP::Simple\n";
   my $content = LWP::Simple::get( URL );

   if ( $content )
   {
      my $len = length($content);
      print "Retrieved $len bytes\n";
   }
   else
   {
      print "Failed to retrieve URL\n";
   }
}

