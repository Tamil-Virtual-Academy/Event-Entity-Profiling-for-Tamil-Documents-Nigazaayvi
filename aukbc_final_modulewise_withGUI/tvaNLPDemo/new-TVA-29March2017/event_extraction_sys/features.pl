open(F,$ARGV[0]);
while(<F>)
{
	chomp;
	push (@array,$_);
}
close(F);
	for ($i=0 ; $i<@array ; $i++)
	{
     @temp1=split(/\t/,$array[$i]);
	@temp_pre=split(/\t/,$array[$i-1]);
	@temp_next=split(/\t/,$array[$i+1]);
	@temp_next1=split(/\t/,$array[$i+2]);
	@temp_next2=split(/\t/,$array[$i+3]);
	@temp_next3=split(/\t/,$array[$i+4]);
if(($array[$i+1]=~/^\s*$/)&&($temp1[5]=~/^1$/)&&($temp1[0]!~/^\.$/)) 
	{
    	$temp1[8]=~s/O/1/;
	$array[$i]=join "\t",@temp1;
     	}
if(($temp_next[0]=~/^\.$/)&&($temp1[5]=~/^1$/))
        {
        $temp1[8]=~s/O/1/;
        $array[$i]=join "\t",@temp1;
        }
if(($temp_next[0]=~/^\.$/)&&($temp1[5]=~/^2$/))                                                    
        {
        $temp1[8]=~s/O/1/;
        $array[$i]=join "\t",@temp1;
        }

#if(($temp_pre[1]=~/^VB$/)&&($temp1[0]=~/^or$/)&&($temp_next[0]=~/^that$/)&&($temp_next[1]=~/^IN$/)) 
#	{
#    	$temp1[8]=~s/^o$/B-conn/;
#	$array[$i]=join "\t",@temp1;
# 	}
#if(($temp_pre[1]=~/^NN$/)&&($temp1[0]=~/^,$/)&&($temp_next[0]=~/^or$/)&&($temp_next1[1]=~/^IN$/)&&($temp_next1[0]=~/^that$/)) 
#	{
#    	$temp_next[8]=~s/^o$/B-conn/;
#	$array[$i+1]=join "\t",@temp_next;
#     	}
print"$array[$i]\n";
	}  
