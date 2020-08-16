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


open(F8,"time.txt");
while(<F8>)
{
chomp;
$time_str.="(".$_.")|";
}
chop $time_str;
close (F8);


open(F9,"money1.txt");
while(<F9>)
{
chomp;
$mon_str.="(".$_.")|";
}
chop $mon_str;
close (F9);

open(F10,"organization.txt");
while(<F10>)
{
chomp;
$org_str.="(".$_.")|";
}
chop $org_str;
close (F10);

open(F11,"association.txt");
while(<F11>)
{
chomp;
$asso_str.="(".$_.")|";
}
chop $asso_str;
close (F11);

open(F13,"location-suff.txt");
while(<F13>)
{
chomp;
$locsuf_str.="(".$_.")|";
}
chop $locsuf_str;
close (F13);

open(F13,"location.txt");
while(<F13>)
{
chomp;
$loc1_str.="(".$_.")|";
}
chop $loc1_str;
close (F13);

for($i=0;$i<@line;$i++)
{
	if($line[$i]!~/^\s*$/){
	@prev=split(/\t/,$line[$i-1]);
	@current=split(/\t/,$line[$i]);$l=@current;
	@next1=split(/\t/,$line[$i+1]);
	@next2=split(/\t/,$line[$i+2]);
	@next3=split(/\t/,$line[$i+3]);
	@next4=split(/\t/,$line[$i+4]);
	$len=@current;

	if(($line[$i]=~/\t($org_str),|\t($asso_str),/)&&($line[$i]!~/B-NP/)&&($line[$i-1]=~/N_NN|N_NNP/))
	{
		if($line[$i]=~/\t($org_str),/)		
		{
			$tg="ORGANIZATION";
		}
		if($line[$i]=~/\t($asso_str),/)          
                {
                        $tg="ASSOCIATION";
                }

		$n=$i;
		while(($line[$n]!~/\tB-NP\t/)&&($line[$n]=~/N_NN|N_NNP/))
		{
			$t1="I-".$tg;
			@nextn=split(/\t/,$line[$n]);
			if($line[$n]=~/N_NN|N_NNP/)
                        {
				$line[$n]=~s/$nextn[$len-2]\t$nextn[$len-1]/$t1\t$nextn[$len-1]/g;
			}
			$n--;
		}
			
			$t1="#B-".$tg;
			$line[$n]=~s/\(/\\(/g;
			@nextn=split(/\t/,$line[$n]);
			if($line[$n]=~/N_NN|N_NNP/)
			{
				$line[$n]=~s/$nextn[$len-2]\t$nextn[$len-1]/$t1\t$nextn[$len-1]/g;
			}
			
	}


	if(($line[$i+1]=~/\t($month_str),/)&&($line[$i]=~/\tQT/)&&($line[$i+2]=~/\tQT/)){#print"HAI\n";
                        $line[$i]=~s/$current[$len-2]\t$current[$len-1]/#B-YEAR\t$current[$len-1]/g;
                        $line[$i+1]=~s/$next1[$len-2]\t$next1[$len-1]/#I-YEAR\t$next1[$len-1]/g;
                        $line[$i+2]=~s/$next2[$len-2]\t$next2[$len-1]/#I-YEAR\t$next2[$len-1]/g;
                        $i=$i+2;
        }
	
	 elsif(($line[$i]=~/\tQT/)&&($line[$i+1]=~/\t(ANtu),/)){#print"HAI\n";
                        $line[$i]=~s/$current[$len-2]\t$current[$len-1]/#B-YEAR\t$current[$len-1]/g;
                        $line[$i+1]=~s/$next1[$len-2]\t$next1[$len-1]/#I-YEAR\t$next1[$len-1]/g;
                        $i=$i+1;
        }

	if(($line[$i]=~/\t($month_str),/)&&($line[$i+1]=~/^\./)&&($line[$i+2]=~/\t($date_str),/)){#print"HAI\n";
                        $line[$i]=~s/$current[$len-2]\t$current[$len-1]/#B-DATE\t$current[$len-1]/g;
                        $line[$i+1]=~s/$next1[$len-2]\t$next1[$len-1]/#I-DATE\t$next1[$len-1]/g;
                        $line[$i+2]=~s/$next2[$len-2]\t$next2[$len-1]/#I-DATE\t$next2[$len-1]/g;
			$i=$i+2;
        }

	if(($line[$i]=~/\t($month_str),/)&&($line[$i+2]=~/\tQT/)&&($line[$i+3]=~/\t($date_str),/)&&($line[$i+1]=~/\t(mAwam),/)){#print"HAI\n";
                        $line[$i]=~s/$current[$len-2]\t$current[$len-1]/#B-DATE\t$current[$len-1]/g;
                        $line[$i+1]=~s/$next1[$len-2]\t$next1[$len-1]/#I-DATE\t$next1[$len-1]/g;
                        $line[$i+2]=~s/$next2[$len-2]\t$next2[$len-1]/#I-DATE\t$next2[$len-1]/g;
			$line[$i+3]=~s/$next2[$len-2]\t$next2[$len-1]/#I-DATE\t$next2[$len-1]/g;
                        $i=$i+3;
        }

	if(($line[$i]=~/\t($month_str),/)&&($line[$i+1]=~/\tQT/)&&($line[$i+2]=~/\t($date_str),/)){#print"HAI\n";
                        $line[$i]=~s/$current[$len-2]\t$current[$len-1]/#B-DATE\t$current[$len-1]/g;
                        $line[$i+1]=~s/$next1[$len-2]\t$next1[$len-1]/#I-DATE\t$next1[$len-1]/g;
			$line[$i+2]=~s/$next2[$len-2]\t$next2[$len-1]/#I-DATE\t$next2[$len-1]/g;
			$i=$i+2;
        }

	if(($line[$i]=~/\t($month_str),/)&&($line[$i+1]=~/\tQT/)){#print"HAI\n";
                        $line[$i]=~s/$current[$len-2]\t$current[$len-1]/#B-DATE\t$current[$len-1]/g;
                        $line[$i+1]=~s/$next1[$len-2]\t$next1[$len-1]/#I-DATE\t$next1[$len-1]/g;
                        $i=$i+1;
        }

	if(($line[$i]=~/\tQT_/)&&($line[$i+1]=~/\t($date_str),/)){#print"HAI\n";
			$line[$i]=~s/$current[$len-2]\t$current[$len-1]/#B-DATE\t$current[$len-1]/g;
			$line[$i+1]=~s/$next1[$len-2]\t$next1[$len-1]/#I-DATE\t$next1[$len-1]/g;
			$i=$i+1;
	}
	
	if($line[$i]=~/\d+(-nwewi|-mwewi)/){#print"HAI\n";
                        $line[$i]=~s/$current[$len-2]\t$current[$len-1]/#B-DATE\t$current[$len-1]/g;
			$i=$i+1;
        }	

	if($line[$i]=~/\d{1,2}-\d{1,2}-\d{1,4}/){#print"HAI\n";
                        $line[$i]=~s/$current[$len-2]\t$current[$len-1]/#B-DATE\t$current[$len-1]/g;
			$i=$i+1;
        }

	if($line[$i]=~/\d{1,2}\.\d{1,2}\.\d{1,4}/){#print"HAI\n";
                        $line[$i]=~s/$current[$len-2]\t$current[$len-1]/#B-DATE\t$current[$len-1]/g;
                        $i=$i+1;
        }

	if(($line[$i+1]=~/\t(mAwam),/)&&($line[$i]=~/\t($month_str),/)){#print"HAI\n";
                        $line[$i]=~s/$current[$len-2]\t$current[$len-1]/#B-MONTH\t$current[$len-1]/g;
                        $line[$i+1]=~s/$next1[$len-2]\t$next1[$len-1]/#I-MONTH\t$next1[$len-1]/g;
                        $i=$i+1;
        }

	elsif(($line[$i]=~/\t($month_str),/)){#print"HAI\n";
                        $line[$i]=~s/$current[$len-2]\t$current[$len-1]/#B-MONTH\t$current[$len-1]/g;
        }

	if(($line[$i]=~/\t($day_str),/)){#print"HAI\n";
                        $line[$i]=~s/$current[$len-2]\t$current[$len-1]/#B-DAY\t$current[$len-1]/g;
        }

	if(($line[$i]=~/\tQT/)&&($line[$i+1]=~/\t($period_str),/)&&($line[$i+2]=~/\t($period_str),/)){#print"HAI\n";
                        $line[$i]=~s/$current[$len-2]\t$current[$len-1]/#B-PERIOD\t$current[$len-1]/g;
                        $line[$i+1]=~s/$next1[$len-2]\t$next1[$len-1]/#I-PERIOD\t$next1[$len-1]/g;
                        $line[$i+2]=~s/$next2[$len-2]\t$next2[$len-1]/#I-PERIOD\t$next2[$len-1]/g;
                        $i=$i+2;
        }

	 elsif(($line[$i]=~/\tQT/)&&($line[$i+1]=~/\t($period_str),/)&&($line[$i+1]!~/\tmaNi,/)){#print"HAI\n";
                        $line[$i]=~s/$current[$len-2]\t$current[$len-1]/#B-PERIOD\t$current[$len-1]/g;
                        $line[$i+1]=~s/$next1[$len-2]\t$next1[$len-1]/#I-PERIOD\t$next1[$len-1]/g;
			$i=$i+1;
         }

	if(($line[$i]=~/\tQT/)&&($line[$i+1]=~/\t($distance_str),/)&&($line[$i+2]=~/\t($distance_str),/)){#print"HAI\n";
                        $line[$i]=~s/$current[$len-2]\t$current[$len-1]/#B-DISTANCE\t$current[$len-1]/g;
                        $line[$i+1]=~s/$next1[$len-2]\t$next1[$len-1]/#I-DISTANCE\t$next1[$len-1]/g;
                        $line[$i+2]=~s/$next2[$len-2]\t$next2[$len-1]/#I-DISTANCE\t$next2[$len-1]/g;
                        $i=$i+2;
        }

	 elsif(($line[$i]=~/\tQT/)&&($line[$i+1]=~/\t($distance_str),/)){#print"HAI\n";
                        $line[$i]=~s/$current[$len-2]\t$current[$len-1]/#B-DISTANCE\t$current[$len-1]/g;
                        $line[$i+1]=~s/$next1[$len-2]\t$next1[$len-1]/#I-DISTANCE\t$next1[$len-1]/g;
                        $i=$i+1;
         }
	
	if(($line[$i]=~/\tQT/)&&($line[$i+1]=~/\t($quantity_str),/)&&($line[$i+2]=~/\t($quantity_str),/)){#print"HAI\n";
                        $line[$i]=~s/$current[$len-2]\t$current[$len-1]/#B-QUANTITY\t$current[$len-1]/g;
                        $line[$i+1]=~s/$next1[$len-2]\t$next1[$len-1]/#I-QUANTITY\t$next1[$len-1]/g;
                        $line[$i+2]=~s/$next2[$len-2]\t$next2[$len-1]/#I-QUANTITY\t$next2[$len-1]/g;
                        $i=$i+2;
        }

         elsif(($line[$i]=~/\tQT/)&&($line[$i+1]=~/\t($quantity_str),/)&&($line[$i+2]!~/DISTANCE/)){#print"HAI\n";
                        $line[$i]=~s/$current[$len-2]\t$current[$len-1]/#B-QUANTITY\t$current[$len-1]/g;
                        $line[$i+1]=~s/$next1[$len-2]\t$next1[$len-1]/#I-QUANTITY\t$next1[$len-1]/g;
                        $i=$i+1;
         }	


	#\d kotiye \d latcam rUpAy
	if(($line[$i]=~/\tQT/)&&($line[$i+1]=~/\t($mon_str),/)&&($line[$i+2]=~/\tQT/)&&($line[$i+3]=~/\tQT|\t($mon_str),/)&&($line[$i+4]=~/\t($money_str)/)){#print"HAI\n";
                        $line[$i]=~s/$current[$len-2]\t$current[$len-1]/#B-MONEY\t$current[$len-1]/g;
                        $line[$i+1]=~s/$next1[$len-2]\t$next1[$len-1]/#I-MONEY\t$next1[$len-1]/g;
                        $line[$i+2]=~s/$next2[$len-2]\t$next2[$len-1]/#I-MONEY\t$next2[$len-1]/g;
                        $line[$i+3]=~s/$next3[$len-2]\t$next3[$len-1]/#I-MONEY\t$next3[$len-1]/g;
			$line[$i+4]=~s/$next4[$len-2]\t$next4[$len-1]/#I-MONEY\t$next4[$len-1]/g;
                        $i=$i+4;
        }
	#\d Ayiram koti rUpAy or \d Ayirathu \d rUpAy
	if(($line[$i]=~/\tQT|\t($mon_str),/)&&($line[$i+1]=~/\t($money_str),|\t($mon_str),/)&&($line[$i+2]=~/\tQT|\t($mon_str)/)&&($line[$i+3]=~/\t($money_str)/)){#print"HAI\n";
                        $line[$i]=~s/$current[$len-2]\t$current[$len-1]/#B-MONEY\t$current[$len-1]/g;
                        $line[$i+1]=~s/$next1[$len-2]\t$next1[$len-1]/#I-MONEY\t$next1[$len-1]/g;
                        $line[$i+2]=~s/$next2[$len-2]\t$next2[$len-1]/#I-MONEY\t$next2[$len-1]/g;
			$line[$i+3]=~s/$next3[$len-2]\t$next3[$len-1]/#I-MONEY\t$next3[$len-1]/g;
                        $i=$i+3;
        }

	#rU. \d Ayiram koti
	if(($line[$i]=~/\t($money_str),/)&&($line[$i+1]=~/\tQT|\t($mon_str),/)&&($line[$i+2]=~/\tQT|\t($mon_str),/)&&($line[$i+3]=~/\t($money_str),|\t($mon_str),/)){#print"HAI\n";
                        $line[$i]=~s/$current[$len-2]\t$current[$len-1]/#B-MONEY\t$current[$len-1]/g;
                        $line[$i+1]=~s/$next1[$len-2]\t$next1[$len-1]/#I-MONEY\t$next1[$len-1]/g;
                        $line[$i+2]=~s/$next2[$len-2]\t$next2[$len-1]/#I-MONEY\t$next2[$len-1]/g;
                        $line[$i+3]=~s/$next3[$len-2]\t$next3[$len-1]/#I-MONEY\t$next3[$len-1]/g;
                        $i=$i+3;
        }

	#rUpAy \d koti|latcam|Ayiram
	if(($line[$i]=~/\t($money_str),/)&&($line[$i+1]=~/\tQT|\t($mon_str)/)&&($line[$i+2]=~/\tQT|\t($mon_str),/)){#print"HAI\n";
                        $line[$i]=~s/$current[$len-2]\t$current[$len-1]/#B-MONEY\t$current[$len-1]/g;
                        $line[$i+1]=~s/$next1[$len-2]\t$next1[$len-1]/#I-MONEY\t$next1[$len-1]/g;
                        $line[$i+2]=~s/$next2[$len-2]\t$next2[$len-1]/#I-MONEY\t$next2[$len-1]/g;
                        $i=$i+2;
        }
	#\d koti|latcam|Ayiram rUpAy	
	if(($line[$i+2]=~/\t($money_str),/)&&($line[$i]=~/\tQT|\t($mon_str),/)&&($line[$i+1]=~/\tQT|\t($mon_str),/)){#print"HAI\n";
                        $line[$i]=~s/$current[$len-2]\t$current[$len-1]/#B-MONEY\t$current[$len-1]/g;
                        $line[$i+1]=~s/$next1[$len-2]\t$next1[$len-1]/#I-MONEY\t$next1[$len-1]/g;
                        $line[$i+2]=~s/$next2[$len-2]\t$next2[$len-1]/#I-MONEY\t$next2[$len-1]/g;
                        $i=$i+2;
        }
	
	if(($line[$i]=~/\t($money_str),/)&&($line[$i+1]=~/\tQT|\t($mon_str),/)){#print"HAI\n";
                        $line[$i]=~s/$current[$len-2]\t$current[$len-1]/#B-MONEY\t$current[$len-1]/g;
                        $line[$i+1]=~s/$next1[$len-2]\t$next1[$len-1]/#I-MONEY\t$next1[$len-1]/g;
                        $i=$i+1;
        }
	
	if(($line[$i+1]=~/\t($money_str),/)&&($line[$i]=~/\tQT/)){#print"HAI\n";
                        $line[$i]=~s/$current[$len-2]\t$current[$len-1]/#B-MONEY\t$current[$len-1]/g;
                        $line[$i+1]=~s/$next1[$len-2]\t$next1[$len-1]/#I-MONEY\t$next1[$len-1]/g;
                        $i=$i+1;
        }
	
	if(($line[$i]=~/(rU\.\d+)/)){#print"HAI\n";
                        $line[$i]=~s/$current[$len-2]\t$current[$len-1]/#B-MONEY\t$current[$len-1]/g;
                       
        }

	if(($line[$i+1]=~/\tQT/)&&($line[$i]=~/\t($time_str),/)&&($line[$i+2]=~/\t($time_str),/)){#print"HAI\n";
                        $line[$i]=~s/$current[$len-2]\t$current[$len-1]/#B-TIME\t$current[$len-1]/g;
                        $line[$i+1]=~s/$next1[$len-2]\t$next1[$len-1]/#I-TIME\t$next1[$len-1]/g;
                        $line[$i+2]=~s/$next2[$len-2]\t$next2[$len-1]/#I-TIME\t$next2[$len-1]/g;
                        $i=$i+2;
        }
	
	elsif(($line[$i+1]=~/\tQT/)&&($line[$i]=~/\t($time_str),/)){#print"HAI\n";
                        $line[$i]=~s/$current[$len-2]\t$current[$len-1]/#B-TIME\t$current[$len-1]/g;
                        $line[$i+1]=~s/$next1[$len-2]\t$next1[$len-1]/#I-TIME\t$next1[$len-1]/g;
                        $i=$i+1;
        }

	if(($line[$i]=~/\tQT/)&&($line[$i+1]=~/\t($time_str),/)){#print"HAI\n";
                        $line[$i]=~s/$current[$len-2]\t$current[$len-1]/#B-TIME\t$current[$len-1]/g;
                        $line[$i+1]=~s/$next1[$len-2]\t$next1[$len-1]/#I-TIME\t$next1[$len-1]/g;
                        $i=$i+1;
        }

	if(($line[$i]=~/\d{4,4}/)&&($current[$len-2]=~/^o$/i)){#print"HAI\n";
                        $line[$i]=~s/$current[$len-2]\t$current[$len-1]/#B-YEAR\t$current[$len-1]/g;
        }

	if(($line[$i]=~/($locsuf_str$),/)&&($line[$i]=~/N_NNP/))
	{
		$line[$i]=~s/$current[$len-2]\t$current[$len-1]/#B-LOCATION\t$current[$len-1]/g;
	}

	if(($line[$i]=~/\t$loc1_str,/)&&($line[$i-1]=~/N_NNP/)&&($prev[$len-2]=~/^O$/i))
        {
		$line[$i]=~s/$current[$len-2]\t$current[$len-1]/#I-LOCATION\t$current[$len-1]/g;
                $n=$i-1;
                @nextn=split(/\t/,$line[$n]);
                while(($line[$n]=~/\tN_NNP\t/))
                {
                        #print"HAI\n";
                        if($line[$n]=~/N_NNP/)
                        {
                                $line[$n]=~s/$nextn[$len-2]\t$nextn[$len-1]/#I-LOCATION\t$nextn[$len-1]/g;
                        }
                        $n--;
                        @nextn=split(/\t/,$line[$n]);
                }
			$n++;
			@nextn=split(/\t/,$line[$n]);
			$line[$n]=~s/$nextn[$len-2]\t$nextn[$len-1]/#B-LOCATION\t$nextn[$len-1]/g;
	}
	
	if(($current[0]=~/\d/)&&($current[$len-2]=~/INDIVIDUAL|LOCATION|PLACE|CITY|DISTRICT|TOWN|STATE|NATION|COUNTRY/))
	{
		$line[$i]=~s/$current[$len-2]\t$current[$len-1]/o\t$current[$len-1]/g;
	}

	if(($current[1]=~/(RB)|(V_VM.*)/)&&($current[$len-2]=~/(B|I)-.*/))
        {
                $line[$i]=~s/$current[$len-2]\t$current[$len-1]/O\t$current[$len-1]/g;
        }

	}
}

for($i=0;$i<@line;$i++)
{
	@current=split(/\t/,$line[$i]);$l=@current;
        @next1=split(/\t/,$line[$i+1]);
	@prev=split(/\t/,$line[$i-1]);
	$line[$i]=~s/#B/B/g;
	$line[$i]=~s/#I/I/g;
	if(($current[$l-2]=~/B-(.*)/)&&($next1[$l-2]=~/B-(.*)/))
        {
                $nt=$1;
                if(($line[$i]=~/B-NP/)&&($line[$i+1]=~/I-NP/)&&($current[$l-2]=~/B-(.*)/))
                {
                        $ct=$1;
                        if($nt eq $ct)
                        {
                                $tag="I-".$nt;
                                $line[$i+1]=~s/$next1[$len-2]\t$next1[$len-1]/$tag\t$next1[$len-1]/g;
                        }
                }
        }

	if(($current[$l-2]=~/(B|I)-(.*)/)&&($next1[$l-2]=~/I-(.*)/))
        {
                $nt=$1;
                if(($line[$i]=~/B-NP/)&&($line[$i+1]=~/I-NP/)&&($current[$l-2]=~/(B|I)-(.*)/))
                {
                        $ct=$2;
                        if($nt ne $ct)
                        {
                                $tag="B-".$nt;
                                #$line[$i+1]=~s/$next1[$len-2]\t$next1[$len-1]/$tag\t$next1[$len-1]/g;
                                $line[$i]=~s/$current[$len-2]\t$current[$len-1]/$tag\t$current[$len-1]/g;
                        }
                }
        }

	if(($prev[$l-2]=~/^o$/i)&&($current[$l-2]=~/(I)-(.*)/))
        {
			$tg1=$2;
			$tg2="B-".$tg1;
		$line[$i]=~s/$current[$len-2]\t$current[$len-1]/$tg2\t$current[$len-1]/g;
	}
	print"$line[$i]\n";

}
