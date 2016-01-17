#local local_clock = global_clock - 6;

#declare Rnd_1 = seed(int(1153*local_clock));
#include "Informatikum/Informatikum.inc"

#declare shake = function(xx) { 1.5 * (1 - pow(xx - .573134328, 2)/.328482958) }

camera {
    Camera_SO
    rotate <shake(local_clock) * SRand(Rnd_1), shake(local_clock) * SRand(Rnd_1), shake(local_clock) * SRand(Rnd_1)>
}

#declare Container_T = texture {
   pigment {rgbt <1,1,1,1>}
   finish {ambient 0 diffuse 0}
}

#declare Scale = (pow(2, local_clock) - 1) * 3225;
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

#if (local_clock < 0.5)
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
#end

sphere {
    0 1
    pigment { rgbt <1, 0.5, 0, .7> }
    hollow
    scale Scale
    translate <900, 300, 900>
} //--------------------------------------
