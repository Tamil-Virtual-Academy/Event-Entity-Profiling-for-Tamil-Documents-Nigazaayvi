perl corefChainBuilder.pl $1 >corf1 2> corefChains.txt
perl prune.pl < corf1 >corf2

java convert_WX_UTF_tam -i corf2 -o $1_corefout.txt
cat $1_corefout.txt

