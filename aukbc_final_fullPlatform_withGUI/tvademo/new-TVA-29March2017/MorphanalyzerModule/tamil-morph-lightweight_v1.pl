#!/usr/bin/perl
# Read the associated files from their respective DBM hashes

readrootDict();
readNEdict();
readFsa();
readOntology();
readAlloMorphMappingInfo();

#to handle punctuations the list of punctuation characters are inserted into the hash
%CER_hash = (
	"&" => "&amp;",
	"," => "&comma;",
	"%" => "&percent;",
	"." => "&dot;",
	"“" => "&ldquo;",
	"\"" => "&quot;",
	"”" => "&rdquo;",
	"'" => "&lsquo;",
	"<" => "&lt;",
	">" => "&gt;",
	".." => "..",
	"..." => "...",
	"...." => "....",
	"`" => "`",
	"=" => "=",
	"_" => "_",
	"-" => "-",
	":" => ":",
	";" => ";",
	"\\" => "&fslash;",
	"/" => "&bslash;",
	"(" => "(",
	")" => ")",
	"]" => "]",
	"[" => "[",
	"+" => "+",
	"!" => "!",
);
#list of punctuation characters inserted into the hash


while(<>) {
	chomp;

	s/\cM//g;

	$word = $_;
	chomp($word);

	if($word eq undef) { print "\n"; next;}
	ILMTma($word);
}


exec("echo >/dev/null");

