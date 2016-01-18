WORK_THREADS    = 24
POVRAY          = povray +WT$(WORK_THREADS)
clean:
	rm -r Build
scene01:
	$(POVRAY) Space.ini     2>Logs/scene01 &
scene03:
	$(POVRAY) Campus.ini +SF1    +EF336     2>Logs/scene03 &
scene04:
	$(POVRAY) Campus.ini +SF337  +EF672     2>Logs/scene04 &
scene05:
	$(POVRAY) Campus.ini +SF673  +EF1008    2>Logs/scene05 &
scene06:
	$(POVRAY) Campus.ini +SF1009 +EF1344    2>Logs/scene06 &
scene07:
	$(POVRAY) Campus.ini +SF1345 +EF1680    2>Logs/scene07 &
scene08:
	$(POVRAY) Campus.ini +SF1681 +EF2016    2>Logs/scene08 &
scene09:
	$(POVRAY) Campus.ini +SF2017 +EF2352    2>Logs/scene09 &
Campus.mp4:
	ffmpeg -framerate 24.5 -i Build/Campus%04d.png -c:v libx264 -pix_fmt yuv420p Campus.mp4
