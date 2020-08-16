open(F,$ARGV[0]);
while(<F>)
{chomp;
$word=$_;
 if($_ =~ /^\s*$/) {
        #      print "\n";
                next;
        }

next if($_ eq undef);
@arr = split(/\t/,$_);
$l=  @arr;
=c
	if(($arr[0]=~/^\s*$/)&&($arr[1]=~/^\s*$/)&&($arr[2]=~/^\s*$/)){$arr[0]="NN";$arr[1]="NN";$arr[2]="NN";


	print"$arr[0]\t$arr[1]\t$arr[2]\t$arr[3]\t$arr[4]\t$arr[5]\n";}

	elsif(($arr[0]=~/^\s*$/)&&($arr[1]=~/^\s*$/)){
                $arr[0]="NN";$arr[1]="NN";
                print"$arr[0]\t$arr[1]\t$arr[2]\t$arr[3]\t$arr[4]\t$arr[5]\n";
                }

	 elsif($arr[0]=~/^\s*$/){
        $arr[0]=$arr[1];$arr[1]="NN";
                print"$arr[0]\t$arr[1]\t$arr[2]\t$arr[3]\t$arr[4]\t$arr[5]\n";
                }

	elsif($arr[1]=~/^\s*$/){
        $arr[1]="NN";
               print"$arr[0]\t$arr[1]\t$arr[2]\t$arr[3]\t$arr[4]\t$arr[5]\n";
                }
#	else{print"$arr[0]\t$arr[1]\t$arr[2]\t$arr[3]\t$arr[4]\t$arr[5]\t$arr[6]\n";}
	elsif($arr[5]=~/^\s*$/){
        $arr[5]="o";
               print"$arr[0]\t$arr[1]\t$arr[2]\t$arr[3]\t$arr[4]\t$arr[5]\n";
                }


else{print"$arr[0]\t$arr[1]\t$arr[2]\t$arr[3]\t$arr[4]\t$arr[5]\n";}
=cut
#if($l<6){
	print"$l $.\n";
#}
	


}

