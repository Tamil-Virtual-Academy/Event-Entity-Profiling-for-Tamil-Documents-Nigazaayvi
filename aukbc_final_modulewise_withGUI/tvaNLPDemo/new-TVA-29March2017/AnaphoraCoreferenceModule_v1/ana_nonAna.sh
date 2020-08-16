perl Ana-N_Ana/prepareData.pl $1 > step1_a_na
crf_test -m Ana-N_Ana/model_ana_nonAna step1_a_na > step2_a_na
perl Ana-N_Ana/putInfoBAck_a_na.pl $1 step2_a_na > a_na_output.txt
#perl Ana-N_Ana/putInfoBAck_a_na.pl $1 step2_a_na 

