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
#include "inc/minimon.inc"
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
//--------------------------------------------------------------------------
// parameters and variables ------------------------------------------------
#declare time = clock;
//--------------------------------------------------------------------------
// camera ------------------------------------------------------------------
/*
camera
{
    perspective angle 100 // front view
    //location <0.0, 1, ((-8)*time)-5>
    location <0.0, 1, -5>
    right x*image_width/image_height
    look_at <0.0 , 0.0 , 0.0>
    //rotate <0,360*clock, 0>
}
*/
camera
{
    perspective angle 100 // front view
    location <0.0, 0.1, -2>
    right x*image_width/image_height
    look_at <0.0 , 1.0 , 0.0>
    //rotate <0,360*clock, 0>
}                            
//--------------------------------------------------------------------------
// moves ------------------------------------------------------------------
#declare jumpwalking_minimon =
merge
{
    object { upper_head }
    object { lower_head }
    object
    {
        arm
        rotate <0, 0, Flap(time, 1)>
        translate offset_arm_right
    }
    object
    {
        arm
        rotate <0, 180, Flap(time, -1)>
        translate offset_arm_left
    }
    object
    {
        foot
        rotate <Paddle(time), 0, 0>
        translate offset_foot_right
        
    }
    object
    {
        foot
        rotate <Paddle(-time), 0, 0>
        translate offset_foot_left
        
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
        arm
        rotate <Swing(time), 0, 0>
        translate offset_arm_right
    }
    object
    {
        arm
        rotate <Swing(time), 180, 0>
        translate offset_arm_left
    }
    object
    {
        foot
        rotate <Paddle(time), 0, 0>
        translate offset_foot_right
        
    }
    object
    {
        foot
        rotate <Paddle(-time), 0, 0>
        translate offset_foot_left
        
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
        arm
        rotate <0, 0, 0>
        translate offset_arm_right
    }
    object
    {
        arm
        rotate <0, 180, 0>
        translate offset_arm_left
    }
    object
    {
        foot
        rotate <0, 0, 0>
        translate offset_foot_right
        
    }
    object
    {
        foot
        rotate <0, 0, 0>
        translate offset_foot_left
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
        arm
        rotate <0, 0, Flap(time, 1)>
        translate offset_arm_right
    }
    object
    {
        arm
        rotate <0, 180, Flap(time, -1)>
        translate offset_arm_left
    }
    object
    {
        foot
        rotate <Paddle(time), 0, 0>
        translate offset_foot_right
        
    }
    object
    {
        foot
        rotate <Paddle(-time), 0, 0>
        translate offset_foot_left
        
    }
    rotate <0, -39 * sin(8*pi*time), 0>
    translate <sin(16*pi*time), Bounce(time) + 1.3, -8* time>
}

//waiting_minimon
                
