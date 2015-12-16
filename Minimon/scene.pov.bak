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
#include "minimon.inc"
//--------------------------------------------------------------------------
// macros ------------------------------------------------------------------

#macro  Bounce(X)
 abs(sin(8*pi*X))
#end

#macro Flap(X, d)
 (-180)*(d)*abs(sin(8*pi*X))
#end

#macro Paddle(X)
 45*sin(8*pi*X)
#end

#macro Swing(X)
 -90*sin(8*pi*X)
#end

#macro Totter(X)
 -5*sin(8*pi*X)
#end

#macro Breathe(X)
 abs(sin(2*pi*X))
#end

#declare time = clock;
//--------------------------------------------------------------------------
// camera ------------------------------------------------------------------
#declare Camera_0 = camera {perspective angle 100               // front view
                            //location  <0.0, 1, ((-8)*time)-5>
                            location  <0.0, 1, -5>
                            right     x*image_width/image_height
                            look_at   <0.0 , 0.0 , 0.0>
                            //rotate <0,360*clock, 0>
                            }
#declare Camera_1 = camera {/*ultra_wide_angle*/ angle 90   // diagonal view
                            location  <2.0 , 2.5 ,-3.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
#declare Camera_2 = camera {/*ultra_wide_angle*/ angle 90  //right side view
                            location  <3.0 , 1.0 , 0.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
#declare Camera_3 = camera {/*ultra_wide_angle*/ angle 90        // top view
                            location  <0.0 , 3.0 ,-0.001>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
#declare Camera_4 = camera {perspective angle 75               // front view
                            location  <0.0 , 1.0 ,-3.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
#declare Frosch = camera {perspective angle 100               // front view
                            //location  <0.0, 1, ((-8)*time)-5>
                            location  <0.0, 0.1, -2>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>
                            //rotate <0,360*clock, 0>
                            }                            
camera{Frosch}
// sun ----------------------------------------------------------------------
light_source{< 3000,3000,-3000> color White}
// sky ----------------------------------------------------------------------
//sky_sphere { pigment { gradient <0,1,0>
//                       color_map { [0.00 rgb <0.6,0.7,1.0>]
//                                   [0.35 rgb <0.1,0.0,0.8>]
//                                   [0.65 rgb <0.1,0.0,0.8>]
//                                   [1.00 rgb <0.6,0.7,1.0>] 
//                                 } 
//                       scale 2         
//                     } // end of pigment
//           } //end of skysphere
// ground -------------------------------------------------------------------
//plane{ <0,1,0>, 0 
//       texture{ pigment{ checker color rgb<1,1,1>*1.2 color rgb<0.25,0.15,0.1>*0}
//              //normal { bumps 0.75 scale 0.025}
//                finish { phong 0.1}
//              } // end of texture
//     } // end of plane
     
//---------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//---------------------------------------------------------------------------

#declare jumpwalking_minimon =
merge
{
    object { upper_head }
    object { lower_head }
    object
    {
        arm // front view, left arm
        rotate <0, 0, Flap(time, 1)>
        translate <-1, 0, 0>
    }
    object
    {
        arm // front view, right arm
        rotate <0, 180, Flap(time, -1)>
        translate <1, 0, 0>
    }
    object
    {
        foot // front view, left foot
        rotate <Paddle(time), 0, 0>
        translate <-0.4, -1, -0.2>
        
    }
    object // front view, right foot
    {
        foot
        rotate <Paddle(-time), 0, 0>
        translate <0.4, -1, -0.2>
        
    }
    translate <0, Bounce(time) + 1.3, -8* time>
}

#declare walking_minimon =
merge
{
    object { upper_head }
    object { lower_head }
    object
    {
        arm // front view, left arm
        rotate <Swing(time), 0, 0>
        translate <-1, 0, 0>
    }
    object
    {
        arm // front view, right arm
        rotate <Swing(time), 180, 0>
        translate <1, 0, 0>
    }
    object
    {
        foot // front view, left foot
        rotate <Paddle(time), 0, 0>
        translate <-0.4, -1, -0.2>
        
    }
    object // front view, right foot
    {
        foot
        rotate <Paddle(-time), 0, 0>
        translate <0.4, -1, -0.2>
        
    }
    rotate <0, 0, Totter(time)>
    translate <0, (0.5 * Bounce(time)) + 1.3, -8* time>
}

#declare waiting_minimon =
merge
{   
    merge
    {
        object { upper_head }
        object { lower_head }
        translate <0, 0.05 * Breathe(time), 0>
    }
    object
    {
        arm // front view, left arm
        rotate <0, 0, 0>
        translate <-1, 0, 0>
    }
    object
    {
        arm // front view, right arm
        rotate <0, 180, 0>
        translate <1, 0, 0>
    }
    object
    {
        foot // front view, left foot
        rotate <0, 0, 0>
        translate <-0.4, -1, -0.2>
        
    }
    object // front view, right foot
    {
        foot
        rotate <0, 0, 0>
        translate <0.4, -1, -0.2>
    }
    translate <0, 1.3, 0>
}

#declare crossstepping_minimon =
merge
{
    object { upper_head }
    object { lower_head }
    object
    {
        arm // front view, left arm
        rotate <0, 0, Flap(time, 1)>
        translate <-1, 0, 0>
    }
    object
    {
        arm // front view, right arm
        rotate <0, 180, Flap(time, -1)>
        translate <1, 0, 0>
    }
    object
    {
        foot // front view, left foot
        rotate <Paddle(time), 0, 0>
        translate <-0.4, -1, -0.2>
        
    }
    object // front view, right foot
    {
        foot
        rotate <Paddle(-time), 0, 0>
        translate <0.4, -1, -0.2>
        
    }
    rotate <0, -39 * sin(8*pi*time), 0>
    translate <sin(16*pi*time), Bounce(time) + 1.3, -8* time>
}

waiting_minimon
                
