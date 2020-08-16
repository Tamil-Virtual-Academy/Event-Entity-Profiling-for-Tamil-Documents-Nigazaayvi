##input file is 5 col text in wx form 1. word 2.pos 3.chunk 4. morph 5.clause
##final outfile 1. word 2.pos 3.chunk 4.morph 5.clause 6.contag 7.arg2start 8.arg1end 9.arg2end 10.arg1start
cp $1 CETestFile-In0.txt
java convert_UTF_WX_tam -i CETestFile-In0.txt -o CETestFile-In.txt
crf_test -m conmodel1-ss CETestFile-In.txt >con-taggedout1
perl markcon-test.pl < con-taggedout1 >con-taggedout_2
crf_test -m model-arg2start-tt1 con-taggedout_2 > ce-arg2start-op
crf_test -m model-arg1end-tt ce-arg2start-op > ce-arg1end-op
crf_test -m model-arg2end-tt ce-arg1end-op > ce-arg2end-op
crf_test -m model-arg1start-tt ce-arg2end-op >ce-arg1start-op
perl merge-cetags.pl < ce-arg1start-op > causeEffectOut_0.txt

perl checkForCorrectness.pl causeEffectOut_0.txt > causeEffectOut_1.txt
perl findCE_usingRules.pl < causeEffectOut_1.txt > causeEffectOut_2.txt
perl extractCESentences.pl < causeEffectOut_2.txt > causeEffectOut_iitk.txt
java convert_WX_UTF_tam -i causeEffectOut_iitk.txt -o causeEffectOut_utf8.txt

