// all the minimon's start marching in this scene
#include "Informatikum/Informatikum4.pov"
#local local_clock = global_clock - 3; 
#local n = 32; 
#local path = D2_front + offset_minimon + distance_jump + <0, 0, -n* scale_minimon * local_clock>;

#declare marching_minimon =
    merge {
        object { upper_head }
        object { lower_head }
        object
        {
            arm
            rotate <0, 0, Flap(local_clock, n, 1)>
            translate offset_arm_right
        }
        object
        {
            arm
            rotate <0, 180, Flap(local_clock, n, -1)>
            translate offset_arm_left
        }
        object
        {
            foot
            rotate <Paddle(local_clock, n, 1), 0, 0>
            translate offset_foot_right
            
        }
        object
        {
            foot
            rotate <Paddle(local_clock, n, -1), 0, 0>
            translate offset_foot_left
            
        }
        scale scale_minimon
        translate <0, scale_minimon*Bounce(local_clock, n), 0>
    }


#declare marching_minimon_army = 
union {
    // minimon army in the background marching
    #local distance_x = scale_minimon * 4;
    #local distance_z = scale_minimon * 4;
    #local number_x = -5;
    #local final_x = 6;
    
    #while (number_x < final_x)
        #local number_z = 1;
        #local final_z = 6;
        #while (number_z < final_z)
            object {                
                marching_minimon
                translate <number_x*distance_x, 0, number_z*distance_z>
            }
            #local number_z = number_z + 1;
        #end
        #local number_x = number_x + 1;
    #end
    
    // leading minimon marching
    object {
        marching_minimon
    } 
}
 
object{ 
    marching_minimon_army
    
    // path
    translate path
}

//--------------------------------------------------------------------------
// sub-scene 01 ------------------------------------------------------------
//--------------------------------------------------------------------------
// frontal view on minimon army
#if (local_clock < 1/4)
    #local another_local_clock = local_clock * 4;
    
    camera {
        right image_width/image_height * x
        location path + scale_minimon * <0, 10*local_clock, -5 - 10*local_clock> 
        look_at path
    }

#end

//--------------------------------------------------------------------------
// sub-scene 02 ------------------------------------------------------------
//--------------------------------------------------------------------------
// from the back
#if (local_clock >= 1/4 & local_clock <= 2/4)
    #local another_local_clock = (local_clock - 1/4) * 4;
    
    camera {
        right image_width/image_height * x
        location D2_front + scale_minimon * <0, 5, -20> 
        look_at  path + another_local_clock * <0, 0, -100>
    }
         
#end

//--------------------------------------------------------------------------
// sub-scene 03 ------------------------------------------------------------
//--------------------------------------------------------------------------
// from above
#if (local_clock >= 2/4 & local_clock <= 3/4)
    #local another_local_clock = (local_clock - 2/4) * 4; 
    #local position_camera = <0, 0, -40>;
    
    camera {
        right image_width/image_height * x
        location D2_front + scale_minimon * (position_camera + <0, 5 + 5*another_local_clock, -10*another_local_clock>) 
        look_at D2_front + scale_minimon * position_camera
    }
#end

//--------------------------------------------------------------------------
// sub-scene 04 ------------------------------------------------------------
//--------------------------------------------------------------------------
// from the front again
#if (local_clock >= 3/4)
    #local another_local_clock = (local_clock - 3/4) * 4;

   camera {
        right image_width/image_height * x
        location path + scale_minimon * <0, 0, -5 - 10 * another_local_clock> 
        look_at path + <0, scale_minimon, 0> * (1-another_local_clock)
    }
#end
    




