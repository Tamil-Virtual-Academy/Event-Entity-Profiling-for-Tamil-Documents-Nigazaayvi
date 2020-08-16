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

binmode(STDIN, ":encoding(UTF-8)");
$/=undef;
$input =<STDIN>;
$input =~ s/\cM//g;
$input=~s/\n\n\n/\n\n/g;
$input=~s/\n\n\n/\n\n/g;
$input=~s/\n\n\n/\n\n/g;
$input=~s/\n\n\n/\n\n/g;
$input=~s/\n\n\n/\n\n/g;
$input=~s/\n\n\n/\n\n/g;
$input=~s/^\n+//g;
$input=~s/\n+$//g;


$input =~ s/பொன்\n\.\n\n/பொன்\n\.\n/;
$input =~ s/தொல்\n\.\n\n/தொல்\n\.\n/; 
$input =~ s/பிவி\n\.\n\n/பிவி\n\.\n/; 

$input =~ s/\.\n\.\n\.\n\.\n/...../g;
$input =~ s/\.\n\.\n\.\n/...../g;
$input =~ s/\:\s*\n\n/\:\n/g;

print $input
