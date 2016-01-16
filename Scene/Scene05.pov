#local local_clock = global_clock - 2;     

#local distance_jump = scale_minimon * <0, 0, -25>;

//--------------------------------------------------------------------------
// sub-scene 01 ------------------------------------------------------------
//--------------------------------------------------------------------------
// zoom at eyes of the minimon standing on top of building D
#if (local_clock < 1/4)

    // second-level local clock
    #local another_local_clock = 4* local_clock;
    
    // camera settings
    camera {
        right image_width/image_height * x
        
        location D2_top + scale_minimon*<-(1+(1-another_local_clock))*sin(pi*another_local_clock), 1, (5+5*(1-another_local_clock))*cos(pi*another_local_clock)>
        look_at D2_top + scale_minimon*<0, (0.5+0.5*another_local_clock)*sin(2.5*pi*another_local_clock), 1>
    
    }
    
    // minimon arrived at edge
    object {
        minimon
        scale scale_minimon
        translate D2_top + offset_minimon
    }

#end

//--------------------------------------------------------------------------
// sub-scene 02 ------------------------------------------------------------
//--------------------------------------------------------------------------
// minimon jumping off from roof of building D
#if (local_clock >= 1/4 & local_clock < 2/4)
    #local another_local_clock = (local_clock - 1/4) * 4;
    
    // following the minimon until a specific point in time
    #local time_switch = 0.5;
    
    // camera moving with minimon as it jumps off from roof
    camera {
        right image_width/image_height * x
        
        location D2_top + offset_minimon + another_local_clock*distance_jump + scale_minimon*<0, 0, -5>
        
        
        #if (another_local_clock < time_switch)
            look_at D2_top + scale_minimon*<0, 5*Jump(another_local_clock), 0>
        #else
            look_at D2_top + scale_minimon*<0, 5*Jump(time_switch), 0>
        #end
        
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
        scale scale_minimon
        translate D2_top + offset_minimon + distance_jump*another_local_clock + <0,  scale_minimon * 3*Jump(another_local_clock), 0>
    }

#end


//--------------------------------------------------------------------------
// sub-scene 03 ------------------------------------------------------------
//--------------------------------------------------------------------------
// camera positioned on the ground and looking up to the sky.
// camera following minimon while it lands to the ground in front of a minimon crowd.
#if (local_clock >= 2/4 & local_clock < 3/4)
    #local another_local_clock = (local_clock - 2/4) * 4;
    
    // initial elevation of minimon from the ground
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
        
        scale scale_minimon
        translate D2_front + offset_minimon + height*(1-another_local_clock) + distance_jump
    }

    //todo: army of minimons in the background


#end

//--------------------------------------------------------------------------
// sub-scene 04 ------------------------------------------------------------
//--------------------------------------------------------------------------
// minimon finally landed in front of a minimon crowd
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
