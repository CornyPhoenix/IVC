//--------------------------------------------------------------------------
// author:  Sibel Toprak, Konstantin Mšllers
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
#include "Informatikum.inc"
//--------------------------------------------------------------------------

// camera ------------------------------------------------------------------
camera{Camera_HausB}

// sun ---------------------------------------------------------------------
light_source{<1500,2500,-2500> color White}
// sky ---------------------------------------------------------------------
plane{<0,1,0>,1 hollow  
       texture{ pigment{ bozo turbulence 0.76
                         color_map { [0.5 rgb <0.20, 0.20, 1.0>]
                                     [0.6 rgb <1,1,1>]
                                     [1.0 rgb <0.5,0.5,0.5>]}
                       }
                finish {ambient 1 diffuse 0} }      
       scale 10000}
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
//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------

// Ground
box {
	<0,0,0>
	<1,1,0.1>
	/*texture{ pigment{ color rgb<.24,0.45,0.23>*0.67 }
	         normal { bumps 0.75 scale .000017647 }
               }*/
	texture {
		pigment { 
			image_map { 
				png "texture.png"
				map_type 0 
				interpolate 2 			
		  }		  
		}
	}
	scale <1800, 1800, 1>
	rotate -90*x
	rotate 180*y
	translate <1800, 0, 0>
}

// Haus B

#declare Pigment_1 =
pigment{ gradient <0,1,0> 
         color_map{
            [ 0.0 color rgb<.9,.9,.9> ]
            [ 0.5 color rgb<1,0,0> ]
            [ 1.0 color rgb<.9,.9,.9> ]
         } // end color_map
         scale 5
} // end pigment

#local B1_tex = texture{
          pigment{ color rgb<.7,.7,.7>}
          normal {pigment_pattern{Pigment_1},0.5}
          finish { phong 0.5  }
        } // end of texture
box {
	<B1_x,          0,                      B1_z-B1_depth>
	<B1_x+B1_width, B1_levels*level_height, B1_z>
	texture { B1_tex }
}

// Haus C
box {
	<C3_x,          0,                      C3_z-C3_depth>
	<C3_x+C3_width, C3_levels*level_height, C3_z>
	texture { Fenster }
	hollow on
}
box {
	<C1_x,          0,                      C1_z-C1_depth>
	<C1_x+C1_width, C1_levels*level_height, C1_z>
	texture { Ziegel }
	hollow on
}
box {
	<C2_x,          0,                      C2_z-C2_depth>
	<C2_x+C2_width, C2_levels*level_height, C2_z>
	texture { Ziegel }
	hollow on
}

// Haus D
union {
    #local window_width=39;
    
    merge {
        box {
        	<D1_x,15,D1_z-D1_depth>
        	<D1_x+D1_width,D1_levels*level_height+15,D1_z>
        	texture { pigment { color White } }
        	hollow on
        }
        // Fenster ausschneiden
        #for (level, 0, 1)
        #for (window, 0, 7)
        #for (rechts, 0, 1)
            #local x1 = rechts*(D1_width/2+D2_width/2-D1_margin) + D1_margin+D1_x+window*window_width +2;
            #local x2 = rechts*(D1_width/2+D2_width/2-D1_margin) + D1_margin+D1_x+(window+1)*window_width -2;
            #local y1 = level*level_height+25;
            #local y2 = (level+1)*level_height+12;
            #local z1 = D1_z-D1_depth-0.1;
            #local z2 = D1_z+0.1;
            box {
                <x1,y1,z1>
                <x2,y2,z2>
                texture { Fenster }
            }
        #end
        #end
        #end
    }
    box {
    	<D1_x,0,D1_z-D1_depth>
    	<D1_x+D1_width,15,D1_z>
    	texture { Ziegel }
    }
    
    // Dach
    box {
        #local overlap = 4;
    	<D1_x - overlap, D1_levels * level_height + 15, D1_z-D1_depth - overlap>
    	<D1_x+D1_width + overlap, D1_levels * level_height + 17, D1_z + overlap>
    	texture { pigment { color Gray70 } }
    }
    
    // Zwischenboden
    #for (level, 1, 1)
        box {
        	<D1_x, level * level_height + 14, D1_z-D1_depth>
        	<D1_x+D1_width, level * level_height + 15, D1_z>
        	texture { pigment { color Gray30 } }
        }
    #end
    
    // Haessliche braune Fensterrahmen von Haus D nachzaubern
    #local RahmenD = texture { pigment { color IndianRed } }
    #for (level, 0, 1)
        #for (window, 0, 7)
            #for (rechts, 0, 1)
                #for (hinten, 0, 1)
                    #local x1 = rechts*(D1_width/2+D2_width/2-D1_margin) + D1_margin+D1_x+window*window_width +2;
                    #local x2 = rechts*(D1_width/2+D2_width/2-D1_margin) + D1_margin+D1_x+(window+1)*window_width -2;
                    #local y1 = level*level_height+25;
                    #local y2 = (level+1)*level_height+12;
                    #local z1 = D1_z-D1_depth-0.1 + hinten*(D1_depth+0.2);
                    // Graue Pfosten
                    box {
                        <x1-2,y1-10,z1-1>
                        <x1-1,y2+3,z1>
                        texture { pigment { color Gray60 } }
                    }
                    box {
                        <x2+1,y1-10,z1-1>
                        <x2+2,y2+3,z1>
                        texture { pigment { color Gray60 } }
                    }
                    
