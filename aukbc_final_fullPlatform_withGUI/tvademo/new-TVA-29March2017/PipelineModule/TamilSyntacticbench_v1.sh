WORK_DIR=$PWD
cp $1 ../TokenizerModule/.
cd ../TokenizerModule
perl tokenizer-splitter-v1.pl < $1 > $1_tokenized_output.txt
cp $1_tokenized_output.txt ../POSModule/.

cd ../POSModule
sh TamilPOSEngine_v1.sh $1_tokenized_output.txt >$1_POS_output.txt
cp $1_POS_output.txt ../ChunkerModule/.

cd ../ChunkerModule
sh TamilChunkingEngine_v1.sh $1_POS_output.txt >$1_Chunk_output.txt
cp $1_Chunk_output.txt ../MorphanalyzerModule/.

cd $WORK_DIR
perl prune_mst_mrp.pl < ../MorphanalyzerModule/$1_Chunk_output.txt >../MorphanalyzerModule/mrp_prune_interim.txt
cd ../MorphanalyzerModule
sh TamilmorphAnalyser_v1.sh mrp_prune_interim.txt >morph_only_out.txt
perl $WORK_DIR/colorder.pl $1_Chunk_output.txt morph_only_out.txt >$1_Morph_output.txt
cp $1_Morph_output.txt ../ClauseIdentifierModule/.

cd ../ClauseIdentifierModule
sh TamilClauseEngine_v1.sh $1_Morph_output.txt >$1_Clause_output.txt
cat $1_Clause_output.txt

