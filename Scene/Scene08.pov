#local local_clock = global_clock - 5;

#include "Informatikum/Informatikum4.pov"

#declare CAM_ROTATE = 0;

#switch (local_clock)
    // Frame 1681: Roof of Haus C
    #range (0, 0.25)
        #local my_clock = local_clock * 4;
        #declare CAM_LOCATION = <210, 30 + C1_levels * level_height, 450> + my_clock*<0, 0, 420>;
        #declare CAM_ROTATE = -45*y;
    // Frame 1765: Roof of Haus G
    #break #range (0.25, 0.5)
        #local my_clock = (local_clock - 0.25) * 4;
        #declare CAM_LOCATION = <1590, 30 + G_levels * level_height, 890> + my_clock*<0, 0, -420>;
        #declare CAM_ROTATE = 135*y;
    // Frame 1849: Look into Haus D
    #break #range (0.5, 0.75)
        #local my_clock = (local_clock - 0.5) * 4;
        #declare CAM_LOCATION = <340, 35 + level_height, 840> + my_clock*<320, 0, 0>;
        #declare CAM_ROTATE = 30*y;
    // Frame 1933: Bridge
    #break #else
        #local my_clock = (local_clock - 0.75) * 4;
        #declare CAM_LOCATION = <1190, 30, 890> + my_clock*2*level_height*y;
        #declare CAM_ROTATE = x*(-30 + 60*my_clock);
    // Last Frame: 2016
#end

camera {
    location  <0,0,0>
    look_at   <0,0,1>
    right     CAM_RIGHT
    rotate    CAM_ROTATE
    translate CAM_LOCATION
}
//
//// Minimon
//object {
//    MinimonWalking(32, local_clock)
//    scale 1.3
//    rotate <0,90,0>
//    translate CAM_LOCATION + <30,-14,0>
//}
