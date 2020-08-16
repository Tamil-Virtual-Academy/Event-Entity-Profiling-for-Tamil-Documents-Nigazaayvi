/*
Copyright (C) 2016-2017 by Computaional Linguistics Research Group (CLRG), AU-KBC Research Centre, MIT Camppus of Anna University, Chrompet, Chennai. 

AUKBC Tamil Morph Analyser Light Weight  v1.0 website:  http://au-kbc.org/nlp


AUKBC Tamil Morph Analyser Light Weight v1.0 is a free software. You can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, version 3 of the License.

AUKBC Tamil Morph Analyser Light Weight v1.0 is distributed WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

Please see the GNU General Public License  available at http://www.gnu.org/licenses for further license details
##
*/


import java.io.*;
/**This class is used for converting the Unicode format
 * <BR>string to WX Roman format.
 *@version 1.0
*/

public class convert_UTF_WX_tam{
	
	
	/**
	 * An empty constructor
	 */
	public convert_UTF_WX_tam() {}
	private int[] Unicode1 = { 2947,2949,2950,2951,2952,2953,2954,2958,2959,2960,2962,2963,2964,
              2965,2969,2970,2972,2974,2975,2979,2980,2984,2985,2986,2990,2991,2992,2993,2994,2995,2996,2997,2999,3000,3001};
	private int[] Unicode2 ={3007,3008,3009,3010,3014,3015,3016,3018,3019,3020};
	private int[] prevUnicode = {2965,2969,2970,2972,2974,2975,2979,2980,2984,2985,2986,2990,2991,2992,2993,2994,2995,
                2996,2997,2999,3000,3001,
	};
	private String[] Iitk1 = {"H","a","A","i","I","u","U","eV","e","E","oV","o","O","ka","fa","ca","ja","Fa","ta","Na","wa","na","nYa","pa","ma","ya","ra","rYa","la","lYa","lYYa","va","Ra","sa","ha"};
     	private String[] prevIitk={"k","f","c","j","F","t","N","w","n","nY","p","m","y","r","rY","l","lY","lYY","v","R","s","h"};
	private String[] Iitk2 ={"i","I","u","U","eV","e","E","oV","o","O"};
/**This method is used  for converting the  given unicodeString
  * <BR> to WX Roman format string.	
  * @param  unicodeString -a String 
  * @return iitkstring - a String type
 */
   public String convertUnicodeToIitk(String unicodeString) {
   		StringBuffer	unicodeStringBuffer	=	new StringBuffer(unicodeString);
		StringBuffer	iitkFontString		=	new StringBuffer();
		int				code;
		int 			prevcode;
		//System.out.println("Unicode String =: " + unicodeString);
		for(int charIndex=0;charIndex<unicodeStringBuffer.length();charIndex++) {
			code = (int)unicodeStringBuffer.charAt(charIndex);
			prevcode=code;
			//System.out.println(code + "-" + unicodeStringBuffer.charAt(charIndex));
			if(charIndex>0){
						prevcode=(int)unicodeStringBuffer.charAt((charIndex)-1);
			}			
			if(code > 2944 && code < 3071) {
				for(int arrIndex=0;arrIndex<Unicode1.length;arrIndex++){
					if(code==Unicode1[arrIndex]){
						iitkFontString.append(Iitk1[arrIndex]);
						break;
					}
				}	
				if(code==3021){
						if(iitkFontString.length()>0){
							StringBuffer tempString= new StringBuffer(iitkFontString.toString());
							char lastChar=tempString.charAt(tempString.length()-1);
							iitkFontString.deleteCharAt(iitkFontString.length()-1);
						}
				}
				if(code==3006){
						if(iitkFontString.length()>0){
							StringBuffer tempString= new StringBuffer(iitkFontString.toString());
							char lastChar1=tempString.charAt(tempString.length()-1);
							char lastChar2=tempString.charAt(tempString.length()-2);
							//System.out.println("LastChar11 - " + lastChar1);
							//System.out.println("LastChar22 - " + lastChar2);
							if((lastChar1 == 'V') && (lastChar2 == 'e')){
								iitkFontString.deleteCharAt(iitkFontString.length()-1);
								iitkFontString.deleteCharAt(iitkFontString.length()-1);
								iitkFontString.append("oV");
							}else if(lastChar1 == 'e'){ 
								iitkFontString.deleteCharAt(iitkFontString.length()-1);
								iitkFontString.append("o");
								
							}else{
								char lastChar=tempString.charAt(tempString.length()-1);
                                                                iitkFontString.deleteCharAt(iitkFontString.length()-1);
                                                                iitkFontString.append("A");
							}
						}
				}
				
				for(int arrIndex=0;arrIndex<Unicode2.length;arrIndex++){
					if(iitkFontString.length()>0){
							   if(code==Unicode2[arrIndex]){
									StringBuffer tempString= new StringBuffer(iitkFontString.toString());
										char lastChar=tempString.charAt(tempString.length()-1);
										iitkFontString.deleteCharAt(iitkFontString.length()-1);
										iitkFontString.append(Iitk2[arrIndex]);
										break;
								}
					}
				}

			}
			else{
				iitkFontString.append((char)code);
			}
		}
		//System.out.println("IITK = " + iitkFontString.toString());
		String temp = iitkFontString.toString();
		temp = temp.replace("keVlYa","kO");
		temp = temp.replace("ceVlYa","cO");
		temp = temp.replace("teVlYa","tO");
		temp = temp.replace("weVlYa","wO");
		temp = temp.replace("peVlYa","pO");
		temp = temp.replace("meVlYa","mO");
		temp = temp.replace("veVlYa","vO");
		temp = temp.replace("oVlYa","O");
		//return iitkFontString.toString();
		return temp;
	}

	public static void main(String args[]) {
		
		convert_UTF_WX_tam UtoIITK=new convert_UTF_WX_tam();
		boolean inputGiven = false;
		boolean outputGiven = false;
		boolean helpWanted = false;
		
		String input="",output="";
		
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

		//String inputFile = args[0];
		//String outputFile = args[1];
		try {
			br = new BufferedReader(new InputStreamReader(new FileInputStream(inputFile), "UTF-8"));
			//br = new BufferedReader(new InputStreamReader(new FileInputStream(inputFile), "UNICODE"));
			bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(outputFile), "UTF-8"));
			while((input=br.readLine())!=null) {
				//System.out.println(input);
				output = UtoIITK.convertUnicodeToIitk(input);
				bw.write(output + System.getProperty("line.separator"));
			}
			bw.close();
			br.close();

		} catch(Exception e) {
			e.printStackTrace();
		}
		
	}

	private static void Usage() {
		System.err.println("Usage: convert_UTF_WX_tam -i <inputFile> -o <outputFile> [-h]");
	}
}
