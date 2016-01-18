#local local_clock = global_clock - 5;

#include "Informatikum/Informatikum4.pov"

#local n = 8;
#macro DancingMinimon(another_local_clock, pTrans, pRot)
    object {
        merge {
            object { upper_head }
            object { lower_head }
            object { arm
                rotate <0, 0, Flap(another_local_clock, n, 1)>
                translate offset_arm_right
            }
            object { arm
                rotate <0, 180, Flap(another_local_clock, n, -1)>
                translate offset_arm_left
            }
            object { foot
                rotate <FeetUp(another_local_clock, n), 0, 0>
                translate offset_foot_right

            }
            object { foot
                rotate <FeetUp(another_local_clock, n), 0, 0>
                translate offset_foot_left
            }
            scale scale_minimon
            translate <0, scale_minimon*Bounce(another_local_clock, n), 0>
        }
        rotate pRot
        translate pTrans + offset_minimon
    }
#end


#declare CAM_ROTATE = 0;

#switch (local_clock)
    // Frame 1681: Roof of Haus C
    #range (0, 0.25)
        #local my_clock = local_clock * 4;
        #declare CAM_LOCATION = <210, 30 + C1_levels * level_height, 450> + my_clock*<0, 0, 420>;
        #declare CAM_ROTATE = -45*y;

        #local yy = C1_levels * level_height + 15;
        DancingMinimon(my_clock, <160, yy, 580>, -45*y)
        DancingMinimon(my_clock, <60, yy, 910>, -45*y)
        DancingMinimon(my_clock, <140, yy, 800>, -45*y)
        DancingMinimon(my_clock, <105, yy + level_height, 530>, -45*y)
    // Frame 1765: Roof of Haus G
    #break #range (0.25, 0.5)
        #local my_clock = (local_clock - 0.25) * 4;
        #declare CAM_LOCATION = <1590, 30 + G_levels * level_height, 890> + my_clock*<0, 0, -420>;
        #declare CAM_ROTATE = 135*y;

        #local yy = G_levels * level_height + 15;
        DancingMinimon(my_clock, <1640, yy, 830>, CAM_ROTATE)
        DancingMinimon(my_clock, <1690, yy, 750>, CAM_ROTATE)
        DancingMinimon(my_clock, <1650, yy, 640>, CAM_ROTATE)
        DancingMinimon(my_clock, <1740, yy, 520>, CAM_ROTATE)
        DancingMinimon(my_clock, <1720, yy, 410>, CAM_ROTATE)
    // Frame 1849: Look into Haus D
    #break #range (0.5, 0.75)
        #local my_clock = (local_clock - 0.5) * 4;
        #declare CAM_LOCATION = <340, 35 + level_height, 840> + my_clock*<320, 0, 0>;
        #declare CAM_ROTATE = 30*y;

        #local yy = level_height + 15;
        #for (i, 0, 10)
            #local xx = 370 + i*31;
            DancingMinimon(my_clock, <xx, yy, 890>, 0)
        #end
    // Frame 1933: Bridge
    #break #else
        #local my_clock = (local_clock - 0.75) * 4;
        #declare CAM_LOCATION = <1190, 30, 890> + my_clock*2*level_height*y;
        #declare CAM_ROTATE = x*(-30 + 60*my_clock);

        #local yy = level_height + 15;
        #for (i, 0, 4)
            #local xx = 1140 + i*25;
            DancingMinimon(my_clock, <xx, yy, 950>, 0)
        #end
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
