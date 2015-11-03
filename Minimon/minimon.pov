
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









// sample sphere 


/**sphere { <0,1,0>, 1.00 
         pigment { color Yellow } 
         scale<1.5,1,1>
       }
**/


/*#declare eye =
merge
{
    sphere
    {
        0, 1
        pigment { color White }
    }
    sphere
    {
        <0, 0, -2> , 0.5
        texture
        {
            pigment{ color rgb< 1, 1, 1>*0.00 } //  color Black
            finish { phong 1 }
        }
        scale 0.4*z
    }
    
}



#declare head =
union
{
    sphere
    {
        0, 1
        pigment { color Pink }
        scale 1.3*x
    }
    object
    {
        eye
        scale <0.3 ,0.3, 0.2>
        rotate 30*y
        translate -1*z
        rotate -30*y
    }
    object
    {
        eye
        scale <0.2 ,0.2, 0.1>
        rotate -30*y
        translate -1*z
        rotate 30*y
    }
    translate 1*y
}

head*/
#declare eye =
sphere
{
    0, 1
    texture
    {
        pigment{ color Black }
        finish { phong 1 }
        finish { phong 1 reflection { 0.4 metallic 0.5} }
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
            //finish { phong 1 }
            finish { phong 1 reflection { 0.4 metallic 0.5} }
        }
    }
    /*texture
    {
        pigment{ color rgb< 1.0, 0.65, 0.0> } 
        finish { phong 1 reflection 0.00 }
    }*/
    texture
    {
        pigment{ color rgb<1.0, 0.1, 0.20>*1 }
        finish { phong 1 reflection { 0.4 metallic 0.5} }
    }
}

#declare upper_head =
merge
{
    object { half_head }
    object
    {
        eye
        scale <0.1, 0.2, 0.1>
        translate -0.98*z
        rotate <20, 20, 0>
        
    }
    object
    {
        eye
        scale <0.1, 0.2, 0.1>
        translate -0.98*z
        rotate <20, -20, 0>
    }
    torus
    {
        0.8, 0.1 
        texture
        {
            pigment{ color White }
            //finish { phong 1 reflection 0.00 }
            finish { phong 1 reflection { 0.4 metallic 0.5} }
            //finish { phong 1 }
        }
        scale <1,1.5,1>
    }
}

#declare max_y = 0.5;
#declare min_y = 0.1;

#declare lower_head =
difference
{
    object
    {
        half_head
        rotate 180*z
    }
    cone
    {
        <0, 0, -1>, 1, <0, 0, 0.7>, 0
        // scale <1,0.75,1>
        scale <.7, (max_y - min_y) * pow(sin(2*pi*clock),2) + min_y,1>
        texture
        {
            pigment{ color Black }
            finish { phong 1 reflection { 0.4 metallic 0.5} }
            //finish { phong 1 }
        }
    }
}



/*
intersection
{
    box
    {
        <-1, 0, -1> , <1, 0, 1>
        texture
        {
            pigment{ color rgb<1.00, 1.00, 1.00>}  
            finish { phong 1 reflection{ 0.00 metallic 0.00 } } 
        }
    }
    sphere
    {
        0, 1
        texture
        {
            pigment{ color rgb<1.00, 0.55, 0.00>}
            finish { phong 1.0 reflection 0.00}
        }  
    }  
}*/

merge {
object { upper_head }
object { lower_head }
//rotate clock*360*y
rotate -10*x
}
 
