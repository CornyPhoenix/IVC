#local local_clock = global_clock - 1;

camera {
    right image_width/image_height * x

    #if (local_clock < 1/4)

        #local another_local_clock = 4*local_clock;

        location D2_top + <0, 4-another_local_clock, 3>
        look_at D2_top-<0,0,50>-another_local_clock*<0,0,100>
        // look_at D2_top-<0,0,100>

    #end

    #if (local_clock >= 1/4 & local_clock < 1/2)


    #end

    #if (local_clock >= 1/2 & local_clock < 3/4)


    #end


    #if (local_clock >= 1/2)


    #end
}


object {
    minimon
    translate D2_top + offset_minimon
}
