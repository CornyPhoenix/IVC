#local local_clock = global_clock - 6;

#include "Informatikum/Informatikum.inc"
camera { Camera_SO }

#declare Container_T = texture {
   pigment {rgbt <1,1,1,1>}
   finish {ambient 0 diffuse 0}
}

#declare Scale = local_clock * 1290;
#declare INTERIOR = interior { media
                                  { emission <1,0.5,0>/Scale
                                    density
                                    { spherical color_map
                                      { [0 rgb 0]
                                        [0.5 rgb 0]
                                        [0.7 rgb .5]
                                        [1 rgb 1]
                                      }
                                      scale Scale
                                    }
                                  }
                                } // end of interior

difference {
    union {
        #include "Informatikum/Informatikum4.pov"
        #include "Informatikum/Baeume.pov"
    }

    sphere {
        0 1
        scale Scale
        translate <900, 300, 900>
    }
}

sphere {
    0 1
    pigment { rgbt <1, 0.5, 0, .7> }
    hollow
    scale Scale
    translate <900, 300, 900>
} //--------------------------------------
