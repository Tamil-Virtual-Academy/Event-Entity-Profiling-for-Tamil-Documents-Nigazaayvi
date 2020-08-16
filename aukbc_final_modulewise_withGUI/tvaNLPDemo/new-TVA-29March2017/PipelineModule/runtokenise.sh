WORK_DIR=$PWD

cd $WORK_DIR
cp $1 ../TokenizerModule/tokenizer_1_input.txt
cd ../TokenizerModule
perl tokenizer-splitter-v1.pl < tokenizer_1_input.txt | perl pruneExtraLines.pl 
