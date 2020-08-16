###cat empty.txt > /home/aukbc/apache-tomcat-8.0.18/webapps/tvademo/new-TVA-29March2017/PipelineModule/final_Output.html
cat empty.txt > /home/aukbc/apache-tomcat-8.0.18/webapps/tvademo/final_Output.html
cat empty.txt > /home/aukbc/apache-tomcat-8.0.18/webapps/tvademo/coref_output.html
perl new_crawler2coref.pl $1 > /home/aukbc/apache-tomcat-8.0.18/webapps/tvademo/new-TVA-29March2017/PipelineModule/final_Output.txt

perl makeHtml4Coref.pl  < /home/aukbc/apache-tomcat-8.0.18/webapps/tvademo/new-TVA-29March2017/CoreferenceChainModule_v1/corefChains.txt > /home/aukbc/apache-tomcat-8.0.18/webapps/tvademo/corefChain.html
