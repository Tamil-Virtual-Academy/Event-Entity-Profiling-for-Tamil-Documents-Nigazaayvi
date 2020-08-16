open(F,$ARGV[0]);
while(<F>)
{
        chomp;
        $line=$_;
        if($line =~ /^\s*$/) {
             print "HAI";
              next;
        }
        next if($line eq undef);
        print"$line\n";
}

