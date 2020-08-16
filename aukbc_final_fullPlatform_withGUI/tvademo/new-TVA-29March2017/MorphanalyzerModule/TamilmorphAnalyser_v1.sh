
##Copyright (C) 2016-2017 by Computaional Linguistics Research Group (CLRG), AU-KBC Research Centre, MIT Camppus of Anna University, Chrompet, Chennai. 

###AUKBC Tamil Morph Analyser Light Weight  v1.0 website:  http://au-kbc.org/nlp


##AUKBC Tamil Morph Analyser Light Weight v1.0 is a free software. You can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, version 3 of the License.

###AUKBC Tamil Morph Analyser Light Weight v1.0 is distributed WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

##3Please see the GNU General Public License  available at http://www.gnu.org/licenses for further license details
##

java convert_UTF_WX_tam -i $1 -o morph_interim1.txt
perl tamil-morph-lightweight_v1.pl < morph_interim1.txt | perl prune_new.pl > morph_out_wx_interim2.txt
java convert_WX_UTF_tam -i morph_out_wx_interim2.txt -o $1_morph_out.txt
cat $1_morph_out.txt
##rm morph_interim1.txt morph_out_wx_interim2.txt 
