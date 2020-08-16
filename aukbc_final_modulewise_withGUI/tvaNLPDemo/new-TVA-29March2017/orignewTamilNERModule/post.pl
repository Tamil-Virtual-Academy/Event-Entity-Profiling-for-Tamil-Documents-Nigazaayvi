#DICTIONARY

open(F,$ARGV[0]);
while(<F>)
{
chomp;
push(@line,$_);
}

open(F1,"date.txt");
while(<F1>)
{
chomp;
$date_str.="(".$_.")|";
}
chop $date_str;
close (F1);


open(F2,"month.txt");
while(<F2>)
{
chomp;
$month_str.="(".$_.")|";
}
chop $month_str;
close (F2);

open(F3,"day.txt");
while(<F3>)
{
chomp;
$day_str.="(".$_.")|";
}
chop $day_str;
close (F3);

open(F4,"period.txt");
while(<F4>)
{
chomp;
$period_str.="(".$_.")|";
}
chop $period_str;
close (F4);


open(F5,"distance.txt");
while(<F5>)
{
chomp;
$distance_str.="(".$_.")|";
}
chop $distance_str;
close (F5);

open(F6,"quantity.txt");
while(<F6>)
{
chomp;
$quantity_str.="(".$_.")|";
}
chop $quantity_str;
close (F6);

open(F7,"money.txt");
while(<F7>)
{
chomp;
$money_str.="(".$_.")|";
}
chop $money_str;
close (F7);

