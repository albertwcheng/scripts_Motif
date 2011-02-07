#!/bin/sh

#export LD_LIBRARY_PATH=/usr/local/lib
TAB=`echo -e "\t"`

#if [ 1 -gt 2 ]; then
rm -Rf ../motifAnalysis
mkdir ../motifAnalysis

fgsetToUse=../byEGString/miPS_Sharif_Boyer-MEF_Sharif_Boyer/CombinedAnalysis.final.FDRm.FDR0.05_dPsi-0.10.1.xls ######
bgsetToUse=../byEGString/miPS_Sharif_Boyer-MEF_Sharif_Boyer/CombinedAnalysis.final.FDRm.FDR0.05_dPsi-0.10.1bps_union.xls   ##../byEGString/CombinedAnalysis.final.FDRm.DetectedBoth.xls   ######

echo "Collecting ID and dPsi from DetectedBoth and FDR>0.05 as base for FG set";
cuta.py -f ".eventID,@dPsi$" $fgsetToUse  | awk 'FNR>1' | sort +0 -1 > id1.00

echo "Partitioning ID for up or down or both direction";
awk '$2<0' id1.00 | cut -f1 > down.sel.00;
awk '$2>0' id1.00 | cut -f1 > up.sel.00;
cut -f1 id1.00  > both.sel.00;

head -n 1 ../seq.merged.xls > ../seqHeader.txt

echo "Getting sequence file header";
selector=`colSelect.py -o, ../seqHeader.txt ".eventID,.eventType,.locusName,.chr,.strand,.inc/excBound,.inUFSeq-.exDFSeq"`
echo $selector 

cuta.py -f$selector ../seqHeader.txt > seq.header.00
echo columns selected are 
cat seq.header.00

echo "Getting headerless sequences";
cuta.py -f$selector ../seq.merged.highlyRedundant > seq.00

echo "Collecting ID from DetectedBoth as BG set (including FG)"
cuta.py -f ".eventID" $bgsetToUse  | awk 'FNR>1' | sort +0 -1 > dbid1.00
joinu.py dbid1.00 seq.00 > seqdbbg.nh.00
#cat seq.header.00 seqdbbg.nh.00 > ../motifAnalysis/DetectedBoth.bg




echo "Preprocessing file for different directions"
#preprocess Files:
for DIR in up down both
	do
	echo "making file for $DIR"
	
	#sort +0 -1 "$DIR.sel.00" > "$DIR.id.00"
	joinu.py "$DIR.sel.00" seq.00 > "$DIR.seqselnh.00"
	cat seq.header.00 "$DIR.seqselnh.00"> "../motifAnalysis/$DIR.seqsel.txt"
	
done;




#cut -d"$TAB" -f1 $fg > tmpIndex.00
#cut -d"$TAB" -f1 $bg >> tmpIndex.00

cat dbid1.00 both.sel.00 > tmpIndex.00 #adds background to foreground to get sets of things that are not differential.

echo "creating bg subtract fg set for -h analysis";
#select bg by subtracting fg from bg
sort tmpIndex.00 | uniq -c | awk '($1==1 && NF>1) {print $2}' > bgsubfgI.00

joinu.py bgsubfgI.00 seqdbbg.nh.00 > bgsubfg.00
cat seq.header.00 bgsubfg.00 > ../motifAnalysis/bgsfg.seqsel.txt

#fi #skipper

oriPath=`pwd`

cd ../motifAnalysis
for i in *.seqsel.txt; do
	wc -l $i
done

for i in *.seqsel.txt; do
	colStat.py $i
done

cd $oriPath

echo "Now the real stuff, calculate and output enriched Nmer";
for Nmer in 5 6 7
	do 
	echo "calculating $Nmer mer";	
	for DIR in up down both
		do 
		echo "calculating $DIR";		
		./calEnrichmentInner.sh $Nmer "../motifAnalysis/$DIR.seqsel.txt" ../motifAnalysis/bgsfg.seqsel.txt "../motifAnalysis/$DIR.$Nmer";
	done;
done;	

echo "Done Analysis. Cleaning Temp files";
#rm *.00
echo "<Done>";





