//--------------------------------------------------------------------------
// author:  Sibel Toprak, Konstantin Mšllers
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
#include "Informatikum.inc"
//--------------------------------------------------------------------------

// camera ------------------------------------------------------------------
camera{Camera_SO}

// sun ---------------------------------------------------------------------
light_source{<1500,2500,-2500> color White}

// sky ---------------------------------------------------------------------
plane{<0,1,0>,1 hollow  
       texture{ pigment{ bozo turbulence 0.76
                         color_map { [0.5 rgb <0.20, 0.20, 1.0>]
                                     [0.6 rgb <1,1,1>]
                                     [1.0 rgb <0.5,0.5,0.5>]}
                       }
                finish {ambient 1 diffuse 0} }      
       scale 10000}

// fog ---------------------------------------------------------------------
fog{fog_type   2
    distance   50
    color      White
    fog_offset 0.1
    fog_alt    2.0
    turbulence 0.8}

// ground ------------------------------------------------------------------
plane { <0,-0.1,0>, 0 
        texture{ pigment{ color rgb<.24,0.35,0.23> }
	         normal { bumps 0.75 scale 0.015 }
                 finish { phong 0.1 }
               } // end of texture
} // end of plane

//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------

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
				png "texture.png"
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

Haus(A1_x, A1_z, A1_width, A1_depth, A1_levels, A1_color)
Haus(A2_x, A2_z, A2_width, A2_depth, A2_levels, A2_color)
Haus(B1_x, B1_z, B1_width, B1_depth, B1_levels, B1_color)
Haus(B2_x, B2_z, B2_width, B2_depth, B2_levels, B2_color)
Haus(C1_x, C1_z, C1_width, C1_depth, C1_levels, C1_color)
Haus(C2_x, C2_z, C2_width, C2_depth, C2_levels, C2_color)
Haus(C3_x, C3_z, C3_width, C3_depth, C3_levels, C3_color)
Haus(D1_x, D1_z, D1_width, D1_depth, D1_levels, D1_color)
Haus(D2_x, D2_z, D2_width, D2_depth, D2_levels, D2_color)
Haus(F1_x, F1_z, F1_width, F1_depth, F1_levels, F1_color)
Haus(F2_x, F2_z, F2_width, F2_depth, F2_levels, F2_color)
Haus(G_x,  G_z,  G_width,  G_depth,  G_levels,  G_color)
Haus(H_x,  H_z,  H_width,  H_depth,  H_levels,  H_color)
Haus(R_x, R_z, R_width, R_depth, R_levels, R_color)
