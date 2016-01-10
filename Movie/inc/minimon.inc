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
// parameters and variables ------------------------------------------------
#declare time = clock;

// w.r.t. front view of minimon
#declare offset_arm_right = <-1, 0, 0>;
#declare offset_arm_left = <1, 0, 0>;
#declare offset_foot_right = <-0.5, -1, -0>;
#declare offset_foot_left = <0.5, -1, -0>;
//--------------------------------------------------------------------------
// textures ----------------------------------------------------------------
#declare skin =
texture // Yellow
{
    pigment{ color rgb< 1.0, 0.65, 0.0> }
}

#declare flesh =
texture
{
    pigment{ color rgb< 0.75, 0.0, 0.10> }
}

//--------------------------------------------------------------------------
// body parts --------------------------------------------------------------
#declare eye =
sphere
{
    0, 1
    scale <0.1, 0.2, 0.1>
    texture
    {
        pigment{ color rgb< 0, 0, 0> } //  color Black
        finish { phong 2 }
    }
    scale <1, sin(8*time), 1>    
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

#declare teeth =
torus
{
    0.8, 0.1 
    texture
    {
        pigment{ color White }
    }
    scale <1, 1.5, 1>
}

#declare arm =
object
{
    intersection
    {
        Spheroid(<0, -0.6, 0>, <0.15, 0.3, 0.15>)
        box { <-1, -1, -1>, <0, 1, 1> }
    }
    texture{ skin }         
} 

#declare foot =
intersection
{   
    box
    {
        <-1, 0, -1>, <1, -0.3, 1>
        texture { skin }
    } 
    object
    {
        Spheroid(<0,-0.3,-0.2>, <0.3, 0.3, 0.5>) // (CenterVector, RadiusVector Rx,Ry,Rz)
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
            scale <0.9, 0.9, 0>
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
        arm 
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
        translate offset_foot_right
    }
    object
    {
        foot
        translate offset_foot_left
    }
}