open(WR, ">/root/apache-tomcat-6.0.13/webapps/tvademo/final_Output.txt");
open(FH,$ARGV[0]);
while(<FH>){
	chomp;
	print WR "URL -- > $_\n";
}
close(FH);
close(WR);

