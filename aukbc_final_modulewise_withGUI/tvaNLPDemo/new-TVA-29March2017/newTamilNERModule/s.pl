$arg=$ARGV[0];
my @a,$v,$j,$i,$k,%hash,$s,@x,@b;
$j=0,$p=0,$n=0,$ne=0,$m=0;

undef %hash;

open(f1,"<$arg") or die "Could not open '$filename': $!";
   #$i=0;
             
	while($line=<f1>)
	{
	 chomp($line);
		 if(($line=~m/^\s*$/))
          	 {
			 
			 #print"NE:$ne\n";
            		 if($ne==1){&compare(@a1);}
            		 undef(@a);
	    		 undef(@a1);
			 $ne=0;$cnt=0;$i=0;
            		 next; 
            	}
		else
		{
			 @b = split(/\t/,$line);
			 $l=@b;
			 if($b[$l-1]=~/B-.*/){$ne++;}
             		 #$a[$j]  = $line;
	    		 $a1[$i] = $line;
            		 $i++;
		}
	}

close(f1);

sub compare()
{

	$z=scalar(@a1);
     	
for($k=0;$k<$z;$k++){
	print"$a1[$k]\n";
}
print"\n";
#$m=$k;

}
                                      
