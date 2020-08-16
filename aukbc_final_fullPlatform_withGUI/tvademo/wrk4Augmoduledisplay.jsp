<%--
  Licensed to the Apache Software Foundation (ASF) under one or more
  contributor license agreements.  See the NOTICE file distributed with
  this work for additional information regarding copyright ownership.
  The ASF licenses this file to You under the Apache License, Version 2.0
  (the "License"); you may not use this file except in compliance with
  the License.  You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
--%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%
  // To prevent the character encoding declared with 'contentType' page
  // directive from being overriden by JSTL (apache i18n), we freeze it
  // by flushing the output buffer.
  // see http://java.sun.com/developer/technicalArticles/Intl/MultilingualJSP/
  out.flush();
%>
<%@ page
  session="true"
  contentType="text/html; charset=UTF-8"
  import="java.io.*"
  import="java.util.*"
  import="java.net.*"
  import="java.lang.*"
%>


<html>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<head>
<title>Event - Entity Profiling </title>
<style type="text/css">
body {
	margin-top: 0px;
	padding-top: 10px;
}

</style> 
</head>

<body>
<p align="left">
<a href="http://www.searchko.in:8080/tvademo/" target="_top"> Home </a>
<br>____________________<br>
<a href="url_content.html" target="right1"> Content Currently Processed </a>
<br>____________________<br>
<a href="Tokenizer_Output.html" target="right1"> Tokenizer </a><br><br><br>
<a href="Morph_Output.html" target="right1"> Morph Analysis </a><br><br>
<a href="POS_Output.html" target="right1"> POS </a><br><br><br>
<a href="Chunk_Output.html" target="right1"> Chunker </a><br><br>
<a href="Clause_Output.html" target="right1"> Clause Tagger </a><br><br><br>
<a href="NER_Output.html" target="right1"> Named Entity </a><br><br>
<a href="Anaphora_Output.html" target="right1"> Anaphora  </a><br><br><br>
<a href="CorefChain_Output_linear.html" target="right1"> Coreference Chain </a>
<br>____________________<br>
<a href="CorefChain_Output.html" target="right1"> All Module Outputs </a>
</p>
</body></html>

