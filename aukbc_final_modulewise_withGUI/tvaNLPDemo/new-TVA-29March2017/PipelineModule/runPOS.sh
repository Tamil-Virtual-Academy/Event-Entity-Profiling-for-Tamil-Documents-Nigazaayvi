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
sh Pruning.sh POS_output.txt 
