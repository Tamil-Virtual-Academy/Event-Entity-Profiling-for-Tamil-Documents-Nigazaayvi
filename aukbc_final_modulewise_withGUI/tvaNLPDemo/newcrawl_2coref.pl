open(WR, ">/home/aukbc/apache-tomcat-8.0.18/webapps/tvademo/final_Output.txt");
open(FH,$ARGV[0]);
while(<FH>){
	chomp;
	print WR "URL -- > $_\n";
}
close(FH);
close(WR);

