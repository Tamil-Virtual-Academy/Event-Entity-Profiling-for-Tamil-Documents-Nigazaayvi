WORK_DIR=$PWD

cd $WORK_DIR
cp $1 ../TokenizerModule/tokenizer_1_input.txt
cd ../TokenizerModule
perl tokenizer-splitter-v1.pl < tokenizer_1_input.txt | perl pruneExtraLines.pl > tokenized_output.txt
cp tokenized_output.txt ../MorphanalyzerModule/.
perl runTokaniser.pl
#echo "tokeniser done";

cd ../MorphanalyzerModule/
sh TamilmorphAnalyser_v1.sh tokenized_output.txt > morph_only_out.txt
cp  morph_only_out.txt ../POSModule/.
perl runMorph.pl
#echo "morphanalysr done";

cd ../POSModule/
perl re-orderInput.pl morph_only_out.txt > POSinput_step1
sh TamilPOSEngine_v1.sh POSinput_step1 >POS_output_0.txt
perl re-orderOutput.pl morph_only_out.txt POS_output_0.txt | perl pos_postprocessing.pl > POS_output.txt
cp POS_output.txt ../Pruning/.
#echo "pos_module done";

cd ../Pruning/
sh Pruning.sh POS_output.txt > prune_output.txt
cp prune_output.txt ../ChunkerModule/.
perl runPOS.pl
#echo "pruning done";

cd ../ChunkerModule/
perl re-orderInput.pl prune_output.txt > ChunkerInput.txt
sh TamilChunkingEngine_v1.sh ChunkerInput.txt > Chunk_output_0.txt
perl re-orderOutput.pl prune_output.txt  Chunk_output_0.txt > Chunk_foutput.txt 
perl nP_correction.pl < Chunk_foutput.txt >Chunk_output.txt
cp  Chunk_output.txt ../ClauseIdentifierModule/.
cp  Chunk_output.txt ../event_extraction_sys/.
perl runChunking.pl
#echo "chunker done";

cd ../event_extraction_sys/
sh event.sh Chunk_output.txt


cd ../ClauseIdentifierModule/
sh TamilClauseEngine_v1.sh Chunk_output.txt  >Clause_output.txt
cp Clause_output.txt ../newTamilNERModule/.
cp Clause_output.txt ../causeEffectSys/.
perl runCLid.pl
#echo "clause done";

cd ../causeEffectSys/
sh cause-tag-script.sh Clause_output.txt

cd ../newTamilNERModule/
sh TamilNerEngine_v6.sh Clause_output.txt >ner_out.txt
cp ner_out.txt ../AnaphoraCoreferenceModule_v1/.
perl runNER.pl
#echo "ner done";

cd ../AnaphoraCoreferenceModule_v1/
sh AnaphoraCoref.sh ner_out.txt >anaphora_resolveOut.txt
cp anaphora_resolveOut.txt ../CoreferenceChainModule_v1/.
#perl run_AR.pl
#echo "anaphora done";

cd ../CoreferenceChainModule_v1/
sh CoreferenceChain.sh anaphora_resolveOut.txt >coref_final_colOut.txt
perl run_coref.pl
cat coref_final_colOut.txt
#echo "co-ref done";
