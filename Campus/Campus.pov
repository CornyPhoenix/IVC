//--------------------------------------------------------------------------
// author:  Sibel Toprak, Konstantin M�llers
// date:    2016-01-01
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
//-----
//#include "./Informatikum/Informatikum.inc"
#include "./Minimon/Minimon.inc"
//--------------------------------------------------------------------------
// parameters and variables ------------------------------------------------

#declare global_clock = clock;

#declare FRAMES_PER_SECOND = 24.5;
#declare BPM = 140;

#declare D2_top = <D2_x+0.5*D2_width, level_height*D2_levels, D2_z-D2_depth> + <0,0,1>;
#declare D2_front = <D2_x+0.5*D2_width, 0, D2_z-D2_depth>; 
#declare offset_minimon = <0, 1.3, 0>;  
//--------------------------------------------------------------------------
// macros ------------------------------------------------------------------
#macro  Jump(X)
 #if (X<0.5) abs(sin(2*pi*X))
 #else -20*(X-0.5)
 #end
#end

#macro HandsUp(X, d)
 (-165)*(d)*abs(sin(0.5*pi*X)) 
#end 

#macro  Bounce(time, number)
 abs(sin(number*pi*time))
#end

#macro Flap(time, number)
 -180*abs(sin(number*pi*time))
#end

#macro Paddle(time, number)
 45*sin(number*pi*time)
#end

#macro Swing(time, number)
 -90*sin(number*pi*time)
#end

#macro Totter(time, number)
 -5*sin(number*pi*time)
#end

#macro Breathe(X)
 abs(sin(2*pi*X))
#end

//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------

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
//--------------------------------------------------------------------------
// sky ---------------------------------------------------------------------
sky_sphere
{
    pigment
    {   
        image_map
        {
            jpeg "./Textures/sky.jpg"
            map_type 1
        }
	}
}
// fog ---------------------------------------------------------------------
fog{fog_type   2
    distance   50
    color      White
    fog_offset 0.1
    fog_alt    2.0
    turbulence 0.8}

// ground ------------------------------------------------------------------
plane { <0,-0.1,0>, 0 
        texture{ pigment{ color rgb<.24,0.35,0.23> }
	         normal { bumps 0.75 scale 0.015 }
                 finish { phong 0.1 }
               } // end of texture
} // end of plane



// Ground
box {
	<0,0,0>
	<1,1,0.1>
	/*texture{ pigment{ color rgb<.24,0.45,0.23>*0.67 }
	         normal { bumps 0.75 scale .000017647 }
               }*/
//	texture {
//		pigment {
//			image_map {
//				png "./Textures/texture.png"
//				map_type 0
//				interpolate 2
//		    }
//		}
//	}
	scale <1800, 1800, 1>
	rotate -90*x
	rotate 180*y
	translate <1800, 0, 0>
}

//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------
#include "Informatikum/Informatikum4.pov"

