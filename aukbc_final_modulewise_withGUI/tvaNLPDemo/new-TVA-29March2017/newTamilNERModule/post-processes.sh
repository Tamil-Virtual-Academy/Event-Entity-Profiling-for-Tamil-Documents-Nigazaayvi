perl merge-two-files.pl ner_wx_interim1.txt  crfner_interimOut.txt > oo
perl 1assign-netag.pl oo > tag-dict.txt
perl 1ne-tag-dict.pl tag-dict.txt oo > inter-ner.txt
