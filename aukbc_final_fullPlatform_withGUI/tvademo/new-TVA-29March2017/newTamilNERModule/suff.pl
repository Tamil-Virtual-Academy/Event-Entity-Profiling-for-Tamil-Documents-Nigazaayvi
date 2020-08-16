#! /usr/bin/perl -w
##use feature 'unicode_strings';
use strict;
use warnings;
use utf8;
#use utf8;
binmode(STDOUT,":utf8");
open(F,'<:encoding(UTF-8)',$ARGV[0]);
#open(F,$ARGV[0]);
while(<F>)
{
chomp;
	my $line=$_;
	if($line =~ /^\s*$/) {
              print "\n";
	#	next;
        }
	#next if($line eq undef);
	else{
	my @arr=split(/\t/,$line);my $l=@arr;
	my $len=length $arr[0];
	
	my $psuf1=substr $arr[0],-4;
	my $psuf2=substr $arr[0],-3;
	my $psuf3=substr $arr[0],-2;
	my $suf1=substr $arr[0],0,4;
	my $suf2=substr $arr[0],0,3;
	my $suf3=substr $arr[0],0,2;
	if($len<=4){$psuf1=0;$suf1=0;}
	if($len<=3){$psuf2=0;$suf2=0;}
	if($len<=2){$psuf3=0;$suf3=0;}
=c
	if($arr[1]=~/NNP/)
	{
		my $nn=1;
	}
	else{ my $nn=0;}
=cut
	#if($len<=4){$suf1=0;}
		#print"$arr[0]\t$arr[1]\t$arr[2]\t$arr[3]\t$psuf1\t$psuf2\t$psuf3\t$suf1\t$suf2\t$suf3\t$arr[$l-1]\n";
	#	print"$arr[0]\t$arr[1]\t$arr[2]\t$suf1\t$suf2\t$psuf1\t$psuf2\t$arr[$l-1]\n";
		print"$arr[0]\t$arr[1]\t$arr[2]\t$suf1\t$suf2\t$psuf1\t$psuf2\n";
	#	print"$arr[0]\t$arr[1]\t$suf1\t$suf2\t$psuf1\t$psuf2\t$arr[$l-1]\n";
	}
}