sub ILMTma
{ 
	$token = $_[0];
	#print "~~~~~~~~~\n";
	print $token,"\t";
	$inittime=(times)[0];

	$correct=0;
	$total=0;

	$timeout = 60;

	@perfect=();
	@perfect_adj=();
	$moditoken ="";
    	%finalout=();
	%possible_tags = ();
	$total++;


	$token =~ s/([A-Za-z]+)([,?:#`'‘’“”";\-\–()@!<>\&\$\]\[~%\^\*])+$/\1/g; #removal of special characters like punctuation
	#if($token =~ /\./) {print "I am Mr DOT\n";}
	#$token =~ s/\.+$//g if($token !~ /^[\w+.][\w+.][\w+]/); #remove only ending fullstops.
	#$token =~ s/\.+$//g if($token =~ /^[\w+.]/); #remove only ending fullstops.
	$token =~ s/^\.+//g if($token =~ /([A-Za-z])/);#remove only beginning fullstops.
    	$modiToken  = $token;
	
	$token =~ s/\.$// if($token =~ /^rU/ and $token =~ /\.$/);
	$token =~ s/// if($token =~ //); #to remove junk char in degree celsius input # 23⁰
	#print "$token\n";

    	if($token =~ /^\-?[0-9]+([.,-]?([0-9]+)?)*$/) { # check for number
		$analysis = "$token,"."num,,,,,,";
		push(@perfect,$analysis);
    	}elsif($token =~ /^(\-|\;|\:|\!|\?|\/|\'|\‘|\’|\’’|\"|\“|\”|\(|\))+$/) { # check for punc
		$analysis = "$token,"."punc,,,,,,";
		push(@perfect,$analysis);
    	}elsif($token =~ /^(\.)+$/) { # check for punc
		$analysis = "&dot;,"."punc,,,,,,";
		push(@perfect,$analysis);
    	}elsif($token =~ /^(\*|\%|\+|\–)$/) { # check for symbols
		$analysis = "$token,"."punc,,,,,,";
		push(@perfect,$analysis);
	}elsif($token =~ /^[0-9]+([.,]?([0-9]+)?)\s*-?[⁰]/) { # check for degree celsius
		$analysis = "$token,"."num,,,,,,";
		push(@perfect,$analysis);
	}elsif($token =~ /^rU\.?[0-9]+([.,][0-9]+)?([.,][0-9]+)?\s*$/) { # check for currency
		$analysis = "$token,"."num,,,,,,";
		push(@perfect,$analysis);
	}elsif($token =~ /^rU\.?[0-9]+([.,][0-9]+)?([.,][0-9]+)?-?(m)\s*$/) { # check for inflected currency
		$analysis = "$token,"."num,,sg,,,";
		push(@perfect,$analysis);
	}elsif($token =~ /^rU\.?[0-9]+([.,][0-9]+)?([.,][0-9]+)?-?(n)\s*$/) { # check for inflected currency
		$analysis = "$token,"."num,,sg,,,";
		push(@perfect,$analysis);
	}elsif($token =~ /^\-?[0-9]+([.,][0-9]+)?([.,][0-9]+)?-?(n)\s*$/) { # check for inflected number
		$analysis = "$token,"."num,,sg,,,";
		push(@perfect,$analysis);
	}elsif($token =~ /^\-?[0-9]+([.,][0-9]+)?([.,][0-9]+)?-?(nwewi)\s*$/) { # check for inflected number
		$analysis = "$token,"."N,,sg,,,";
		push(@perfect,$analysis);
	}elsif($token =~ /^rU\.?[0-9]+([.,][0-9]+)?([.,][0-9]+)?-?(E)[ktcpw]?\s*$/) { # check for inflected currency
		$token =~ s/-?E[ktcpw]?//;
		$analysis = "$token,"."num,E-acc,sg,,,";
		push(@perfect,$analysis);
	}elsif($token =~ /^rU\.?[0-9]+([.,][0-9]+)?([.,][0-9]+)?-?(kku)[ktcpw]?\s*$/) { # check for inflected currency
		$token =~ s/-?kku[ktcpw]?//;
		$analysis = "$token,num,kku-dat,sg,,,";
		push(@perfect,$analysis);
	}elsif($token =~ /^rU\.?[0-9]+([.,][0-9]+)?([.,][0-9]+)?-?(ilirunwu)[ktcpw]?\s*$/) { # check for inflected currency
           	$token =~ s/-?ilirunwu[ktcpw]?//;
		$analysis = "$token,num,ilirunwu-abl,sg,,,";
		push(@perfect,$analysis);
        }elsif($token =~ /^rU\.?[0-9]+([.,][0-9]+)?([.,][0-9]+)?-?(kkum)\s*$/) { # check for inflected currency
		$token =~ s/-?kkum//;
		$analysis = "$token,num,kku-dat,sg,,,";
		push(@perfect,$analysis);
	}elsif($token =~ /^rU\.?[0-9]+([.,][0-9]+)?([.,][0-9]+)?-?(kkulY)\s*$/) { # check for inflected currency
		$token =~ s/-?kkulY//;
		$analysis = "$token,num,kku-dat,sg,,,";
		push(@perfect,$analysis);
	}elsif($token =~ /^[0-9]+([.,][0-9]+)?([.,][0-9]+)?-?(kkulY)\s*$/) { # check for inflected numbers
		$token =~ s/-?kkulY//;
		$analysis = "$token,num,kku-dat,sg,,,";
		push(@perfect,$analysis);
	}elsif($token =~ /^[0-9]+(\.[0-9]+)?-?(Am)\s*$/) { # check for inflected numbers
		$token =~ s/-?Am//;
		$analysis = "$token,num,,sg,,,";
		push(@perfect,$analysis);
	}elsif($token =~ /^[0-9]+(\.[0-9]+)?-?(m)\s*$/) { # check for inflected numbers
		$token =~ s/-?m//;
		$analysis = "$token,num,,sg,,,";
		push(@perfect,$analysis);
	}elsif($token =~ /^[0-9]+(\.[0-9]+)?-?(ilirunwu)\s*$/) { # check for inflected numbers
		$token =~ s/-?ilirunwu//;
		$analysis = "$token,num,ilirunwu-abl,sg,,,";
		push(@perfect,$analysis);
        }elsif($token =~ /[0-9]+(\.[0-9]+)?-?(vawu)\s*$/) { # check for inflected numbers
		$token =~ s/-?vawu//;
		$analysis = "$token,num,,sg,,,";
		push(@perfect,$analysis);
        }elsif($token =~ /[0-9]+(\.[0-9]+)?-?(Avawu)\s*$/) { # check for inflected numbers
		$token =~ s/-?Avawu//;
		$analysis = "$token,num,,sg,,,";
		push(@perfect,$analysis);
	}elsif($token =~ /[0-9]+(\.[0-9]+)?-?(vawum)\s*$/) { # check for inflected numbers
		$token =~ s/-?vawum//;
		$analysis = "$token,num,,sg,,,";
		push(@perfect,$analysis);
	}elsif($token =~ /[0-9]+(\.[0-9]+)?-?(vawAka)[ktcpw]?\s*$/) { # check for inflected numbers
		$token =~ s/-?vawAka[ktcpw]?//;
		$analysis = "$token,num,,sg,,,";
		push(@perfect,$analysis);
	}elsif($token =~ /[0-9]+(\.[0-9]+)?-?(Aka)[ktcpw]?\s*$/) { # check for inflected numbers
		$token =~ s/-?Aka[ktcpw]?//;
		$analysis = "$token,num,,sg,,,";
		push(@perfect,$analysis);
	}elsif($token =~ /[0-9]+(\.[0-9]+)?-?(nY)\s*$/) { # check for inflected numbers
		$token =~ s/-?nY//;
		$analysis = "$token,num,,sg,,,";
		push(@perfect,$analysis);
	}elsif($token =~ /[0-9]+(\.[0-9]+)?-?(E)[ktcpw]?\s*$/) { # check for inflected numbers
		$token =~ s/-?E[ktcpw]?//;
		$analysis = "$token,"."num,E-acc,sg,,,";
		push(@perfect,$analysis);
	}elsif($token =~ /[0-9]+(\.[0-9]+)?-?(e)\s*$/) { # check for inflected numbers
		$token =~ s/-?e//;
		$analysis = "$token,"."num,,sg,,,";
		push(@perfect,$analysis);
	}elsif($token =~ /[0-9]+(\.[0-9]+)?-?i?(l)\s*$/) { # check for inflected numbers
		$token =~ s/-?i?l//;
		$analysis = "$token,num,il-loc,sg,,,";
		push(@perfect,$analysis);
        }elsif($token =~ /[0-9]+(\.[0-9]+)?-?(kku)\s*$/) { # check for inflected numbers
		$token =~ s/-?kku//;
		$analysis = "$token,num,kku-dat,sg,,,";
		push(@perfect,$analysis);
	}elsif($token =~ /[0-9]+(\.[0-9]+)?-?(kalYil)\s*$/) { # check for inflected numbers
		$token =~ s/-?kalYil//;
		$analysis = "$token,num,il-loc,pl,,,";
		push(@perfect,$analysis);
	}elsif($token =~ /[0-9]+(\.[0-9]+)?-?(kalYinY)\s*$/) { # check for inflected numbers
		$token =~ s/-?kalYinY//;
		$analysis = "$token,num,inY-gen,pl,,,";
		push(@perfect,$analysis);
	}elsif($token =~ /[0-9]+(\.[0-9]+)?-?(lirunwu)\s*$/) { # check for inflected numbers
		$token =~ s/-?lirunwu//;
		$analysis = "$token,num,ilirunwu-abl,sg,,,";
		push(@perfect,$analysis);
	}elsif($token =~ /[0-9]+(\.[0-9]+)?-?(kkum)\s*$/) { # check for inflected numbers
		$token =~ s/-?kkum//;
		$analysis = "$token,num,kku-dat,sg,,,";
		push(@perfect,$analysis);
	}elsif($token =~ /[0-9]+(\.[0-9]+)?-?(kkAnYa)\s*$/) { # check for inflected numbers
		$token =~ s/-?kkAnYa//;
		$analysis = "$token,num,kku-dat,sg,,,";
		push(@perfect,$analysis);
	}elsif(exists $CER_hash{$token}) {
		$analysis = "$CER_hash{$token},punc,,,,,";
		push(@perfect,$analysis);
	}else{
		undef $selectedlCat;
		morph($modiToken);
	}
	#print "QAZXSW", join "~~", @perfect,"\n";

	if($perfect[0] eq undef) {
		if($perfect_adj[0] eq undef) {
			print "$token,unk,,,,,,\n";
		}else{
			@perfect = @perfect_adj;
			finaloutput();
		}
	}else{
		finaloutput();
	}

	#print STDERR "I am came here\n";
	undef $selectedlCat;
	undef @perfect;	
	#print STDERR "123qazQAZqaz\n";	

#dbmclose(%rootDict);
#dbmclose(%correct);
#dbmclose(%stateTableCategory);
#dbmclose(%suffixCategory);
#dbmclose(%CER_hash);
#dbmclose(%genderHash);

$endtime=(times)[0];

}
1;

###### new MA

#--------------------------------

sub morph {
	my $state8 = 0;
	my $inpWord8;
	@adjArr8 = ("m", "nY", "r", "A");
	$bomChar = "﻿";
	$splChar200c = "‌";
	$splChar80 = "";
	$splChar99 = "";
	$splChar93 = "";
	$inpWord8 = shift @_; 
	$inpWord8 =~ s/^\s+//;
	$inpWord8 =~ s/\s+$//;
         	$inpWord8 =~ s/^[`'‘“"!@#$%^&*(),+-.:;_=?<>~â¦]+//;
         	$inpWord8 =~ s/[`'’”"!@#$%^&*(),+-.:;_=?<>~â¦]+$// if($inpWord8 !~ /^[\w+.][\w+.][\w+]/);
		$inpWord8 =~ s/$bomChar//; #removing the BOM-Byte Order Mark special(cntrl) char
		$inpWord8 =~ s/$splChar200c//; #removing the special char 200c #search pattern[Ctrl-v u200c]
                $inpWord8 =~ s/$splChar80//;  #hexcode 80
                $inpWord8 =~ s/$splChar99//;  #hexcode 99
                $inpWord8 =~ s/$splChar93//;  #hexcode 93
		#$inpWord8 =~ s/[‘’]//;
		#$inpWord8 =~ s/^\‘//;
		#$inpWord8 =~ s/\’$//;
	
	#print STDERR "$inpWord8 :: "; #------------Input Reads-------------------#	
		$input8 = $inpWord8;
		$splitMorpheme8 = "";
		$tagOut8 = "";

		#$starttime = (times)[0]; #to measure running time for each word
		#print "$starttime\n";
		morphanalysis($state8, $input8, $splitMorpheme8, $tagOut8);
		#print time(),"\n";
		#$endtime = (times)[0];
		#print "$endtime\n";
		#$timetaken = $endtime - $starttime; #to measure running time for each word
		#print (times)[0],"\n";
		#print "$inpWord time_taken=> $timetaken\n";	
}


sub morphanalysis{
	my ($mystate8, $word8, $newMorphOut8, $newTagOutput8) = @_;
	
#	print STDERR "Inputs are $mystate8, $word8, $newMorphOut8, $newTagOutput8\n";

	#to check rootdictionary
	#my $morphOut  = $newMorphOut;
	#my $tagOutput = $newTagOutput;

	my (@paradigms8, $paradigmKey8, $fsakey8, $suffix8, $paradigm8, @nextStates8, $nextState8, $inpWord18, $modiWord8,$sandhiKey8, $sandhiCorr8, $remainW8);

# to handle adjectives that endswith 'a'
	if($word8 =~ m/a$/ and $mystate8 eq "0"){
		foreach $elem8 (@adjArr8){
			if($elem8 =~ /^A$/) {
				$inpWord18 = $word8;
				$inpWord18 =~ s/a$/$elem8/;
			}else{
				$inpWord18 = $word8.$elem8 if($rootDictHash8{$word8} !~ /ADV|WQ|PSP|PN|V/);
			}
		#	print STDERR "$inpWord18\n";
			$splitMorpheme8 = "";
			my $tagOutAdj8 = "ADJ";
			
			if($rootDictHash8{$inpWord18} =~ /,/){
			my @cmAdjArr = split(/,/, $rootDictHash8{$inpWord18});
				foreach my $cmAdjArrElem(@cmAdjArr){
					my $tagOutputAdj8 = $cmAdjArrElem."+".$tagOutAdj8;
					#my $morphOutputAdj8 = $word8.$elem8."+"."a";
					my $morphOutputAdj8 = $inpWord18."+"."a";
		#newlyadded
					if($newTagOutput8 ne undef) {
						$tagOutputAdj8 = "$newTagOutput8+$tagOutputAdj8";
						$morphOutputAdj8 = "$newMorphOut8+$morphOutputAdj8";
					}
		#newlyadded	
			#print STDERR "morphOut: $morphOutputAdj8 -- tagOut: $tagOutputAdj8\n" if(exists $rootDictHash8{$inpWord18});
					if(exists $rootDictHash8{$inpWord18}) {
						push(@perfect_adj,$morphOutputAdj8, $tagOutputAdj8);
					}
				}
			}else{
				my $tagOutputAdj8 = $rootDictHash8{$inpWord18}."+".$tagOutAdj8;
				#my $morphOutputAdj8 = $word8.$elem8."+"."a";
				my $morphOutputAdj8 = $inpWord18."+"."a";
				
				if($newTagOutput8 ne undef) {
					$tagOutputAdj8 = "$newTagOutput8+$tagOutputAdj8";
					$morphOutputAdj8 = "$newMorphOut8+$morphOutputAdj8";
				}

				if(exists $rootDictHash8{$inpWord18}) {
					push(@perfect_adj,$morphOutputAdj8, $tagOutputAdj8);
				}
			}
		}
	#to handle adjectives that ends with 'a' followed by [ktcpw]
	}

	if($word8 =~ m/a[kctwp]$/ and $mystate8 eq "0" and !exists $rootDictHash8{$word8}){
			$word8 =~ s/a[kctpw]$/a/;
			#print STDERR "I came here in adj ktcpw #### $word8\n";
			foreach $elem8 (@adjArr8){
	                       if($elem8 =~ /^A$/) {
        	                        $inpWord18 = $word8;
        	                        $inpWord18 =~ s/a$/$elem8/;
        	               }else{
					$inpWord18 = $word8.$elem8 if($rootDictHash8{$word8} !~ /ADV|WQ|PSP|PN/);
                 	       }
				
				$splitMorpheme8 = "";
				my $tagOutAdj8 = "ADJ";
			if($rootDictHash8{$inpWord18} =~ /,/){
				my @cmAdjArr = split(/,/, $rootDictHash8{$inpWord18});
				foreach my $cmAdjArrElem(@cmAdjArr){
					my $tagOutputAdj8 = $cmAdjArrElem."+".$tagOutAdj8;

					#my $tagOutputAdj8 = $rootDictHash8{$inpWord18}."+".$tagOutAdj8;
					#my $morphOutputAdj8 = $word8.$elem8."+"."a";
					my $morphOutputAdj8 = $inpWord18."+"."a";

					if($newTagOutput8 ne undef) {
						$tagOutputAdj8 = "$newTagOutput8+$tagOutputAdj8";
						$morphOutputAdj8 = "$newMorphOut8+$morphOutputAdj8";
					}
#print STDERR "morphOut: $morphOutputAdj8 -- tagOut: $tagOutputAdj8\n" if(exists $rootDictHash8{$inpWord18});
					if(exists $rootDictHash8{$inpWord18}) {
						push(@perfect,$morphOutputAdj8, $tagOutputAdj8);
                	        	}
			}
			}else{
				my $tagOutputAdj8 = $rootDictHash8{$inpWord18}."+".$tagOutAdj8;
				my $morphOutputAdj8 = $inpWord18."+"."a";

				if($newTagOutput8 ne undef) {
					$tagOutputAdj8 = "$newTagOutput8+$tagOutputAdj8";
					$morphOutputAdj8 = "$newMorphOut8+$morphOutputAdj8";
				}
#print STDERR "morphOut: $morphOutputAdj8 -- tagOut: $tagOutputAdj8\n" if(exists $rootDictHash8{$inpWord18});
                        	if(exists $rootDictHash8{$inpWord18}) {
					push(@perfect,$morphOutputAdj8, $tagOutputAdj8);
                        	}	
			}
                }
	}
#newlyadded	
#=cut

        if($word8 =~ /^((i)|(a)|(eV))(\w)\5/ and $mystate8 eq "0"){
	#print STDERR "$word8\n";
		$ivvDet = "ivv";
		$avvDet = "avv";
		$eVvvDet = "eVvv";
                $inpWord18 = $word8;
		my $splitMorpheme8;
		if($inpWord18 =~ /^((i)|(a)|(eV))(\w)/) {
			$splitMorpheme8 = $1;
		}
                my $tagOutDem8 = "DEM_DET";
		if($inpWord18 =~ /^(($ivvDet)|($avvDet)|($eVvvDet))/){
			my $inpWord18_tmp = $inpWord18;
			#$inpWord18_tmp =~ s/^((i)|(a)|(eV))(\w)\5//;
			$inpWord18_tmp =~ s/^((i)|(a)|(eV))(\w)//;
			#print STDERR "~~~~~~~~~~~~~ \($mystate8, $inpWord18_tmp, $splitMorpheme8, $tagOutDem8\)\n";
			morphanalysis($mystate8, $inpWord18_tmp, $splitMorpheme8, $tagOutDem8);
		}
		$inpWord18 =~ s/^((i)|(a)|(eV))(\w)\5/\5/;
		#print STDERR "~~~~~~ $mystate8, $inpWord18, $splitMorpheme8, $tagOutDem8\n";
		$inpWord18 =~ s/[kctpw]$// if($inpWord18 =~ m/[kctwp]$/ and $mystate8 eq "0" and !exists $rootDictHash8{$inpWord18}); #added by mario on 19-6 [to strip 'ktcpw' from inp word before calling morph#
		morphanalysis($mystate8, $inpWord18, $splitMorpheme8, $tagOutDem8);
        }

#--------------------

## actual morph analysis starts, here we check for root word
	#print STDERR "I am in the dict - $word8\n";
	if(exists $rootDictHash8{$word8}){
		#print STDERR "I am in the dict $word8\n";
		if($mystate8 eq "0"){
			my $rootTag8 =  $rootDictHash8{$word8};
			$m_input =$word8;
			
			if($newTagOutput8 =~ /DEM_DET/) {
				#$rootTag8 = "DEM_DET+".$rootTag8;
				if($newMorphOut8 =~ /((i)|(a)|(eV))$/){
					$dem = $&;
					#print STDERR "$newMorphOut8\n";
					$m_input = "$dem+$m_input";
				}
			}

				#print STDERR "morphOut111: $word8 => $rootTag8\n";
			if($rootTag8 !~ m/,/){
				$rootTag8 = "DEM_DET+".$rootTag8 if($newTagOutput8 =~ /DEM_DET/);
				#push(@perfect,$m_input, $rootTag8) if($rootTag8 !~ /^DEM_DET\+V\d+/);
				#code modified by mario on 19-6 
				#to handle when i/p word of the categories, no need of determiner processing
				if(($rootTag8 !~/^DEM_DET/) && ($rootTag8 =~ /^((ADV)|(ADJ)|(WQ)|(PN)|(PSP))/i)){
					undef @perfect;
					push(@perfect,$m_input, $rootTag8);
					$selectedlCat = 1;
					#print STDERR "$selectedlCat\n qazxsw\n";
				}else{
					push(@perfect,$m_input, $rootTag8) if($rootTag8 !~ /^DEM_DET\+V\d+/);
				} #code modified by mario on 19-6
			}else{
				#print STDERR "morphOut112: $word8 => $rootTag8\n";
				undef @rootTagArr8;
				@rootTagArr8 = split(/,/, $rootTag8);
				#print STDERR "morphOut113: @rootTagArr8 = $newTagOutput8\n";
				foreach $newRootTag8 (@rootTagArr8){
					$newRootTag8 = "DEM_DET+".$newRootTag8 if($newTagOutput8 =~ /DEM_DET/);
					next if($newRootTag8 =~ /^DEM_DET\+V\d+/);

					if(($newRootTag8 !~/^DEM_DET/) && ($newRootTag8 =~ /^((ADV)|(WQ)|(PN)|(PSP))/i)){
						$selectedlCat = 1;
						#print STDERR "$selectedlCat\n qazxsw\n";
					}
				#print STDERR "morphOut113: $m_input = $newRootTag8\n";
					push(@perfect,$m_input, $newRootTag8);
				}
			}
		}else{
			#print STDERR  "$word8 -- $rootDictHash8{$word8}\n";
			if($rootDictHash8{$word8} =~ /\,/){
				@paradigms8 = split(/,/, $rootDictHash8{$word8});
			}else{
				push(@paradigms8, $rootDictHash8{$word8});
			}

			#print STDERR join "---", @paradigms8,"\n";
			foreach $paradigm8(@paradigms8){
				$paradigmKey8 = $mystate8."_".$paradigm8;
				#print STDERR "para_key $paradigmKey8\n";
				if (exists $fsaHash8{$paradigmKey8}){
					#print STDERR "~!~!@~!~! $word8, $rootDictHash{$word8}\n";
					my $morphOut8 = $word8."+".$newMorphOut8;
					my $tagOutput8 = $paradigm8."+".$newTagOutput8;
					$morphOut8 =~ s/\+\s*$//;
					$tagOutput8 =~ s/\+\s*$//;
					
					if(($tagOutput8 =~ /\+DEM_DET$/) && ($morphOut8 =~ /\+((i)|(a)|(eV))$/)) {
						$tagOutput8 =~ s/\+DEM_DET$//;
						$tagOutput8 = "DEM_DET+".$tagOutput8;
						if($morphOut8 =~ /\+((i)|(a)|(eV))$/) {
							$det8 = $1;
							$morphOut8 =~ s/\+$det8$//;
							$morphOut8 = "$det8+".$morphOut8;
						}
					}
					#print STDERR "morphOut: $morphOut8 -- tagOut: $tagOutput8\n";
					if($tagOutput8 =~ /DEM_DET/) {
						push(@perfect, $morphOut8, $tagOutput8) if($tagOutput8 =~ /\+((N\d+)|(VN))/);
					}else{
						push(@perfect, $morphOut8, $tagOutput8);
					}
					#print "$morphOut -- $tagOutput\n";
				}
			}
		}
	}
	#else{
	#to strip ckptw from input words & check in rootDict
	if($mystate8 eq "0") {
		$tmp_word8 =$word8;
		if($tmp_word8 =~ /[kctpw]$/) {
			$tmp_word8 =~ s/[ckptw]$//;
			#print "morphOut: $tmp_word8 => $rootDictHash8{$tmp_word8}\n" if(exists $rootDictHash8{$tmp_word8});
			if(exists $rootDictHash8{$tmp_word8}) {
                        	if($newTagOutput8 =~ /DEM_DET/) {
                        	        $rootTag8 = "DEM_DET+".$rootTag8;
                        	        if($newMorphOut8 =~ /((i)|(a)|(eV))$/){
                        	                $dem = $&;
                        	                #print STDERR "$newMorphOut8\n";
                        	                $tmp_word8 = "$dem+$tmp_word8";
                        	        }
                       		 }

				my $rootTag8 =  $rootDictHash8{$tmp_word8};
				if($rootTag8 !~ m/,/){
					push(@perfect,$tmp_word8, $rootTag8);
				}else{
					undef @rootTagArr8;
					@rootTagArr8 = split(/,/, $rootTag8);
					foreach $newRootTag8 (@rootTagArr8){
						push(@perfect,$tmp_word8, $newRootTag8);
					}
				}
			}
		}
=c
	else{
			$nextState8 = 0;
			$modiWord8 = $tmp_word8;
			$morphOut8 = "";
			$tagOutput8 = "";
			morphanalysis($nextState8, $modiWord8, $morphOut8, $tagOutput8);
		}
=cut
	}
	if($mystate8 eq "0") {			#to strip ckptw from input words & process the word
		$word8 =~ s/[ckptw]$//;
		#print STDERR "~~~~~~~$word8\n";
	}

##  morph analysis here we check for possible suffixes
	foreach $suffix8 (keys %suffixHash8) {
		next if($suffix8 !~ /\w+/);
		if($word8 =~ /$suffix8$/){
			$remainW8 = $`;
			#to form fsa key for retrieving next state
			$fsakey8 = $mystate8."_".$suffix8;
			#print "FSA key $fsakey--\n";

			#possible next states
			if($fsaHash8{$fsakey8} =~ /\,/){
				@nextStates8 = split(/,/, $fsaHash8{$fsakey8});
			}else{
				push(@nextStates8, $fsaHash8{$fsakey8});
			}
		
			foreach $nextState8 (@nextStates8){

				#to form sandhi key for sandhi correction
				$sandhiKey8 = $mystate8."_".$nextState8."_".$suffix8;
				#print "SANDHIKEY-$sandhiKey\n";
				if(exists $sandhiHash8{$sandhiKey8}){	
					$sandhiCorr8 = $sandhiHash8{$sandhiKey8};
					#print "SANDHICORR-$sandhiCorr\n";
					
					#sandhi replacement
					$modiWord8 = "$remainW8$sandhiCorr8";
				}else{
					$modiWord8 = "$remainW8";
				}
				if(exists $tagHash8{$sandhiKey8}) {	
					#print "Modified word = $modiWord\n Next State = $nextState\n";
					my $morphOut8 = "$suffix8+$newMorphOut8";
					#print "MORPHOUT SUFF---$suffix---\n";
					#print "MORPHOUT---$morphOut--\n";
#########################################
					if($tagHash8{$sandhiKey8} =~ /\,/) {
						undef $possibletag8;
						#print "~~~ $tagHash{$sandhiKey}\n";
						foreach $possibletag8 (split(/\,/, $tagHash8{$sandhiKey8})) {
							my $tagOutput8 = "$possibletag8+$newTagOutput8";
							#print "NS-$nextState\tMW-$modiWord\tMOUT-$morphOut\tTAGOUT-$tagOutput\n";
							morphanalysis($nextState8, $modiWord8, $morphOut8, $tagOutput8);
						}
					}else{
						my $tagOutput8 = "$tagHash8{$sandhiKey8}+$newTagOutput8";
						#print "NS-$nextState\tMW-$modiWord\tMOUT-$morphOut\tTAGOUT-$tagOutput\n";
						morphanalysis($nextState8, $modiWord8, $morphOut8, $tagOutput8);
					}

########################################
				}
			}
		}
	}#foreach_suffix_ends_here
	#}#main_else_ends_here
}


###############

sub finaloutput()
{
	#orderOutput();
	#print STDERR "I came herer\n";
	print_result();
}

1;

sub isCorrect()
{
	my $tag = $_[0];
	foreach $ct (keys %correct) {
		$ct =~ s/\+/\\+/g;
		if($tag =~ /^$ct$/) {
			return 1;
		}
	}
	return 0;
}

sub print_result1() {
	for($ijk8 = 0;$ijk8 < @perfect;$ijk8=$ijk8+2) {
		#print "!!! $perfect[$ijk8] --- $perfect[$ijk8+1]\n";
	}
}

sub print_result() # Conversion of result to SSF format
{
	#print STDERR "~~~~!@# $token PERFECT @perfect\n";
	for($ijk8 = 0;$ijk8 < @perfect;$ijk8=$ijk8+2) {
		#print "!!! $perfect[$ijk8] --- $perfect[$ijk8+1] ~~~~\n";
	}
	#-----------------------  #alloMorpheme to equivalent Morpheme mapping done here
	my($al, @morphemeArray1, @morphemeArray2);
	for($al=0; $al<@perfect ; $al=$al+2){
		#$perfect[$al+1] =~ s/\~/\+/;
		@morphemeArray1 = split(/\+/, $perfect[$al]);
		@morphemeArray2 = split(/\+/, $perfect[$al+1]);

		#print STDERR "$perfect[$al] ----- $perfect[$al+1]\n";
		if(@morphemeArray1 == @morphemeArray2){
			for($ijkl = 1; $ijkl < @morphemeArray1;$ijkl++) {
				$key = "$morphemeArray2[$ijkl]\_$morphemeArray1[$ijkl]";
				#print STDERR "KKK $key -- $alloMorphMappingHash8{$key}\n";
				if(exists $alloMorphMappingHash8{$key}) {
					#print STDERR "KKK1 $key -- $alloMorphMappingHash8{$key}\n";
					$morphemeArray1[$ijkl] = $alloMorphMappingHash8{$key};
				}
			}
		}
		$line1 = join "+", @morphemeArray1;
		$line2 = join "+", @morphemeArray2;

		$line1 =~ s/\+$//;
		$line2 =~ s/\+$//;

		$perfect[$al] = $line1;
		$perfect[$al+1] = $line2;

		$perfect[$al+1] =~ s/NEG~VBP/NEG_VBP/;
		$perfect[$al+1] =~ s/NEG~RP/NEG_RP/;
		$perfect[$al+1] =~ s/\~/+/g;
		$perfect[$al+1] =~ s/VAUX/V/g;

		#print STDERR "*** $perfect[$al]\n";
		#print STDERR "*** $perfect[$al+1]\n";
	}	
	#remove duplicates wrt to paradigms
	undef @newPERFECT;
	undef @perfectDem;
	undef %ma_analysisHash;	

	$noAnalysis = @perfect;
	
	for($al=0; $al<@perfect ; $al=$al+2){
		$analysis = $perfect[$al+1];
		$analysis =~ s/V(\d+)/V/;
		$analysis =~ s/N(\d+)/N/;
		$analysis =~ s/V\+FUTURE\+NDRD/V\+FUTURE\+3SN/;
		$analysis =~ s/^\s*//;
		$perfect[$al] =~ s/^\s*//;

		$perfect[$al] =~ s/\+a\+awu\+Al/\+awAl/;
		$analysis =~ s/\+RP\+NDRD\+INS/\+COND/;

		$key = $perfect[$al]."~".$analysis;
		#print "$key\n";

		if(($noAnalysis > 2) && ($analysis =~ /^$/)) {next;}

		if(($key !~ /\+IMP/) && ($key !~ /\+VOC/)) {
		if(!exists $ma_analysisHash{$key}) {

			if($analysis =~ /^DEM_DET/) {
				push(@perfectDem,$perfect[$al]);
				push(@perfectDem,$analysis);
			}else{
				push(@newPERFECT,$perfect[$al]);
				push(@newPERFECT,$analysis);
			}

			$ma_analysisHash{$key}++;
		}
		}else{
			#print STDERR "!~! $key\n";
		}
	}
	
	undef @perfect;
	@perfect = @newPERFECT;

	push(@perfect, @perfectDem);

	undef $combinedResult;

	for($al=0; $al<@perfect ; $al=$al+2){
		#print STDERR " $perfect[$al] ~~~ $perfect[$al+1]\n";
		$modifiedResult = formatResult($perfect[$al], $perfect[$al+1]);
		#print  " $modifiedResult\n";
		$combinedResult = $combinedResult."|$modifiedResult";
		#print  " $perfect[$al+1] --- $modifiedResult\n";
	}

	$combinedResult =~ s/^\|//;
	print "$combinedResult\n";
}

sub formatResult {
	my ($inputHere1,$inputHere) = @_;

	#print "!!! $inputHere -- $inputHere1\n";

	#to remove dem_det
	if($inputHere =~ /DEM_DET/i) {
		$inputHere =~ s/DEM_DET\+//i;	
		$inputHere1 =~ s/^\s*\w+\+//i;
	}	
	
	@analysisEle1 = split(/\+/,$inputHere1);
	@analysisEle = split(/\+/,$inputHere);

	my($cat, $person, $number, $gender, $tense, $verbType, $plural, $case);
	
	if($analysisEle[0] =~ /V/) {
		$cat = $analysisEle[0];
		if($inputHere =~ /(PRESENT)|(PAST)|(FUTURE)/) {$tense = $&;}
		if($inputHere =~ /3SM/) {$person = 3; $number = "sg"; $gender = "m";}
		if($inputHere =~ /3SF/) {$person = 3; $number = "sg"; $gender = "f";}
		if($inputHere =~ /3SN/) {$person = 3; $number = "sg"; $gender = "n";}
		if($inputHere =~ /3PH/) {$person = 3; $number = "pl"; $gender = "c";}
		if($inputHere =~ /3SH/) {$person = 3; $number = "sg"; $gender = "c";}
		if($inputHere =~ /3PN/) {$person = 3; $number = "pl"; $gender = "n";}
		if($inputHere =~ /3PC/) {$person = 3; $number = "pl"; $gender = "c";}
		
		if($inputHere =~ /1SC/) {$person = 1; $number = "sg"; $gender = "c";}
		if($inputHere =~ /1PC/) {$person = 1; $number = "pl"; $gender = "f";}

		if($inputHere =~ /2SC/) {$person = 2; $number = "sg"; $gender = "c";}
		if($inputHere =~ /2PC/) {$person = 2; $number = "pl"; $gender = "f";}

		$verbType = "";
		if($inputHere =~ /\+NEG_RP/) {$verbType = $verbType."-neg_rp";
		}elsif($inputHere =~ /\+RP\+3SN/) {$verbType = $verbType."-RP-PRP";
		}elsif($inputHere =~ /\+RP\+NDRD/) {$verbType = $verbType."-RP-PRP";
		}elsif($inputHere =~ /\+RP\+PSP/) {$verbType = $verbType."-RP-PSP";
		}elsif($inputHere =~ /\+RP/) {$verbType = $verbType."-RP";
		}elsif($inputHere =~ /\+COND/) {$verbType = $verbType."-COND";
		}else{
			if($inputHere =~ /\+VBP\+INF/) {$verbType = $verbType."-INF";
			}elsif($inputHere =~ /\+INF\+VBP/) {$verbType = $verbType."-VBP";
			}elsif($inputHere =~ /\+VBP(\+INC)?$/) {$verbType = $verbType."-VBP";
			}elsif($inputHere =~ /\+INF(\+INC)?$/) {$verbType = $verbType."-INF";}
		}
		if($inputHere =~ /\+NEG/) {$verbType = $verbType."-NEG";}
		if($inputHere =~ /\+PSP/) {$verbType = $verbType."-PSP";}

		$verbType =~ s/^\-//;

		$modiRes = "$analysisEle1[0],$analysisEle[0],$tense,$number,$person,$gender,$verbType";

	}elsif($analysisEle[0] =~ /(P)?N/) {
		$cat = $analysisEle[0];

		$key456 = "$analysisEle1[0]\_". uc($analysisEle[0]);

		#print "$key456\n";

		$gender = $genderHash{$key456};

		$number = $numberHash{$key456};

		if($analysisEle[1] =~ /PL/) {
			$number = "pl";
			if($analysisEle[2] =~ /(DAT)|(LOC)|(ABL)|(ACC)|(SOC)|(INS)|(GEN)/) {
				$case = "$analysisEle1[2]-$&";
			}
		}else{
			if($analysisEle[1] =~ /(DAT)|(LOC)|(ABL)|(ACC)|(SOC)|(INS)|(GEN)|(ADJ)|(PSP)|(ADV)/) {
				$case = "$analysisEle1[1]-$&";
			}
		}
		$modiRes = "$analysisEle1[0],$analysisEle[0],$case,$number,$person,$gender,";
		

	}elsif(($inputHere!~ /\+/) && ($inputHere =~ /\w+/)) {
		$modiRes = "$analysisEle1[0],$analysisEle[0],,,,,";
	}elsif($inputHere eq "") {
		if($analysisEle1[0] !~ /\,/){
			$modiRes = "$analysisEle1[0],unk,,,,,";
		}else{
			$modiRes = "$analysisEle1[0]";
		}
	}else{
		$modiRes = $inputHere;
	}
}

=c
	#-----------------------  #alloMorpheme to equivalent Morpheme mapping ends here
	
	#print result in the ILMT feature structure format

   	if(scalar @perfect) { #if there is a valid output
		%Copula = undef;
		%Existential = undef;
		readCopula();
		readExistential();
				
   		$correct++;
   		for($i=0;$i < @perfect;$i+=2){ # The @perfect array contains valid ouput alternating with its valid tag
	
			my $featureStr = {};
			$featureStr->{ROOT}= "";  # the first eight entries of ILMT fs are initialised
			$featureStr->{LCAT}= "";
			$featureStr->{GEND}= "n";
			$featureStr->{NUM}= "sg";
			$featureStr->{PERS}= "";
			$featureStr->{CASE}= "d";
			$featureStr->{CM}= "";
			$featureStr->{TAM}= "";
			$featureStr->{EXTD}= " case_name=\"nom\""; 
			$featureStr->{SUFF}= "";
			my $paradigm = 0;

		my @finalkeys=split(/\+/,$perfect[$i]);
		my @finaltags=split(/\+/,$perfect[$i+1]);

		$genkey8 = $finaltags[0];
		$genkey8 =~ s/\d+$//;
		$genkey8 = $finalkeys[0]."_".$genkey8;

		#Hash to handle Nouns with NDRD (derived nouns e.g. patEyulYlYavar)
		%ndrdGenderTagHashforDRDNoun = (
			"avanY" => "m",
			"avalY" => "f",
			"avar" => "mf",
			"or" => "mf",
			"avarkalY" => "mf",
			"arkalY" => "mf",
		);

    	    for($mu=0;$mu<@finalkeys;$mu++) {
				#print STDERR "$mu  $finaltags[$mu] -- $finalkeys[$mu]\n";
				if($finaltags[$mu] =~ /^N\d*$/ or $finaltags[$mu] =~ /^PN\d*$/ or $finaltags[$mu] =~ /^NUM\d*/) { #Noun or pronoun ROOT
					$featureStr->{ROOT} .= $finalkeys[$mu];
					$featureStr->{LCAT}= $paradigm = lc $finaltags[$mu];
					#print STDERR "$featureStr->{LCAT} = $paradigm = $finaltags[$mu]\n";
					
					if($featureStr->{LCAT} =~ /^n\d+/) {
						$featureStr->{GEND}= "any";
					}
	#print STDERR "$featureStr->{ROOT} = $featureStr->{GEND} = $finaltags[$mu] = $finalkeys[$mu]\n";
	
	#to assign PERS to nouns(root-form) like avar, cirYiyavar, avanY, cirYiyavanY, avalY, cirYiyavalY#
					if($finalkeys[$mu] =~ /(avalY)$|(avanY)$|(avar)$/){ 
						$featureStr->{PERS} = "3";
					}

					#handler for nouns with NDRD (derived nouns e.g. patEyulYlYavar)
					foreach my $ngenderTag (@finaltags){
						foreach my $ngenderKey (@finalkeys){
							if($ngenderTag =~ /^NDRD/){
								$featureStr->{GEND}= $ndrdGenderTagHashforDRDNoun{$ngenderKey} if(exists $ndrdGenderTagHashforDRDNoun{$ngenderKey});
							}
						}
					}
					$genkey = $finalkeys[$mu].",". lc ($finaltags[$mu]);
					$genkey =~ s/\d+$//;
	    				#print STDERR "$genkey8 -- $ontologyHash{$genkey8}\n";

			#if it's pronoun, we generate key of ontologyHash which is ($finalkeys[$mu],n) form#
	    					if($finaltags[$mu] =~ /^PN\d*$/){
							$finaltags[$mu] =~ s/PN/N/;
							$genkey = $finalkeys[$mu].",". lc ($finaltags[$mu]);
							$genkey =~ s/\d+$//;
						}
					$featureStr->{NUM}= $ontologyHash{$genkey8} if(exists $ontologyHash{$genkey8});

	    				#print STDERR "$genkey8 -- $ontologyHash{$genkey8}\n";
					#print STDERR "$featureStr->{GEND} = $genkey\n";
					if($ontologyHash{$genkey} =~ /human_female$/) {
						$featureStr->{GEND}= "f";
					}elsif($ontologyHash{$genkey} =~ /human_nfemale$/) {
						$featureStr->{GEND}= "m";
					}elsif($ontologyHash{$genkey} =~ /human$/) {
						$featureStr->{GEND}= "mf";
					}
#=cut ontologyInfoCommented
					if(exists $ontologyHash{$genkey}){
						#print STDERR "$genkey is there\n";
						$featureStr->{EXTD} .= " ontlg_info=\"$ontologyHash{$genkey}\"";
					}
#=cut ontologyInfoCommented

					if(exists $Number{$finalkeys[$mu].",".$finaltags[$mu]}) {
						$featureStr->{NUM}= lc $Number{$finalkeys[$mu].",".$finaltags[$mu]};
					}
					if($finaltags[$mu+1] =~ /^V\d*$/ ) { # if it is a derived verb from noun eg. peVrumE(N) + atE (V)
							next;
					}
					if($finaltags[$mu+1] =~ /^ADJ\d*$/ and $finaltags[$mu+2] = /^V\d*$/) { # derived verb from noun eg. kopam(N)+ a(ADJ)+ patu(V)
						$mu++;
						next;
					}
					
					DERIVEDNOUN:  #label for derived noun . Control transfers here
					$mu++;
					#print STDERR "FFFKKK $finalkeys[$mu] ; FFFTTT $finaltags[$mu]\n";
%copulaPersonTagHash = (
	"AnYawu" => "3",
	"mikkawu" => "3",
);
					while($mu < @finalkeys) {
						#print STDERR "~~~~$finaltags[$mu]\n";
						if($finaltags[$mu] =~ /^N\d*$/ or $finaltags[$mu] =~ /^PN\d*$/) {  # compound nouns
							$featureStr->{ROOT} .= "$finalkeys[$mu]";
							$genkey = $finalkeys[$mu].",". lc ($finaltags[$mu]);
							$genkey =~ s/\d+$//;

							if($ontologyHash{$genkey} =~ /human_female$/) {
								$featureStr->{GEND}= "f";
							}elsif($ontologyHash{$genkey} =~ /human_nfemale$/) {
								$featureStr->{GEND}= "m";
							}

							if(exists $Number{$finalkeys[$mu].",".$finaltags[$mu]}) {
								$featureStr->{NUM}= lc $Number{$finalkeys[$mu].",".$finaltags[$mu]};
							}
							$featureStr->{LCAT} = $paradigm = lc $finaltags[$mu];
						}
						elsif($finaltags[$mu] =~ /^(ADJ)\d*$/) {
							#$featureStr->{ROOT} .= "$finalkeys[$mu]";
							#print STDERR "here the lcat is $finaltags[$mu] $featureStr->{LCAT}\n";
#print STDERR "here the lcat is $finaltags[$mu]; $featureStr->{LCAT}; $finalkeys[$mu] ne $featureStr->{ROOT}\n";
							if($featureStr->{LCAT} !~ /^n/) {
							#added by mario on 11-6
								#$featureStr->{LCAT} = $paradigm = lc $finaltags[$mu];
								if($featureStr->{LCAT} =~ /^(pn)\d+/){
									$featureStr->{LCAT} =~  s/$featureStr->{LCAT}/pn/;
									$featureStr->{SUFF} .= "_$finalkeys[$mu]";
									$featureStr->{EXTD} .= " adj=\"$finalkeys[$mu]\"";
								}
								if(($finaltags[$mu] =~ /^ADJ\d*$/) && ($featureStr->{LCAT} ne "") && ($finalkeys[$mu] ne $featureStr->{ROOT} && $featureStr->{LCAT} ne "pn")){ # adjs
								#print STDERR "here the lcat is $finaltags[$mu] $featureStr->{LCAT}\n";
									$featureStr->{SUFF} .= "_$finalkeys[$mu]";
									$featureStr->{EXTD} .= " adj=\"$finalkeys[$mu]\"";
								}
							#added by mario on 11-6
							}
							else{
					#print STDERR "here the lcat is $finaltags[$mu] $featureStr->{LCAT}\n";
								$featureStr->{EXTD} .= " adj=\"$finalkeys[$mu]\"";
								$featureStr->{SUFF}.= "_$finalkeys[$mu]";
							}
						}elsif($finaltags[$mu] =~ /^(COPULA)\d*$/) {
								$featureStr->{EXTD} .= " copula=\"Y\"";
								$featureStr->{SUFF}.= "_$finalkeys[$mu]";
								$featureStr->{PERS} = $copulaPersonTagHash{$finalkeys[$mu]} if(exists $copulaPersonTagHash{$finalkeys[$mu]});
						}elsif($finaltags[$mu] =~ /^(WH)\d*$/){
								$featureStr->{EXTD} .= " int=\"Y\"";
								$featureStr->{SUFF}.= "_$finalkeys[$mu]";
						}elsif($finaltags[$mu] =~ /^(ADV)\d*$/){
							#$featureStr->{ROOT} .= "$finalkeys[$mu]";
							if($featureStr->{LCAT} !~ /^n/) {
							#added by mario on 11-6
								#$featureStr->{LCAT} = $paradigm = lc $finaltags[$mu];
								if($featureStr->{LCAT} =~ /^(pn)\d+/){
									$featureStr->{LCAT} =~  s/$featureStr->{LCAT}/pn/;
									$featureStr->{SUFF}.= "_$finalkeys[$mu]";
									$featureStr->{EXTD} .= " adv=\"$finalkeys[$mu]\"";
									#$featureStr->{EXTD} .= " adv=\"Y\" adv_marker=\"$finalkeys[$mu]\"";
								}#added by mario on 22-6
								if($featureStr->{LCAT} =~ /^(v)\d+/){
									$featureStr->{SUFF}.= "_$finalkeys[$mu]";
									$featureStr->{EXTD} .= " adv=\"$finalkeys[$mu]\"";
								} #added by mario on 22-6
							#added by mario on 11-6
					#$featureStr->{LCAT} = $paradigm = s/$featureStr->{LCAT}//;
					#print STDERR "here the lcat is $finaltags[$mu] $featureStr->{LCAT}\n";
							}
							else{
								$featureStr->{EXTD} .= " adv=\"$finalkeys[$mu]\"";
								#$featureStr->{EXTD} .= " adv=\"Y\" adv_marker=\"$finalkeys[$mu]\"";
								$featureStr->{SUFF}.= "_$finalkeys[$mu]";
							}
						}
						#elsif( $finaltags[$mu] =~ /PLURAL/) {
						elsif($finaltags[$mu] =~ /PL/) {
							$featureStr->{NUM}= "pl";
							$featureStr->{SUFF}.= "_$finalkeys[$mu]";
						}elsif($finaltags[$mu] =~ /CAUSE/) {
							$featureStr->{EXTD} .= " cause=\"Y\" cause_marker=\"$finalkeys[$mu]\""; 	
						}elsif($finaltags[$mu] =~ /CONJ/) {
							$featureStr->{SUFF}.= "_$finalkeys[$mu]";
							$featureStr->{EXTD} .= " conj=\"Y\" conj_marker=\"$finalkeys[$mu]\""; 
						}elsif($finaltags[$mu] =~ /(ACC|DAT|INS|BEN|ABL|LOC|GEN|SOC|NEG)/ ) { # mark the case
							if($& eq "INS" and $featureStr->{LCAT} =~ /^v/ ) { #For words like varuvawAl
								$featureStr->{EXTD} =~ s/rp=\"Y\"//;
								$featureStr->{EXTD} .= " cond=\"Y\" cause=\"Y\"";
							}elsif($& eq "NEG") {
								#$featureStr->{EXTD} .= " neg=\"Y\" existential=\"Y\"";
							$featureStr->{EXTD} .= " neg=\"Y\" neg_marker=\"$finalkeys[$mu]\"";
							}else {
								$featureStr->{CM} = $finalkeys[$mu];
								my $case_name = "case_name=\"".lc ($&)."\"";
								$featureStr->{EXTD} =~ s/case_name[^ ]*/$case_name/; 
							}
							$featureStr->{TAM} .= "_$finalkeys[$mu]";
							$featureStr->{SUFF} .= "_$finalkeys[$mu]";
						#print STDERR "$featureStr->{TAM} = _$finaltags[$mu]\n";

						}
						elsif($finaltags[$mu] =~ /^CLT$/) { # clitic could be emphatic
							$featureStr->{EXTD} .= " clt=\"Y\" clt_marker=\"$finalkeys[$mu]\" clt_posn=\"$mu\""; 
							$featureStr->{SUFF}.= "_$finalkeys[$mu]";
						}
						elsif($finaltags[$mu] =~ /^PSP\d*$/) { # postposition
									$featureStr->{EXTD} .= " psp=\"Y\" psp_marker=\"$finalkeys[$mu]\" psp_posn=\"$mu\"";
									$featureStr->{SUFF}.= "_$finalkeys[$mu]";
						}
						elsif($finaltags[$mu] =~ /^INC$/) { # inclusive marker
							$featureStr->{SUFF} .= "_$finalkeys[$mu]";
							#$featureStr->{TAM} = "$finalkeys[$mu]";
							$featureStr->{EXTD} .= " inc=\"Y\" inc_marker=\"$finalkeys[$mu]\" inc_posn=\"$mu\"";
							#print STDERR "$featureStr->{TAM}\n";
						}
						elsif($finaltags[$mu] =~ /^INT$/) { # inclusive marker
							$featureStr->{EXTD} .= " int=\"Y\"";
							$featureStr->{SUFF}.= "_$finalkeys[$mu]";
						}
						elsif($finaltags[$mu] =~ /^([A-Z]*)_DRD$/) { # a derived adjective or adverb or noun
							my $key = lc $1;
							$featureStr->{EXTD} .= " $key=\"$finalkeys[$mu]\"";
							$featureStr->{SUFF}.= "_$finalkeys[$mu]";
						}
						elsif($finaltags[$mu] =~ /^PRO_([1-3])([SP])([MFNCH])$/) {  #Pronominalised 
							$featureStr->{GEND}= lc($3);
							$featureStr->{NUM}= ($2 eq "P") ? "pl" : "sg";
							$featureStr->{PERS}= $1;
							$featureStr->{SUFF}.= "_$finalkeys[$mu]";
							$featureStr->{EXTD} .= " ndrd=\"Y\"";
						}
						elsif($finaltags[$mu] =~ /^V\d*$/) {
							if(exists $Copula{$finalkeys[$mu]}) {
								$featureStr->{LCAT} =  lc $finaltags[$mu];
								$featureStr->{EXTD} .= " copula=\"Y\"";
								$featureStr->{EXTD} .= " finite=\"Y\"";
								#$featureStr->{SUFF}.= "_$finalkeys[$mu]";
							}
							elsif(exists $Existential{$finalkeys[$mu]} ) {
								$featureStr->{LCAT} =  lc $finaltags[$mu];
								$featureStr->{EXTD} .= " existential=\"Y\"";
								$featureStr->{EXTD} .= " finite=\"Y\"";
								#$featureStr->{SUFF}.= "_$finalkeys[$mu]";
							}
							else {
								$featureStr->{LCAT} = $paradigm = lc $finaltags[$mu];
							}
							$featureStr->{ROOT} .= "$finalkeys[$mu]";
						}
#add ontolgy info here
						$mu++;
					}
				}
				elsif($finaltags[$mu] =~ /^V\d*$/) {   # Verb ROOT
					if(exists $Copula{$finalkeys[$mu]}) {
							$featureStr->{ROOT} .= $finalkeys[$mu];
							if(!$paradigm  )  {
								$featureStr->{LCAT} = $paradigm = lc $finaltags[$mu];
							}
							else {
								$featureStr->{LCAT} =  lc $finaltags[$mu];
							}
							$featureStr->{EXTD} .= " copula=\"Y\"";
							$featureStr->{EXTD} .= " finite=\"Y\"";
							#$featureStr->{SUFF}.= "_$finalkeys[$mu]";
							$mu++;
					}
					elsif(exists $Existential{$finalkeys[$mu]} ) {
							$featureStr->{ROOT} .= $finalkeys[$mu];
							if(!$paradigm  )  {
								$featureStr->{LCAT} = $paradigm = lc $finaltags[$mu];
							}
							else {
								$featureStr->{LCAT} =  lc $finaltags[$mu];
							}
							$featureStr->{EXTD} .= " existential=\"Y\"";
							$featureStr->{EXTD} .= " finite=\"Y\"";
							$mu++;
#print STDERR "1:$featureStr->{ROOT};$featureStr->{LCAT};$featureStr->{TAM};$featureStr->{SUFF};$finalkeys[$mu]\n";
					}
					else {
						if($featureStr->{ROOT}) {
							#$featureStr->{ROOT} .= "_$finalkeys[$mu]";
							$featureStr->{ROOT} .= "$finalkeys[$mu]";
						}
						else{
							$featureStr->{ROOT} .= "$finalkeys[$mu]";
						}
						if($finaltags[$mu] =~ /V18/) {
							$featureStr->{EXTD} .= " finite=\"Y\"";
						}
						$featureStr->{LCAT} = $paradigm = lc $finaltags[$mu];
						$mu++;
						$lleenn = @finalkeys;

#to handle gender for verbs with NDRD category
%ndrdGenderTagHash = (
	"avanY" => "m",
	"avalY" => "f",
	"avar" => "mf",
	"or" => "mf",
	"avarkalY" => "mf",
	"arkalY" => "mf",
	"ufkalY" => "mf",
);

#to handle person for verbs with NDRD category
%ndrdPersonTagHash = (
	"avanY" => "3",
	"avalY" => "3",
	"avar" => "3",
	"avarkalY" => "3",
	"or" => "3",
	"awu" => "3",
);
						while($mu < @finalkeys) {
							#print STDERR "11 $mu  $finaltags[$mu] -- $lleenn\n";
							if($finaltags[$mu] =~ /^([A-Z]*)_DRD$/) {  # derived noun/adjective/adverb
								my $key = lc $1;
								$featureStr->{EXTD} .= " $key=\"$finalkeys[$mu]\"";
								$featureStr->{SUFF}.= "_$finalkeys[$mu]";
							}
							elsif($finaltags[$mu] =~ /^PRO_([1-3])([SP])([MFNCH])$/ or $finaltags[$mu] =~ /NDRD/ or $finaltags[$mu] =~ /IMP/) {  #Pronominalised 
						#	print STDERR "11 $mu  $finaltags[$mu] -- $lleenn\n";
								$featureStr->{GEND}= lc($3);
								$featureStr->{GEND}= $ndrdGenderTagHash{$finalkeys[$mu]} if(exists $ndrdGenderTagHash{$finalkeys[$mu]});
								
								$featureStr->{NUM}= ($2 eq "P") ? "pl" : "sg";
								$featureStr->{PERS}= $1;
				#$featureStr->{EXTD} =~ /rp="Y"/ and $finalkeys[$mu] =~ /awu/)#
								if(exists $ndrdPersonTagHash{$finalkeys[$mu]} or $featureStr->{EXTD} =~ /rp="Y"/ and $finalkeys[$mu] =~ /awu/){ #to assign person for a_awu format#
									$featureStr->{PERS}= $ndrdPersonTagHash{$finalkeys[$mu]} if(exists $ndrdPersonTagHash{$finalkeys[$mu]});
								}
								$featureStr->{SUFF}.= "_$finalkeys[$mu]";
								$featureStr->{EXTD} .= " ndrd=\"Y\"";
								#print STDERR "NUMB $featureStr->{PERS}\n";
								goto DERIVEDNOUN;
							}
							elsif($finaltags[$mu] =~ /^([1-3])([SP])([MFNCH]+)$/ or $finaltags[$mu] =~ /NDRD/ or $finaltags[$mu] =~ /IMP/) {  #PNG
							#print STDERR "11 $mu  $finalkeys[$mu] = $finaltags[$mu] -- $lleenn\n";
								$featureStr->{GEND}= lc($3);
								$featureStr->{GEND}= $ndrdGenderTagHash{$finalkeys[$mu]} if(exists $ndrdGenderTagHash{$finalkeys[$mu]});
								$featureStr->{NUM}= ($2 eq "P") ? "pl" : "sg";
								$featureStr->{PERS}= $1;
								if(exists $ndrdPersonTagHash{$finalkeys[$mu]} or $featureStr->{EXTD} =~ /rp="Y"/ and $finalkeys[$mu] =~ /awu/){
									$featureStr->{PERS}= $ndrdPersonTagHash{$finalkeys[$mu]} if(exists $ndrdPersonTagHash{$finalkeys[$mu]});
								}
								$featureStr->{SUFF}.= "_$finalkeys[$mu]";
								$featureStr->{EXTD} .= " finite=\"Y\"";
							}
                                                        elsif($finaltags[$mu] =~ /NEG\_([1-3])([SP])([MFNCH])$/ or $finaltags[$mu] =~ /NDRD/ or $finaltags[$mu] =~ /IMP/) {  #PNG
                                                                $featureStr->{GEND}= lc($3);
								$featureStr->{GEND}= $ndrdGenderTagHash{$finalkeys[$mu]} if(exists $ndrdGenderTagHash{$finalkeys[$mu]});
                                                                $featureStr->{NUM}= ($2 eq "P") ? "pl" : "sg";
                                                                $featureStr->{PERS}= $1;
								if(exists $ndrdPersonTagHash{$finalkeys[$mu]} or $featureStr->{EXTD} =~ /rp="Y"/ and $finalkeys[$mu] =~ /awu/){
									$featureStr->{PERS}= $ndrdPersonTagHash{$finalkeys[$mu]} if(exists $ndrdPersonTagHash{$finalkeys[$mu]});
								}
                                                                $featureStr->{SUFF} .= "_$finalkeys[$mu]";
                                                                $featureStr->{EXTD} .= " finite=\"Y\"";
                                                                $featureStr->{EXTD} .= " neg=\"Y\"";
								
                                                        }
							elsif($finaltags[$mu] =~ /VN/) {
								$featureStr->{EXTD} .= " vn=\"$finalkeys[$mu]\"";
                                                                $featureStr->{SUFF}.= "_$finalkeys[$mu]";
									
							}elsif($finaltags[$mu] =~ /(PAST|PRESENT|FUTURE)/) {  # tense
						#print STDERR "$featureStr->{TAM} = _$finaltags[$mu]\n";
								$featureStr->{EXTD} .= " tense=\"$1\"";
								$featureStr->{TAM}.= "_$finalkeys[$mu]";
								$featureStr->{SUFF}.= "_$finalkeys[$mu]";
		#print STDERR "$featureStr->{TAM} = $finaltags[$mu] $featureStr->{SUFF} = $featureStr->{EXTD}\n";
								if($featureStr->{ROOT} eq $token) {
									my $pers = $featureStr->{PERS};
									$pers = ($pers eq "") ? "2": $pers;
									$featureStr->{PERS}= $pers;
								}
							}elsif($finaltags[$mu] =~ /(COND|VBP|NEG_VBP|NEG_RP|RP|INF|INT|SUPP|NEG_SUFF|NEG|COPULA)/) {  # other tags
								#print STDERR "$& INT is identified here\n";
								my $key = lc $&;
								$featureStr->{EXTD} .= " $key=\"Y\"";
								if($finalkeys[$mu] =~ /illE/)  {
                                                                	$featureStr->{EXTD} .= " finite=\"Y\"";
								}
		#print STDERR "here the lcat is $finaltags[$mu] -- $featureStr->{LCAT} -- $finalkeys[$mu]\n";
						#commented by mario	#$featureStr->{TAM} .= "_$finalkeys[$mu]";
									$featureStr->{TAM} .= "_$finalkeys[$mu]" if($finaltags[$mu] ne "COND" and $finaltags[$mu] ne "NEG"); #to solve TAM&Suffix discrepancy for COND|NEG category
						#print STDERR "$featureStr->{TAM} = _$finaltags[$mu]\n";
								$featureStr->{SUFF}.= "_$finalkeys[$mu]";
								if($featureStr->{ROOT} eq $token) {
									my $pers = $featureStr->{PERS};
									$pers = ($pers eq "") ? "2": $pers;
									$featureStr->{PERS}= $pers;
								}
							}elsif($finaltags[$mu] =~ /(OPT|HORT)/){#Other finite tags
								my $key = lc $&;
								$featureStr->{EXTD} .= " $key=\"Y\"";
								$featureStr->{EXTD} .= " finite=\"Y\"";
								$featureStr->{TAM}.= "_$finalkeys[$mu]";
								$featureStr->{SUFF}.= "_$finalkeys[$mu]";
								if($featureStr->{ROOT} eq $token) {
									my $pers = $featureStr->{PERS};
									$pers = ($pers eq "") ? "2": $pers;
									$featureStr->{PERS}= $pers;
								}

							}elsif($finaltags[$mu] =~ /^PSP\d*$/) { # postposition
								$featureStr->{EXTD} .= " psp=\"Y\" psp_marker=\"$finalkeys[$mu]\" psp_posn=\"$mu\"";
								$featureStr->{SUFF}.= "_$finalkeys[$mu]";
							}elsif($finaltags[$mu] =~ /IMP/){
								$featureStr->{EXTD} .= " imp_plural=\"Y\"";	
								$featureStr->{EXTD} .= " finite=\"Y\"";	
								$featureStr->{SUFF}.= "_$finalkeys[$mu]";
							}elsif($finaltags[$mu] =~ /NDRD/){
								$featureStr->{EXTD} .= " ndrd=\"Y\"";	
								$featureStr->{SUFF} .= "_$finalkeys[$mu]";
							}elsif($finaltags[$mu] =~ /CONC/) {  # 
								$featureStr->{EXTD} .= " cond=\"Y\" conc=\"Y\"";
								$featureStr->{TAM}.= "_$finalkeys[$mu]";
								$featureStr->{SUFF}.= "_$finalkeys[$mu]";
							}elsif($finaltags[$mu] =~ /CONJ/){ #added by mario on 19-6
								$featureStr->{SUFF}.= "_$finalkeys[$mu]";
								$featureStr->{EXTD} .= " conj=\"Y\" conj_marker=\"$finalkeys[$mu]\""; 
							}#added by mario on 26-6
							elsif($finaltags[$mu] =~ /^INC$/) { # inclusive
								$featureStr->{EXTD} .= " inc=\"Y\" inc_marker=\"$finalkeys[$mu]\" inc_posn=\"$mu\""; 
								$featureStr->{SUFF}.= "_$finalkeys[$mu]";
							}
							elsif($finaltags[$mu] =~ /^ACC$/) { # accusative
								$featureStr->{EXTD} .= " case_name=\"acc\""; 
								$featureStr->{SUFF}.= "_$finalkeys[$mu]";
							}#added by mario on 26-6
							elsif($finaltags[$mu] =~ /^ADJ$/){ # adjs
								$featureStr->{SUFF} .= "_$finalkeys[$mu]";
								$featureStr->{EXTD} .= " adj=\"Y\" adj_marker=\"$finalkeys[$mu]\"";
							}#added by mario on 22-6
							elsif($finaltags[$mu] =~ /^ADV$/){ # advs
								$featureStr->{SUFF} .= "_$finalkeys[$mu]";
								$featureStr->{EXTD} .= " adv=\"$finalkeys[$mu]\"";
							}#added by mario on 22-6
					#print STDERR "here the lcat is $finaltags[$mu] $featureStr->{LCAT}\n";
							#elsif($finaltags[$mu] =~ /INS/) {  # May not be used
								#$featureStr->{EXTD} .= " cond=\"Y\" cause=\"Y\"";
								#$featureStr->{TAM}.= "_$finalkeys[$mu]";
								#$featureStr->{SUFF}.= "_$finalkeys[$mu]";
							#}
							elsif($finaltags[$mu] =~ /^CLT$/) {
								$featureStr->{EXTD} .= " clt=\"Y\" clt_marker=\"$finalkeys[$mu]\" clt_posn=\"$mu\"";
								$featureStr->{SUFF}.= "_$finalkeys[$mu]";
                	                                }#added by mario on 22-6 for words with tags(V+VN+LOC)
							elsif($finaltags[$mu] =~ /^LOC$/) {
								$featureStr->{SUFF}.= "_$finalkeys[$mu]";
								$featureStr->{EXTD} .= " case_name=\"$finalkeys[$mu]\"";
                	                                }#added by mario on 22-6
							elsif($finaltags[$mu] =~ /^V\d*$/) {  # just a verb root
								if(exists $Copula{$finalkeys[$mu]}) {
									$featureStr->{EXTD} .= " copula=\"Y\"";
									$featureStr->{EXTD} .= " finite=\"Y\"";
									#$featureStr->{SUFF}.= "_$finalkeys[$mu]";
									$mu++;
								}
								elsif(exists $Existential{$finalkeys[$mu]} ) {
									$featureStr->{EXTD} .= " existential=\"Y\"";
									$featureStr->{EXTD} .= " finite=\"Y\"";
									#$featureStr->{SUFF}.= "_$finalkeys[$mu]";
									$mu++;
								}
								else {
									$featureStr->{TAM} .= "_".$finalkeys[$mu];
									$featureStr->{SUFF} .= "_$finalkeys[$mu]";
								}
							}
							else{
								$featureStr->{SUFF}.= "_$finalkeys[$mu]";
							}

							if($finaltags[$mu] =~ /V_NEG/) { # to handle negation 
					#print STDERR "here the lcat is $finaltags[$mu] $featureStr->{LCAT}\n";
								$featureStr->{EXTD} .= " neg=\"$finalkeys[$mu]\"";
								$featureStr->{EXTD} .= " finite=\"Y\"";
							}
							$mu++;
							#print STDERR "22 $mu  $finaltags[$mu] -- $lleenn\n";
						}
					}
				}#Verb root ends
				elsif($finaltags[$mu] =~ /DEM_DET/) {  #determiner
					if($finalkeys[$mu] =~ /^a/) {
						$featureStr->{EXTD} .= " det=\"a\"";
					}
					elsif($finalkeys[$mu] =~ /^eV/) { #added by mario on 18-6
						$featureStr->{EXTD} .= " det=\"eV\"";
					}				  #added by mario on 18-6
					else{
						$featureStr->{EXTD} .= " det=\"i\"";
					}
					if(!defined $finaltags[$mu+1]) {
						$featureStr->{ROOT} = "$finalkeys[$mu]";
						$featureStr->{LCAT} = $paradigm = lc $finaltags[$mu];
						$featureStr->{SUFF} =~ s/^_//;
						printfs(\$featureStr);
					}
					#$featureStr->{TAM} .= lc $finaltags[$mu];
					next;
				}
				elsif($finaltags[$mu] =~ /DET/) {  #determiner
					if(!defined $finaltags[$mu+1]) {
						$featureStr->{ROOT} = "$finalkeys[$mu]";
						$featureStr->{LCAT} = $paradigm = lc $finaltags[$mu];
						$featureStr->{SUFF} =~ s/^_//;
						printfs(\$featureStr);
					}
					#$featureStr->{TAM} .= lc $finaltags[$mu];
					next;
				}
				elsif(($finaltags[$mu] =~ /^(ADJ|ADV|PSP)\d*$/)) { #ROOT
					$featureStr->{ROOT} .= "$finalkeys[$mu]" if($featureStr->{ROOT} eq "");
					$featureStr->{LCAT} = $paradigm = lc $finaltags[$mu] if($featureStr->{LCAT} eq "");
					if(($finaltags[$mu] =~ /^PSP\d*$/) && ($featureStr->{LCAT} ne "") && ($finalkeys[$mu] ne $featureStr->{ROOT})){ # postposition
						$featureStr->{EXTD} .= " psp=\"Y\" psp_marker=\"$finalkeys[$mu]\" psp_posn=\"$mu\"";
						$featureStr->{SUFF}.= "_$finalkeys[$mu]";
					}
#print STDERR "here the lcat is $finaltags[$mu]; $featureStr->{LCAT}; $finalkeys[$mu] ne $featureStr->{ROOT}\n";
#added by mario on 15-6 starts #to handle adj+adv forms
					if(($finaltags[$mu] =~ /^ADV\d*$/) && ($featureStr->{LCAT} ne "") && ($finalkeys[$mu] ne $featureStr->{ROOT})){ # adverbs
					#print STDERR "here the lcat is $finaltags[$mu] $featureStr->{LCAT}\n";
						$featureStr->{SUFF} .= "_$finalkeys[$mu]";
						$featureStr->{EXTD} .= " adv=\"$finalkeys[$mu]\"";
						#$featureStr->{EXTD} .= " adv=\"Y\" adv_marker=\"$finalkeys[$mu]\"";
					}
#to handle adv+adj forms
					if(($finaltags[$mu] =~ /^ADJ\d*$/) && ($featureStr->{LCAT} ne "") && ($finalkeys[$mu] ne $featureStr->{ROOT})){ # adjs
					#print STDERR "here the lcat is $finaltags[$mu] $featureStr->{LCAT}\n";
						$featureStr->{SUFF} .= "_$finalkeys[$mu]";
						$featureStr->{EXTD} .= " adj=\"$finalkeys[$mu]\"";
					}
#added by mario on 15-6 ends
					if(defined $finaltags[$mu+1]) {
						if($finaltags[$mu+1] =~ /^([1-3])([SP])([MFNCH])$/) {  #PNG
							$featureStr->{GEND}= lc($3);
							$featureStr->{NUM}= ($2 eq "P") ? "pl" : "sg";
							$featureStr->{PERS}= $1;
							$featureStr->{EXTD} .= " finite=\"Y\"";
							$mu++;
						}
						elsif($finaltags[$mu+1] =~ /^PRO_([1-3])([SP])([MFNCH])$/) {  #Pronominalised 
						#print STDERR "22 $finaltags[$mu+1]\n";
							$featureStr->{GEND}= lc($3);
							$featureStr->{NUM}= ($2 eq "P") ? "pl" : "sg";
							$featureStr->{PERS}= $1;
							$featureStr->{SUFF}.= "_$finalkeys[$mu+1]";
							$featureStr->{EXTD} .= " ndrd=\"Y\"";
							$mu++;
							goto DERIVEDNOUN;
						}		
						elsif($finaltags[$mu+1] =~ /^([A-Z]*)_DRD/){
							my $key = lc $1;
							$featureStr->{EXTD} .= " $key=\"$finalkeys[$mu+1]\"";
							$featureStr->{SUFF}.= "_$finalkeys[$mu+1]";
							$mu++;
						}
						elsif($finaltags[$mu] =~ /^V\d*$/) {  # just a verb root
							if(exists $Copula{$finalkeys[$mu]}) {
									$featureStr->{EXTD} .= " copula=\"Y\"";
									$featureStr->{EXTD} .= " finite=\"Y\"";
									#$featureStr->{SUFF}.= "_$finalkeys[$mu]";
									$mu++;
							}
							elsif(exists $Existential{$finalkeys[$mu]} ) {
									$featureStr->{EXTD} .= " existential=\"Y\"";
									$featureStr->{EXTD} .= " finite=\"Y\"";
									#$featureStr->{SUFF}.= "_$finalkeys[$mu]";
									$mu++;
							}
							else {
								$featureStr->{TAM} .= "_".$finalkeys[$mu];
								$featureStr->{SUFF} .= "_$finalkeys[$mu]";
							}
							$mu++;
						}
						else {
							#$mu++;
							next;
						}
					}
				}
				elsif($finaltags[$mu] =~ /^INC$/) { # clitic could be emphatic
					$featureStr->{EXTD} .= " inc=\"Y\" inc_marker=\"$finalkeys[$mu]\" inc_posn=\"$mu\""; #To change
				}
				elsif($finaltags[$mu] =~ /^CLT$/) { # clitic could be emphatic
					$featureStr->{EXTD} .= " clt=\"Y\" clt_marker=\"$finalkeys[$mu]\" clt_posn=\"$mu\""; #To change
					$featureStr->{SUFF}.= "_$finalkeys[$mu]";
				}
				else {
#print STDERR "2:$featureStr->{EXTD};$featureStr->{ROOT};$featureStr->{LCAT};$featureStr->{TAM};$featureStr->{SUFF};$finalkeys[$mu]\n";
					if($featureStr->{EXTD} !~ "existential"){#if-loop added by mario on 26-3
					if($featureStr->{ROOT}) {
						#$featureStr->{ROOT} .= "_$finalkeys[$mu]";
						$featureStr->{ROOT} .= "$finalkeys[$mu]";
					}
					else{
						$featureStr->{ROOT} .= "$finalkeys[$mu]";
					}
					$featureStr->{LCAT} = $paradigm = lc $finaltags[$mu];
				}#outer if-loop added by mario on 26-3
				elsif($featureStr->{ROOT} and $featureStr->{EXTD} =~ "existential"){
					$featureStr->{SUFF} .= "_$finalkeys[$mu]";
					$featureStr->{TAM} .= "_$finalkeys[$mu]" if($finaltags[$mu] =~ /(PRESENT)|(PAST)|(FUTURE)/);
#print STDERR "3:$featureStr->{ROOT};$featureStr->{LCAT};$featureStr->{TAM};$featureStr->{SUFF};$finalkeys[$mu]\n";
					
				}
			}
    	    }
   			if($i) {
				@fields = &get_fields($leaf);
				$morph_output  = $fields[3];
				$morph_output .= "|";
				&modify_field($leaf,3,$morph_output);
			}
			#Final changes in feature structure
			$featureStr->{SUFF} =~ s/^_//;
			if(!($featureStr->{LCAT} =~ /^p?n\d*/)){
				$featureStr->{CM}= "";
				$featureStr->{CASE}= "";
			}
			if($featureStr->{LCAT} =~ /^v/) {
				$featureStr->{CASE}= "";
		 		if(!( $featureStr->{EXTD} =~ /(finite|ndrd)/)) {
					$featureStr->{GEND} = "any";
					$featureStr->{PERS} = "any";
					$featureStr->{NUM} = "any";
				}
			}
			if($featureStr->{LCAT} =~ /^adj/) {
		 		if( $featureStr->{EXTD} eq " case_name=\"nom\"") {
					$featureStr->{CASE}= "";
					$featureStr->{GEND} = "any";
					$featureStr->{PERS} = "any";
					$featureStr->{NUM} = "any";
				}
			}
									#added by mario on 18-6
			if($featureStr->{LCAT} =~ /^adv|intj|conj|fw/) { 
		 		if( $featureStr->{EXTD} eq " case_name=\"nom\"") {
					$featureStr->{CASE}= "d";
				}
			}#added by mario on 18-6 #to add 'd' for paradigm="adv" and case_name="nom"
			$featureStr->{EXTD} .= " paradigm=\"$paradigm\"";
			printfs(\$featureStr);
   		} #mu for loop ends here #press shift % to confirm#
   	}
   	else {
		$featureStr->{ROOT} = $token;
		$featureStr->{LCAT}= "unk";
		printfs(\$featureStr);
   	}
}
1;
=cut

sub printfs() #Print the feature Structure generated
{
	$refFS = shift;

	my $fsString = "";
	$fsString = "<fs af='".${$refFS}->{ROOT}.",";
	${$refFS}->{LCAT} =~ s/([a-z]+)\d+/$1/g;
	${$refFS}->{LCAT} =~ s/dem_det/pn/;	# for ilmt
	${$refFS}->{LCAT} =~ s/fw/any/;	# for ilmt
	#${$refFS}->{LCAT} =~ s/wq/pn/;	# for ilmt
	${$refFS}->{LCAT} =~ s/det/pn/;	# for ilmt
	${$refFS}->{GEND} =~ s/c/mf/;	# for ilmt
	$fsString .= ${$refFS}->{LCAT}.",";
	if(${$refFS}->{LCAT} !~ /^(unk|punc|num)$/ and ${$refFS}->{GEND} eq "") {
		${$refFS}->{GEND} = "any";
	}
	if(${$refFS}->{LCAT} !~ /^(unk|punc|num)$/ and ${$refFS}->{NUM} eq "") {
		${$refFS}->{NUM} = "any";
	}
	if(${$refFS}->{LCAT} !~ /^(unk|punc|num)$/ and ${$refFS}->{PERS} eq "") {
		${$refFS}->{PERS} = "any";
	}
	if(${$refFS}->{LCAT} =~ /^(n|pn)$/) {
		$fsString .= ${$refFS}->{GEND}; 
		$fsString =~ s/h$/mf/;
		$fsString .= ",".${$refFS}->{NUM}.",";
		$fsString .= ${$refFS}->{PERS}.",";
		$fsString .= ${$refFS}->{CASE}.",";
		$fsString .= ${$refFS}->{CM}.",";
		$fsString .= ${$refFS}->{SUFF}."'";
		if(${$refFS}->{EXTD}) {
			$fsString .= ${$refFS}->{EXTD};
		}
		$fsString .= ">";
	}
	elsif(${$refFS}->{LCAT} =~ /^v$/) {
		${$refFS}->{EXTD} =~ s/ case_name=\"nom\"//;
		$fsString .= ${$refFS}->{GEND}; 
		$fsString =~ s/h$/mf/;
		$fsString .= ",".${$refFS}->{NUM}.",";
		$fsString .= ${$refFS}->{PERS}.",";
		$fsString .= ${$refFS}->{CASE}.",";
		${$refFS}->{TAM} =~ s/^\_//;
		$fsString .= ${$refFS}->{TAM}.",";
		$fsString .= ${$refFS}->{SUFF}."'"; 
		if(${$refFS}->{EXTD}) {
			$fsString .= ${$refFS}->{EXTD};
			}
		$fsString .= ">";
	}
	elsif(${$refFS}->{LCAT} =~ /^punc$/) {
		$fsString .= ${$refFS}->{GEND}; 
		$fsString .= ",".${$refFS}->{NUM}.",";
		$fsString .= ${$refFS}->{PERS}.",";
		$fsString .= ${$refFS}->{CASE}.",";
		$fsString .= ${$refFS}->{CM}.",";
		$fsString .= ${$refFS}->{SUFF}."'>";
	}
	else {
		${$refFS}->{EXTD} =~ s/ case_name=\"nom\"//;
		$fsString .= ${$refFS}->{GEND}; 
		$fsString .= ",".${$refFS}->{NUM}.",";
		$fsString .= ${$refFS}->{PERS}.",";
		$fsString .= ${$refFS}->{CASE}.",";
		$fsString .= ${$refFS}->{CM}.",";
		$fsString .= ${$refFS}->{SUFF}."'";
		if(${$refFS}->{EXTD}) {
			$fsString .= ${$refFS}->{EXTD};
		}
		$fsString .= ">";
	}
	$fsString =~ s/,h,/,mf,/;
	#print STDERR "$fsString\n";

	if(${$refFS}->{LCAT}) {
		@fields = &get_fields($leaf,$sentid);
		if($morph_output eq undef) {
			$morph_output  = $fields[3];
			$morph_output .= "unk\t$fsString";
		}
		else {
			$morph_output  = $fields[3];
			$morph_output .= "$fsString";
		}
		&modify_field($leaf,3,$morph_output,$sentid);
	}
	else {
		@fields = &get_fields($leaf);
		$morph_output  = $fields[3];
		$morph_output .= "unk\t<fs af='$token,unk,,,,,,'>";
		&modify_field($leaf,3,$morph_output,$sent,$sentid);
	}
}
1;


sub readCopula
{
$Copula{"Akum"} = 1;
$Copula{"AnYawu"} = 1;
$Copula{"AyirYrYu"} = 1;
$Copula{"AvAnY"} = 1;
$Copula{"AvAlY"} = 1; 
$Copula{"AvAr"} = 1;
$Copula{"Avar"} = 1;
$Copula{"AvArkalY"} = 1;

}

sub readExistential
{
$Existential{"uNtu"}=1;
$Existential{"illE"}=1;
$Existential{"ulYlYawu"}=1;
$Existential{"ulYlYanYar"}=1;
$Existential{"ulYlYanYa"}=1;
}


############################### Resource Required & provided here 
sub readrootDict{
        my ($lined8, @dictarr8,$value8);
        open(FHR8,"<","tam/dict.txt") or die "what about the dictionary file!!\n";
        while($lined8 = <FHR8>){
		$lined8 =~ s/\cM//;
                chomp($lined8);
                next if($lined8 =~ m/^\s*$/);
		next if $lined8 =~ m/^\#+/;

		$lined8 =~ s/^\s+//;
		$lined8 =~ s/\s+$//;

                @dictarr8 = split(/,/, $lined8);
                $value8 = $dictarr8[1].$dictarr8[2];
                $key81 = "$dictarr8[0]\_$dictarr8[1]";

                if (exists $rootDictHash8{$dictarr8[0]}){
                        $rootDictHash8{$dictarr8[0]} = $rootDictHash8{$dictarr8[0]}.",".$value8;
                }else{
                        $rootDictHash8{$dictarr8[0]} = $value8;
                }
	
		if($dictarr8[3] =~ /^\w+$/) {$genderHash{$key81} = lc($dictarr8[3]);}
		if($dictarr8[4] =~ /^PL$/i) {$numberHash{$key81} = lc($dictarr8[4]);}
		
		#print "$key81 -- $genderHash{$key81}\n";	
        }
        close(FHR8);
}

sub readNEdict{
        my ($linen8, @nedictarr8,$nevalue8);
        open(FHN8,"<","tam/nedict.txt") or die "what about the NEdictionary file!!\n";
        while($linen8 = <FHN8>){
		$linen8 =~ s/\cM//;
                chomp($linen8);
                next if($linen8 =~ m/^\s*$/);
		next if $linen8 =~ m/^\#+/;
                        $linen8 =~ s/^\s+//;
                        $linen8 =~ s/\s+$//;

                @nedictarr8 = split(/,/, $linen8);
                $nevalue8 = $nedictarr8[1].$nedictarr8[2];

                if (exists $rootDictHash8{$nedictarr8[0]}){
                        $rootDictHash8{$nedictarr8[0]} = $rootDictHash8{$nedictarr8[0]}.",".$nevalue8;
                }else{
                        $rootDictHash8{$nedictarr8[0]} = $nevalue8;
                }
        }
        close(FHN8);
}

sub readFsa{
        my ($linef8, @fsaarr8,$value8, @symbol8, $key18, $key28);
        open(FHF8,"<","tam/cmbd_DFSA_a3_10.txt") or die "what about the FSA file! $!\n";
        while($linef8 = <FHF8>){
		$linef8 =~ s/\cM//;
		chomp($linef8);
		next if($linef8 =~ m/^\s*$/);
                	$linef8 =~ s/^\s+//;
                	$linef8 =~ s/\s+$//;

                @fsaarr8 = split(/\t/, $linef8);

		@symbol8 = split(/_/, $fsaarr8[2]);
		$key18 = $fsaarr8[0]."_".$symbol8[0];
		$key28 = $fsaarr8[0]."_".$fsaarr8[1]."_".$symbol8[0];


		#print STDERR "$key18 \n";

		if (exists $fsaHash8{$key18}){
                        $fsaHash8{$key18} = $fsaHash8{$key18}.",".$fsaarr8[1];
                }else{
                        $fsaHash8{$key18} = $fsaarr8[1];
                }

		if($symbol8[0] !~ /((PN)|(N)|(V))\d+/){ 
			if(exists $sandhiHash8{$key28}){
			$sandhiHash8{$key28} = $sandhiHash8{$key28}.",".$symbol8[1] if($symbol8[1] !~ /\#/);
				$tagHash8{$key28} = $tagHash8{$key28}.",".$symbol8[2];
			}else{
				$sandhiHash8{$key28} = $symbol8[1] if($symbol8[1] !~ /\#/);
				$tagHash8{$key28} = $symbol8[2];
			}
		}

		if($symbol8[0] !~ /((PN)|(N)|(V))\d+/){
			$suffixHash8{$symbol8[0]}++;
		}
        }
#added on 24-4-13
        foreach my $v8 (sort keys %sandhiHash8){
                if($sandhiHash8{$v8} =~ /\,/) {
                        #print "$v\n";
                        undef %uniqSandhiCorr8;
                        foreach $Corr8 (split(/\,/,$sandhiHash8{$v8})) {
                                $uniqSandhiCorr8{$Corr8}++;
                        }
                        $finalCorr8 = join ",", keys%uniqSandhiCorr8;
                        $finalCorr8 =~ s/^\,//;
                        $finalCorr8 =~ s/\,$//;

                        $sandhiHash8{$v8} = $finalCorr8;
                        #print "$v -- $finalCorr\n";
                }
        }

        foreach my $v8 (sort keys %fsaHash8){
                if($fsaHash8{$v8} =~ /\,/) {
                        #print "$v\n";
                        undef %uniqState8;
                        foreach $uniqS8 (split(/\,/,$fsaHash8{$v8})) {
                                $uniqState8{$uniqS8}++;
                        }
                        $finalS8 = join ",", keys%uniqState8;
                        $finalS8 =~ s/^\,//;
                        $finalS8 =~ s/\,$//;

                        $fsaHash8{$v8} = $finalS8;
                        #print "$v -- $finalCorr\n";
                }
        }
#added on 24-4-13
	close(FHF8);
}

sub readOntology {

	@ontFilePath = glob("tam/Ontology-tamil/*"); #filename in 5th col when splitted by "/"

	foreach $ontFilePathAtom (@ontFilePath){
		chomp($ontFilePathAtom);
		@ontFileArr = split("/",$ontFilePathAtom);
		push(@ontFileNames,pop(@ontFileArr));
	}

	undef %ontologyHash;
	for( $i_onto = 0; $i_onto < @ontFileNames; $i_onto++){
		$ontFileAtom = $ontFilePath[$i_onto];
		#print STDERR "QAZ $ontFileAtom\n";
	
		open(OFHF,"<","$ontFileAtom") or die "Can't open the Ontology file";
		
		while($ontlinefl = <OFHF>){
			$ontlinefl =~ s/\cM//; #to substitute the ^M char#
			chomp($ontlinefl);
			next if $ontlinefl =~ m/^\s+$/;
			next if $ontlinefl =~ m/^\#+/;
			$ontlinefl =~ s/^\s+//;
			$ontlinefl =~ s/\s+$//;

			$ontHashKey = $ontlinefl.",n";
			#print STDERR "ONTO HASH KEY = $ontHashKey\n";
			$ontHashVal = $ontFileNames[$i_onto];

			if(exists $ontologyHash{$ontHashKey}){
			#print STDERR "ONTO HASH KEY = $ontHashKey\n";
				$ontologyHash{$ontHashKey} = "$ontologyHash{$ontHashKey},"."$ontHashVal";
			}else{
				$ontologyHash{$ontHashKey} = $ontHashVal;
			}
		}
		close(OFHF);
	}
}


sub readAlloMorphMappingInfo {
        my ($alloLine8, @allomorpheme8);
        open(FHAL8,"<","tam/alloMorphMappingFile.txt") or die "what about alloMorphMapping file!!\n";
        while($alloLine8 = <FHAL8>){
                chomp($alloLine8);
                next if($alloLine8 =~ /^\s*$/);

                $alloLine8 =~ s/^\s+//;
                $alloLine8 =~ s/\s+$//;
			
                @allomorpheme8 = split(/\t\-+>\t/, $alloLine8);
		if($allomorpheme8[1] =~ m/,/){
			@alloMorphs8 = split(/,/, $allomorpheme8[1]);
			foreach $alloMorphElem8 (@alloMorphs8){
				$alloMorphMappingHashKey8 = $allomorpheme8[0]."_".$alloMorphElem8;
				$alloMorphMappingHashVal8 = $allomorpheme8[2];
				$alloMorphMappingHash8{$alloMorphMappingHashKey8} = $alloMorphMappingHashVal8;
			}
		}else{	
				$alloMorphMappingHashKey8 = $allomorpheme8[0]."_".$allomorpheme8[1];
				$alloMorphMappingHashVal8 = $allomorpheme8[2];
				$alloMorphMappingHash8{$alloMorphMappingHashKey8} = $alloMorphMappingHashVal8;
		}
	}
=c
	foreach $jujuj (keys%alloMorphMappingHash8){
		print STDERR "$jujuj -- $alloMorphMappingHash8{$jujuj}\n";
	}
=cut
}
1; #won't return anything

###########@###################### @@@@ ###########@###################### @@@ ###########@######################