for($i=0;$i<@line;$i++)
{
	if($line[$i]!~/^\s*$/){
	@current=split(/\t/,$line[$i]);$l=@current;
	@next1=split(/\t/,$line[$i+1]);
	@next2=split(/\t/,$line[$i+2]);
	@next3=split(/\t/,$line[$i+3]);
	@next4=split(/\t/,$line[$i+4]);
	$len=@current;

	if(($line[$i+1]=~/\t$month_str/)&&($line[$i]=~/\tQT/)&&($line[$i+2]=~/\tQT/)){#print"HAI\n";
                        $line[$i]=~s/$current[$len-2]\t$current[$len-1]/#B-YEAR\t$current[$len-1]/g;
                        $line[$i+1]=~s/$next1[$len-2]\t$next1[$len-1]/#I-YEAR\t$next1[$len-1]/g;
                        $line[$i+2]=~s/$next2[$len-2]\t$next2[$len-1]/#I-YEAR\t$next2[$len-1]/g;
                        $i=$i+2;
        }
	
	 elsif(($line[$i]=~/\tQT/)&&($line[$i+1]=~/ANtu/)){#print"HAI\n";
                        $line[$i]=~s/$current[$len-2]\t$current[$len-1]/#B-YEAR\t$current[$len-1]/g;
                        $line[$i+1]=~s/$next1[$len-2]\t$next1[$len-1]/#I-YEAR\t$next1[$len-1]/g;
                        $i=$i+1;
        }

	elsif(($line[$i]=~/\d{4,4}/)){#print"HAI\n";
                        $line[$i]=~s/$current[$len-2]\t$current[$len-1]/#B-YEAR\t$current[$len-1]/g;
                       
        }

	if(($line[$i]=~/\t$month_str/)&&($line[$i+1]=~/^\./)&&($line[$i+2]=~/\t$date_str/)){#print"HAI\n";
                        $line[$i]=~s/$current[$len-2]\t$current[$len-1]/#B-DATE\t$current[$len-1]/g;
                        $line[$i+1]=~s/$next1[$len-2]\t$next1[$len-1]/#I-DATE\t$next1[$len-1]/g;
                        $line[$i+2]=~s/$next2[$len-2]\t$next2[$len-1]/#I-DATE\t$next2[$len-1]/g;
			$i=$i+2;
        }

	if(($line[$i]=~/\t$month_str/)&&($line[$i+1]=~/\tQT/)&&($line[$i+2]=~/\t$date_str/)){#print"HAI\n";
                        $line[$i]=~s/$current[$len-2]\t$current[$len-1]/#B-DATE\t$current[$len-1]/g;
                        $line[$i+1]=~s/$next1[$len-2]\t$next1[$len-1]/#I-DATE\t$next1[$len-1]/g;
			$line[$i+2]=~s/$next2[$len-2]\t$next2[$len-1]/#I-DATE\t$next2[$len-1]/g;
			$i=$i+2;
        }

	if(($line[$i]=~/\t$month_str/)&&($line[$i+1]=~/\tQT/)){#print"HAI\n";
                        $line[$i]=~s/$current[$len-2]\t$current[$len-1]/#B-DATE\t$current[$len-1]/g;
                        $line[$i+1]=~s/$next1[$len-2]\t$next1[$len-1]/#I-DATE\t$next1[$len-1]/g;
                        $i=$i+1;
        }

	if(($line[$i]=~/\tQT_/)&&($line[$i+1]=~/\t$date_str/)){#print"HAI\n";
			$line[$i]=~s/$current[$len-2]\t$current[$len-1]/#B-DATE\t$current[$len-1]/g;
			$line[$i+1]=~s/$next1[$len-2]\t$next1[$len-1]/#I-DATE\t$next1[$len-1]/g;
			$i=$i+1;
	}
	
	if($line[$i]=~/\d+(-nwewi|-mwewi)/){#print"HAI\n";
                        $line[$i]=~s/$current[$len-2]\t$current[$len-1]/#B-DATE\t$current[$len-1]/g;
			$i=$i+1;
        }	

	if($line[$i]=~/\d{1,2}-\d{1,2}-\d{1,4}/){#print"HAI\n";
                        $line[$i]=~s/$current[$len-2]\t$current[$len-1]/##B-DATE\t$current[$len-1]/g;
			$i=$i+1;
        }

	if(($line[$i+1]=~/\tmAwam/)&&($line[$i]=~/\t$month_str/)){#print"HAI\n";
                        $line[$i]=~s/$current[$len-2]\t$current[$len-1]/#B-MONTH\t$current[$len-1]/g;
                        $line[$i+1]=~s/$next1[$len-2]\t$next1[$len-1]/#I-MONTH\t$next1[$len-1]/g;
                        $i=$i+1;
        }

	elsif(($line[$i]=~/\t$month_str/)){#print"HAI\n";
                        $line[$i]=~s/$current[$len-2]\t$current[$len-1]/#B-MONTH\t$current[$len-1]/g;
        }

	if(($line[$i]=~/\t$day_str/)){#print"HAI\n";
                        $line[$i]=~s/$current[$len-2]\t$current[$len-1]/#B-DAY\t$current[$len-1]/g;
        }

	if(($line[$i]=~/\tQT/)&&($line[$i+1]=~/\t$period_str/)&&($line[$i+2]=~/\t$period_str/)){#print"HAI\n";
                        $line[$i]=~s/$current[$len-2]\t$current[$len-1]/#B-PERIOD\t$current[$len-1]/g;
                        $line[$i+1]=~s/$next1[$len-2]\t$next1[$len-1]/#I-PERIOD\t$next1[$len-1]/g;
                        $line[$i+2]=~s/$next2[$len-2]\t$next2[$len-1]/#I-PERIOD\t$next2[$len-1]/g;
                        $i=$i+2
        }

	 elsif(($line[$i]=~/\tQT/)&&($line[$i+1]=~/\t$period_str/)){#print"HAI\n";
                        $line[$i]=~s/$current[$len-2]\t$current[$len-1]/#B-PERIOD\t$current[$len-1]/g;
                        $line[$i+1]=~s/$next1[$len-2]\t$next1[$len-1]/#I-PERIOD\t$next1[$len-1]/g;
			$i=$i+1;
         }

	if(($line[$i]=~/\tQT/)&&($line[$i+1]=~/\t$distance_str\t/)&&($line[$i+2]=~/\t$distance_str\t/)){#print"HAI\n";
                        $line[$i]=~s/$current[$len-2]\t$current[$len-1]/#B-DISTANCE\t$current[$len-1]/g;
                        $line[$i+1]=~s/$next1[$len-2]\t$next1[$len-1]/#I-DISTANCE\t$next1[$len-1]/g;
                        $line[$i+2]=~s/$next2[$len-2]\t$next2[$len-1]/#I-DISTANCE\t$next2[$len-1]/g;
                        $i=$i+2
        }

	 elsif(($line[$i]=~/\tQT/)&&($line[$i+1]=~/\t($distance_str),/)){#print"HAI\n";
                        $line[$i]=~s/$current[$len-2]\t$current[$len-1]/#B-DISTANCE\t$current[$len-1]/g;
                        $line[$i+1]=~s/$next1[$len-2]\t$next1[$len-1]/#I-DISATNCE\t$next1[$len-1]/g;
                        $i=$i+1;
         }
	
	if(($line[$i]=~/\tQT/)&&($line[$i+1]=~/\t$quantity_str/)&&($line[$i+2]=~/\t$quantity_str/)){#print"HAI\n";
                        $line[$i]=~s/$current[$len-2]\t$current[$len-1]/#B-QUANTITY\t$current[$len-1]/g;
                        $line[$i+1]=~s/$next1[$len-2]\t$next1[$len-1]/#I-QUANTITY\t$next1[$len-1]/g;
                        $line[$i+2]=~s/$next2[$len-2]\t$next2[$len-1]/#I-QUANTITY\t$next2[$len-1]/g;
                        $i=$i+2
        }

         elsif(($line[$i]=~/\tQT/)&&($line[$i+1]=~/\t$quantity_str/)){#print"HAI\n";
                        $line[$i]=~s/$current[$len-2]\t$current[$len-1]/#B-QUANTITY\t$current[$len-1]/g;
                        $line[$i+1]=~s/$next1[$len-2]\t$next1[$len-1]/#I-QUANTITY\t$next1[$len-1]/g;
                        $i=$i+1;
         }	

	if(($line[$i]=~/\t($money_str),/)&&($line[$i+1]=~/\tQT/)&&($line[$i+2]=~/\tQT/)){#print"HAI\n";
                        $line[$i]=~s/$current[$len-2]\t$current[$len-1]/#B-MONEY\t$current[$len-1]/g;
                        $line[$i+1]=~s/$next1[$len-2]\t$next1[$len-1]/#I-MONEY\t$next1[$len-1]/g;
                        $line[$i+2]=~s/$next2[$len-2]\t$next2[$len-1]/#I-MONEY\t$next2[$len-1]/g;
                        $i=$i+2;
        }
	
	if(($line[$i+2]=~/\t($money_str),/)&&($line[$i]=~/\tQT/)&&($line[$i+1]=~/\tQT/)){#print"HAI\n";
                        $line[$i]=~s/$current[$len-2]\t$current[$len-1]/#B-MONEY\t$current[$len-1]/g;
                        $line[$i+1]=~s/$next1[$len-2]\t$next1[$len-1]/#I-MONEY\t$next1[$len-1]/g;
                        $line[$i+2]=~s/$next2[$len-2]\t$next2[$len-1]/#I-MONEY\t$next2[$len-1]/g;
                        $i=$i+2;
        }
	
	if(($line[$i]=~/\t($money_str),/)&&($line[$i+1]=~/\tQT/)){#print"HAI\n";
                        $line[$i]=~s/$current[$len-2]\t$current[$len-1]/#B-MONEY\t$current[$len-1]/g;
                        $line[$i+1]=~s/$next1[$len-2]\t$next1[$len-1]/#I-MONEY\t$next1[$len-1]/g;
                        $i=$i+1;
        }

	if(($line[$i+1]=~/\t($money_str),/)&&($line[$i]=~/\tQT/)){#print"HAI\n";
                        $line[$i]=~s/$current[$len-2]\t$current[$len-1]/#B-MONEY\t$current[$len-1]/g;
                        $line[$i+1]=~s/$next1[$len-2]\t$next1[$len-1]/#I-MONEY\t$next1[$len-1]/g;
                        $i=$i+1;
        }

	}
}

for($i=0;$i<@line;$i++)
{
	print"$line[$i]\n";

}