#switch (clock)

    //--------------------------------------------------------------------------
    // scene 03 ----------------------------------------------------------------
    // minimon shows itself on top of building D
    // walks to the edge of the roof while camera is following
    #range (0,1)
        #warning "Scene 03"
        #local local_clock = global_clock;
        #local distance_edge = <0, 0, 24>;
        
        //minimon
        #if (local_clock <= 3/4)
            
            #local another_local_clock = 4/3 * local_clock;
            #local n = 32;
        
            merge
            {
                object { upper_head }
                object { lower_head }
                object
                {
                    arm
                    rotate <Swing(local_clock, n), 0, 0>
                    translate offset_arm_right
                }
                object
                {
                    arm
                    rotate <Swing(local_clock, n), 180, 0>
                    translate offset_arm_left
                }
                object
                {
                    foot
                    rotate <Paddle(local_clock, n), 0, 0>
                    translate offset_foot_right
                    
                }
                object
                {
                    foot
                    rotate <Paddle(-local_clock, n), 0, 0>
                    translate offset_foot_left
                    
                }
                //rotate <0, 0, Totter(local_clock)>
                translate D2_top + offset_minimon + <0, 0.5*Bounce(local_clock, n), 0> + distance_edge*(1-another_local_clock)
            }    
                
        #end
        
        #if (local_clock > 3/4)
        
            // minimon arrived at edge
            object
            {
                minimon
                translate D2_top + offset_minimon
            }
        
        #end   
        
        // camera settings
        camera
        {
            right image_width/image_height * x
            
            #local position_camera = D2_top + <0, 15, 0>;
            #local point_focus = D2_top - <0, 0, 1>;
            
            #if (local_clock < 1/4)
            
                location position_camera + 2/3*distance_edge
                look_at point_focus + 2/3*distance_edge
                
            #end
            
            #if (local_clock >= 1/4 & local_clock < 2/4)
            
                #local another_local_clock = (local_clock - 1/4)*4; 
            
                location position_camera + 2/3*distance_edge*(1-another_local_clock)
                look_at point_focus + 2/3*distance_edge*(1-another_local_clock)
    
            #end
            
            
            #if (local_clock >= 2/4)
                
                #local another_local_clock = (local_clock - 1/2)*2;
                
                location D2_top - <0, 2*(1-another_local_clock), 3>
                look_at D2_top + <0, 1, 0>
        
            #end       
        }        

    #break // of scene 03.

    //--------------------------------------------------------------------------
    // scene 04 ----------------------------------------------------------------
    #range (1,2)
        #warning "Scene 04"

        #local local_clock = global_clock - 1;

        object
        {
            minimon
            translate D2_top + offset_minimon
        }
        
        camera
        {
            right image_width/image_height * x
            
            #if (local_clock < 1/4)
            
                #local another_local_clock = 4*local_clock;
            
                location D2_top + <0, 4-another_local_clock, 3>
                look_at D2_top-<0,0,50>-another_local_clock*<0,0,100>
                // look_at D2_top-<0,0,100>
                
            #end 
            
            #if (local_clock >= 1/4 & local_clock < 1/2)
            
    
            #end
            
            #if (local_clock >= 1/2 & local_clock < 3/4)
            
    
            #end
            
            
            #if (local_clock >= 1/2)
                
        
            #end
        } 
          
    #break // of scene 04.

    //--------------------------------------------------------------------------
    // scene 05 ----------------------------------------------------------------
    //--------------------------------------------------------------------------
    #range (2,3)
        #warning "Scene 05"
        

        #local local_clock = global_clock - 2;
        #local distance_jump = <0, 0, -25>;
        
        // jumping off roof
            #if (local_clock < 1/4)
            
                #local another_local_clock = 4* local_clock;
            
                //todo: zoom on minimon's face or sth
                
            #end
            
            // pov of minimon while falling to the ground
            #if (local_clock >= 1/4 & local_clock < 2/4)
            
                #local another_local_clock = (local_clock - 1/4) * 4;
                
                camera
                {  
                    right image_width/image_height * x
                    location D2_top + offset_minimon + distance_jump*another_local_clock + <0, 0, -5>
                    look_at D2_top + <0,5*Jump(another_local_clock),0>
                    // look_at D2_top + <0,3-20*pow(another_local_clock, 2),0>
                }
                
                // minimon
                merge
                {
                    object { upper_head }
                    object { lower_head }
                    object
                    {
                        arm
                        rotate <0, 0, HandsUp(another_local_clock, 1)> 
                        translate offset_arm_right
                        rotate <0,0,-5>
                        
                    }
                    object
                    {
                        arm
                        rotate <0, 180, 0>
                        rotate <0, 0, HandsUp(another_local_clock, -1)>
                        translate offset_arm_left
                        rotate <0,0,5>
                        
                    }
                    object
                    {
                        foot
                        rotate <Paddle(another_local_clock, 8), 0, 0>
                        translate offset_foot_right
                    }
                    object
                    {
                        foot
                        rotate <Paddle(-another_local_clock, 8), 0, 0>
                        translate offset_foot_left
                    }
                    
                    translate D2_top + offset_minimon + distance_jump*another_local_clock + <0, 3*Jump(another_local_clock), 0>   
                }
                
            #end
            
            // minimon finally landed in front of a minimon crowd
            #if (local_clock >= 2/4 & local_clock < 3/4)
            
                #local another_local_clock = (local_clock - 2/4) * 4;
                
                #local height = <0, 10, 0>;
                
                camera
                {  
                    right image_width/image_height * x
                    location D2_front + offset_minimon + distance_jump + <0, 0, -5*pow(another_local_clock,2)>
                    look_at D2_front + offset_minimon + height*(1-another_local_clock) + distance_jump 
                }
                
                // leading minimon
                merge
                {
                    object { upper_head }
                    object { lower_head }
                    object
                    {
                        arm
                        rotate <0, 0, HandsUp(another_local_clock, -1)> 
                        translate offset_arm_right
                        rotate <0,0,-5>
                        
                    }
                    object
                    {
                        arm
                        rotate <0, 180, 0>
                        rotate <0, 0, HandsUp(another_local_clock, 1)>
                        translate offset_arm_left
                        rotate <0,0,5>
                        
                    }
                    object
                    {
                        foot
                        rotate <Paddle(another_local_clock, 8), 0, 0>
                        translate offset_foot_right
                    }
                    object
                    {
                        foot
                        rotate <Paddle(-another_local_clock, 8), 0, 0>
                        translate offset_foot_left
                    }
                    
                    translate D2_front + offset_minimon + height*(1-another_local_clock) + distance_jump   
                }
                
                //todo: army of minimons in the background
                
                  
            #end    
    
            
            // all the minimon's start marching
            #if (local_clock > 3/4)
            
                #local another_local_clock = (local_clock - 3/4) * 4;
            
                camera
                {
                    right image_width/image_height * x
                    
                    location D2_front + <0, 5, ((-8)*another_local_clock)-40>
                    look_at D2_front + <0, 1, 0> //rotate <0,360*clock, 0>
                }
                
                #local Dx = 4.00;
                #local Dz = 4.00;
                #local NrX = -3;
                #local EndNrX = 4;
                #while (NrX < EndNrX)
                    #local NrZ = 0;
                    #local EndNrZ = 7;
                    #while (NrZ < EndNrZ)
                        object
                        {
                            minimon
                            translate D2_front - <NrX*Dx, 0, NrZ*Dz>
                        }
                        #local NrZ = NrZ + 1;
                    #end
                    #local NrX = NrX + 1;
                #end
                
                object
                { 
                    minimon
                    translate D2_front - <0, 0, 8*Dz>
                }
                
            #end
    
    #break // of scene 05.

    //--------------------------------------------------------------------------
    // scene 06 ----------------------------------------------------------------
    //--------------------------------------------------------------------------
    #range (3,4)
        #warning "Scene 06\n"
    #break // of scene 06.

    //--------------------------------------------------------------------------
    // scene 07 ----------------------------------------------------------------
    //--------------------------------------------------------------------------
    #range (4,5)
        #warning "Scene 07\n"
    #break // of scene 07.

    //--------------------------------------------------------------------------
    // scene 08 ----------------------------------------------------------------
    //--------------------------------------------------------------------------
    #range (5,6)
        #warning "Scene 08\n"
    #break // of scene 08.

    //--------------------------------------------------------------------------
    // scene 09 ----------------------------------------------------------------
    //--------------------------------------------------------------------------
    #range (6,7)
        #warning "Scene 09\n"
    #break // of scene 09.

    #else
        #warning "Else!\n"
#end