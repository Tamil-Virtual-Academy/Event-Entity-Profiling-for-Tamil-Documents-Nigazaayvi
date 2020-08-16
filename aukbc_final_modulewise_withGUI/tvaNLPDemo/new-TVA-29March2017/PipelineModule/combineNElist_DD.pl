
undef %ddhash;

##open the DD Engine output file - AnaphoraCoreferenceModule_v1/interDD
open(FH,$ARGV[0]);
while(<FH>){
	chomp;
	if($_=~/^\d+\t/){
	@arr=split(/<dim>/,$_);
	@at1=split(/\t/,$arr[0]);
	$pos=$at1[0]."_".$at1[1];
	@at2=split(/\t/,$arr[1]);
	$ddvalue=$at2[2];
	}
	$ddhash{$pos}=$ddvalue;
}
close(FH);

undef %listhash;
##open the NE list collection output file (output of collectNEs.pl)
open(F1,$ARGV[1]);
while(<F1>){
	chomp;
	$line=$_;
	@linarr=split(/<dim>/,$line);
	#print "LL -- $line\n";
	if(exists$ddhash{$linarr[0]}){
		$DD=$ddhash{$linarr[0]};
		$DD=~s/_/ /g;
		$key=$linarr[1]."<T>".$linarr[2];
		$listhash{$key}="|<iitk> ".$DD." <\/iitk>";
		###print "$linarr[0]<dim> <iitk> $DD <\/iitk> $linarr[1] <dim>$linarr[2]\n";
	}
	else{
		####print "$line\n";
		$key=$linarr[1]."<T>".$linarr[2];
		$listhash{$key}.="|NIL";

	}
}
close(F1);
undef @perarr;
foreach $kk (keys%listhash){
	##print "JJ== $kk -> $listhash{$kk}\n";
	if($kk=~/<T>person/){
		$kk1=$kk;
		$kk1=~s/<T>person//;
		$str=$listhash{$kk};
		$str=~s/NIL//g;
		$str=~s/\|//g;
		###print "$str $kk1#";
		push(@perarr,"$str $kk1");
	}
}

#print join "\n", @perarr, "\n";
undef %rep_perAr;

foreach $perA1 (@perarr)  {
	foreach $perA2 (@perarr) {
		if(($perA1 =~ /\Q$perA2\E$/) && ($perA1 ne $perA2)) {
			$rep_perAr{$perA2}++;
		}
	}
}

#print join "\n", keys%rep_perAr,"\n";

undef @uniq_perarr;
foreach $kk11 (@perarr) {
	if(!exists $rep_perAr{$kk11}) {
		push(@uniq_perarr,$kk11);	
	}
}

print join "#", @uniq_perarr;

print "<dim>";

foreach $kk (keys%listhash){
	##print "JJ== $kk -> $listhash{$kk}\n";
	if($kk=~/<T>place/){
		$kk1=$kk;
		$kk1=~s/<T>place//;
		$str=$listhash{$kk};
		$str=~s/NIL//g;
		$str=~s/\|//g;
		push(@locAr, "$str $kk1");
	}
}

undef %rep_locAr;

foreach $locA1 (@locAr)  {
	foreach $locA2 (@locAr) {
		if(($locA1 =~ /\Q$locA2\E$/) && ($locA1 ne $locA2)) {
			$rep_locAr{$locA2}++;
		}
	}
}

#print join "\n", keys%rep_perAr,"\n";

undef @uniq_locarr;
foreach $kk11 (@locAr) {
	if(!exists $rep_locAr{$kk11}) {
		push(@uniq_locarr,$kk11);	
	}
}
print join "#", @uniq_locarr;

