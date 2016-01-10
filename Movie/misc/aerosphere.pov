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
#include "rand.inc"
//--------------------------------------------------------------------------
// parameters and variables ------------------------------------------------ 
#declare time = clock;
#declare random_numbers = seed (1234); 
//--------------------------------------------------------------------------
// camera ------------------------------------------------------------------
camera
{
	location <0, 0, 0>
	right x*image_width/image_height
	look_at <-10*sin(pi*time),10*cos(pi*time), 0>
	rotate <0, 360*time, 0>
}
//--------------------------------------------------------------------------
// sky ---------------------------------------------------------------------
sky_sphere
{
    pigment
    {   
        image_map
        {
            jpeg "img/sky.jpg"
            map_type 1
        }
	}
} 
//--------------------------------------------------------------------------
// lights ------------------------------------------------------------------
// (source: http://www.joshuarenglish.com/cyclopedia/lookslike.html )
#declare container_space =
cone { <0,0,0>, 2, <0,100,0>, 5 }
 
#declare light_ball =
light_source
{
    <0, 0, 0>
    color rgb <1.0, 1.0, 0.25>
    looks_like
    {
        sphere
        {
            0, 1
            pigment { rgbf 1 } 
            finish { specular 1 }
        }
    }
}

#declare light_balls =
union
{    
    #local counter = 0;
    #local final = 100;
    
    #while (counter < final)
    
    object
    {
        light_ball
        translate VRand_In_Obj(container_space, random_numbers)
    }     
    
    #local counter = counter + 1;
    #end
    object
    {
        light_ball
        translate <0,100,0>
    }
}

object
{
    light_ball
    scale <1+(5*time), 1+(5*time), 1+(5*time)>
    translate <0,25,0>
}

#if (time > 0.15)
object
{
    light_balls
    translate <0, 100-(200*time), 0>
}
#end


