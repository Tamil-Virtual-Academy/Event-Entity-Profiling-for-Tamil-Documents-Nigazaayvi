java convert_UTF_WX_tam -i $1 -o eventInp01.txt
perl removePhrases.pl eventInp01.txt > eventInp0.txt
perl adjustCol.pl eventInp0.txt > eventInp.txt
perl morphinfo.pl eventInp.txt > out_morphinfo
perl senwordno.pl out_morphinfo >out_senwordno
perl colneed_trig.pl out_senwordno >out_colneed_trig
perl dict.pl dict_trigger out_colneed_trig >out_dict
perl replace.pl out_dict >out_replace
perl joino.pl out_replace >out_replace_o
perl features.pl out_replace_o >out_replace_fea
#crf_test -m model_event_trigger out_replace >out_event_trigger
crf_test -m model_eventtrigger_18417 out_replace_fea >out_event_trigger
perl colneed_event.pl out_event_trigger >out_colneed_event
crf_test -m model_event_data_start_24417 out_colneed_event >out_event_start
crf_test -m model_event_end out_colneed_event >out_event_end
awk '{ print $7 }' out_event_end > end_awk
awk 'NR==FNR{a[++i]=$0; next}{$8=a[++j]}1' OFS="\t" end_awk out_event_start >out_event_startend
perl final_output.pl out_event_startend >event_final_output
perl rebuiltOutput.pl $1 event_final_output | perl  getEventSentence.pl > eventTaggedOut.txt

