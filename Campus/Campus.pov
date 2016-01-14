//--------------------------------------------------------------------------
// author:  Sibel Toprak, Konstantin M�llers
// date:    2016-01-01
//--------------------------------------------------------------------------
#version 3.7;
global_settings{ assumed_gamma 1.0 }
#default{ finish{ ambient 0.1 diffuse 0.9 }} 
//--------------------------------------------------------------------------
#include "colors.inc"
#include "textures.inc"
#include "glass.inc"
#include "metals.inc"
#include "golds.inc"
#include "stones.inc"
#include "woods.inc"
#include "shapes.inc"
#include "shapes2.inc"
#include "functions.inc"
#include "math.inc"
#include "transforms.inc"
//-----
#include "./Informatikum/Informatikum.inc"
#include "./Minimon/Minimon.inc"
//--------------------------------------------------------------------------
// parameters and variables ------------------------------------------------

#declare global_clock = clock;

#declare FRAMES_PER_SECOND = 24.5;
#declare BPM = 140;

#declare D2_top = <D2_x+0.5*D2_width, level_height*D2_levels, D2_z-D2_depth> + <0,0,1>;
#declare D2_front = <D2_x+0.5*D2_width, 0, D2_z-D2_depth>; 
#declare offset_minimon = <0, 1.3, 0>;  
//--------------------------------------------------------------------------
// macros ------------------------------------------------------------------
#macro  Jump(X)
 #if (X<0.5) abs(sin(2*pi*X))
 #else -20*(X-0.5)
 #end
#end

#macro HandsUp(X, d)
 (-165)*(d)*abs(sin(0.5*pi*X)) 
#end 

#macro  Bounce(time, number)
 abs(sin(number*pi*time))
#end

#macro Flap(time, number)
 -180*abs(sin(number*pi*time))
#end

#macro Paddle(time, number)
 45*sin(number*pi*time)
#end

#macro Swing(time, number)
 -90*sin(number*pi*time)
#end

#macro Totter(time, number)
 -5*sin(number*pi*time)
#end

#macro Breathe(X)
 abs(sin(2*pi*X))
#end

//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------

// sun ---------------------------------------------------------------------
light_source{<1500,2500,-2500> color White}

// sky ---------------------------------------------------------------------
/*plane{<0,1,0>,1 hollow  
       texture{ pigment{ bozo turbulence 0.76
                         color_map { [0.5 rgb <0.20, 0.20, 1.0>]
                                     [0.6 rgb <1,1,1>]
                                     [1.0 rgb <0.5,0.5,0.5>]}
                       }
                finish {ambient 1 diffuse 0} }      
       scale 10000}*/
sky_sphere {
    pigment {
        image_map {
            jpeg "./Textures/sky.jpg"
            map_type 1
        }
	}
}

// fog ---------------------------------------------------------------------
fog {
    fog_type   2
    distance   50
    color      White
    fog_offset 0.1
    fog_alt    2.0
    turbulence 0.8
}

// ground ------------------------------------------------------------------
plane { <0,-0.1,0>, 0 
        texture{ pigment{ color rgb<.24,0.35,0.23> }
	         normal { bumps 0.75 scale 0.015 }
                 finish { phong 0.1 }
               } // end of texture
} // end of plane



// Ground
box {
	<0,0,0>
	<1,1,0.1>
	/*texture{ pigment{ color rgb<.24,0.45,0.23>*0.67 }
	         normal { bumps 0.75 scale .000017647 }
               }*/
	texture {
		pigment {
			image_map {
				png "./Textures/texture.png"
				map_type 0
				interpolate 2
		    }
		}
	}
	scale <1800, 1800, 1>
	rotate -90*x
	rotate 180*y
	translate <1800, 0, 0>
}

//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------
#include "Informatikum/Informatikum4.pov"

#switch (clock)

    //--------------------------------------------------------------------------
    // scene 03 ----------------------------------------------------------------
    // minimon shows itself on top of building D
    // walks to the edge of the roof while camera is following
    #range (0,1) /* frame 1 to 336 */
        #warning "Scene 03"
        #include "Scene/Scene03.pov"
    #break // of scene 03.

    //--------------------------------------------------------------------------
    // scene 04 ----------------------------------------------------------------
    #range (1,2) /* frame 337 to 672 */
        #warning "Scene 04"
        #include "Scene/Scene04.pov"
    #break // of scene 04.

    //--------------------------------------------------------------------------
    // scene 05 ----------------------------------------------------------------
    //--------------------------------------------------------------------------
    #range (2,3) /* frame 673 to 1008 */
        #warning "Scene 05"
        #include "Scene/Scene05.pov"
    #break // of scene 05.

    //--------------------------------------------------------------------------
    // scene 06 ----------------------------------------------------------------
    //--------------------------------------------------------------------------
    #range (3,4) /* frame 1009 to 1344 */
        #warning "Scene 06\n"
        #include "Scene/Scene06.pov"
    #break // of scene 06.

    //--------------------------------------------------------------------------
    // scene 07 ----------------------------------------------------------------
    //--------------------------------------------------------------------------
    #range (4,5) /* frame 1345 to 1680 */
        #warning "Scene 07\n"
    #break // of scene 07.

    //--------------------------------------------------------------------------
    // scene 08 ----------------------------------------------------------------
    //--------------------------------------------------------------------------
    #range (5,6) /* frame 1681 to 2016 */
        #warning "Scene 08\n"
    #break // of scene 08.

    //--------------------------------------------------------------------------
    // scene 09 ----------------------------------------------------------------
    //--------------------------------------------------------------------------
    #range (6,7) /* frame 2017 to 2352 */
        #warning "Scene 09\n"
    #break // of scene 09.

    #else
        #warning "Else!\n"
#end
