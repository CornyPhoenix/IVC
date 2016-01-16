#include "Informatikum/Informatikum4.pov"

#declare CAMERA_ROT_ANGLE = 160;
#declare CAMERA_START_ANGLE = (180 + (180 - CAMERA_ROT_ANGLE)/2) * pi/180;
#declare CAMERA_LOOK_AT = <760, level_height, 825>;
#declare CAMERA_RADIUS_X = 980;
#declare CAMERA_RADIUS_Y = 625;
#local local_clock = global_clock - 1;

#include "Informatikum/Baeume.pov"

camera {
    right image_width/image_height * x
    
    // camera positioned behind minimon to view building A
    // pitching up the camera slightly
    #if (local_clock < .25) 
        #local another_local_clock = 4*local_clock;
        
        location D2_top + <0, scale_minimon*(3+another_local_clock), scale_minimon*3>
        look_at D2_top-<0,0,50>-(1-another_local_clock)*<0,0,100>
        
    #else
        #local CAMERA_ANGLE = CAMERA_START_ANGLE + CAMERA_ROT_ANGLE * 4 * pi * (local_clock - .25) / 540;

        location CAMERA_LOOK_AT + <CAMERA_RADIUS_X * cos(CAMERA_ANGLE), 200, CAMERA_RADIUS_Y * sin(CAMERA_ANGLE)>
        look_at CAMERA_LOOK_AT
    #end
}


object {
    minimon
    scale scale_minimon
    translate D2_top + offset_minimon
}
