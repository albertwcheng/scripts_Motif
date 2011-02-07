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


#export LD_LIBRARY_PATH=/usr/local/lib



echo "motif 1m"
# -1m filename,headerRow1,startRow1,strandCol1,fromCol1,toCol1,N,CGBinInterval,FDRCutOff,pvalueCutOff,topCount
#$pvalueCutOff $FDRCutOff $outputCutOff

#-1m filename eventIDCols fromCol toCol N-mer CGBinSize
motifEnrichment.py --headerRow 1 --startRow 2 1m $FgFile .eventType,.locusName,.eventID 7 12 $Nmer $BinSize1MM   > "$OutputName.mmotif.txt" 2> "$OutputName.mmotif.stderr"



echo "motif h from C++ program"
#./motifEnrichment2 -h -h filenamefg,filenamebg,headerRow1,startRow1,strandCol1,fromCol1,toCol1,N,CGBinInterval,FDRCutOff,pvalueCutOff,topCount,familyFile[.=no],noOverlap[=yes,no],usePSSM[=yes,no],PSSM.nShuffle,PSSM.FDR
motifEnrichment2 -h $FgFile $BgFile 1 2 5 7 12 $Nmer $BinIntervalHG $pvalueCutOff $FDRCutOff $outputCutOff . no no 100 0.05 > "$OutputName.hmotif.txt" 2> "$OutputName.hmotif.stderr"

