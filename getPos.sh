#!/bin/sh

for DIR in up down
	do 
		for MOTIF in UGUGU GUGUG AUAUA UAUAU GCAUG CUCUC UCUCU
			do echo "Searching for motif $MOTIF in $DIR direction";
				./motifEnrichment.py -pos "../motifAnalysis/$DIR.seqsel.txt" 1 3 3 1 2 5 6 11 $MOTIF > "../motifPlace/$DIR.$MOTIF.txt"
		done
done

