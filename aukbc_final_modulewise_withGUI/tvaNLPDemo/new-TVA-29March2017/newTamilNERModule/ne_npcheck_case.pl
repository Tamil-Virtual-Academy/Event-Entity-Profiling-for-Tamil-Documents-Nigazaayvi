while(<>){
	chomp;
	push(@array,$_);
}

for($i = 0;$i < @array;$i++) {
		if($array[$i] eq undef) { print "\n"; next; }
                @temp = split(/\s+/,$array[$i]);$l=@temp;
                @tempMore = split(/\,/,$temp[$l-1]);
		#print STDERR "$temp[3] -- $tempMore[2]\n";
                @temp1 = split(/\s+/,$array[$i+1]);

                if(($tempMore[2] =~ /\-((ACC)|(BEN)|(LOC)|(INS)|(ABL)|(DAT)|(SOC))/i) && ($temp[$l-2] =~ /B\-(.*)/) && ($temp1[$l-2] =~ /I\-(.*)/)) {
			$t2=$2;
			if(($temp[$l-2] =~ /B\-$t2/)&&($temp[$l-2]!~/B-EVENT/)){
                		$array[$i+1]=~s/I-($t2)/B-\1/g;
			}
		}
		print "$array[$i]\n";
}

