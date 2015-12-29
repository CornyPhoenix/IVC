//--------------------------------------------------------------------------
// scene -------------------------------------------------------------------
// PoVRay 3.7 Scene File " ... .pov"
// author:  ...
// date:    ...
//--------------------------------------------------------------------------
#version 3.7;
global_settings{ assumed_gamma 1.0 }
#default{ finish{ ambient 0.1 diffuse 0.9 }}
//--------------------------------------------------------------------------
// includes ---------------------------------------------------------------- 
#include "inc/moves.inc"
//--------------------------------------------------------------------------
// parameters and variables ------------------------------------------------ 
#declare time = clock;          
//--------------------------------------------------------------------------
// camera ------------------------------------------------------------------

/*camera
{
	perspective angle 100
	location <0, 0, -5>
	right x*image_width/image_height
	look_at <0, 0, 0>
	rotate <0, 360*time, 0>
}*/ 


// PoVRay 3.7 Scene File " ... .pov"
// author:  ...
// date:    ...
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
// sun ----------------------------------------------------------------------
light_source{< 300,300,-300> color White}
// sky ----------------------------------------------------------------------
sky_sphere { pigment { gradient <0,1,0>
                       color_map { [0.00 rgb <0.6,0.7,1.0>]
                                   [0.35 rgb <0.1,0.0,0.8>]
                                   [0.65 rgb <0.1,0.0,0.8>]
                                   [1.00 rgb <0.6,0.7,1.0>] 
                                 } 
                       scale 2         
                     } // end of pigment
           } //end of skysphere
// ground -------------------------------------------------------------------
plane{ <0,1,0>, 0 
       texture{ pigment{ checker color rgb<1,1,1>*1.2 color rgb<0.25,0.15,0.1>*0}
              //normal { bumps 0.75 scale 0.025}
                finish { phong 0.1}
              } // end of texture
     } // end of plane
// end of sphere ----------------------------------- 

camera
{
    // perspective angle 100 // front view
    location <0.0, 5, ((-8)*time)-10> // location <0.0, 1, -5>
    right x*image_width/image_height
    look_at <0.0 , 1 , 0.0> //rotate <0,360*clock, 0>
} 


#declare Dx = 4.00; // distance in x
#declare Dz = 4.00;
#declare NrX = -3;      // startX
#declare EndNrX = 4;   // endX
#while (NrX < EndNrX) // <-- loop X
 #declare NrZ = 0;     // startZ
 #declare EndNrZ = 7;  // endZ
 #while (NrZ < EndNrZ) // <- loop Z
  object{ walking_minimon
          translate<NrX*Dx, 0, NrZ*Dz>}
 #declare NrZ = NrZ + 1;  // next NrZ
 #end // --------------- end of loop Z
#declare NrX = NrX + 1;// next NrX
#end //


