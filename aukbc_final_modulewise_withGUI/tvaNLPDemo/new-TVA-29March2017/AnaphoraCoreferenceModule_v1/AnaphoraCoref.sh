#perl removeInfo.pl < $1 > raw_file0
java convert_UTF_WX_tam -i $1 -o raw_file0

perl improveGenderInfo.pl raw_file0 | perl prepareData.pl > raw_file 
#perl improveGenderInfo.pl $1 > raw_file 
#Anaphoric - Non_Anaphiric 
sh ana_nonAna.sh raw_file

rm sg_pn_out.txt
rm pl_pn_out.txt
rm interNN

#Singular Pronoun Resolution
perl pronominalSingular/readFile_training_buildMatrix_testing.pl a_na_output.txt  >  sg_pn_out.txt 2> moreDetails_sg
perl annotatePronouns.pl raw_file sg_pn_out.txt > output_stage1.txt

#Plural Pronoun Resolution
perl pronominalPlural/readFile_training_buildMatrix_plural_testing.pl a_na_output.txt > pl_pn_out.txt 2> moreDetails_pl
perl annotatePronouns.pl output_stage1.txt pl_pn_out.txt > output_stage2.txt

#Definite Description
##perl DDEngine/ddIdentification_testing.pl output_stage2.txt 
perl DDEngine/ddIdentification_testing.pl output_stage2.txt > interDD
perl annotateNN.pl output_stage2.txt interDD > output_stage3.txt
perl collectDDs.pl  interDD > dd_in_file.txt

#Noun-Noun Anaphora
perl nn_ana/getNPs.pl output_stage2.txt | perl nn_ana/makePairsForLearning_testing.pl |perl nn_ana/postProcess.pl > interNN1
perl postprocess2.pl dd_in_file.txt interNN1 > interNN
#erl nn_ana/getNPs.pl output_stage2.txt | perl nn_ana/makePairsForLearning_testing.pl 
perl annotateNN.pl output_stage3.txt interNN | perl prune_AR.pl > anaOut.txt
java convert_WX_UTF_tam -i anaOut.txt -o anaOut_utf.txt
less anaOut_utf.txt


#perl corefChainBuilder.pl output_stage4.txt 2> coref_chains.txt
#cat sg_pn_out.txt
#cat pl_pn_out.txt
