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
#include "./Informatikum/Informatikum.inc"
#include "./Minimon/Minimon.inc"
//--------------------------------------------------------------------------
// parameters and variables ------------------------------------------------

#declare global_clock = clock;

#declare FRAMES_PER_SECOND = 24.5;
#declare BPM = 140;

#declare D2_top = <D2_x+0.5*D2_width, level_height*D2_levels, D2_z-D2_depth> + 1*z; 
#declare D2_front = <D2_x+0.5*D2_width, 0, D2_z-D2_depth>;
//--------------------------------------------------------------------------
// macros ------------------------------------------------------------------
#macro  Jump(X)
 #if (X<0.5) abs(sin(2*pi*X))
 #else -20*(X-0.5)
 #end
#end

#macro HandsUp(X, d)
 (-180)*(d)*abs(sin(pi*X)) 
#end 

#macro  Bounce(X)
 abs(sin(32*pi*X))
#end

#macro Flap(X, d)
 (-180)*(d)*abs(sin(32*pi*X))
#end

#macro Paddle(X)
 45*sin(32*pi*X)
#end

#macro Swing(X)
 -90*sin(32*pi*X)
#end

#macro Totter(X)
 -5*sin(32*pi*X)
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

Haus(A1_x, A1_z, A1_width, A1_depth, A1_levels, A1_color)
Haus(A2_x, A2_z, A2_width, A2_depth, A2_levels, A2_color)
Haus(B1_x, B1_z, B1_width, B1_depth, B1_levels, B1_color)
Haus(B2_x, B2_z, B2_width, B2_depth, B2_levels, B2_color)
Haus(C1_x, C1_z, C1_width, C1_depth, C1_levels, C1_color)
Haus(C2_x, C2_z, C2_width, C2_depth, C2_levels, C2_color)
Haus(C3_x, C3_z, C3_width, C3_depth, C3_levels, C3_color)
Haus(D1_x, D1_z, D1_width, D1_depth, D1_levels, D1_color)
Haus(D2_x, D2_z, D2_width, D2_depth, D2_levels, D2_color)
Haus(F1_x, F1_z, F1_width, F1_depth, F1_levels, F1_color)
Haus(F2_x, F2_z, F2_width, F2_depth, F2_levels, F2_color)
Haus(G_x,  G_z,  G_width,  G_depth,  G_levels,  G_color)
Haus(H_x,  H_z,  H_width,  H_depth,  H_levels,  H_color)
Haus(R_x, R_z, R_width, R_depth, R_levels, R_color)

//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------

//--------------------------------------------------------------------------
// scene 01 ----------------------------------------------------------------
// minimon shows itself on top of building D
// walks to the edge of the roof while camera is following
     
#if (global_clock <= 1)

    #local local_clock = global_clock;
    #local distance_edge = <0, 0, 32>;
    
    //minimon
    #if (local_clock < 1/2)
    
        merge
        {
            object { upper_head }
            object { lower_head }
            object
            {
                arm
                rotate <Swing(local_clock), 0, 0>
                translate offset_arm_right
            }
            object
            {
                arm
                rotate <Swing(local_clock), 180, 0>
                translate offset_arm_left
            }
            object
            {
                foot
                rotate <Paddle(local_clock), 0, 0>
                translate offset_foot_right
                
            }
            object
            {
                foot
                rotate <Paddle(-local_clock), 0, 0>
                translate offset_foot_left
                
            }
            //rotate <0, 0, Totter(local_clock)>
            translate D2_top + <0, 0.5*Bounce(local_clock) + 1.3, 0> + distance_edge*(1-local_clock)
        }    
            
    #end
    
    #if (local_clock >= 1/2 & local_clock <= 3/4)

        merge
        {
            object { upper_head }
            object { lower_head }
            object
            {
                arm
                rotate <Swing(local_clock), 0, 0>
                translate offset_arm_right
            }
            object
            {
                arm
                rotate <Swing(local_clock), 180, 0>
                translate offset_arm_left
            }
            object
            {
                foot
                rotate <Paddle(local_clock), 0, 0>
                translate offset_foot_right
                
            }
            object
            {
                foot
                rotate <Paddle(-local_clock), 0, 0>
                translate offset_foot_left
                
            }
            //rotate <0, 0, Totter(local_clock)>
            #local another_local_clock = (local_clock - 1/2) * 4;
            translate D2_top + <0, 0.5*Bounce(local_clock) + 1.3, 0> + 1/4*distance_edge*(1-local_clock)
        }
    #end
    
    #if (local_clock > 3/4)
        // arrived at edge
        object
        {
            minimon
            translate D2_top + <0, 1.3, 0>
        }
    #end
    
    // camera settings
    camera
    {
        right image_width/image_height * x
        
        #local position_camera = D2_top + <0, 15, 0>;
        #local point_focus = D2_top - <0, 0, 1>;
        
        #if (local_clock < 1/4)
        
            location position_camera + 3/4*distance_edge
            look_at point_focus + 3/4*distance_edge
            
        #end 
        
        #if (local_clock >= 1/4 & local_clock < 1/2)
        
            location position_camera + distance_edge*(1-local_clock)
            look_at point_focus + distance_edge*(1-local_clock)

        #end
        
        
        #if (local_clock >= 1/2)
            
            #local another_local_clock = (local_clock - 1/2)*2;
            
            location D2_top - <0, 2*(1-another_local_clock), 3>
            look_at D2_top + <0, 1, 0>
    
        #end       
    }
    
