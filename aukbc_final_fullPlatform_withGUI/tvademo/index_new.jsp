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
<title>Tamil Syntactic - Semantic Processing Bench </title>
<link rel="stylesheet" type="text/css" href="simple.css"/>
<script type="text/javascript">

 function queryfocus() { document.identify.url1.focus(); }

</script>
</head>

<body onLoad="queryfocus();">

<form name="identify" action="text_process.jsp" method="post">
 <table>
  <tr>

<td align="left"><img src="cwhome.jpeg" height="150" width="120"></td>
<td align="center" width="1050">
   <font size="5">Tamil Syntactic - Semantic Processing Bench</b><br></font>

   <font size="3"><b>(Project funded by Tamil Virtual Academy)</b><br></font>
   <font size="5"><b>கணினி மொழியியல் ஆராய்ச்சிக் குழு</b><br></font>
  <b>Computational Linguistics Research Group,</b><br>
  <b>AU-KBC Research Centre</b><br>
</td>
<td align="right"><img src="AnnaLogo3.png" height="150" width="100"></td>
</tr>
</table>
<hr>

 <center>
 <p> Please enter the URL: </p>
 <TEXTAREA NAME="url1" cols=90 rows=2 WRAP=VIRTUAL></TEXTAREA><br><br> 
 <p> Please enter the text: </p>
 <TEXTAREA NAME="textInp" cols=90 rows=16 WRAP=VIRTUAL></TEXTAREA><br><br>
<table>
<td><tr> <button type="button-tokenise">Tokenise</button> </tr>
<tr> <button type="button-morph">Morphanalyse</button> </tr>
<tr> <button type="button-pos">PoS</button> </tr>
<tr> <button type="button-chunk">Chunking</button> </tr>
<tr> <button type="button-ClauseId">ClauseBoundary</button> </tr>
<tr> <button type="button-NER">NER</button> </tr></td><br><br>
<td>
<tr> <button type="button-pnAR">Prononimal Resolution</button> </tr>
<tr> <button type="button-nounAR">Noun-Noun Anaphora Resolution</button> </tr>
<tr> <button type="button-corefChain">Co-reference Chain builder</button> </tr>
</td>
</table><br>
 <input type="submit" value="Analyse">
  </center>
</form>

<center>

</center>

</body></html>
