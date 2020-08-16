#!/usr/bin/perl

while(<>) {
	chomp;
	
	if($_ eq undef) {
		process(@array);
		undef @array;
		next;
	}
	
	push(@array,$_);
}

sub process {
	my @tempArray = @_;
	#print join "\n", @tempArray,"\n";

	for($i = 0;$i < @tempArray;$i++) {
		if($tempArray[$i] =~ /B\-(\w+)/) {
			undef $chunk;
			$chunk = $1;
			undef @chunkA;
			push(@chunkA,$tempArray[$i]);
			
			$d = $i;
			$true = 1;

			while($true) {
				if($tempArray[$i+1] =~ /I\-$chunk/) {
					push(@chunkA,$tempArray[$i+1]);
					$i++;
				}else{
					$true = 0;
				}
			}
			
			modify(@chunkA,$chunk);
		}
	}
	print "\n";
}
1;

sub modify {
	my $chunkT = pop(@_);
	my @tempChunk = @_;

	#print "$chunkT\n";
	#print join "\n", @tempChunk,"\n";

	if($chunkT eq "NP") {
		#print join "\n", @tempChunk,"\n";
		# trying to get the clause marker 

		undef $clauseM;
		undef $case;
		@temp = split(/\t/,$tempChunk[0]);
		$clauseM = $temp[4];
		$l = @tempChunk;
		$l--;
		$l1 = $l;	

		# trying to put the in our np form 
		undef @temp;
		$true = 1;	
		while(($tempChunk[$l] !~ /N_NN|PR_|QT|ADJ|QO|VGN|VNG|NST|PRP|RB|DM|INTF|INTJ|JJ|SYM|ECH|PUNC|CCS/g)&&($true == 1)) {
			$l--;
			if($l < 0) {
				$true = 0;
			}
		}
		if($l < 0) {
			for($ii = 0;$ii < @tempChunk;$ii++) {
                                #print "$tempChunk[$ii]\n";
                                my @temp = split(/\t/,$tempChunk[$ii]);
                                print "$temp[0]\t$temp[1]\t$temp[2]\n";
                        }
		}else{
	
		#print "$l 0000 uuu \n";
                @temp =  split(/\t/,$tempChunk[$l]);
                # to form morph output

                @ma_arra = split(/\,/,$temp[3]);
                undef $case;
                $case = $ma_arra[2];
                if($case ne undef)  {
                        ($suffix,$tag) = split(/\-/,$case);
                        $morph_out = "n\_$tag";
                }
                if($morph_out eq undef) {
                        $morph_out = "n_nom";
                }
=c
		if($temp[3] =~ /CASE_NAME=[\'\"](\w+)[\'\"]/i) {
			#print "$temp[3] --> $1\n";
			$case = $1;
			@ma_arra = split(/\,/,$temp[3]);
			$lcat = $ma_arra[1];
			$morph_out = "$lcat\_$case";
		}
=cut
		if($morph_out eq undef) {
			$morph_out = "n_nom";
		}
		#$morph_out =~ s/pn_/n_/;
		#print "Vijay $tempChunk[$l]\tqazxsw $temp[4]\n";	
		
		if($temp[4] =~ /\{\/\w+\}/) {
			$clauseM = $temp[4] if($clauseM !~ /\{\/?\w+\}/);
		}

		print "np\tnp\t$morph_out\n"; 	
		
		if($l1 != $l) {
			$l++;
			for($ii = $l;$ii <= $l1;$ii++) {
				#print "$tempChunk[$ii]\n";
				my @temp = split(/\t/,$tempChunk[$ii]);
				print "$temp[0]\t$temp[1]\t$temp[2]\n";
			}
		}
		}
	}elsif($chunkT =~ /^VG/) {
		for($ii = 0;$ii < @tempChunk;$ii++) {
			undef $morph;
			
			if($tempChunk[$ii] =~ /\tSYM\t/) {
				my @temp = split(/\t/,$tempChunk[$ii]);
				print "$temp[0]\t$temp[1]\t$temp[2]\n";
				next;	
			}
			
			my @temp = split(/\t/,$tempChunk[$ii]);

                        if(($temp[3] =~ /\,RP/) ||($temp[1] =~ /\_RP/) || ($temp[1] =~ /RP\_NEG/)){
                                $morph = "V_RP";
                                $temp[1] = $temp[1]."_RP";
                        }elsif(($temp[3] =~ /VBP/i) || ($temp[1] =~ /\_VBN/)){
                                $morph = "V_VBP";
                                $temp[1] = $temp[1]."_VBP";
                        }elsif(($temp[3] =~ /INF/i) || ($temp[1] =~ /\_INF/)) {
                                $morph = "V_INF";
                                $temp[1] = $temp[1]."_INF";
                        }elsif(($temp[3] =~ /COND/i) || ($temp[1] =~ /_cond/i)) {
                                $morph = "V_COND";
                                $temp[1] = $temp[1]."_COND";
                        }elsif($temp[2] =~ /VGF/i) {
                                $morph = "V_VGF";
                                $temp[1] = $temp[1]."_VGF";
                        }elsif($temp[1] =~ /VBN/i) {
                                $morph = "V_NF";
                                $temp[1] = $temp[1];
                        }

			if($morph eq "") {
				$morph = $temp[1];
			}
			print "$temp[0]\t$temp[1]\t$morph\n";
		}
	}elsif($chunkT =~ /RBP/) {
		for($ii = 0;$ii < @tempChunk;$ii++) {

			if($tempChunk[$ii] =~ /\tSYM\t/) {
				my @temp = split(/\t/,$tempChunk[$ii]);
				#print "$temp[0]\t$temp[1]\tSYM\to\n";
				next;	
			}

			my @temp = split(/\t/,$tempChunk[$ii]);
			my @ma_arra = split(/\,/,$temp[3]);
			$lcat = $ma_arra[1];	
			$last_Content = pop(@ma_arra);
			#print "QAZXSWEDCVFRTGB $last_Content\n";
			if($last_Content =~ /(.*?)\'/) {
				$morpheme = $1;
				#print "QAZX QAZ $morpheme QAZ \n";
			}
			$morph = "$lcat\_$morpheme";
			#print "I am in morph $morph\n";
                        print "$temp[0]\t$temp[1]\t$morph\n";
		}
	}else{
		for($ii = 0;$ii < @tempChunk;$ii++) {
			my @temp = split(/\t/,$tempChunk[$ii]);
			if($temp[1] =~ /PSP/i) {
				print "$temp[0]\t$temp[1]\tpsp\n";
			}elsif(($temp[1] =~ /CC_CCS/i)  && ($temp[0] =~ /eVnYrYu|eVnYa/)){
				print "$temp[0]\t$temp[1]\tUT\n";
			}elsif($temp[1] =~ /SYM/) {
				print "$temp[0]\t$temp[1]\tSYM\n";
			}else{
				print "$temp[0]\t$temp[1]\t$temp[2]\n";
			}
		}
	}	
}
1;
