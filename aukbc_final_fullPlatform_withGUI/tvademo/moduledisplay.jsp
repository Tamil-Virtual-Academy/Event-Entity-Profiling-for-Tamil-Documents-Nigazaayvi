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
<a href="http://www.searchko.in:8080/tvademo/" target="_top" title="Home"> முகப்பு </a>
<br>____________________<br>
<a href="url_content.html" target="right1" title="Webpage Content"> வலைத்தள உரை உள்ளடக்கம் </a>
<br>____________________<br>
<a href="Tokenizer_Output.html" target="right1" title="Tokenizer"> சொல் பிரித்தெடுப்பி </a><br><br><br>
<a href="Morph_Output.html" target="right1" title="Morph Analyser"> உருபு பகுப்பாய்வி </a><br><br>
<a href="POS_Output.html" target="right1" title="POS Tagger"> சொல் இலக்கணக்குறிப்பி </a><br><br><br>
<a href="Chunk_Output.html" target="right1" title="Chunker"> தொடர் தொகுப்பி </a><br><br>
<a href="Clause_Output.html" target="right1" title="Clause Identifier"> எச்சத்தொடர் அடையாளங்காட்டி </a><br><br><br>
<a href="NER_Output.html" target="right1" title="Named Entity Recognizer"> பெயர் பொருள் உணரி </a><br><br>
<a href="Anaphora_Output.html" target="right1" title="Anaphora Resolution"> முற்சுட்டு ஆய்வி  </a><br><br><br>
<a href="CorefChain_Output_linear.html" target="right1" title="Coreference Chain"> இணைப்பெயர் தெளிவுத் திறன் </a>
<br>____________________<br>
<a href="CorefChain_Output.html" target="right1" title="All Module Outputs"> அனைத்து கருவிகள் வெளியீடுகளை </a>
</p>
</body></html>

