%.png: 
	povray %.pov +H500 +W500 +KFI0 +KFF99 +KI0.0 +KF99.0
%.gif: %.png  
	convert -delay 5 -loop 0 "*.png" animation.gif
