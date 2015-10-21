// This work is licensed under the Creative Commons Attribution 3.0 Unported License.
// To view a copy of this license, visit http://creativecommons.org/licenses/by/3.0/
// or send a letter to Creative Commons, 444 Castro Street, Suite 900, Mountain View,
// California, 94041, USA.

// Persistence Of Vision raytracer version 3.5 sample file.
// File by Alexander Enzmann
//
// -w320 -h240
// -w800 -h600 +a0.3
//
#version 3.7;
global_settings { assumed_gamma 1.0 }

#include "textures.inc"

#declare Cam_Z = -5 * cos(2 * pi * clock);
#declare Cam_X = 5 * sin(2 * pi * clock);

camera {
   location  <Cam_X, 1, Cam_Z>
   right     x*image_width/image_height
   direction <0, 0, 1.7>
   look_at   <0, 0, 0>
}

background { color rgb<1,1,1>*0.02 } 

light_source { <-15, 30, -25> color red 1 green 1 blue 1 }
light_source { < 15, 30, -25> color red 1 green 1 blue 0 }
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
plane{ <0,1,0>, -1
       texture{ pigment{ checker color rgb<1,1,1>*1.2 color rgb<0.25,0.15,0.1>*0}
              //normal { bumps 0.75 scale 0.025}
                finish { phong 0.1}
              } // end of texture
     } // end of plane
     
// BLOB SCENE     
#declare My_X = 0.75 * sin(clock * 8 * pi);

blob {
   threshold 0.6
   component 1.0, 1.0, <My_X, 0, 0>
   component 1.0, 1.0, <-0.375, 0.64952, 0>
   component 1.0, 1.0, <-0.375, -0.64952, 0>

   //pigment { color rgb< 0.0,0.4,0.05> }
   material{
	  texture{
	    pigment{ rgbf<.93,.95,.98,0.825>*0.99}
	    finish { ambient 0.0 diffuse 0.15
	             reflection{0.1,0.1}
	             specular 0.6 roughness 0.005
	             conserve_energy
	           } // end finish
	  } // end of texture
	
	  interior{ ior 1.33
	             fade_power 1001
	             fade_distance 0.5
	             fade_color <0.8,0.8,0.8>
	             caustics 0.16
	   } // end of interior
	 } // end of material
//   finish {
//   	texture{ Polished_Chrome }
//      ambient 0.1
//      diffuse 0.7
//      phong 1
//   }
   rotate 30*y
   normal{ ripples 1.15
             scale 0.03
             turbulence 0.3
             translate<-0.05,0,0>
             rotate<0,-20,0>
           } // end normal

}

// Android robot
#declare Android_Tex = texture { //Polished_Chrome
    pigment{ color rgb<0.4, 1.0, 0.2> } // rgb< 1, 0.0, 0.0>}
    finish { phong 1 reflection {0.05 metallic 0.5}}
} // end of texture

#declare Arm =  union {
                    sphere {<0,0,0>, 0.5}
                    cylinder {<0,-2,0>, <0,0,0>, 0.5}
                    sphere {<0,-2,0>, 0.5}
                    scale<.5,.5,.5>
                }

#declare Leg =  union {
                    sphere {<0,1,0>, 0.5}
                    cylinder {<0,-1,0>, <0,1,0>, 0.5}
                    sphere {<0,-1,0>, 0.5}
                    scale<.35,.35,.35>
                    translate<0,-0.80,0>
                }

#declare Antenna =  union {
                        sphere {<0,2.5,0>, 0.03}
                        cylinder {<0,1.8,0>, <0,2.5,0>, 0.03}
                        sphere {<0,1.8,0>, 0.03}

                    }

union {
	// Rumpf
	cylinder { 
		<0,-0.5,0>, <0,1,0>, 1
	}
	// Eyes
	sphere { <-0.35,1.5,-0.8>, 0.05 pigment { color rgb<0.1,0.1,0.1> } }
	sphere { < 0.35,1.5,-0.8>, 0.05 pigment { color rgb<0.1,0.1,0.1> } }
	// Kopf
	intersection {
		sphere {<0,1,0>, 1}
		box {<-1,2,-1>, <1,1,1>}
		translate<0,0.08,0>
	}
	// Arms
	union { Arm rotate<0,0,-120+20*sin(10*pi*clock)> translate<-1.3,1,0> }
	union { Arm rotate<0,0,+5> translate<+1.3,1,0> }
	// Legs
	union { Leg translate<-0.4,0,0> }
	union { Leg translate< 0.4,0,0> }
	// Antennas
	union { Antenna rotate<0,0, 15> }
	union { Antenna rotate<0,0,-15> }

	texture{Android_Tex}
	scale .5
	translate<0,abs(sin(2*pi*clock)),0>
    rotate<0,50,20 * sin(2*pi*clock)>
	translate<2,-0.35,2>
}

