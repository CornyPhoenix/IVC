WORK_THREADS    = 24
POVRAY          = povray +WT$(WORK_THREADS)
clean:
	rm -r Build
scene01:
	$(POVRAY) Space.ini
scene03:
	$(POVRAY) Campus.ini +SF1    +EF336
scene04:
	$(POVRAY) Campus.ini +SF336  +EF672
scene05:
	$(POVRAY) Campus.ini +SF673  +EF1008
scene06:
	$(POVRAY) Campus.ini +SF1009 +EF1339
scene07:
	$(POVRAY) Campus.ini +SF1345 +EF1680
scene08:
	$(POVRAY) Campus.ini +SF1681 +EF2016
scene09:
	$(POVRAY) Campus.ini +SF2017 +EF2352
