WORK_DIR=$PWD

cd $WORK_DIR
cp $1 ../TokenizerModule/tokenizer_1_input.txt
cd ../TokenizerModule
perl tokenizer-splitter-v1.pl < tokenizer_1_input.txt | perl pruneExtraLines.pl > tokenized_output.txt
cp tokenized_output.txt ../MorphanalyzerModule/.

cd ../MorphanalyzerModule/
sh TamilmorphAnalyser_v1.sh tokenized_output.txt 
