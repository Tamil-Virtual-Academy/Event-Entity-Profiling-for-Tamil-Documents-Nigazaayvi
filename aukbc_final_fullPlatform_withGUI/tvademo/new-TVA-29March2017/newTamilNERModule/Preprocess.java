import java.io.*;
import java.lang.*;
import java.util.Scanner;
import java.util.StringTokenizer;
import java.util.regex.*;
import java.util.*;
public class Preprocess {
public static void main(String[] args) throws FileNotFoundException {
	Preprocess readFile = new Preprocess();
	readFile.suffix(args[0]);
}

public void suffix (String inputFile) throws FileNotFoundException{
	String suf_4, suf_3, pref_4, pref_3, nnp;
	int l;
	Scanner sc;  //I intend to use the info. from the file to do something here
	sc = new Scanner(new FileReader(inputFile));
    	while (sc.hasNext()){
		String x = sc.nextLine();
	//	System.out.println(x);
		if(x.isEmpty()){
			System.out.print("\n");
		}
		else{
        		String[] token = x.split("\t");
			l = token[0].toString().length();
			//check nnp feature
			if(token[1].contains("NNP"))
			{	
				nnp="1";
			}
			else
			{
				nnp="0";
			}

			//suffix prefix 4 char
			if(l>4)
			{
				suf_4=token[0].substring(l-4, l);
				pref_4=token[0].substring(0,4);
			}
			else
			{
				suf_4="0";
				pref_4="0";
			}
			//suffix prefix 3 char
			if(l>3)
                        {
                                suf_3=token[0].substring(l-3, l);
				pref_3=token[0].substring(0,3);
                        }
                        else
                        {
                                suf_3="0";
				pref_3="0";
                        }
			System.out.println(token[0]+"\t"+token[1]+"\t"+token[2]+"\t"+nnp+"\t"+pref_4+"\t"+pref_3+"\t"+suf_4+"\t"+suf_3+"\t"+token[token.length-1]);
		}

	}

}



}
