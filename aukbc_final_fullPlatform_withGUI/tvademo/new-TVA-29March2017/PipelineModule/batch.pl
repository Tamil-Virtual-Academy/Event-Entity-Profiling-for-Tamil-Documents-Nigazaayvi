@file=glob("/home/clrg/TVA_Project_Deliverable_milestone2/PipelineModule/crawl-Mar_28_214642_2017/*");

foreach $k(@file)
{    
	@arr=split(/\//,$k);$l=@arr;
	if($k=~/(.+?)\/($arr[$l-1])$/){$dir=$1;$filen=$2;}
	$out=$arr[$l-1]."_neout.txt";
    	$cmd = "sh 1crawler-to-ner.sh $k >  $dir\/$out";
    	system($cmd);
	print "$cmd\n";
}
