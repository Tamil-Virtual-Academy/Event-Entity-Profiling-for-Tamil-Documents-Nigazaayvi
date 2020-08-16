WORK_DIR=$PWD
cp $1 ../TokenizerModule/.
cd ../TokenizerModule
perl tokenizer-splitter-v1.pl < $1 > $1_tokenized_output.txt
cp $1_tokenized_output.txt ../MorphanalyzerModule/.

cd ../MorphanalyzerModule/
sh TamilmorphAnalyser_v1.sh $1_tokenized_output.txt > morph_only_out.txt
cp  morph_only_out.txt ../POSModule/.

cd ../POSModule/
perl re-orderInput.pl morph_only_out.txt > $1_POSinput_step1
sh TamilPOSEngine_v1.sh $1_POSinput_step1 >$1_POS_output_0.txt
perl re-orderOutput.pl morph_only_out.txt $1_POS_output_0.txt > $1_POS_output.txt
cp $1_POS_output.txt ../Pruning/.

cd ../Pruning/
sh Pruning.sh $1_POS_output.txt > $1_prune_output.txt
cp $1_prune_output.txt ../ChunkerModule/.

cd ../ChunkerModule/
perl re-orderInput.pl $1_prune_output.txt > $1_ChunkerInput.txt
sh TamilChunkingEngine_v1.sh $1_ChunkerInput.txt > $1_Chunk_output_0.txt
perl re-orderOutput.pl $1_prune_output.txt  $1_Chunk_output_0.txt > $1_Chunk_foutput.txt 
perl nP_correction.pl < $1_Chunk_foutput.txt >$1_Chunk_output.txt
cp  $1_Chunk_output.txt ../ClauseIdentifierModule/.

cd ../ClauseIdentifierModule/
sh TamilClauseEngine_v1.sh $1_Chunk_output.txt  >$1_Clause_output.txt
cp $1_Clause_output.txt ../TamilNERModule_v1/.

cd ../TamilNERModule_v1/
sh TamilNerEngine_v1.sh $1_Clause_output.txt >$1_ner_out.txt
cat $1_ner_out.txt
#cp $1_ner_out.txt ../AnaphoraCoreferenceModule_v1/.

#cd ../AnaphoraCoreferenceModule_v1/
#sh AnaphoraCoref.sh $1_ner_out.txt >$1_anaphora_resolveOut.txt
#cp $1_anaphora_resolveOut.txt ../CoreferenceChainModule_v1/.

#cd ../CoreferenceChainModule_v1/
#sh CoreferenceChain.sh $1_anaphora_resolveOut.txt 
