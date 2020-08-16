/*
Copyright (C) 2016-2017 by Computaional Linguistics Research Group (CLRG), AU-KBC Research Centre, MIT Camppus of Anna University, Chrompet, Chennai. 

AUKBC Tamil Morph Analyser Light Weight  v1.0 website:  http://au-kbc.org/nlp


AUKBC Tamil Morph Analyser Light Weight v1.0 is a free software. You can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, version 3 of the License.

AUKBC Tamil Morph Analyser Light Weight v1.0 is distributed WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

Please see the GNU General Public License  available at http://www.gnu.org/licenses for further license details
##
*/



import java.io.*;
import java.lang.*;
//import java.lang.StringBuffer;
//import java.lang.Integer;
import java.util.StringTokenizer;

public class convert_WX_UTF_tam {
	
	
	/**
	 * An empty constructor
	 */
	public convert_WX_UTF_tam() {}
	

private String[][] Iitk2Char = {
                {"k","\u0B95","\u0BCD"},
                {"f","\u0B99","\u0BCD"},
                {"c","\u0B9A","\u0BCD"},
                {"j","\u0B9C","\u0BCD"},
                {"F","\u0B9E","\u0BCD"},
                {"t","\u0B9F","\u0BCD"},
                {"N","\u0BA3","\u0BCD"},
                {"w","\u0BA4","\u0BCD"},
                {"n","\u0BA8","\u0BCD"},
                {"nY","\u0BA9","\u0BCD"},
                {"p","\u0BAA","\u0BCD"},
                {"m","\u0BAE","\u0BCD"},
                {"y","\u0BAF","\u0BCD"},
                {"r","\u0BB0","\u0BCD"},
                {"rY","\u0BB1","\u0BCD"},
                {"l","\u0BB2","\u0BCD"},
                {"lY","\u0BB3","\u0BCD"},
                {"lYY","\u0BB4","\u0BCD"},
                {"v","\u0BB5","\u0BCD"},
                {"R","\u0BB7","\u0BCD"},
                {"S","\u0BB8","\u0BCD"},
		{"s","\u0BB8","\u0BCD"},
                {"h","\u0BB9","\u0BCD"},
                {"kA","\u0B95","\u0BBE"},
                {"fA","\u0B99","\u0BBE"},
                {"cA","\u0B9A","\u0BBE"},
                {"jA","\u0B9C","\u0BBE"},
                {"FA","\u0B9E","\u0BBE"},
                {"tA","\u0B9F","\u0BBE"},
                {"NA","\u0BA3","\u0BBE"},
                {"wA","\u0BA4","\u0BBE"},
                {"nA","\u0BA8","\u0BBE"},
                {"nYA","\u0BA9","\u0BBE"},
                {"pA","\u0BAA","\u0BBE"},
                {"mA","\u0BAE","\u0BBE"},
                {"yA","\u0BAF","\u0BBE"},
                {"rA","\u0BB0","\u0BBE"},
                {"rYA","\u0BB1","\u0BBE"},
                {"lA","\u0BB2","\u0BBE"},
                {"lYA","\u0BB3","\u0BBE"},
                {"lYYA","\u0BB4","\u0BBE"},
                {"vA","\u0BB5","\u0BBE"},
                {"RA","\u0BB7","\u0BBE"},
                {"SA","\u0BB8","\u0BBE"},
		{"sA","\u0BB8","\u0BBE"},
                {"hA","\u0BB9","\u0BBE"},
                {"ki","\u0B95","\u0BBF"},
                {"fi","\u0B99","\u0BBF"},
                {"ci","\u0B9A","\u0BBF"},
                {"ji","\u0B9C","\u0BBF"},
                {"Fi","\u0B9E","\u0BBF"},
                {"ti","\u0B9F","\u0BBF"},
                {"Ni","\u0BA3","\u0BBF"},
                {"wi","\u0BA4","\u0BBF"},
                {"ni","\u0BA8","\u0BBF"},
                {"nYi","\u0BA9","\u0BBF"},
                {"pi","\u0BAA","\u0BBF"},
                {"mi","\u0BAE","\u0BBF"},
                {"yi","\u0BAF","\u0BBF"},
                {"ri","\u0BB0","\u0BBF"},
                {"rYi","\u0BB1","\u0BBF"},
                {"li","\u0BB2","\u0BBF"},
                {"lYi","\u0BB3","\u0BBF"},
                {"lYYi","\u0BB4","\u0BBF"},
                {"vi","\u0BB5","\u0BBF"},
                {"Ri","\u0BB7","\u0BBF"},
                {"Si","\u0BB8","\u0BBF"},
		{"si","\u0BB8","\u0BBF"},
                {"hi","\u0BB9","\u0BBF"},
                {"kI","\u0B95","\u0BC0"},
                {"fI","\u0B99","\u0BC0"},
                {"cI","\u0B9A","\u0BC0"},
                {"jI","\u0B9C","\u0BC0"},
                {"FI","\u0B9E","\u0BC0"},
                {"tI","\u0B9F","\u0BC0"},
                {"NI","\u0BA3","\u0BC0"},
                {"wI","\u0BA4","\u0BC0"},
                {"nI","\u0BA8","\u0BC0"},
                {"nYI","\u0BA9","\u0BC0"},
                {"pI","\u0BAA","\u0BC0"},
                {"mI","\u0BAE","\u0BC0"},
                {"yI","\u0BAF","\u0BC0"},
                {"rI","\u0BB0","\u0BC0"},
                {"rYI","\u0BB1","\u0BC0"},
                {"lI","\u0BB2","\u0BC0"},
                {"lYI","\u0BB3","\u0BC0"},
                {"lYYI","\u0BB4","\u0BC0"},
                {"vI","\u0BB5","\u0BC0"},
                {"RI","\u0BB7","\u0BC0"},
                {"SI","\u0BB8","\u0BC0"},
		{"sI","\u0BB8","\u0BC0"},
                {"hI","\u0BB9","\u0BC0"},
                {"ku","\u0B95","\u0BC1"},
                {"fu","\u0B99","\u0BC1"},
                {"cu","\u0B9A","\u0BC1"},
                {"ju","\u0B9C","\u0BC1"},
                {"Fu","\u0B9E","\u0BC1"},
                {"tu","\u0B9F","\u0BC1"},
                {"Nu","\u0BA3","\u0BC1"},
                {"wu","\u0BA4","\u0BC1"},
                {"nu","\u0BA8","\u0BC1"},
                {"nYu","\u0BA9","\u0BC1"},
                {"pu","\u0BAA","\u0BC1"},
                {"mu","\u0BAE","\u0BC1"},
                {"yu","\u0BAF","\u0BC1"},
                {"ru","\u0BB0","\u0BC1"},
                {"rYu","\u0BB1","\u0BC1"},
                {"lu","\u0BB2","\u0BC1"},
                {"lYu","\u0BB3","\u0BC1"},
                {"lYYu","\u0BB4","\u0BC1"},
                {"vu","\u0BB5","\u0BC1"},
                {"Ru","\u0BB7","\u0BC1"},
                {"Su","\u0BB8","\u0BC1"},
		{"su","\u0BB8","\u0BC1"},
                {"hu","\u0BB9","\u0BC1"},
                {"kU","\u0B95","\u0BC2"},
                {"fU","\u0B99","\u0BC2"},
                {"cU","\u0B9A","\u0BC2"},
                {"jU","\u0B9C","\u0BC2"},
                {"FU","\u0B9E","\u0BC2"},
                {"tU","\u0B9F","\u0BC2"},
                {"NU","\u0BA3","\u0BC2"},
                {"wU","\u0BA4","\u0BC2"},
                {"nU","\u0BA8","\u0BC2"},
                {"nYU","\u0BA9","\u0BC2"},
                {"pU","\u0BAA","\u0BC2"},
                {"mU","\u0BAE","\u0BC2"},
                {"yU","\u0BAF","\u0BC2"},
                {"rU","\u0BB0","\u0BC2"},
                {"rYU","\u0BB1","\u0BC2"},
                {"lU","\u0BB2","\u0BC2"},
                {"lYU","\u0BB3","\u0BC2"},
                {"lYYU","\u0BB4","\u0BC2"},
                {"vU","\u0BB5","\u0BC2"},
                {"RU","\u0BB7","\u0BC2"},
                {"SU","\u0BB8","\u0BC2"},
		{"sU","\u0BB8","\u0BC2"},
                {"hU","\u0BB9","\u0BC2"},
                {"keV","\u0B95","\u0BC6"},
                {"feV","\u0B99","\u0BC6"},
                {"ceV","\u0B9A","\u0BC6"},
                {"jeV","\u0B9C","\u0BC6"},
                {"FeV","\u0B9E","\u0BC6"},
                {"teV","\u0B9F","\u0BC6"},
                {"NeV","\u0BA3","\u0BC6"},
                {"weV","\u0BA4","\u0BC6"},
                {"neV","\u0BA8","\u0BC6"},
                {"nYeV","\u0BA9","\u0BC6"},
                {"peV","\u0BAA","\u0BC6"},
                {"meV","\u0BAE","\u0BC6"},
                {"yeV","\u0BAF","\u0BC6"},
                {"reV","\u0BB0","\u0BC6"},
                {"rYeV","\u0BB1","\u0BC6"},
                {"leV","\u0BB2","\u0BC6"},
                {"lYeV","\u0BB3","\u0BC6"},
                {"lYYeV","\u0BB4","\u0BC6"},
                {"veV","\u0BB5","\u0BC6"},
                {"ReV","\u0BB7","\u0BC6"},
                {"SeV","\u0BB8","\u0BC6"},
		{"seV","\u0BB8","\u0BC6"},
                {"heV","\u0BB9","\u0BC6"},
                {"ke","\u0B95","\u0BC7"},
                {"fe","\u0B99","\u0BC7"},
                {"ce","\u0B9A","\u0BC7"},
                {"je","\u0B9C","\u0BC7"},
                {"Fe","\u0B9E","\u0BC7"},
                {"te","\u0B9F","\u0BC7"},
                {"Ne","\u0BA3","\u0BC7"},
                {"we","\u0BA4","\u0BC7"},
                {"ne","\u0BA8","\u0BC7"},
                {"nYe","\u0BA9","\u0BC7"},
                {"pe","\u0BAA","\u0BC7"},
                {"me","\u0BAE","\u0BC7"},
                {"ye","\u0BAF","\u0BC7"},
                {"re","\u0BB0","\u0BC7"},
                {"rYe","\u0BB1","\u0BC7"},
                {"le","\u0BB2","\u0BC7"},
                {"lYe","\u0BB3","\u0BC7"},
                {"lYYe","\u0BB4","\u0BC7"},
                {"ve","\u0BB5","\u0BC7"},
                {"Re","\u0BB7","\u0BC7"},
                {"Se","\u0BB8","\u0BC7"},
		{"se","\u0BB8","\u0BC7"},
                {"he","\u0BB9","\u0BC7"},
                {"kE","\u0B95","\u0BC8"},
                {"fE","\u0B99","\u0BC8"},
                {"cE","\u0B9A","\u0BC8"},
                {"jE","\u0B9C","\u0BC8"},
                {"FE","\u0B9E","\u0BC8"},
                {"tE","\u0B9F","\u0BC8"},
                {"NE","\u0BA3","\u0BC8"},
                {"wE","\u0BA4","\u0BC8"},
                {"nE","\u0BA8","\u0BC8"},
                {"nYE","\u0BA9","\u0BC8"},
                {"pE","\u0BAA","\u0BC8"},
                {"mE","\u0BAE","\u0BC8"},
                {"yE","\u0BAF","\u0BC8"},
                {"rE","\u0BB0","\u0BC8"},
                {"rYE","\u0BB1","\u0BC8"},
                {"lE","\u0BB2","\u0BC8"},
                {"lYE","\u0BB3","\u0BC8"},
                {"lYYE","\u0BB4","\u0BC8"},
                {"vE","\u0BB5","\u0BC8"},
                {"RE","\u0BB7","\u0BC8"},
                {"SE","\u0BB8","\u0BC8"},
		{"sE","\u0BB8","\u0BC8"},
                {"hE","\u0BB9","\u0BC8"},
                {"koV","\u0B95","\u0BCA"},
                {"foV","\u0B99","\u0BCA"},
                {"coV","\u0B9A","\u0BCA"},
                {"joV","\u0B9C","\u0BCA"},
                {"FoV","\u0B9E","\u0BCA"},
                {"toV","\u0B9F","\u0BCA"},
                {"NoV","\u0BA3","\u0BCA"},
                {"woV","\u0BA4","\u0BCA"},
                {"noV","\u0BA8","\u0BCA"},
                {"nYoV","\u0BA9","\u0BCA"},
                {"poV","\u0BAA","\u0BCA"},
                {"moV","\u0BAE","\u0BCA"},
                {"yoV","\u0BAF","\u0BCA"},
                {"roV","\u0BB0","\u0BCA"},
                {"rYoV","\u0BB1","\u0BCA"},
                {"loV","\u0BB2","\u0BCA"},
                {"lYoV","\u0BB3","\u0BCA"},
                {"lYYoV","\u0BB4","\u0BCA"},
                {"voV","\u0BB5","\u0BCA"},
                {"RoV","\u0BB7","\u0BCA"},
                {"SoV","\u0BB8","\u0BCA"},
		{"soV","\u0BB8","\u0BCA"},
                {"hoV","\u0BB9","\u0BCA"},
                {"ko","\u0B95","\u0BCB"},
                {"fo","\u0B99","\u0BCB"},
                {"co","\u0B9A","\u0BCB"},
                {"jo","\u0B9C","\u0BCB"},
                {"Fo","\u0B9E","\u0BCB"},
                {"to","\u0B9F","\u0BCB"},
                {"No","\u0BA3","\u0BCB"},
                {"wo","\u0BA4","\u0BCB"},
                {"no","\u0BA8","\u0BCB"},
                {"nYo","\u0BA9","\u0BCB"},
                {"po","\u0BAA","\u0BCB"},
                {"mo","\u0BAE","\u0BCB"},
                {"yo","\u0BAF","\u0BCB"},
                {"ro","\u0BB0","\u0BCB"},
                {"rYo","\u0BB1","\u0BCB"},
                {"lo","\u0BB2","\u0BCB"},
                {"lYo","\u0BB3","\u0BCB"},
                {"lYYo","\u0BB4","\u0BCB"},
                {"vo","\u0BB5","\u0BCB"},
                {"Ro","\u0BB7","\u0BCB"},
                {"So","\u0BB8","\u0BCB"},
		{"so","\u0BB8","\u0BCB"},
                {"ho","\u0BB9","\u0BCB"},
                {"kO","\u0B95","\u0BCC"},
                {"fO","\u0B99","\u0BCC"},
                {"cO","\u0B9A","\u0BCC"},
                {"jO","\u0B9C","\u0BCC"},
                {"FO","\u0B9E","\u0BCC"},
                {"tO","\u0B9F","\u0BCC"},
                {"NO","\u0BA3","\u0BCC"},
                {"wO","\u0BA4","\u0BCC"},
                {"nO","\u0BA8","\u0BCC"},
                {"nYO","\u0BA9","\u0BCC"},
                {"pO","\u0BAA","\u0BCC"},
                {"mO","\u0BAE","\u0BCC"},
                {"yO","\u0BAF","\u0BCC"},
                {"rO","\u0BB0","\u0BCC"},
                {"rYO","\u0BB1","\u0BCC"},
                {"lO","\u0BB2","\u0BCC"},
                {"lYO","\u0BB3","\u0BCC"},
                {"lYYO","\u0BB4","\u0BCC"},
                {"vO","\u0BB5","\u0BCC"},
                {"RO","\u0BB7","\u0BCC"},
                {"SO","\u0BB8","\u0BCC"},
		{"sO","\u0BB8","\u0BCC"},
                {"hO","\u0BB9","\u0BCC"},
};

