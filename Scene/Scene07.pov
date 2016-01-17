#local local_clock = global_clock - 4;

#include "Informatikum/Informatikum4.pov"

#declare CAM_START = <
    (Bruecke_x1 + Bruecke_x2) / 2,
    (Bruecke_y1 + Bruecke_y2) / 2, // Augenhöhe
    (Bruecke_z1 + Bruecke_z2) / 2
>;

#declare CAM_MOVE = <-D1_width/2, 0, 0>;
#declare CAM_ANGLE_X = 10 * sin(32 * pi * local_clock);
#if (local_clock < 0.25 | local_clock > 0.75)
    #declare CAM_ANGLE_Y = 0;
#else
    #declare CAM_ANGLE_Y = 180 * pow(sin(2 * pi * (local_clock - 0.25)), 2);
#end

#declare CAM_ANGLE_Z = -10;

#declare CAM_LOCATION = CAM_START + local_clock * CAM_MOVE;
#declare CAM_LOOK_AT = vrotate(-x, <0, CAM_ANGLE_Y, CAM_ANGLE_Z>);

camera {
    location  0
    look_at   CAM_LOOK_AT
    right     CAM_RIGHT
    rotate    x * CAM_ANGLE_X
    translate CAM_LOCATION
}

// Minimon
object {
    MinimonWalking(32, local_clock)
    scale 1.3
    rotate <0,90,0>
    translate CAM_LOCATION + <30,-14,0>
}