#end 


//--------------------------------------------------------------------------
// scene 02 ----------------------------------------------------------------
 
#if (global_clock > 1 & time <= 2)

    #local local_clock = global_clock - 1;

    object
    {
        minimon
        translate D2_top + <0, 1.3, 0>
    }
    
    camera
    {
        right image_width/image_height * x
        
        #if (local_clock < 1/4)
        
            #local another_local_clock = (local_clock - 1/4) * 4
        
            location D2_top + <0,1+(3-another_local_clock),3>
            look_at D2_top-<0,0,30>-another_local_clock*<0,0,100>
            
        #end 
        
        #if (local_clock >= 1/4 & local_clock < 1/2)
        

        #end
        
        #if (local_clock >= 1/2 & local_clock < 3/4)
        

        #end
        
        
        #if (local_clock >= 1/2)
            
    
        #end
    }
    
    

#end

//--------------------------------------------------------------------------
// scene 03 ----------------------------------------------------------------

/*
#if (global_clock >= 2 & time < 3)
    #local local_time = global_clock - 2;
    
    camera
    {  
        right x*image_width/image_height
        location D2_roof_front_center+<0,1.3,-10>
        look_at D2_roof_front_center+<0,3-20*local_time*local_time,0>
    }
    
    // minimon
    merge
    {
        object { upper_head }
        object { lower_head }
        object
        {
            arm
            rotate <0, 0, HandsUp(local_time, 1)> 
            translate offset_arm_right
            rotate <0,0,-5>
            
        }
        object
        {
            arm
            rotate <0, 180, 0>
            rotate <0, 0, HandsUp(local_time, -1)>
            translate offset_arm_left
            rotate <0,0,5>
            
        }
        object
        {
            foot
            rotate <Paddle(local_time), 0, 0>
            translate offset_foot_right
        }
        object
        {
            foot
            rotate <Paddle(-local_time), 0, 0>
            translate offset_foot_left
        }
        translate D2_roof_front_center + <0,1.3+3*Jump(local_time),1-3*local_time>
    }
#end */

//--------------------------------------------------------------------------
// scene 04 ----------------------------------------------------------------

/*
#if (global_clock >= 3 & global_clock < 4)
    #local local_time = global_clock - 3;
    
    camera
    {
        // perspective angle 100 // front view
        location D2_building_front + <0, 5, ((-8)*time)-40>
        right x*image_width/image_height
        look_at D2_building_front + <0, 1, 0> //rotate <0,360*clock, 0>
    }

    #declare Dx = 4.00; // distance in x
    #declare Dz = 4.00;
    #declare NrX = -3;      // startX
    #declare EndNrX = 4;   // endX
    #while (NrX < EndNrX) // <-- loop X
     #declare NrZ = 0;     // startZ
     #declare EndNrZ = 7;  // endZ
     #while (NrZ < EndNrZ) // <- loop Z
      object{ walking_minimon
              translate D2_building_front - <NrX*Dx, 0, NrZ*Dz>}
     #declare NrZ = NrZ + 1;  // next NrZ
     #end // --------------- end of loop Z
    #declare NrX = NrX + 1;// next NrX
    #end //
    
    object{ walking_minimon
              translate D2_building_front - <0, 0, 8*Dz> }  
#end
*/

