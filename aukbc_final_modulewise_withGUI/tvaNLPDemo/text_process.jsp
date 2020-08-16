<%@ page
  session="true"
  contentType="text/html; charset=UTF-8"
  import="java.io.*"
  import="java.util.*"
  import="java.net.*"
  import="java.lang.*"

%>

<%
 //set the character encoding to use when interpreting request values
   request.setCharacterEncoding("UTF-8");
  // get content from request
  String urlscrap = request.getParameter("url1");
  String input ="";
  String output ="";
  int urlflag=0;
  int contflag=0;
  BufferedWriter bw = new BufferedWriter(new  OutputStreamWriter(new FileOutputStream("/home/aukbc/apache-tomcat-8.0.18/webapps/tvademo/new-TVA-29March2017/PipelineModule/input_url1")));

 bw.write(urlscrap);
 bw.close();
  //out.println( urlscrap + "----" + filecontent);

try {
     String[] cmd=null;
     cmd = new String[] { "./test.sh", "input_url1" };
      Process p = Runtime.getRuntime().exec(cmd, null, new File("/home/aukbc/apache-tomcat-8.0.18/webapps/tvademo/new-TVA-29March2017/PipelineModule/"));
      p.waitFor();
	}
	catch(Exception ex){
		System.out.println(ex);
	}
	//BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream("/home/aukbc/apache-tomcat-8.0.18/webapps/tvademo/new-TVA-29March2017/PipelineModule/final_Output.txt")));
	//while((input=br.readLine())!=null) {
	//	output += input + System.getProperty("line.separator");
   	//}
   	//br.close();
	   //output = output.replace("<","&lt;");
	   //output = output.replace(">","&gt;");
   	//output = output.replace("\n","<br>");

 	//String opfilename1="pos_tagged_utf_" + gensuff +".html";
   	//String opfilename2="shortFreq_" + gensuff +".html";

%>
 <iframe src="final_Output.html" frameborder="0" style="overflow:hidden" height="100%" width="100%"></iframe>


