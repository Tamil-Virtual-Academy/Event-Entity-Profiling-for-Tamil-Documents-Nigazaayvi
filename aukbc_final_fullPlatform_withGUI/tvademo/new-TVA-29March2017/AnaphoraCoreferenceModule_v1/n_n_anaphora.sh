
java convert_UTF_WX_tam -i $1 -o raw_file
perl nn_ana/getNPs.pl raw_file | perl nn_ana/makePairsForLearning_testing.pl
