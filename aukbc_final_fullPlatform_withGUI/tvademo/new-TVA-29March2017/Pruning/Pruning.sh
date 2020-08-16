##Copyright (C) 2016-2017 by Computaional Linguistics Research Group (CLRG), AU-KBC Research Centre, MIT Camppus of Anna University, Chrompet, Chennai.

##AUKBC Tamil POSTagger v1.0 website:  http://au-kbc.org/nlp/

##AUKBC Tamil POSTagger v1.0 is a free software. You can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, version 3 of the License.

###AUKBC Tamil POSTagger is distributed WITHOUT ANY WARRANTY; without the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

##You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>


java convert_UTF_WX_tam -i $1 -o pruning_interim1.txt
perl pruneMultiAnalysis.pl < pruning_interim1.txt | perl prune.pl > pruning_interim2.txt
java convert_WX_UTF_tam -i pruning_interim2.txt -o $1_pruning_out.txt
cat $1_pruning_out.txt

