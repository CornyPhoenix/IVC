// PoVRay 3.7 Scene File " ... .pov"
// author:  ...
// date:    ...
//--------------------------------------------------------------------------  
// settings ----------------------------------------------------------------
#version 3.7;
global_settings{ assumed_gamma 1.0 }
#default{ finish{ ambient 0.1 diffuse 0.9 }} 
//--------------------------------------------------------------------------
// includes ----------------------------------------------------------------
#include "colors.inc"
#include "textures.inc" 
#include "rand.inc"
//--------------------------------------------------------------------------
// declares ----------------------------------------------------------------
#declare global_clock = clock; // initial: 0, final: 2

#declare random_x = seed(1234);
#declare random_y = seed(2345);
#declare random_numbers = seed(3456); 
//--------------------------------------------------------------------------
// light source ------------------------------------------------------------
light_source
{
	<-100, 10, 0>
	color rgb <1, 1, 1>
}
//--------------------------------------------------------------------------
// space -------------------------------------------------------------------
sky_sphere
{
    pigment
    {   
        image_map
        {
            png "Textures/stars.png"
            map_type 1
        }
        scale 1000000
	}
}
//--------------------------------------------------------------------------
// earth -------------------------------------------------------------------
sphere
{
    <0, 0, 0>, 5
    pigment
    {
        image_map
        {
            jpeg "Textures/earth.jpg"
            map_type 1
        }
    }
    rotate -80*y
    rotate -10*x
}
//--------------------------------------------------------------------------
// lights ------------------------------------------------------------------

// one light ball
#declare light_ball =  
sphere
{
    0, 1
    pigment { rgbt 1 }
    hollow
    interior
    {
        media
        {
            emission 1
            density
            {
                spherical density_map
                {
                    [0 rgb 0]
                    [0.4 rgb <1,0.5,0>]
                    [0.8 rgb <1,1,0.25>]
                    [1 rgb 1]
                }
            }
        }
    }
}

// a sequence of hundred light balls,
// each one randomly placed around the z-axis
#declare light_balls =
union
{   
    #local scaling_factor = 0.3;   
    #local counter = 1;
    #local final = 100;
    
    object
    {
        light_ball
        //scale scaling_factor
    }
    
    #while (counter < final)
    
    object
    {
        light_ball
        scale scaling_factor
        translate <-1+2*rand(random_x), -1+2*rand(random_y), -counter>
    }     
    #local counter = counter + 1;
    #end
}

//--------------------------------------------------------------------------
// scene 01 ----------------------------------------------------------------
// unidentifiable lights from outer space moving closer to earth
#local scene_switch = 1.5;

#if (global_clock < scene_switch)
    
    #local local_clock = 1/scene_switch * global_clock;
    #local position_camera = <0, 0, -50>;
    #local n = 12;
    #local p1 = 8;
    #local p2 = 9;
    
    object
    {
        light_balls
        translate position_camera + <0, 0, 10*(-p1+n*local_clock)>
    }

    // camera directed to where lights come from
    #if (local_clock < p1/n)
    
        #local another_local_clock = n/p1 * local_clock;
    
        camera
        {
        	location position_camera
        	right image_width/image_height * x
        	look_at position_camera - <0, 0, 1>
        }
    
    #end 
    
    // following the lights while moving camera towards earth
    #if (local_clock >= p1/n & local_clock < p2/n)
    
        #local another_local_clock = local_clock*n - p1;
    
        camera
        {
        	location position_camera
        	right image_width/image_height * x
        	look_at position_camera - another_local_clock * <sin(pi*another_local_clock), 0, cos(pi*another_local_clock)> 
        }
    
    #end
    
    // camera directed towards earth
    #if (local_clock >= p2/n)
     
        #local another_local_clock = local_clock*n - p2;
        
        camera
        {
        	location position_camera
        	right image_width/image_height * x
        	look_at position_camera + <0, 0, 1>
        }
    
    #end    
    
#end

//--------------------------------------------------------------------------
// scene 02 ----------------------------------------------------------------
// unidentifiable lights from outer space reaching earth

#if (global_clock >= scene_switch)

    #local local_clock = (global_clock - scene_switch) * 2;
    
    camera
    {
    	location <0, 7.5*local_clock, -25+(30*local_clock*local_clock)>
    	right x*image_width/image_height
    	look_at <10*sin(pi*local_clock), 0, -10*cos(pi*local_clock)>	
    }
    
    object
    {
        light_balls
        translate <0, 0, -25*(1-local_clock)>
    }
    
    
#end

