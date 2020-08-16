WORK_DIR=$PWD

cd $WORK_DIR
cp $1 ../TokenizerModule/tokenizer_1_input.txt
cd ../TokenizerModule
perl tokenizer-splitter-v1.pl < tokenizer_1_input.txt | perl pruneExtraLines.pl > tokenized_output.txt
cp tokenized_output.txt ../MorphanalyzerModule/.

cd ../MorphanalyzerModule/
sh TamilmorphAnalyser_v1.sh tokenized_output.txt > morph_only_out.txt
cp  morph_only_out.txt ../POSModule/.

cd ../POSModule/
perl re-orderInput.pl morph_only_out.txt > POSinput_step1
sh TamilPOSEngine_v1.sh POSinput_step1 >POS_output_0.txt
perl re-orderOutput.pl morph_only_out.txt POS_output_0.txt | perl pos_postprocessing.pl > POS_output.txt
cp POS_output.txt ../Pruning/.

cd ../Pruning/
sh Pruning.sh POS_output.txt > prune_output.txt
cp prune_output.txt ../ChunkerModule/.

cd ../ChunkerModule/
perl re-orderInput.pl prune_output.txt > ChunkerInput.txt
sh TamilChunkingEngine_v1.sh ChunkerInput.txt > Chunk_output_0.txt
perl re-orderOutput.pl prune_output.txt  Chunk_output_0.txt > Chunk_foutput.txt 
perl nP_correction.pl < Chunk_foutput.txt 
