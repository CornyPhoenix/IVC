// PoVRay 3.7 Scene File " ... .pov"
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
//camera{Camera_0}
camera
{ location <0,0,-5>
  look_at 0
  rotate <0,clock*360,0>
}
// sun ---------------------------------------------------------------------
light_source{<15,15,-15> color White}
//--------------------------------------------------------------------------
// Set a color of the background (sky)
//background { color rgb< 1, 1, 1> }
   
 // sky ---------------------------------------------------------------
plane{<0,1,0>,1 hollow  
       texture{ pigment{ bozo turbulence 0.92
                         color_map { [0.00 rgb <0.25, 0.35, 1.0>*0.7]
                                     [0.50 rgb <0.25, 0.35, 1.0>*0.7]
                                     [0.70 rgb <1,1,1>]
                                     [0.85 rgb <0.25,0.25,0.25>]
                                     [1.0 rgb <0.5,0.5,0.5>]}
                        scale<1,1,1.5>*2.5  translate< 0,0,0>
                       }
                finish {ambient 1 diffuse 0} }      
       scale 10000}
// fog on the ground ------------------------- end of sky with clouds
fog { fog_type   2
      distance   100
      color      White*0.5  
      fog_offset 0.1
      fog_alt    2.0
      turbulence 1.8
    }
//------------------------------------------------- end of ground fog

//--------------------------------------------------------------------------
// TEXTURES ----------------------------------------------------------------
#declare skin =
/*texture // Yellow
{
    pigment{ color rgb< 1.0, 0.65, 0.0> }
    finish { phong 1 reflection { 0.4 metallic 0.5 } }
} */ 
texture
{
    pigment{ color rgb< 0.0, 0.5, 1.0> } //  Greenish Blue 
    // normal { bumps 0.5 scale 0.05 }
    finish { phong 2 }
}


#declare flesh =
texture
{
    pigment{ color rgb< 0.75, 0.0, 0.10> }
    finish { phong 1 reflection { 0.4 metallic 0.2 } }
    /* pigment{ color Black }
    finish { phong 1 reflection { 0.4 metallic 0.5} } */
}

//--------------------------------------------------------------------------
// BODY PARTS --------------------------------------------------------------
#declare eye =
sphere
{
    0, 1
    scale <0.1, 0.2, 0.1>
    /*texture
    {
        pigment{ color Black }
        finish { phong 1  reflection { 0.2 metallic 0.2 } }
    }*/
    texture
    {
        pigment{ color rgb< 1, 1, 1>*0.00 } //  color Black
        // normal { bumps 0.5 scale 0.05 }
        finish { phong 2 }
    }    
}

#declare half_head = 
intersection
{
    sphere { 0, 1 }
    box {
        <-1, 0, -1>, <1, 1, 1> 
        texture { flesh }
    }
    texture { skin }    
}

#declare antenna = 
object
{
    Round_Cone2( <0,0,0>, 0.2, <0,0.6,0>, 0.1, 0 ) // (point A, radius A, point B, radius B, merge on)
    texture{ skin }
}

#declare teeth =
torus
{
    0.8, 0.1 
    texture
    {
        pigment{ color White }
        finish { phong 1 reflection { 0.1 } }
    }
    scale <1, 1.5, 1>
}

#declare arm =
object
{
    // Round_Cone2( <0,0,0>, 0.15, <0,0.4,0>, 0.1, 0 )
    intersection
    {
        Spheroid(<0, 0, 0>, <0.15, 0.3, 0.15>)
        box { <-1, -1, -1>, <0, 1, 1> }
    }
    texture{ skin }
    translate y * (-0.3)          
} 

#declare foot =
intersection
{   
    box { <-1, 0, -1>, <1, 1, 1> } 
    object
    {
        Spheroid(<0,0,0>, <0.3, 0.3, 0.6>) // (CenterVector, RadiusVector Rx,Ry,Rz)
        texture{ skin }
    }
}

#declare upper_head =
merge
{
    object { half_head }
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
    object
    {
        teeth
    }
}

#declare lower_head =
merge {
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
            scale <0.9, 0.8, 0>
            texture { flesh }

        }
    }
}


#declare minimon =
merge
{
    object { upper_head }
    object { lower_head }
    object
    {
        arm // front view, left arm
        translate <-1, -0.4, 0>
        rotate 180*x
    }
    object
    {
        arm // front view, right arm
        //rotate <, 180, 0>
        translate <1, -0.4, 0>
        rotate 180*x
    }
    object
    {
        foot // front view, left foot
        translate <-0.3, -1.2, -0.2>
    }
    object // front view, right foot
    {
        foot
        translate <0.3, -1.2, -0.2>
    }
    
    // translate 1.5*y
}

minimon

//--------------------------------------------------------------------------
// MISC --------------------------------------------------------------------

/*#declare max_y = 0.5;
#declare min_y = 0.1;
#declare max_x = 0.6;
#declare min_x = 0.3;

#declare lower_head =
difference
{
    object
    {
        arm
        rotate <0,0,110>
        translate <-0.8, 0, -0.4>
    }
    object
    {
        
        <0, 0, -1>, 1, <0, 0, 0.7>, 0
        // scale <1,0.75,1>
        scale <(max_x - min_x) * pow(sin(2*pi*clock),2) + min_x, (max_y - min_y) * pow(sin(2*pi*clock),2) + min_y,1>
        texture
        {
            pigment{ color rgb<0.05,0.0,0.01> }
            //finish { phong 1 reflection { 0.4 metallic 0.5} }
            //finish { phong 1 }
        }
    } 
}*/