#!/usr/bin/perl

##Copyright (C) 2016-2017 by Computaional Linguistics Research Group (CLRG), AU-KBC Research Centre, MIT Camppus of Anna University, Chrompet, Chennai.	

##AUKBC Tokenizer v1.0 website:  http://au-kbc.org/nlp/

##AUKBC Tokenizer v1.0 is a free software. You can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, version 3 of the License.

##AUKBC Tokenizer v1.0 is distributed WITHOUT ANY WARRANTY; without the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

##Please see the GNU General Public License details at  <http://www.gnu.org/licenses/>

##


#enabling unicode support
##use encoding 'utf8';
use utf8;
binmode(STDIN, ":encoding(UTF-8)");
binmode(STDOUT, ":encoding(UTF-8)");
$count =1;

undef @filearray;

#words in this file (with numbers) need not be disturbed in tokenizer#
open(FI, "notbesplittedwords.txt") or die "can't open the file $!\n";
while(<FI>){
	chomp;
	next if($_ =~ /^#/);
	$wordHash{$_}++;
}
close(FI);


#$filename=$ARGV[0];
#open(FH,"$filename");

binmode(STDIN, ":encoding(UTF-8)");
$/=undef;
$input =<STDIN>;
$input=~s/\n+/ /g;

#print "$input";
#close(FH);

#$kimistr = "ki.mI.";

#------------sentence splitter-------------------

	$W = "[^0-9A-Za-z_ஂ-௺]";
	#$W = "[^0-9A-Za-z_\\x{0b80}-\\x{0bff}]";
	
	@farr = ();
	#$input =~ s/ (\d+\.?)ki\.mI\.?\E/ \1  kiDOTmIDOT /g;
	#$input =~ s/ (\d+(\.\d+)?-?)ki\.mI\.?\E/ \1 kiDOTmIDOT /g;
	#$input =~ s/ ki\.mI\.?\E/ kiDOTmIDOT /g;

	#$wrds_excep="((ki\.mI\.?)|(ca\.ki\.mI\.?)|(ki\.mIttar)|(mI\.?)|(ki\.?))";
	$wrds_excep="((ki\.mI\.?)|(ca\.ki\.mI\.?)|(ki\.mIttar)|(mI\.?)|(ki\.?)|(கி\.மீ\.?)(ச\.கி\.மீ\.?)|(கி\.மீட்டர்\.?)|(மீ\.?)|(கி\.?))"; #with unicode support

	if($input=~/ (\d+\.?)($wrds_excep\.?)\E/){
		$match=$2;
		$omatch=$match;
		$omatch=~s/\./DOT/g;
		$input =~ s/ (\d+\.?)$match\E/ \1  $omatch /g;
	}
	elsif($input=~/ (\d+(\.\d+)?-?)($wrds_excep)\E/){
		$match=$2;
		$omatch=$match;
		$omatch=~s/\./DOT/g;
		$input =~ s/ (\d+(\.\d+)?-?)$wrds_excep\E/ \1 $omatch /g;
	}


	$input =~ s/\.+ /\. /g; 
	$input =~ s/ wiru\./ wiruDOT/g;
	$input =~ s/ திரு\./ திருDOT/g; #tamil font
	$input =~ s/ wirumawi\./ wirumawiDOT/g;
	$input =~ s/ திருமதி\./ திருமதிDOT/g; #tamil font
	$input =~ s/ uyarwiru\./ uyarwiruDOT/g;
	$input =~ s/ உயர்திரு\./ உயர்திருDOT/g; #tamil font
	#print STDERR "111$input\n";
	$input =~ s/ rU\.(\d+)\-(\w+)/ rUDOT $1-$2/g;
	$input =~ s/ rU\.(\d+) / rUDOT $1 /g;
	$input =~ s/ ரூ\.(\d+)\-(\w+)/ ரூDOT $1-$2/g; #tamil font
	#print STDERR "222$input\n";
	
	while ($input =~ /\b((.*?)[.?!])\s*([^ ]*)\b/g)
	{
		my ($before,$after) = ($`.$1,$3.$');
		#------- do not split the abbreviations--------
		if($before=~/\.[^ ]+\.$/ or $before=~/(^| )[^ ]{1,3}\.$/){
				#print STDERR "BEFFF $before\n";
				#print STDERR "AFFF $after\n";
				pos($input) = length($before)+1;
			
		}
		else
		{
			push(@farr,$before);
			$input = $after;
			pos($input) = 0;
		}
	}
	push(@farr,$input);

#-----------checking the split sentences---------------

	foreach $f(@farr)
	{
		chomp($f);
		$f=~s/\n/ /g;
		push(@farr1,$f);
		#print "$f\n";
	}

#------------preprocessing the tokens-----------------
	foreach $_(@farr1)
	{
		chomp($_);
		s/\n\.\n([^\"A-Z])/\.\n$1/g;      # put periods behind abbreviations
		s/(\.[A-Z]+)\n\.\n/$1.\n/g;       # put periods behind abbreviations
		#s/\.\s*$/ \./g;
			
#code cmod mm 
		s/(\d+)([!~@?#`'‘’“”";×x()<>\&\$\]\[\^\*]+)/$1 $2 /g; #separating special characters like punctuation
			s/(\s*\d+\s*\-\s*\d+\s*\-\s*\d+\w*\s*)/ $1 /g;
			while($_ =~ /\s*(\d+(\.\d+)?-*–*)([a-zA-Z]+)\s*/g){
					$digstr=$1;
					$folstr=$3;
					$fullistr=$digstr.$folstr;
					#print STDERR "HERE1111 $folstr --- $fullistr\n";
					if(!exists $wordHash{$folstr}){
						#print STDERR "HERE2222 $folstr --- $fullistr\n";
						$_ =~ s/$fullistr/ $digstr $folstr /g;
					}
			}
			
				
		#s/(rU\.\d+\-\w+)/ $1 /g; #code cmod mm
###code cmod mm end
		
		
		# put space around colons and commas, unless they're surrounded by numbers
		s/([0-9])\:([0-9])/$1<CLTKN>$2/g;
		s/\:/ \: /g;
		s/([0-9])<CLTKN>([0-9])/$1\:$2/g;
		s/([0-9])\,([0-9])/$1<CMTKN>$2/g;
		s/\,/ \, /g;
		s/([0-9])<CMTKN>([0-9])/$1\,$2/g;
		
		# put space before any other punctuation
		s/([^ ])\!/$1 \!/g;
		s/([^ ])\?/$1 \?/g;
		s/([^ ])\;/$1 \;/g;
		s/([^ ])\"/$1 \"/g;
		s/([^ ])\)/$1 \)/g;
		s/([^ ])\(/$1 \(/g;
		s/([^ ])\//$1 \//g;
		s/([^ ])\.$/$1 \./g; #change cmod mm
		
		# put space after any other punctuation
		s/\!([^ ])/\! $1/g;
		s/\?([^ ])/\? $1/g;
		s/\;([^ ])/\; $1/g;
		s/\"([^ ])/\" $1/g;
		s/\(([^ ])/\( $1/g;
		s/\)([^ ])/\) $1/g;
		s/\/([^ ])/\/ $1/g;
		#s/\.([^ ])/\. $1/g; #change cmod mm #enabling splitting of abbr & initials
		
		#put spaces around special symbols
		s/([^ ])\%/$1 \%/g;
		s/([^ ])\$/$1 \$/g;
		s/([^ ])\+/$1 \+/g;
		s/([^ ])\#/$1 \#/g;
		s/([^ ])\*/$1 \*/g;
		s/([^ ])\[/$1 \[/g;
		s/([^ ])\]/$1 \]/g;
		s/([^ ])\{/$1 \{/g;
		s/([^ ])\}/$1 \}/g;
		s/([^ ])\>/$1 \>/g;
		s/([^ ])\</$1 \</g;
		s/([^ ])\_/$1 \_/g;
		##s/([^ ])\-/$1 \-/g if(($_ !~ /\s*\d+\s*\-\s*\d+\s*\-\s*\d+\w*\s*/) or ($_ =~ /\d+\-\w+/));
		s/([^ ])\\/$1 \\/g;
		s/([^ ])\|/$1 \|/g;
		s/([^ ])\=/$1 \=/g;
		s/([^\d])\,/$1 \, /g;
		
		s/([^ ])\'/$1 \'/g;
		s/([^ ])\`/$1 \`/g;
		s/([^ ])”/$1 ”/g;
		s/([^ ])“/$1 “/g;
		s/([^ ].+?)\"/$1 \"/g; #change cmod mm
		s/\‘([^ ])/\‘ $1/g; #change cmod mm
		s/\‘([^ ])/\‘ $1/g; #change cmod mm
		s/([^ ])\’/$1 \’/g; #change cmod mm
		s/(\D+)\-(\D+)/$1 \- $2/g;
		s/(\D+)\-(\D+)([?.])+/$1 \- $2 $3/g;
		
		#-------------------------------
		
		s/\%([^ ])/\% $1/g;
		s/\$([^ ])/\$ $1/g;
		s/\+([^ ])/\+ $1/g;
		#s/\-([^ ])/\- $1/g if($_ !~ /\s*\d+\s*\-\s*\d+\s*\-\s*\d+\w*\s*/);
		##s/\-([^ ])/\- $1/g if(($_ !~ /\s*\d+\s*\-\s*\d+\s*\-\s*\d+\w*\s*/) or ($_ =~ /\d+\-\w+/));
		s/\#([^ ])/\# $1/g;
		s/\*([^ ])/\* $1/g;
		s/\[([^ ])/\[ $1/g;
		s/\]([^ ])/\] $1/g;
		s/\}([^ ])/\} $1/g;
		s/\{([^ ])/\{ $1/g;
		s/\\([^ ])/\\ $1/g;
		s/\|([^ ])/\| $1/g;
		s/\_([^ ])/\_ $1/g;
		s/\<([^ ])/\< $1/g;
		s/\>([^ ])/\> $1/g;
		s/\=([^ ])/\= $1/g;
		
		
		s/\'([^ ])/\' $1/g;
		s/\`([^ ])/\` $1/g;
		s/”([^ ])/” $1/g;
		s/“([^ ])/“ $1/g;
		
		# ... by FULL-STOP, SINGLE-QUOTE, HYPHEN, AMPERSAND, unless it has a letter on both sides
		#s/(?<=\W) [\.\-\&]|[\.\-\&] (?=\W)//g;
		s/(?<=\W) [\.\-\&]|[\.\-\&] (?=\W)//g if($_ !~ /(\D+)\s\-\s(\D+)/);
		s/^\s+|\s+$//g;
        s/(\w+)\.$/$1 \./g; #change cmod mm
		s/DOT/\./g;
	#print STDERR "44444$_\n";
	@line=split(/\s+/,$_);
	
	#-----------------tokenize---------------
	 #print "<Sentence id=\"$count\">\n";
    $count1 = 1;
    foreach $tok(@line)
    {
        #print "$count1\t$tok\tunk\n";
        ######-- print "$tok ";
        print "$tok\n";
	push(@filearray,"$tok\n");
        $count1++;
    }
    print "\n";
    undef $count1;
        #print "<\/Sentence>\n\n";
        #####--print "\n";
	push(@filearray,"\n");
        $count++;
        undef @line;
}                    



