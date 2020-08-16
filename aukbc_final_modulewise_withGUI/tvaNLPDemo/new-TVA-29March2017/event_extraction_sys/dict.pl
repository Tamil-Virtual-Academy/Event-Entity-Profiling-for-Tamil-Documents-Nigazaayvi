#!/usr/bin/perl
my $i;
$i=0,$m=0;

open(FILE,$ARGV[0]);
while(<FILE>)
{
	chomp;
	if($_ =~ /^#/)  {next;}
	$_=~s/\cM//;
	my @tq=split(/=>/,$_);
	#$hash{lc($tq[$i])}++;
	$hash{lc($tq[0])}=$tq[1];
#foreach $k1(keys %hash)
#{
# print"$k1\n";
#}
}
close(FILE);

$outputFile = $ARGV[1];
open(FILE1,"$outputFile");
while(<FILE1>)
{
	chomp;
	@temp = (split /\t/, $_);
	#print"@temp\n";
	push(@wordarray,$temp[0]);
	#@wordarray= $temp[0];
	push(@array,$_);
}

for($i=0;$i<@wordarray;$i++){	
	$key13=$wordarray[$i]." ".$wordarray[$i+1]." ".$wordarray[$i+2]." ".$wordarray[$i+3]." ".$wordarray[$i+4]." ".$wordarray[$i+5]." ".$wordarray[$i+6]." ".$wordarray[$i+7]." ".$wordarray[$i+8]." ".$wordarray[$i+9]." ".$wordarray[$i+10]." ".$wordarray[$i+11]." ".$wordarray[$i+12];
	$key12=$wordarray[$i]." ".$wordarray[$i+1]." ".$wordarray[$i+2]." ".$wordarray[$i+3]." ".$wordarray[$i+4]." ".$wordarray[$i+5]." ".$wordarray[$i+6]." ".$wordarray[$i+7]." ".$wordarray[$i+8]." ".$wordarray[$i+9]." ".$wordarray[$i+10]." ".$wordarray[$i+11];
	$key11=$wordarray[$i]." ".$wordarray[$i+1]." ".$wordarray[$i+2]." ".$wordarray[$i+3]." ".$wordarray[$i+4]." ".$wordarray[$i+5]." ".$wordarray[$i+6]." ".$wordarray[$i+7]." ".$wordarray[$i+8]." ".$wordarray[$i+9]." ".$wordarray[$i+10];
	$key10=$wordarray[$i]." ".$wordarray[$i+1]." ".$wordarray[$i+2]." ".$wordarray[$i+3]." ".$wordarray[$i+4]." ".$wordarray[$i+5]." ".$wordarray[$i+6]." ".$wordarray[$i+7]." ".$wordarray[$i+8]." ".$wordarray[$i+9];
	$key9=$wordarray[$i]." ".$wordarray[$i+1]." ".$wordarray[$i+2]." ".$wordarray[$i+3]." ".$wordarray[$i+4]." ".$wordarray[$i+5]." ".$wordarray[$i+6]." ".$wordarray[$i+7]." ".$wordarray[$i+8];
	$key8=$wordarray[$i]." ".$wordarray[$i+1]." ".$wordarray[$i+2]." ".$wordarray[$i+3]." ".$wordarray[$i+4]." ".$wordarray[$i+5]." ".$wordarray[$i+6]." ".$wordarray[$i+7];
	$key7=$wordarray[$i]." ".$wordarray[$i+1]." ".$wordarray[$i+2]." ".$wordarray[$i+3]." ".$wordarray[$i+4]." ".$wordarray[$i+5]." ".$wordarray[$i+6];
	$key6=$wordarray[$i]." ".$wordarray[$i+1]." ".$wordarray[$i+2]." ".$wordarray[$i+3]." ".$wordarray[$i+4]." ".$wordarray[$i+5];
	$key5=$wordarray[$i]." ".$wordarray[$i+1]." ".$wordarray[$i+2]." ".$wordarray[$i+3]." ".$wordarray[$i+4];
	$key4=$wordarray[$i]." ".$wordarray[$i+1]." ".$wordarray[$i+2]." ".$wordarray[$i+3];
	$key3=$wordarray[$i]." ".$wordarray[$i+1]." ".$wordarray[$i+2];
	$key2=$wordarray[$i]." ".$wordarray[$i+1];
	$key1=$wordarray[$i];
#print "$key6\n";
if(exists $hash{lc($key13)})
{
$array[$i] = $array[$i]."\tB-".$hash{lc($key13)};
$array[$i+1] = $array[$i+1]."\tI-".$hash{lc($key13)};
$array[$i+2] = $array[$i+2]."\tI-".$hash{lc($key13)};
$array[$i+3] = $array[$i+3]."\tI-".$hash{lc($key13)};
$array[$i+4] = $array[$i+4]."\tI-".$hash{lc($key13)};
$array[$i+5] = $array[$i+5]."\tI-".$hash{lc($key13)};
$array[$i+6] = $array[$i+6]."\tI-".$hash{lc($key13)};
$array[$i+7] = $array[$i+7]."\tI-".$hash{lc($key13)};
$array[$i+8] = $array[$i+8]."\tI-".$hash{lc($key13)};
$array[$i+9] = $array[$i+9]."\tI-".$hash{lc($key13)};
$array[$i+10] = $array[$i+10]."\tI-".$hash{lc($key13)};
$array[$i+11] = $array[$i+11]."\tI-".$hash{lc($key13)};
$array[$i+12] = $array[$i+12]."\tI-".$hash{lc($key13)};
$i=$i+12;
}
elsif(exists $hash{lc($key12)})
{
$array[$i] = $array[$i]."\tB-".$hash{lc($key12)};
$array[$i+1] = $array[$i+1]."\tI-".$hash{lc($key12)};
$array[$i+2] = $array[$i+2]."\tI-".$hash{lc($key12)};
$array[$i+3] = $array[$i+3]."\tI-".$hash{lc($key12)};
$array[$i+4] = $array[$i+4]."\tI-".$hash{lc($key12)};
$array[$i+5] = $array[$i+5]."\tI-".$hash{lc($key12)};
$array[$i+6] = $array[$i+6]."\tI-".$hash{lc($key12)};
$array[$i+7] = $array[$i+7]."\tI-".$hash{lc($key12)};
$array[$i+8] = $array[$i+8]."\tI-".$hash{lc($key12)};
$array[$i+9] = $array[$i+9]."\tI-".$hash{lc($key12)};
$array[$i+10] = $array[$i+10]."\tI-".$hash{lc($key12)};
$array[$i+11] = $array[$i+11]."\tI-".$hash{lc($key12)};
$i=$i+11;
}
elsif(exists $hash{lc($key11)})
{
$array[$i] = $array[$i]."\tB-".$hash{lc($key11)};
$array[$i+1] = $array[$i+1]."\tI-".$hash{lc($key11)};
$array[$i+2] = $array[$i+2]."\tI-".$hash{lc($key11)};
$array[$i+3] = $array[$i+3]."\tI-".$hash{lc($key11)};
$array[$i+4] = $array[$i+4]."\tI-".$hash{lc($key11)};
$array[$i+5] = $array[$i+5]."\tI-".$hash{lc($key11)};
$array[$i+6] = $array[$i+6]."\tI-".$hash{lc($key11)};
$array[$i+7] = $array[$i+7]."\tI-".$hash{lc($key11)};
$array[$i+8] = $array[$i+8]."\tI-".$hash{lc($key11)};
$array[$i+9] = $array[$i+9]."\tI-".$hash{lc($key11)};
$array[$i+10] = $array[$i+10]."\tI-".$hash{lc($key11)};
$i=$i+10;
}
elsif(exists $hash{lc($key10)})
{
$array[$i] = $array[$i]."\tB-".$hash{lc($key10)};
$array[$i+1] = $array[$i+1]."\tI-".$hash{lc($key10)};
$array[$i+2] = $array[$i+2]."\tI-".$hash{lc($key10)};
$array[$i+3] = $array[$i+3]."\tI-".$hash{lc($key10)};
$array[$i+4] = $array[$i+4]."\tI-".$hash{lc($key10)};
$array[$i+5] = $array[$i+5]."\tI-".$hash{lc($key10)};
$array[$i+6] = $array[$i+6]."\tI-".$hash{lc($key10)};
$array[$i+7] = $array[$i+7]."\tI-".$hash{lc($key10)};
$array[$i+8] = $array[$i+8]."\tI-".$hash{lc($key10)};
$array[$i+9] = $array[$i+9]."\tI-".$hash{lc($key10)};
$i=$i+9;
}
elsif(exists $hash{lc($key9)})
{
$array[$i] = $array[$i]."\tB-".$hash{lc($key9)};
$array[$i+1] = $array[$i+1]."\tI-".$hash{lc($key9)};
$array[$i+2] = $array[$i+2]."\tI-".$hash{lc($key9)};
$array[$i+3] = $array[$i+3]."\tI-".$hash{lc($key9)};
$array[$i+4] = $array[$i+4]."\tI-".$hash{lc($key9)};
$array[$i+5] = $array[$i+5]."\tI-".$hash{lc($key9)};
$array[$i+6] = $array[$i+6]."\tI-".$hash{lc($key9)};
$array[$i+7] = $array[$i+7]."\tI-".$hash{lc($key9)};
$array[$i+8] = $array[$i+8]."\tI-".$hash{lc($key9)};
$i=$i+8;
}
elsif(exists $hash{lc($key8)})
{
$array[$i] = $array[$i]."\tB-".$hash{lc($key8)};
$array[$i+1] = $array[$i+1]."\tI-".$hash{lc($key8)};
$array[$i+2] = $array[$i+2]."\tI-".$hash{lc($key8)};
$array[$i+3] = $array[$i+3]."\tI-".$hash{lc($key8)};
$array[$i+4] = $array[$i+4]."\tI-".$hash{lc($key8)};
$array[$i+5] = $array[$i+5]."\tI-".$hash{lc($key8)};
$array[$i+6] = $array[$i+6]."\tI-".$hash{lc($key8)};
$array[$i+7] = $array[$i+7]."\tI-".$hash{lc($key8)};
$i=$i+7;
}
elsif(exists $hash{lc($key7)})
{
$array[$i] = $array[$i]."\tB-".$hash{lc($key7)};
$array[$i+1] = $array[$i+1]."\tI-".$hash{lc($key7)};
$array[$i+2] = $array[$i+2]."\tI-".$hash{lc($key7)};
$array[$i+3] = $array[$i+3]."\tI-".$hash{lc($key7)};
$array[$i+4] = $array[$i+4]."\tI-".$hash{lc($key7)};
$array[$i+5] = $array[$i+5]."\tI-".$hash{lc($key7)};
$array[$i+6] = $array[$i+6]."\tI-".$hash{lc($key7)};
$i=$i+6;
}
elsif(exists $hash{lc($key6)})
{
$array[$i] = $array[$i]."\tB-".$hash{lc($key6)};
$array[$i+1] = $array[$i+1]."\tI-".$hash{lc($key6)};
$array[$i+2] = $array[$i+2]."\tI-".$hash{lc($key6)};
$array[$i+3] = $array[$i+3]."\tI-".$hash{lc($key6)};
$array[$i+4] = $array[$i+4]."\tI-".$hash{lc($key6)};
$array[$i+5] = $array[$i+5]."\tI-".$hash{lc($key6)};
$i=$i+5;
}
elsif(exists $hash{lc($key5)})
{
$array[$i] = $array[$i]."\tB-".$hash{lc($key5)};
$array[$i+1] = $array[$i+1]."\tI-".$hash{lc($key5)};
$array[$i+2] = $array[$i+2]."\tI-".$hash{lc($key5)};
$array[$i+3] = $array[$i+3]."\tI-".$hash{lc($key5)};
$array[$i+4] = $array[$i+4]."\tI-".$hash{lc($key5)};
$i=$i+4;
}
elsif(exists $hash{lc($key4)})
{
$array[$i] = $array[$i]."\tB-".$hash{lc($key4)};
$array[$i+1] = $array[$i+1]."\tI-".$hash{lc($key4)};
$array[$i+2] = $array[$i+2]."\tI-".$hash{lc($key4)};
$array[$i+3] = $array[$i+3]."\tI-".$hash{lc($key4)};
$i=$i+3;
}
elsif(exists $hash{lc($key3)})
{		
$array[$i] = $array[$i]."\tB-".$hash{lc($key3)};
$array[$i+1] = $array[$i+1]."\tI-".$hash{lc($key3)};
$array[$i+2] = $array[$i+2]."\tI-".$hash{lc($key3)};
$i=$i+2;
}
elsif(exists $hash{lc($key2)})
{	
$array[$i] = $array[$i]."\tB-".$hash{lc($key2)};
$array[$i+1] = $array[$i+1]."\tI-".$hash{lc($key2)};
$i=$i+1;
}
elsif(exists $hash{lc($key1)})
{	
$array[$i] = $array[$i]."\tB-".$hash{lc($key1)};}
else
{	
$array[$i]=$array[$i]."\tO"};
}

for($i=$m;$i<@array;$i++)
{
	$array[$i] =~ s/^\s+O$//;
	print"$array[$i]\n";
}
#{
print "\n";
$m=$i;
#}
close(FILE1);
