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

#declare Window_Glass =  //--------------------------------------------- no IOR window glass texture
      texture { pigment{ rgbf <0.98, 0.98, 0.98, 0.9> }
                finish { diffuse 0.1 reflection 0.2  
                         specular 0.8 roughness 0.0003 phong 1 phong_size 400}
               } // end of texture ------------------------------------------------------------------

//
// Alle Maﬂe sind gegeben in Dezimetern (10 dm = 1 m).
//

//--------------------------------------------------------------------------
// positions ---------------------------------------------------------------
#declare HausF_H = 150.0;
#declare HausF_Pos = <630.576, HausF_H/2, -319.864>;

#declare Camera_Pos = <550, 50.0,-500>;

//--------------------------------------------------------------------------
// camera ------------------------------------------------------------------
#declare Camera = camera {/*ultra_wide_angle*/ angle 100      // front view
                            location  Camera_Pos
                            right     x*image_width/image_height
                            look_at   HausF_Pos}                       
camera{Camera}
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
	scale <862, 850, 1>
	rotate -90*x
	rotate 180*y
	translate <862, 0, -850>
}

// Haus A
union {
	box {
		<309.002,0,-809.424>
		<399.412,90,-742.637>
	}
	box {
		<266.365,0,-773.457>
		<308.831,30,-746.748>
	}
	box {
		<225.267,0,-773.457>
		<266.365,30,-697.432>
	}
	texture { pigment { color Blue } }
}

// Haus B
box {
	<78.348,0,-698.457>
	<267.391,60,-642.979>
	texture { pigment { color Red } }
}

// Haus C
union {
	box {
		<34.686,00,-562.334>
		<99.754,60,-372.607>
	}
	box {
		<099.754,00,-403.086>
		<192.903,30,-373.037>
	}
	texture { pigment { color Green } }
}


// Haus D
union {
	box {
		<192.903,00,-426.709>
		<528.865,60,-364.043>
	}
	box {
		<350.000,00,-440.000>
		<400.000,60,-426.709>
	}
	texture { pigment { color Yellow } }
}


// Haus E

// :'-(

#declare HausF_Ziegel = texture{
                          pigment{ brick
                                   color White  // Fugenfarbe
                                   color rgb<0.8,0.25,0.1>// Ziegelfarbe
                                   brick_size <1.6, 0.6, 0.125 >
                                   // Ziegelformat in x-,y-,z-Richtung
                                   mortar 0.02 // Fugendicke 
                                 }
                          normal { wrinkles 0.75 scale 0.01}
                          finish { diffuse 0.9 phong 0.2}
                        }// end of texture

// Haus F
union {
    merge {
        box {
        	<600,00,-450>
        	<670,HausF_H,-180>
        	texture { pigment { color White } }
        	hollow on
        }
        box {
        	<610,10,-450.1>
        	<635,20,-180>
        	texture { Window_Glass }
        }
    }
    box {
    	<598,00,-452>
    	<610,HausF_H,-420>
    	texture { HausF_Ziegel }
    }
    box {
    	<635,00,-452>
    	<670,HausF_H,-420>
    	texture { HausF_Ziegel }
    }
}

// Haus G
box {
	<761.057,00,-683.564>
	<829.890,60,-345.547>
	texture { pigment { color Orange } }
}

// Haus H
box {
	<665.505,00,-411.299>
	<759.001,30,-373.291>
	texture { pigment { color Cyan } }
}