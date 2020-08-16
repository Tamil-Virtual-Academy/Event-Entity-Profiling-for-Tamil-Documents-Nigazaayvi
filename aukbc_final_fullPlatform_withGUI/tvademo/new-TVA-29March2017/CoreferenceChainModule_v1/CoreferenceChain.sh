perl corefChainBuilder.pl $1 >corf1
perl  putInColumnCoref.pl corf1 > /home/nlp/apache-tomcat-8.5.23//webapps/tvademo/CorefChain_Output_linear.html
perl prune.pl < corf1 >corf2

java convert_WX_UTF_tam -i corf2 -o $1_corefout.txt
cat $1_corefout.txt

