#local local_clock = global_clock;
#local distance_edge = <0, 0, 24>;

// camera settings
camera {
    right image_width/image_height * x

    #local position_camera = D2_top + <0, 15, 0>;
    #local point_focus = D2_top - <0, 0, 1>;

    #if (local_clock < 1/4)
        location position_camera + 2/3*distance_edge
        look_at point_focus + 2/3*distance_edge

    #end

    #if (local_clock >= 1/4 & local_clock < 2/4)
        #local another_local_clock = (local_clock - 1/4)*4;

        location position_camera + 2/3*distance_edge*(1-another_local_clock)
        look_at point_focus + 2/3*distance_edge*(1-another_local_clock)
    #end


    #if (local_clock >= 2/4)
        #local another_local_clock = (local_clock - 1/2)*2;

        location D2_top - <0, 2*(1-another_local_clock), 3>
        look_at D2_top + <0, 1, 0>
    #end
}

//minimon
#if (local_clock <= 3/4)
    #local another_local_clock = 4/3 * local_clock;
    #local n = 32;

    merge {
        object { upper_head }
        object { lower_head }
        object {
            arm
            rotate <Swing(local_clock, n), 0, 0>
            translate offset_arm_right
        }
        object {
            arm
            rotate <Swing(local_clock, n), 180, 0>
            translate offset_arm_left
        }
        object {
            foot
            rotate <Paddle(local_clock, n), 0, 0>
            translate offset_foot_right

        }
        object {
            foot
            rotate <Paddle(-local_clock, n), 0, 0>
            translate offset_foot_left

        }
        //rotate <0, 0, Totter(local_clock)>
        translate D2_top + offset_minimon + <0, 0.5*Bounce(local_clock, n), 0> + distance_edge*(1-another_local_clock)
    }
#end

#if (local_clock > 3/4)
    // minimon arrived at edge
    object {
        minimon
        translate D2_top + offset_minimon
    }
#end
