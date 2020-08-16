java convert_UTF_WX_tam -i $1 -o 1ner_wx_interim1.txt
java Preprocess  1ner_wx_interim1.txt > 1ner_inter2
#perl preprocess-verb.pl ner_inter2 > toNER_CRF_inter3
crf_test -m model-tva1 1ner_inter2  > 1crfner_interimOut.txt
perl merge-two-files.pl 1ner_wx_interim1.txt  1crfner_interimOut.txt > 1inter1.txt
perl ne_npcheck_case.pl 1inter1.txt > 1inter2.txt
perl dict.pl uniq-dict.txt 1inter2.txt > out-dict.txt
#perl post.pl out-dict.txt > out-post.txt
#perl new-1assign-netag.pl out-post.txt > tag-dict.txt
perl new-1assign-netag.pl out-dict.txt > tag-dict.txt
perl new-ne-tag-dict.pl tag-dict.txt 1inter2.txt > 1inter-ner.txt
perl prune_ner.pl 1inter-ner.txt > 1ner_interimOut.txt

java convert_WX_UTF_tam -i 1ner_interimOut.txt -o $1_ner_out0.txt
perl colateFiles.pl $1 $1_ner_out0.txt > $1_ner_out_ii.txt

cat $1_ner_out_ii.txt