 private String[][] Iitk = {
                {"H","2947"},
                {"a","2949"},
                {"A","2950"},
                {"i","2951"},
                {"I","2952"},
                {"u","2953"},
                {"U","2954"},
                {"eV","2958"},
                {"e","2959"},
                {"E","2960"},
                {"oV","2962"},
                {"o","2963"},
                {"O","2964"},
                {"ka","2965"},
                {"fa","2969"},
                {"ca","2970"},
                {"ja","2972"},
                {"Fa","2974"},
                {"ta","2975"},
                {"Na","2979"},
                {"wa","2980"},
                {"na","2984"},
                {"nYa","2985"},
                {"pa","2986"},
                {"ma","2990"},
                {"ya","2991"},
                {"ra","2992"},
                {"rYa","2993"},
                {"la","2994"},
                {"lYa","2995"},
                {"lYYa","2996"},
                {"va","2997"},
                {"Ra","2999"},
                {"Sa","3000"},
		{"sa","3000"},
                {"ha","3001"},
        };

 private String[][] Numbers = {
                {"0","\u0030"},
		{"1","\u0031"},
		{"2","\u0032"},
		{"3","\u0033"},
		{"4","\u0034"},
		{"5","\u0035"},
		{"6","\u0036"},
		{"7","\u0037"},
		{"8","\u0038"},
		{"9","\u0039"},
	};
 private String[][] Punctuations = {
                {" ","\u0020"},
                {"!","\u0021"},
                {"#","\u0023"},
                {"&","\u0026"},
                {"(","\u0028"},
                {")","\u0029"},
                {",","\u002C"},
                {"-","\u002D"},
		{".","\u002E"},
		{":","\u003A"},
		{";","\u003B"},
		//{"\r\n","\u0000D"},
		//{"\n","\u0000A"},
		//{"\n","\u240C"},
		//{"\r", "\u240D"},
		//{"\n", "\u2424"},
        };

