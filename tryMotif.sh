#!/bin/sh

##./motifEnrichment.py -1m ../motifAnalysis/up.5.seqsel.txt 1 3 2 3 8 6 100 0.05 0.05 50 > out6.00 2> err6.00


TAB=`echo -e "\t"`


fg="../motifAnalysis/up.5.seqsel.txt"
bg="../motifAnalysis/seq.bg"

#fg should be a subset of bg

cut -d"$TAB" -f1 $fg > tmpIndex.00
cut -d"$TAB" -f1 $bg >> tmpIndex.00

#select bg by subtracting fg from bg
sort tmpIndex.00 | uniq -c | awk '($1==1 && NF>1) {print $2}' > bgsubfgI.00



join -t"$TAB" bgsubfgI.00 $bg > bgsubfg.00
 cat ../motifAnalysis/seq.header.00 bgsubfg.00 > bgsubfgwh.00

./motifEnrichment.py -h $fg bgsubfgwh.00 1 3 2 3 8 6 1 0.05 0.05 50 > out6.00 2> err6.00

