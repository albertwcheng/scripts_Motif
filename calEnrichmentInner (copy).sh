#!/bin/sh

Nmer=$1
FgFile=$2
BgFile=$3
OutputName=$4



BinSize1MM=100;
BinIntervalHG=0.05;
pvalueCutOff=-1.1;
FDRCutOff=-1.1;
outputCutOff=11110000;


export LD_LIBRARY_PATH=/usr/local/lib


#if [ 1 -eq 0 ]; then

echo "motif 1m"
# -1m filename,headerRow1,startRow1,strandCol1,fromCol1,toCol1,N,CGBinInterval,FDRCutOff,pvalueCutOff,topCount
#$pvalueCutOff $FDRCutOff $outputCutOff
 ./motifEnrichment.py --headerRow 1 --startRow 2 1m $FgFile 6 11 $Nmer $BinSize1MM  > "$OutputName.mmotif.txt" 2> "$OutputName.mmotif.stderr"
 #./motifEnrichment.py --headerRow 1 --startRow 2 --family ./567mers_aligned.txt,$Nmer 1m $FgFile 6 11 $Nmer $BinSize1MM  > "$OutputName.Fmmotif.txt" 2> "$OutputName.Fmmotif.stderr"
 




#echo "find all zefeng location"
#./motifEnrichment.py --headerRow 1 --startRow 2 --family ./567mers_aligned.txt,$Nmer --no-overlap pos $FgFile 1-5 6 11 > $OutputName.zefengLoc.txt 2> $OutputName.zefengLoc.stderr

#fi #skipper

echo "motif h from C++ program"
#./motifEnrichment2 -h -h filenamefg,filenamebg,headerRow1,startRow1,strandCol1,fromCol1,toCol1,N,CGBinInterval,FDRCutOff,pvalueCutOff,topCount,familyFile[.=no],noOverlap[=yes,no],usePSSM[=yes,no],PSSM.nShuffle,PSSM.FDR
motifEnrichment2 -h $FgFile $BgFile 1 2 4 6 11 $Nmer $BinIntervalHG $pvalueCutOff $FDRCutOff $outputCutOff . no no 100 0.05 > "$OutputName.hmotif.txt" 2> "$OutputName.hmotif.stderr"
#motifEnrichment2 -h $FgFile $BgFile 1 2 4 6 11 $Nmer $BinIntervalHG $pvalueCutOff $FDRCutOff $outputCutOff ./567mers_aligned.txt no no 100 0.05 > "$OutputName.Fhmotif.txt" 2> "$OutputName.Fhmotif.stderr"
#motifEnrichment2 -h $FgFile $BgFile 1 2 4 6 11 $Nmer $BinIntervalHG $pvalueCutOff $FDRCutOff $outputCutOff ./567mers_aligned.txt yes yes 100 0.05  > "$OutputName.Phmotif.txt" 2> "$OutputName.Phmotif.stderr"
#if [ $Nmer -eq 5 ]; then
#motifEnrichment2 -h $FgFile $BgFile 1 2 4 6 11 -1 $BinIntervalHG $pvalueCutOff $FDRCutOff $outputCutOff ./spliceAidFam.txt yes yes 100 0.05  > "$OutputName.SAPhmotif.txt" 2> "$OutputName.SAPhmotif.stderr"
#fi



#echo "motif h"

# $pvalueCutOff $FDRCutOff $outputCutOff
#./motifEnrichment.py  --headerRow 1 --startRow 3 h $FgFile $BgFile 6 11 $Nmer $BinIntervalHG > "$OutputName.hmotif.txt" 2> "$OutputName.hmotif.stderr"
#./motifEnrichment.py  --headerRow 1 --startRow 3 --family ./567mers_aligned.txt,$Nmer  h $FgFile $BgFile 6 11 $Nmer $BinIntervalHG > "$OutputName.Fhmotif.txt" 2> "$OutputName.Fhmotif.stderr"

# old echo "motif 1m"
## -1m filename,headerRow1,startRow1,strandCol1,fromCol1,toCol1,N,CGBinInterval,FDRCutOff,pvalueCutOff,topCount
# ./motifEnrichment.py -1m $FgFile 1 3 4 6 11 $Nmer $BinSize1MM $pvalueCutOff $FDRCutOff $outputCutOff > "$OutputName.motif.txt" 2> "$OutputName.motif.stderr"
