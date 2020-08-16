open(F,$ARGV[0]);
while(<>)
{
        chomp;
        if($_=~/^\s*$/)
        {
                print "\n";
                next;
        }
        @a=split(/\t/,$_);
        if(($a[7]!~/^O$/)&&($a[6]=~/^O$/))
        {
                $a[6]=$a[7];
        }
        print "$a[0]\t$a[1]\t$a[2]\t$a[3]\t$a[4]\t$a[5]\t$a[6]\n";
}
