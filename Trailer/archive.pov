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

camera
{
    //location <0 , 100*(1-time), 0>
    //look_at <0, 1000, 0>
    location <0 ,0 , -5>
    look_at <0, 0, 0>
    rotate <0, 360*time, 0>
}

//--------------------------------------------------------------------------
// sun ---------------------------------------------------------------------
light_source{< 3000,3000,-3000> color White}
//--------------------------------------------------------------------------
// sky ---------------------------------------------------------------------
sky_sphere
{
    pigment
    {
        gradient <0,1,0>
        color_map
        {
            [0.00 rgb <0.6,0.7,1.0>]
            [0.35 rgb <0.1,0.0,0.8>]
            [0.65 rgb <0.1,0.0,0.8>]
            [1.00 rgb <0.6,0.7,1.0>] 
        }
        scale 2
    }
}

// clouds by media ---------------------
sphere
{
    0, 10
    //<-1,-1,-1>, <1,1,1>
    texture
    {
        pigment{ rgbf 1 } // color Clear
    } // end of texture
    interior
    {
        media
        {
            method 3
            //intervals 2
            samples 10,10
            absorption 1
            emission 0.5
            scattering { 0.8, <1,1,1>*0.5 }
            density
            {
                bozo
                color_map
                {
                    [0.00 rgb 0]
                    [0.50 rgb 0.01]
                    [0.65 rgb 0.1]
                    [0.75 rgb 0.5]
                    [1.00 rgb 0.2]
                } // end color_map
                turbulence 0.85
                scale  0.75
                translate<1, 0.75,2>
            } // end density
            density
            {
                boxed // or: spherical
                color_map
                {
                    [0.0 rgb 0]    // border
                    [0.1 rgb 0.05]
                    [1.0 rgb 1]    // center
                } // end color_map
                scale <1,1,1>*1
            } // end density
        } // end media
    } // end interior
    hollow
    scale<1,0.5, 1>
    translate<0,0.5,0>
    //-------------------------------------
    scale 15 translate<0,02,30>
}//-------------------------------------


//--------------------------------------------------------------------------
// minimon -----------------------------------------------------------------
object
{
    minimon
    rotate <-135, 0, 0>
    translate<0, 5+100*(1-time), 0>
} 

