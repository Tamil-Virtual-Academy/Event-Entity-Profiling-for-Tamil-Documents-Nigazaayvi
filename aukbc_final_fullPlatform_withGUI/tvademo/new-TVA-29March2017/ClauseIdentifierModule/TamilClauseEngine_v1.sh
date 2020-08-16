
##Copyright (C) 2016-2017 by Computaional Linguistics Research Group (CLRG), AU-KBC Research Centre, MIT Camppus of Anna University, Chrompet, Chennai. 

###AUKBC Tamil Clause Tagger  v1.0 website:  http://au-kbc.org/nlp


##AUKBC Tamil Clause Tagger v1.0 is a free software. You can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, version 3 of the License.

###AUKBC Tamil Clause Tagger v1.0 is distributed WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

##3Please see the GNU General Public License  available at http://www.gnu.org/licenses for further license details
##

java convert_UTF_WX_tam -i $1 -o clause_wx_interim1.txt
perl split2clausetype_new.pl < clause_wx_interim1.txt | perl prune_clause.pl > clause_out_wx_interim2.txt
java convert_WX_UTF_tam -i clause_out_wx_interim2.txt -o $1_clause_out.txt
cat $1_clause_out.txt
##rm morph_interim1.txt morph_out_wx_interim2.txt 
