while(<>){
	chomp;
	push(@array,$_);
}

for($i = 0;$i < @array;$i++) {
		if($array[$i] eq undef) { print "\n"; next; }
                @temp = split(/\s+/,$array[$i]);
                @tempMore = split(/\,/,$temp[3]);
		#print STDERR "~~~~$temp[3] -- $tempMore[2]\n";
                @temp1 = split(/\s+/,$array[$i+1]);

                if(($tempMore[2] =~ /\-((ACC)|(BEN)|(LOC)|(INS)|(ABL)|(DAT)|(SOC))/i) && ($array[$i+1] =~ /I\-NP/) && ($temp1[3] !~ /^[\.\,\'\!\`\?\:\;\.\%]+/)) {
                #if(($tempMore[2] =~ /\-((ACC)|(BEN)|(LOC)|(INS)|(ABL)|(DAT)|(SOC))/i) && ($array[$i+1] =~ /I\-NP/)) {
			#print STDERR "~~~~~~~$array[$i] \n $array[$i+1] --- $temp1[3]\n\n";
                        if($array[$i] !~ /JJ/) {
                                #$array[$i+1] = "~".$array[$i+1];
				#print STDERR "$array[$i+1]\n";
                                $array[$i+1] =~ s/I\-NP/B\-NP/;
				#print STDERR "~~~ $array[$i+1]\n";
                        }
                        #print "hai\n";
                }
		print "$array[$i]\n";
}