	/**
	  * Returns the Unicode for the given <code>IITKString</code>.
	  */ 
   public String convertIitkToUnicode(String iitkString) {
   		String	IitkString = iitkString;
   		String unicodeString="";
		StringBuffer	unicodeFontString = new StringBuffer();
		/*
		 *Replaced the default constructor call with the specialized constructor that would make the Tokenizer consider the newline characters in the input as a valid input
		 *Date		:	30-Jan-2007
		 */
		//StringTokenizer st = new StringTokenizer(IitkString);
		StringTokenizer st = new StringTokenizer(IitkString,"\t\n\r ",true);
     		while (st.hasMoreTokens()) {
			String word = st.nextToken();
			//System.out.print("~~" + word + "**");		
			
         		//System.out.println("~" + word + "~");
			unicodeFontString = new StringBuffer("");	
			int code=0;
			int i=5;
			String temp="";
			while(code<word.length()){
					int flag = 0;
					int flag1 = 0;
					int flag2 = 0;
					int flag3 = 0;
					int cnt =code+i;
					if(cnt <=word.length()){	
     						temp=word.substring(code,cnt);
					}
					else{
					 int tt = word.length();
					 int tt1 = cnt - tt;
					 i=i-tt1;
					 cnt=code+i;
					 temp=word.substring(code,cnt);	
					}
					//System.out.println(temp+"~~~~"+code+cnt+i+"^^"+flag+flag1+flag2+flag3);
					for(int arrIndex=0;arrIndex<Iitk2Char.length;arrIndex++){
						//System.out.println("### KKK1 ##"+temp);	
						if(temp.compareTo(Iitk2Char[arrIndex][0])==0){
						    unicodeFontString.append(Iitk2Char[arrIndex][1]);
						    unicodeFontString.append(Iitk2Char[arrIndex][2]);
						    code=code+i;
						    i=6;
						    flag = 1;
						    //System.out.println("\nTrue : 111\n");
						    break;
						}
					}
					if(flag == 0){//start if..
					for(int arrIndex=0;arrIndex<Iitk.length;arrIndex++){
						int code1=Integer.parseInt(Iitk[arrIndex][1]);
						//System.out.println("### KKK2 ##"+temp);	
                                               	if(temp.compareTo(Iitk[arrIndex][0])==0){
                                                    unicodeFontString.append((char)code1);
                                                    code=code+i;
						    i=6;
						    flag1= 1;
						    //System.out.println("\nTrue : 222\n");	
                                                    break;
                                               	}
                                       	}
					}//end if
					if((flag == 0) && (flag1 == 0)){//start if..
                                        for(int arrIndex=0;arrIndex<Numbers.length;arrIndex++){
						//System.out.println("### KKK3 ##"+temp);	
                                                if(temp.compareTo(Numbers[arrIndex][0])==0){
                                                    unicodeFontString.append(Numbers[arrIndex][1]);
                                                    code=code+i;
                                                    i=6;
                                                    flag2= 1;
                                                    //System.out.println("\nTrue : 333\n");
                                                    break;
                                                }
                                        }
                                        }//end if
					if((flag == 0) && (flag1 == 0) && (flag2 == 0)){//start if..
                                        for(int arrIndex=0;arrIndex<Punctuations.length;arrIndex++){
						//System.out.println("### KKK4 ##"+temp);	
                                                if(temp.compareTo(Punctuations[arrIndex][0])==0){
							//System.out.println("P : " + Punctuations[arrIndex][0]);
							unicodeFontString.append(Punctuations[arrIndex][1]);
                                                    	code=code+i;
                                                    	i=6;
                                                    	flag3= 1;
                                                    	//System.out.println("\nTrue : 444\n");
                                                    	break;
                                                }
                                       	}
					}//end if
					i=i-1;
					if(i==0){
                                                i=5;
						code = code+1;
					        unicodeFontString.append(temp);                                              
                                        }

			}
		//System.out.println(unicodeFontString.toString());
		//unicodeString +=unicodeFontString.toString()+" ";
		unicodeString += unicodeFontString.toString();
		}
		//return unicodeString;
		String uString = "";
                //try {
                  //uString = new String(unicodeString.getBytes(),"UNICODE");
                  uString = new String(unicodeString);
                //}
                //catch (java.io.UnsupportedEncodingException e) { };
                return uString;
	}

	
	public static void main(String args[]) throws Exception {
		
		convert_WX_UTF_tam cc = new convert_WX_UTF_tam();

		String input = "", output = "";

		boolean inputGiven = false;
    boolean outputGiven = false;
    boolean helpWanted = false;
    
    String inputFile = null;
    String outputFile = null;

    if (args == null || args.length <= 0) {
      Usage();
      System.exit(0);
    }   
    else {
      for (int i=0;i<args.length;i++) {
        if (i != args.length-1 && args[i].trim().equalsIgnoreCase("-i") && (! args[i+1].trim().equals("")) && (! args[i+1].trim().startsWith("-"))) {
          inputGiven = true;
          inputFile = args[i+1].trim();
        }
        else if (i != args.length-1 && args[i].trim().equalsIgnoreCase("-o") && (! args[i+1].trim().equals("")) && (! args[i+1].trim().startsWith("-"))) {
          outputGiven = true;
          outputFile = args[i+1].trim();
        }
        else if (args[i].trim().equalsIgnoreCase("-h")) {
          helpWanted = true;
        }
      }
    }     

    if ((! inputGiven) || (! outputGiven) || helpWanted) {
      Usage(); 
      System.exit(0);
    }     

    //System.out.println("Input : " + inputFile);
    //System.out.println("Output : " + outputFile);

		BufferedReader br;
		BufferedWriter bw;

		try {
			br = new BufferedReader(new InputStreamReader(new FileInputStream(inputFile),"UTF-8"));
			bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(outputFile),"UTF-8"));

			int k,l;
			String iitk_str="";

			while((input=br.readLine())!=null) {
				//System.out.println(input);
				output = "";
				if(input.indexOf("xx35") >=0){
					while((k=input.indexOf("<iitk>")) >=0 ){
						output += input.substring(0,k);
						k+=6; //move the index to the character next to <iitk> tag.
						l = input.indexOf("</iitk>"); 
						iitk_str = input.substring(k,l);
						output += iitk_str;
						input = input.substring(l+7);
					}
					output += input;
				}
				else{
					while((k=input.indexOf("<iitk>")) >=0 ){
						output += input.substring(0,k);
						k+=6; //move the index to the character next to <iitk> tag.
						l = input.indexOf("</iitk>"); 
						iitk_str = input.substring(k,l);
						output += cc.convertIitkToUnicode(iitk_str);
						input = input.substring(l+7);
					}
					output += input;
				}
				//output = cc.convertIitkToUnicode(input);

				bw.write(output + System.getProperty("line.separator"));
			}
			bw.close();

		} catch(Exception e) {
			e.printStackTrace();
		}
	}

	private static void Usage() {
    System.err.println("Usage: convert_WX_UTF_tam -i <inputFile> -o <outputFile> [-h]");
  }
}
