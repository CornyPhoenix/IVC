
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
//--------------------------------------------------------------------------
// camera ------------------------------------------------------------------
#declare Camera_0 = camera {/*ultra_wide_angle*/ angle 100      // front view
                            location  <0.0 , 2.0 ,-3.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
#declare Camera_1 = camera {/*ultra_wide_angle*/ angle 90   // diagonal view
                            location  <2.0 , 2.5 ,-3.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
#declare Camera_2 = camera {/*ultra_wide_angle*/ angle 90 // right side view
                            location  <3.0 , 1.0 , 0.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
#declare Camera_3 = camera {/*ultra_wide_angle*/ angle 90        // top view
                            location  <0.0 , 3.0 ,-0.001>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
#declare Camera_4 = camera {/*ultra_wide_angle*/ angle 80        
                            location  <0.0 , 0.0 , -2.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 0.0 , 0.0>}                            
camera{Camera_4}
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
// fog ---------------------------------------------------------------------
/*fog{fog_type   2
    distance   50
    color      White
    fog_offset 0.1
    fog_alt    2.0
    turbulence 0.8}*/
// ground ------------------------------------------------------------------
/*plane { <0,1,0>, 0 
        texture{ pigment{ color rgb<0.35,0.65,0.0>*0.9 }
	         normal { bumps 0.75 scale 0.015 }
                 finish { phong 0.1 }
               } // end of texture
      } // end of plane*/
//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------



#declare minimon_color =
texture
{
    pigment{ color rgb< 1.0, 0.65, 0.0> }//rgb<1.0, 0.1, 0.20>*1 }
    finish { phong 1 reflection { 0.4 metallic 0.5 } }
}


#declare eye =
sphere
{
    0, 1
    scale <0.1, 0.2, 0.1>
    texture
    {
        pigment{ color Black }
        finish { phong 2 reflection { 0.2 metallic 0.2 } }
    }
}

#declare half_head = 
intersection
{
    sphere { 0, 1 }
    box {
        <-1, 0, -1>, <1, 1, 1> 
        texture
        {
            pigment{ color Black }
            finish { phong 1 reflection { 0.4 metallic 0.2 } }
        }
    }
    texture { minimon_color }    
}

#declare antenna = 
object
{   
    //Round_Cone2( point A, radius A, point B, radius B, merge on) 
    Round_Cone2( <0,0,0>, 0.2, <0,0.6,0>, 0.1, 0 )
    texture{ minimon_color }
}

#declare arm =
object
{
    //Round_Cylinder(point A, point B, Radius, EdgeRadius, UseMerge)
    //Round_Cylinder(<0,0,0>, <0,1.5,0>, 0.1, 0.20, 0)
    Round_Cone2( <0,0,0>, 0.15, <0,0.4,0>, 0.1, 0 )  
    texture{ minimon_color }
} 

#declare foot =
intersection
{   
    box{ <-1, 0, -1>, <1, 1, 1> } 
    object
    {
        //Spheroid(  CenterVector,   RadiusVector Rx,Ry,Rz )
        Spheroid(<0,0,0>,<0.3, 0.3, 0.6> )
        texture{ minimon_color }
    }
}

#declare upper_head =
merge
{
    object { half_head }
/*    object
    {
        antenna
        rotate 50*x //<50,0,-20>
        translate <0.3,0.8,0>
    }
    object
    {
        antenna
        rotate 50*x //<50,0,20>
        translate <-0.3,0.8,0>
    } */
    }

#declare max_y = 0.2;
#declare min_y = 0.1;
#declare max_x = 0.5;
#declare min_x = 0.1;

#declare Angle1 = -20;
#declare Angle2 = -25;

#declare head =
union {
    difference
    {
    		union {
	        sphere { 0, 1 texture{ minimon_color } }
	        object
			    {
			        eye
			        translate -0.98*z
			        rotate <15, 15, 0>
			    }
			    object
			    {
			        eye
			        translate -0.98*z
			        rotate <15, -15, 0>
			    }
    		}
        cone // Mouth
        {
            <0, 0, 0>, 0, // Middle
            <0, 0, -2>, 2  // Outer
            rotate (Angle1 + (Angle2 - Angle1) * pow(sin(2*pi*clock),2)) * x
            scale <(max_x - min_x) * pow(sin(2*pi*clock),2) + min_x, (max_y - min_y) * pow(sin(2*pi*clock),2) + min_y,1>
            texture
            {
                pigment{ color rgb <0.05, 0, 0.01> }
                //finish { phong 1 reflection { 0.4 metallic 0.5} }
                //finish { phong 1 }
            }
        }
    }
    object { foot
            translate <.5, -.9, 0> }
    object { foot
            translate <-.5, -.9, 0> }
    object
    {
        arm
        rotate <0,0,110>
        translate <-0.8, 0, -0.4>
    }
    object
    {
        arm
        rotate <0,0,-110>
        translate <0.8, 0, -0.4>
    }
}



union {
//object { upper_head }
object { head }
torus // Teeth
			{
	        0.9, 0.05 
	        texture
	        {
	            pigment{ color White }
	            //finish { phong 1 reflection 0.00 }
	            finish { phong 1 reflection { 0.1 } }
	            //finish { phong 1 }
	        }
	        scale <1,1.5,1>
	    }

//rotate 45*y
//translate 1.5*y
//rotate -10*x
}
 
