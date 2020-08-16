#!/usr/bin/perl

undef @array;

while(<>) {
	chomp;

	if($_=~ /^\s*$/) {
		process(@array);
		undef @array;
	}else{
		push(@array,$_);
	}
}

if(@array eq undef ) {
	process(@array);
}

sub process {


	for($i = 0;$i< @array;$i++) {
		$line = $array[$i];

		@arra = split(/\s+/,$line);

		if(($arra[2] =~ /,N,/) && ($arra[1] =~ /^V/) && ($arra[2] !~ /\|/)) {
			#print "$_\n";
			$arra[1] = "N_NN";
			$line1 = join "\t", @arra;
			$line1 =~ s/\s*$//;
			#print "$line\n";
			$array[$i] = $line1;
		}elsif(($arra[2] =~ /,ADJ,/i) && ($arra[1] =~ /^V/) && ($arra[2] !~ /\|/)) {
			#print "$_\n";
			$arra[1] = "JJ";
			$line1 = join "\t", @arra;
			$line1 =~ s/\s*$//;
			#print "$line\n";
			$array[$i] = $line1;
		}elsif(($arra[2] =~ /RP/) && ($arra[1] =~ /^JJ/) && ($arra[2] !~ /\|/)) {
			#print "$_\n";
			$arra[1] = "V_VM_VNF_RP";
			$line1 = join "\t", @arra;
			$line1 =~ s/\s*$//;
			$array[$i] = $line1;
		}elsif(($arra[2] =~ /COND/) && ($arra[1] =~ /VBN/) && ($arra[2] !~ /\|/)) {
			#print "$_\n";
			$arra[1] =~ s/VBN/COND/;
			$line1 = join "\t", @arra;
			$line1 =~ s/\s*$//;
			$array[$i] = $line1;
		}elsif(($arra[2] =~ /INF/) && ($arra[1] =~ /^JJ/) && ($arra[2] !~ /\|/)) {
			#print "$_\n";
			$arra[1] = "V_VM_VNF_INF";
			$line1 = join "\t", @arra;
			$line1 =~ s/\s*$//;
			$array[$i] = $line1;
		}
	}

	print join "\n", @array,"\n";
}
