#local local_clock = global_clock;           
// initial distance of the minimon with respect to the roof top edge
#local stepcount_minimon = 24;
#local distance_edge = scale_minimon * <0, 0, stepcount_minimon>;

//--------------------------------------------------------------------------
// camera settings ---------------------------------------------------------
//--------------------------------------------------------------------------
camera {
    right image_width/image_height * x
    
    // position of the camera, relative to roof top of building D
    #local position_camera = D2_top + scale_minimon * <0, 15, 0>;
    
    // making camera look straight to the fround 
    #local point_focus = D2_top - <0, 0, 1>;
    
    // camera is statically positioned on top of building D
    // and looking to the ground.
    // minimon appears in the camera's field of view
    #if (local_clock < 1/4)
        location position_camera + 2/3*distance_edge
        look_at point_focus + 2/3*distance_edge
    #end
    
    // once the minimon is in the center of the field of view,
    // the camera starts following it while it continues walking
    // towards the edge of building D's roof.
    #if (local_clock >= 1/4 & local_clock < 2/4)
        #local another_local_clock = (local_clock - 1/4)*4;

        location position_camera + 1/2*distance_edge*(1-another_local_clock) + 1/6*distance_edge
        look_at point_focus + 1/2*distance_edge*(1-another_local_clock) + 1/6*distance_edge
    #end

     
    // camera now positioned at the front facade.
    // camera coming from below, while minimon approaches the edge.
    #if (local_clock >= 2/4)
        #local another_local_clock = (local_clock - 1/2)*2;

        location D2_top - scale_minimon * <0, 2*(1-another_local_clock), 3>
        look_at D2_top + offset_minimon
    #end
}

//--------------------------------------------------------------------------
// minimon -----------------------------------------------------------------
//--------------------------------------------------------------------------
// minimon walking towards front edge of building D
#if (local_clock <= 3/4)
    #local another_local_clock = 4/3 * local_clock;
    #local n = 24;

    merge {
        object { upper_head }
        object { lower_head }
        object {
            arm
            rotate <Swing(another_local_clock, stepcount_minimon), 0, 0>
            translate offset_arm_right
        }
        object {
            arm
            rotate <Swing(another_local_clock, stepcount_minimon), 180, 0>
            translate offset_arm_left
        }
        object {
            foot
            rotate <Paddle(another_local_clock, stepcount_minimon), 0, 0>
            translate offset_foot_right

        }
        object {
            foot
            rotate <Paddle(-another_local_clock, stepcount_minimon), 0, 0>
            translate offset_foot_left

        }
        scale scale_minimon
        translate D2_top + offset_minimon + <0, scale_minimon/2 *Bounce(another_local_clock, stepcount_minimon), 0> + distance_edge*(1-another_local_clock)
    }
#end

// minimon waiting, after having arrived at the edge of building D
#if (local_clock > 3/4)
    // minimon arrived at edge
    object {
        minimon
        scale scale_minimon
        translate D2_top + offset_minimon
    }
#end
