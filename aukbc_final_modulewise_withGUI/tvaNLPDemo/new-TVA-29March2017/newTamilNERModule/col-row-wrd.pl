open(F,$ARGV[0]);
while(<F>)
{
        chomp;

        if($_ =~ /^\s*$/) {
                print "\n";
                next;
        }
        next if($_ eq undef);
        @arr=split(/\t/,$_);$l=@arr;
        print"$arr[0] ";
}

