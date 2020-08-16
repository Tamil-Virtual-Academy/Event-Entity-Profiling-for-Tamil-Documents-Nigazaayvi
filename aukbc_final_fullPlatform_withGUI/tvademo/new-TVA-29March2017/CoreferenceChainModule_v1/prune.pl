#!/usr/bin/perl

##Copyright (C) 2016-2017 by Computaional Linguistics Research Group (CLRG), AU-KBC Research Centre, MIT Camppus of Anna University, Chrompet, Chennai.	

##AUKBC Tamil POSTagger v1.0 website:  http://au-kbc.org/nlp/Tol.html

##AUKBC Tamil POSTagger v1.0 is a free software. You can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, version 3 of the License.

###AUKBC Tamil POSTagger v1.0 is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

##You should have received a copy of the GNU General Public License along with this program.  If not, see http://www.gnu.org/licenses
##

while(<>){
	chomp;
	if($_ eq undef) { print "\n"; next; }
	@aarr=split(/\s+/,$_);
	$aarr[3] = "<iitk>$aarr[3]<\/iitk>";

	$line = join "\t", @aarr;
	##$last=pop(@aarr);
	$line =~ s/\t$//;
	print "$line\n";
	#print "<iitk>$aarr[0]<\/iitk>\t$aarr[1]\t$aarr[2]\t$aarr[3]\t$aarr[4]\n";
}
