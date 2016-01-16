#include "Informatikum/Informatikum4.pov"

#local local_clock = global_clock - 2;
#local distance_jump = <0, 0, -25>;

// jumping off roof
#if (local_clock < 1/4)
    #local another_local_clock = 4* local_clock;

    //todo: zoom on minimon's face or sth
#end

// pov of minimon while falling to the ground
#if (local_clock >= 1/4 & local_clock < 2/4)
    #local another_local_clock = (local_clock - 1/4) * 4;

    camera {
        right image_width/image_height * x
        location D2_top + offset_minimon + distance_jump*another_local_clock + <0, 0, -5>
        look_at D2_top + <0,5*Jump(another_local_clock),0>
        // look_at D2_top + <0,3-20*pow(another_local_clock, 2),0>
    }

    // minimon
    merge
    {
        object { upper_head }
        object { lower_head }
        object {
            arm
            rotate <0, 0, HandsUp(another_local_clock, 1)>
            translate offset_arm_right
            rotate <0,0,-5>

        }
        object {
            arm
            rotate <0, 180, 0>
            rotate <0, 0, HandsUp(another_local_clock, -1)>
            translate offset_arm_left
            rotate <0,0,5>

        }
        object {
            foot
            rotate <Paddle(another_local_clock, 8), 0, 0>
            translate offset_foot_right
        }
        object {
            foot
            rotate <Paddle(-another_local_clock, 8), 0, 0>
            translate offset_foot_left
        }

        translate D2_top + offset_minimon + distance_jump*another_local_clock + <0, 3*Jump(another_local_clock), 0>
    }

#end

// minimon finally landed in front of a minimon crowd
#if (local_clock >= 2/4 & local_clock < 3/4)

    #local another_local_clock = (local_clock - 2/4) * 4;

    #local height = <0, 10, 0>;

    camera {
        right image_width/image_height * x
        location D2_front + offset_minimon + distance_jump + <0, 0, -5*pow(another_local_clock,2)>
        look_at D2_front + offset_minimon + height*(1-another_local_clock) + distance_jump
    }

    // leading minimon
    merge {
        object { upper_head }
        object { lower_head }
        object {
            arm
            rotate <0, 0, HandsUp(another_local_clock, -1)>
            translate offset_arm_right
            rotate <0,0,-5>

        }
        object {
            arm
            rotate <0, 180, 0>
            rotate <0, 0, HandsUp(another_local_clock, 1)>
            translate offset_arm_left
            rotate <0,0,5>

        }
        object {
            foot
            rotate <Paddle(another_local_clock, 8), 0, 0>
            translate offset_foot_right
        }
        object {
            foot
            rotate <Paddle(-another_local_clock, 8), 0, 0>
            translate offset_foot_left
        }

        translate D2_front + offset_minimon + height*(1-another_local_clock) + distance_jump
    }

    //todo: army of minimons in the background


#end


// all the minimon's start marching
#if (local_clock > 3/4)
    #local another_local_clock = (local_clock - 3/4) * 4;

    camera {
        right image_width/image_height * x

        location D2_front + <0, 5, ((-8)*another_local_clock)-40>
        look_at D2_front + <0, 1, 0> //rotate <0,360*clock, 0>
    }

    #local Dx = 4.00;
    #local Dz = 4.00;
    #local NrX = -3;
    #local EndNrX = 4;
    #while (NrX < EndNrX)
        #local NrZ = 0;
        #local EndNrZ = 7;
        #while (NrZ < EndNrZ)
            object {
                minimon
                translate D2_front - <NrX*Dx, 0, NrZ*Dz>
            }
            #local NrZ = NrZ + 1;
        #end
        #local NrX = NrX + 1;
    #end

    object {
        minimon
        translate D2_front - <0, 0, 8*Dz>
    }
#end
