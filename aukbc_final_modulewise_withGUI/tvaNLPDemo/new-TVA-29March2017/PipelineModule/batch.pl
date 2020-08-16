@file=glob("/home/aukbc/apache-tomcat-8.0.18/webapps/tvademo/new-TVA-29March2017/PipelineModule/files_to_check_nemodel/*");
foreach $k(@file)
{    
	@arr=split(/\//,$k);$l=@arr;
	if($k=~/(.+?)\/($arr[$l-1])$/){$dir=$1;$filen=$2;}
	$out=$arr[$l-1]."_neout.txt";
    	$cmd = "sh morph-to-coref.sh $k >  $dir\/$out";
    	system($cmd);
	print "$cmd\n";
}
