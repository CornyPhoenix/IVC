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

#declare time = clock;

//--------------------------------------------------------------------------
// TEXTURES ----------------------------------------------------------------
#declare skin =
texture // Yellow
{
    pigment{ color rgb< 1.0, 0.65, 0.0> }
    // finish { phong 1 reflection { 0.1 metallic 0.1 } }
}
/* 
texture
{
    pigment{ color rgb< 0.0, 0.5, 1.0> } //  Greenish Blue 
    finish { phong 2 }
}
*/


#declare flesh =
texture
{
    pigment{ color rgb< 0.75, 0.0, 0.10> }
    // finish { phong 1 reflection { 0.4 metallic 0.2 } }
    // pigment{ color Black }
    // finish { phong 1 reflection { 0.4 metallic 0.5} }
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
        // finish { phong 1 reflection { 0.1 } }
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
            //scale <1, 0.9*cos(8*pi*time)+0.1, 0>
            scale <0.9, 0.9, 0>
            texture { flesh }

        }
    }
}

/*
#declare minimon =
merge
{
    object { upper_head }
    object { lower_head }
    object
    {
        arm // front view, left arm
        translate <-1, -0.4, 0>
    }
    object
    {
        arm // front view, right arm
        rotate <0, 180, 0>
        translate <1, -0.4, 0>
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
}
*/