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
  String textInput = request.getParameter("textInp");
  String tokanise_chk = request.getParameter("tokenise_button");
  String morph_chk = request.getParameter("morphanalyse_button");
  String pos_chk = request.getParameter("pos_button");
  String chunking_chk = request.getParameter("chunking_button");
  String clId_chk = request.getParameter("clId_button");
  String ner_chk = request.getParameter("ner_button");

  String AR_chk = request.getParameter("AR_button");
  String coref_chk = request.getParameter("coref_button");

if(textInput!=null && !textInput.isEmpty()) {
  String input ="";
  String output ="";
  int urlflag=0;
  int contflag=0;
  BufferedWriter bw = new BufferedWriter(new  OutputStreamWriter(new FileOutputStream("/home/nlp/apache-tomcat-8.5.23//webapps/tvaNLPDemo/new-TVA-29March2017/PipelineModule/input4processing.txt")));

 bw.write(textInput);
 bw.close();
}

if(tokanise_chk!=null && !tokanise_chk.isEmpty()) {
	//out.println("Tokenise is choosen");
	try {
	     String[] cmd=null;
	     cmd = new String[] { "./test_tokenise.sh", "input4processing.txt" };
	     Process p = Runtime.getRuntime().exec(cmd, null, new File("/home/nlp/apache-tomcat-8.5.23//webapps/tvaNLPDemo/new-TVA-29March2017/PipelineModule/"));
	      p.waitFor();
	}catch(Exception ex){
		System.out.println(ex);
	}
}else if(morph_chk!=null && !morph_chk.isEmpty()) {
	//out.println("morph is choosen");
        try {
             String[] cmd=null;
             cmd = new String[] { "./test_morph.sh", "input4processing.txt" };
             Process p = Runtime.getRuntime().exec(cmd, null, new File("/home/nlp/apache-tomcat-8.5.23//webapps/tvaNLPDemo/new-TVA-29March2017/PipelineModule/"));
              p.waitFor();
        }catch(Exception ex){
                System.out.println(ex);
        }

}else if(pos_chk!=null && !pos_chk.isEmpty()) {
	//out.println("morph is choosen");
        try {
             String[] cmd=null;
             cmd = new String[] { "./test_pos.sh", "input4processing.txt" };
             Process p = Runtime.getRuntime().exec(cmd, null, new File("/home/nlp/apache-tomcat-8.5.23//webapps/tvaNLPDemo/new-TVA-29March2017/PipelineModule/"));
              p.waitFor();
        }catch(Exception ex){
                System.out.println(ex);
        }

}else if(chunking_chk!=null && !chunking_chk.isEmpty()) {
	//out.println("morph is choosen");
        try {
             String[] cmd=null;
             cmd = new String[] { "./test_chunking.sh", "input4processing.txt" };
             Process p = Runtime.getRuntime().exec(cmd, null, new File("/home/nlp/apache-tomcat-8.5.23//webapps/tvaNLPDemo/new-TVA-29March2017/PipelineModule/"));
              p.waitFor();
        }catch(Exception ex){
                System.out.println(ex);
        }
}else if(clId_chk!=null && !clId_chk.isEmpty()) {
	//out.println("morph is choosen");
        try {
             String[] cmd=null;
             cmd = new String[] { "./test_clid.sh", "input4processing.txt" };
             Process p = Runtime.getRuntime().exec(cmd, null, new File("/home/nlp/apache-tomcat-8.5.23//webapps/tvaNLPDemo/new-TVA-29March2017/PipelineModule/"));
              p.waitFor();
        }catch(Exception ex){
                System.out.println(ex);
        }
}else if(ner_chk!=null && !ner_chk.isEmpty()) {
	//out.println("morph is choosen");
        try {
             String[] cmd=null;
             cmd = new String[] { "./test_ner.sh", "input4processing.txt" };
             Process p = Runtime.getRuntime().exec(cmd, null, new File("/home/nlp/apache-tomcat-8.5.23//webapps/tvaNLPDemo/new-TVA-29March2017/PipelineModule/"));
              p.waitFor();
        }catch(Exception ex){
                System.out.println(ex);
        }
}else if(AR_chk!=null && !AR_chk.isEmpty()) {
	//out.println("morph is choosen");
        try {
             String[] cmd=null;
             cmd = new String[] { "./test_AR.sh", "input4processing.txt" };
             Process p = Runtime.getRuntime().exec(cmd, null, new File("/home/nlp/apache-tomcat-8.5.23//webapps/tvaNLPDemo/new-TVA-29March2017/PipelineModule/"));
              p.waitFor();
        }catch(Exception ex){
                System.out.println(ex);
        }
}else if(coref_chk!=null && !coref_chk.isEmpty()) {
	//out.println("morph is choosen");
        try {
             String[] cmd=null;
             cmd = new String[] { "./test_coref.sh", "input4processing.txt" };
             Process p = Runtime.getRuntime().exec(cmd, null, new File("/home/nlp/apache-tomcat-8.5.23//webapps/tvaNLPDemo/new-TVA-29March2017/PipelineModule/"));
              p.waitFor();
        }catch(Exception ex){
                System.out.println(ex);
        }
}

/*
  //out.println( urlscrap + "----" + filecontent);

try {
     String[] cmd=null;
     cmd = new String[] { "./test.sh", "input_url1" };
     Process p = Runtime.getRuntime().exec(cmd, null, new File("/home/nlp/apache-tomcat-8.5.23//webapps/tvaNLPDemo/new-TVA-29March2017/PipelineModule/"));
      p.waitFor();
}catch(Exception ex){
	System.out.println(ex);
}
	//BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream("/home/nlp/apache-tomcat-8.5.23//webapps/tvaNLPDemo/new-TVA-29March2017/PipelineModule/final_Output.txt")));
	//while((input=br.readLine())!=null) {
	//	output += input + System.getProperty("line.separator");
   	//}
   	//br.close();
	   //output = output.replace("<","&lt;");
	   //output = output.replace(">","&gt;");
   	//output = output.replace("\n","<br>");

 	//String opfilename1="pos_tagged_utf_" + gensuff +".html";
   	//String opfilename2="shortFreq_" + gensuff +".html";
*/
%>
<iframe src="final_Output.html" frameborder="0" height="100%" width="100%"></iframe>