                    // Vertikale Streben
                    box {
                        <x1,y1,z1-1>
                        <x1+1,y2,z1>
                        texture { RahmenD }
                    }
                    box {
                        <x2-1,y1,z1-1>
                        <x2,y2,z1>
                        texture { RahmenD }
                    }
                    box {
                        <x1+8,y1,z1-1>
                        <x1+9,y2,z1>
                        texture { RahmenD }
                    }
                    box {
                        <x2-9,y1,z1-1>
                        <x2-8,y2,z1>
                        texture { RahmenD }
                    }
                    // Horizontale Streben
                    box {
                        <x1,y1,z1-1>
                        <x2,y1+1,z1>
                        texture { RahmenD }
                    }
                    box {
                        <x1,y2-1,z1-1>
                        <x2,y2,z1>
                        texture { RahmenD }
                    }
                    box {
                        <x1,y2-6,z1-1>
                        <x2,y2-5,z1>
                        texture { RahmenD }
                    }
                #end
            #end 
        #end
    #end
}

// Haus D Eingang
merge {
	union {
		box {
		    <D2_x,0,D2_z-D2_depth>
		    <D2_x+D2_width,D2_levels*level_height,D2_z>
		    texture { pigment { color White } }
		    hollow on
		}
		
		// Graue Kanten Haus D Eingang
		#local y2 = D2_levels*level_height;
		union {
			box {
			    <D2_x+D2_width-6,0,D2_z-D2_depth-.1>
			    <D2_x+D2_width+.1,y2,D2_z-D2_depth+6>
			}
			box {
			    <D2_x+D2_width-53,0,D2_z-D2_depth-.1>
			    <D2_x+D2_width-47,y2,D2_z-D2_depth+6>
			}
			box {
			    <D2_x-.1,0,D2_z-D2_depth-.1>
			    <D2_x+6,y2,D2_z-D2_depth+6>
			}
			box {
			    <D2_x,y2-6,D2_z-D2_depth-.1>
			    <D2_x+D2_width,y2,D2_z-D2_depth+6>
			}
			box {
			    <D2_x,0,D2_z-D2_depth-.1>
			    <D2_x+D2_width,6,D2_z-D2_depth+6>
			}
			texture { pigment { color Gray60 } }
		}
	}
	
	// Fenster ausschneiden
	#for (level, 0, 2)
		#local y2 = (level+1)*level_height-6;
		#local y1 = y2 - level_height/3;
		box {
			<D2_x+6,y1,D2_z-D2_depth-.1>
		  <D2_x+36,y2,D2_z+.1>
		  texture { Fenster }
		}
		box {
			<D2_x+D2_width-83,y1,D2_z-D2_depth-.1>
		  <D2_x+D2_width-53,y2,D2_z+.1>
		  texture { Fenster }
		}
	#end
	
	// Treppenhausfenster
	#for (level, 0, 2)
		#local y2 = level_height + (level+1)*(level_height*2/3)-6;
		#local y1 = y2 - level_height/3;
		box {
			<D2_x+D2_width-47,y1,D2_z-D2_depth-.1>
		  <D2_x+D2_width-6,y2,D2_z+.1>
		  texture { Fenster }
		}
	#end
}

// Haus F
union {
    merge {
        box {
        	<F1_x,0,F1_z-F1_depth>
        	<F1_x+F1_width,F1_levels*level_height+15,F1_z>
        	texture { pigment { color White } }
        	hollow on
        }
        #for (level, 1, 5)
            #local y1 = level * level_height + (level_height/3);
            #local y2 = (level+1) * level_height - 1;
            box {
            	<F1_x+30, y1, F1_z-F1_depth-.1>
            	<F1_x+90, y2, F1_z+.1>
            	texture { Fenster }
            }
            box {
            	<F1_x-0.1,          y1, F1_z-F1_depth-.1>
            	<F1_x+F1_width+0.1, y2, F1_z+.1>
            	texture { Fenster }
            }
        #end
    }
    #for (level, 1, 6)
        box {
        	<F1_x-1, level * level_height - 1, F1_z-F1_depth-1>
        	<F1_x+F1_width+1, level * level_height, F1_z+1>
        	texture { pigment { color Gray30 } }
        }
    #end    
    #for (strebe, 1, 4)
        box {
        	<F1_x+30 + strebe*12 - 0.5, level_height,F1_z-F1_depth-0.5>
            <F1_x+30 + strebe*12 + 0.5, F1_levels*level_height+15,F1_z-F1_depth>
        	texture { pigment { color White } }
        }
    #end
    box {
    	<F1_x-2,0,F1_z-F1_depth-2>
        <F1_x+30,F1_levels*level_height+15,F1_z-F1_depth+50>
    	texture { Ziegel }
    }
    box {
    	<F1_x+90,0,F1_z-F1_depth-2>
        <F1_x+F1_width+2,F1_levels*level_height+15,F1_z-F1_depth+50>
    	texture { Ziegel }
    }
    box {
    	<F1_x-2,0,F1_z-2>
        <F1_x+F1_width+2,F1_levels*level_height+15,F1_z+2>
    	texture { Ziegel }
    }
}

Haus(A1_x, A1_z, A1_width, A1_depth, A1_levels, A1_color)
Haus(A2_x, A2_z, A2_width, A2_depth, A2_levels, A2_color)
Haus(B2_x, B2_z, B2_width, B2_depth, B2_levels, B2_color)
Haus(F2_x, F2_z, F2_width, F2_depth, F2_levels, F2_color)
Haus(G_x,  G_z,  G_width,  G_depth,  G_levels,  G_color)
Haus(H_x,  H_z,  H_width,  H_depth,  H_levels,  H_color)
Haus(R_x, R_z, R_width, R_depth, R_levels, R_color)
