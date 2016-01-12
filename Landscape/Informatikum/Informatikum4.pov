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
#include "Informatikum.inc"
//--------------------------------------------------------------------------

// camera ------------------------------------------------------------------
camera{Camera_SO}

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

#declare Pigment_1 =
pigment{ gradient <0,1,0> 
         color_map{
            [ 0.0 color rgb<1,1,1> ]
            [ 0.5 color rgb<.7,.7,.7> ]
            [ 1.0 color rgb<1,1,1> ]
         } // end color_map
         scale 5
} // end pigment

#local B1_tex = texture{
    Brushed_Aluminum
    pigment{ Pigment_1 }
    //normal { pigment_pattern { Pigment_1 }, 0.5 }
    finish { phong 0.5  }
} // end of texture

#declare y1 = 0;

#macro WandKasten(tex1, tex2)
    union {
        box {
            <x1,        y1,     z1>
            <x2,        y2,     z1 + 2>
            texture { tex1 }
        }
        box {
            <x1,        y1,     z2 - 2>
            <x2,        y2,     z2>
            texture { tex1 }
        }
        box {
            <x1,        y1,     z1>
            <x1 + 2,    y2,     z2>
            texture { tex2 }
        }
        box {
            <x2 - 2,    y1,     z1>
            <x2,        y2,     z2>
            texture { tex2 }
        }
    }
#end

#macro HausKasten(tex1, tex2)
    #local overlap = 10;
    union {
        WandKasten(tex1, tex2)
        box {
            <x1 - overlap,        y2,     z1 - overlap>
            <x2 + overlap,        y2+2,     z2 + overlap>
            texture { Dach }
        }
    }
#end

// Haus A

#local x1 = A1_x;
#local x2 = A1_x + A1_width;
#local y1 = 0;
#local y2 = A1_levels * level_height;
#local z1 = A1_z - A1_depth;
#local z2 = A1_z;
difference {
    HausKasten(texture { Waende }, texture { Waende })

    // Fenster ausschneiden
    #local A1_win = 3;
    #local A1_window_width = 20;
    #for (i, 0, A1_win - 1)
        #local zz1 = z1 + (i + .5) * (z2 - z1) / A1_win - A1_window_width / 2;
        #local zz2 = zz1 + A1_window_width;
        #for (level, 0, 1)
            calcLevel(level, 22, 17)
            box {
                <x1-1,y1,zz1>
                <x2+1,y2,zz2>
                texture { Innen }
            }
        #end
    #end
}

// Fenster einsetzen
#for (i, 0, A1_win - 1)
    #local zz1 = z1 + (i + .5) * (z2 - z1) / A1_win - A1_window_width / 2;
    #local zz2 = zz1 + A1_window_width;
    #for (level, 0, 1)
        calcLevel(level, 22, 17)
        box {
            <x1,y1,zz1>
            <x1 + .1,y2,zz2>
            texture { Fenster }
        }
        box {
            <x2 - .1,y1,zz1>
            <x2,y2,zz2>
            texture { Fenster }
        }
    #end
#end

#local x1 = A2_x;
#local x2 = A2_x + A2_width;
#local y1 = 0;
#local y2 = A2_levels * level_height;
#local z1 = A2_z - A2_depth;
#local z2 = A2_z;
HausKasten(texture { Waende }, texture { Waende })

// Haus B

#local x1 = B1_x;
#local x2 = B1_x + B1_width;
#local y2 = B1_levels * level_height + 15;
#local z1 = B1_z - B1_depth;
#local z2 = B1_z;
difference {
    HausKasten(texture { B1_tex }, texture { Waende })

    #local B1_win = 10;
    #local B1_window_width = 30;
    #for (i, 0, B1_win - 1)
        #local x1 = B1_x + (i + .5) * B1_width / B1_win - B1_window_width / 2;
        #local x2 = x1 + B1_window_width;
        #for (level, 0, 1)
            calcLevel(level, 25, 13)
            box {
                <x1,y1,z1-1>
                <x2,y2,z2+1>
                texture { Innen }
            }
        #end
    #end
}

// Fensterscheiben Haus B
#for (i, 0, B1_win + 1)
    #local x1 = (i + .5) * B1_width / B1_win - B1_window_width / 2;
    #local x2 = x1 + B1_window_width;
    #for (level, 0, 1)
        calcLevel(level, 25, 13)
        box {
            <x1,y1,z1-.1>
            <x2,y2,z1>
            texture { Fenster }
        }
        box {
            <x1,y1,z2>
            <x2,y2,z2+.1>
            texture { Fenster }
        }
    #end
#end

// Haus C
#local x1 = C1_x;
#local x2 = C1_x + C1_width;
#local y1 = 0;
#local y2 = C1_levels * level_height + 15;
#local z1 = C1_z - C1_depth;
#local z2 = C1_z;
difference {
    HausKasten(texture { Ziegel }, texture { ZiegelZ })

    #local C1_win = 10;
    #local C1_window_width = 30;
    #for (i, 0, C1_win - 3)
        #local z1 = C1_z - C1_depth + (i + .5) * C1_depth / C1_win - C1_window_width / 2;
        #local z2 = z1 + C1_window_width;
        #for (level, 0, 1)
            calcLevel(level, 25, 13)
            box {
                <x1-1,y1,z1>
                <x2+1,y2,z2>
                texture { Innen }
            }
        #end
    #end

    // Anbau ausschneiden
    #local z1 = C1_z - C1_depth;
    #local z2 = C3_z;
    #local y1 = 0;
    #local y2 = C1_levels * level_height + 15;
    box {
        <C3_x, y1, z1-12>
        <C3_x + C3_width, y2+3, z2>
        texture { Innen }
    }

    // Tür ausschneiden
    #declare door_width = 30;
    #local x1 = C3_x + C3_width + ((C1_width - C3_width)/2 - door_width)/2;
    #local x2 = x1 + door_width;
    #local y2 = .8*level_height;
    box {
        <x1,y1,z1-1>
        <x2,y2,z2>
    }
}

// Fensterscheiben Haus C
#local C1_win = 10;
#local C1_window_width = 30;
#for (i, 0, C1_win - 3)
    #local z1 = C1_z - C1_depth + (i + .5) * C1_depth / C1_win - C1_window_width / 2;
    #local z2 = z1 + C1_window_width;
    #for (level, 0, 1)
        calcLevel(level, 25, 13)
        box {
            <x1-.1, y1, z1>
            <x1,    y2, z2>
            texture { Fenster }
        }
        box {
            <x2,    y1, z1>
            <x2+.1, y2, z2>
            texture { Fenster }
        }
    #end
#end

// Gläserner Anbau Haus C
#local x1 = C3_x;
#local x2 = C3_x + C3_width;
#local y1 = 0;
#local y2 = C3_levels * level_height + 15;
#local z1 = C3_z - C3_depth;
#local z2 = C3_z;

difference {
    union {
        #for (ix, 0, 3)
            box {
                <x1 + ix*(x2 - x1)/3 - 1, y1, z1-1>
                <x1 + ix*(x2 - x1)/3 + 1, y2, z1+1>
                texture { Waende }
            }
        #end
        #for (ix, 0, 8)
            box {
                <x1 - 1, y1, z1-1 + ix*(z2 - z1)/8>
                <x1 + 1, y2, z1+1 + ix*(z2 - z1)/8>
                texture { Waende }
            }
            box {
                <x2 - 1, y1, z1-1 + ix*(z2 - z1)/8>
                <x2 + 1, y2, z1+1 + ix*(z2 - z1)/8>
                texture { Waende }
            }
        #end
        #for (iy, 0, 3)
            #local offs = iy*(y2 - y1)/3;
            box {
                <x1 - 1, y1 - 1 + offs, z1 - 1>
                <x2 + 1, y1 + 1 + offs, z1 + 1>
                texture { Waende }
            }
            box {
                <x1 - 1, y1 - 1 + offs, z1 - 1>
                <x1 + 1, y1 + 1 + offs, z2 + 1>
                texture { Waende }
            }
            box {
                <x2 - 1, y1 - 1 + offs, z1 - 1>
                <x2 + 1, y1 + 1 + offs, z2 + 1>
                texture { Waende }
            }
        #end
        box {
            <x1, y1, z1+.1>
            <x2, y2, z1+.2>
            texture { Milchglas }
        }
        box {
            <x1, y1, z1>
            <x1+.1, y2, z2>
            texture { Milchglas }
        }
        box {
            <x2-.1, y1, z1>
            <x2, y2, z2>
            texture { Milchglas }
        }
    }

    #local x1 = C1_x;
    #local x2 = C1_x + C1_width;
    #local y1 = 0;
    #local y2 = C1_levels * level_height + 15;
    #local z1 = C1_z - C1_depth;
    #local z2 = C1_z;
    box {
        <x1, y1, z1>
        <x2, y2, z2>
        texture { Innen }
    }
}

// Dach des Anbaus
#local x1 = C3_x;
#local x2 = C3_x + C3_width;
#local z1 = C3_z - C3_depth;
#local z2 = C3_z;
#local y2 = C3_levels * level_height + 15;
box {
    <x1 - 11, y2, z1 - 10>
    <x2 + 11, y2, z2 + 10>
    texture { Dach }
}

// Überdach
#local x1 = C3_x + C3_width;
#local x2 = C1_x + C1_width;
#local z1 = C3_z - C3_depth - 5;
#local z2 = C1_z - C1_depth;
box {
    <x1, level_height + 5, z1>
    <x2, level_height + 7, z2>
    texture { Dach }
}

box {
	<C2_x,          0,                      C2_z-C2_depth>
	<C2_x+C2_width, C2_levels*level_height, C2_z>
	texture { Ziegel }
}

// Haus D
#local window_width=39;

difference {
    union {
        // Außenhülle D1
        box {
            <D1_x,0,D1_z-D1_depth>
            <D1_x+D1_width,D1_levels*level_height+15,D1_z>
        }
        // Außenhülle D2
        box {
            <D2_x,0,D2_z-D2_depth>
            <D2_x+D2_width,D2_levels*level_height,D2_z>
        }
        texture { Waende }
    }

    union {
        // Innenraum D1
        box {
            <D1_x+1,0,D1_z-D1_depth+1>
            <D1_x+D1_width-1,D1_levels*level_height+13,D1_z-1>
        }
        // Innenraum D2
        box {
            <D2_x+1,0,D2_z-D2_depth+1>
            <D2_x+D2_width-1,D2_levels*level_height-2,D2_z-1>
        }

        // Fenster D1 ausschneiden
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
                    }
                #end
            #end
        #end

        // Fenster D2 ausschneiden
        #for (level, 0, 2)
            #local y2 = (level+1)*level_height-6;
            #local y1 = y2 - level_height/3;
            box {
                <D2_x+6,y1,D2_z-D2_depth-.1>
                <D2_x+36,y2,D1_z+.1>
            }
            box {
                <D2_x+D2_width-83,y1,D2_z-D2_depth-.1>
                <D2_x+D2_width-53,y2,D1_z+.1>
            }
        #end

        // Treppenhausfenster D2
        #for (level, 0, 2)
            #local y2 = level_height + (level+1)*(level_height*2/3)-6;
            #local y1 = y2 - level_height/3;
            box {
                <D2_x+D2_width-47,y1,D2_z-D2_depth-.1>
                <D2_x+D2_width-6,y2,D1_z+.1>
            }
        #end

        // Schön hässlich damit authentisch
        texture { Innen }
    }
}

// Fenster D1
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
                <x2,y2,z1+0.1>
                texture { Fenster }
            }
            box {
                <x1,y1,z2-0.1>
                <x2,y2,z2>
                texture { Fenster }
            }
        #end
    #end
#end

// Fenster D2
#for (level, 0, 2)
    #local y2 = (level+1)*level_height-6;
    #local y1 = y2 - level_height/3;
    #local d2z = D2_z - D2_depth;
    box {
        <D2_x+6,y1,d2z-.1>
        <D2_x+36,y2,d2z>
        texture { Fenster }
    }
    box {
        <D2_x+D2_width-83,y1,d2z-.1>
        <D2_x+D2_width-53,y2,d2z>
        texture { Fenster }
    }

    #local y2 = level_height + (level+1)*(level_height*2/3)-6;
    #local y1 = y2 - level_height/3;
    box {
        <D2_x+D2_width-47,y1,D2_z-D2_depth-.1>
        <D2_x+D2_width-6,y2,D2_z-D2_depth>
        texture { Fenster }
    }
    box {
        <D2_x+D2_width-47,y1,D2_z>
        <D2_x+D2_width-6,y2,D2_z+0.1>
        texture { Fenster }
    }
#end

#local mwidth = (D1_width-D2_width)/2;
object {
    Wand(mwidth, 15)
    translate<D1_x, 0, D1_z-D1_depth-2>
}

object {
    Wand(mwidth, 15)
    translate<D1_x + mwidth + D2_width, 0, D1_z-D1_depth-2>
}

#local dachy = D1_levels * level_height + 15;
#local overlap = 4;
// Dach
box {
    <D1_x - overlap, dachy, D1_z-D1_depth - overlap>
    <D1_x+mwidth, dachy + 2, D1_z + overlap>
    texture { Dach }
}

box {
    <D1_x+mwidth, dachy, D2_z>
    <D1_x + mwidth + D2_width, dachy + 2, D1_z + overlap>
    texture { Dach }
}

box {
    <D1_x + mwidth + D2_width, dachy, D1_z-D1_depth - overlap>
    <D1_x+D1_width + overlap, dachy + 2, D1_z + overlap>
    texture { Dach }
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
//} // ende D

// Haus F
union {
    merge {
        box {
        	<F1_x,0,F1_z-F1_depth>
        	<F1_x+F1_width,F1_levels*level_height+15,F1_z>
        	texture { Waende }
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
        	texture { Waende }
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

// Haus G

#local x1 = G_x;
#local x2 = G_x + G_width;
#local y1 = 0;
#local y2 = 15;
#local z1 = G_z - G_depth;
#local z2 = G_z;
WandKasten(texture { Ziegel }, texture { ZiegelZ })

#local y1 = 15;
#local y2 = G_levels * level_height + 15;
#local z2 = G_z - G_depth + 180;
HausKasten(texture { Ziegel }, texture { ZiegelZ })

#local z1 = H_z - H_depth - 20;
#local z2 = G_z;
HausKasten(texture { Ziegel }, texture { ZiegelZ })

#local z2 = z1;
#local z1 = G_z - G_depth + 180;
difference {
    HausKasten(texture { Waende }, texture { Waende })

    // Fenster ausschneiden
    #local G_win = 15;
    #local G_window_width = 25;
    #for (i, 0, G_win - 1)
        #local zz1 = z1 + (i + .5) * (z2 - z1) / G_win - G_window_width / 2;
        #local zz2 = zz1 + G_window_width;
        #for (level, 0, 1)
            calcLevel(level, 21, 21)
            box {
                <x1-1,y1,zz1>
                <x2+1,y2,zz2>
                texture { Innen }
            }
        #end
    #end
}

// Fenster einsetzen, Zwischenstreben
#for (i, 0, G_win - 1)
    #local zz1 = z1 + (i + .5) * (z2 - z1) / G_win - G_window_width / 2;
    #local zz2 = zz1 + G_window_width;
    #for (level, 0, 1)
        calcLevel(level, 21, 21)
        box {
            <x1,y1,zz1>
            <x1 + .1,y2,zz2>
            texture { Fenster }
        }
        box {
            <x2 - .1,y1,zz1>
            <x2,y2,zz2>
            texture { Fenster }
        }
        // Fensterrahmen links
        #for (rechts, 0, 1)
            #local xx1 = x1 - 1 + rechts * (G_width + 1);
            #local xx2 = xx1 + 1;
            // Streber!
            box {
                <xx1, y1 - 6,zz1-3>
                <xx2, y2 + 8,    zz1-1>
                texture { pigment { color Gray30 } }
            }
            union {
                box {
                    <xx1,    y1,     zz1>
                    <xx2,    y1+1,   zz2>
                }
                box {
                    <xx1,    y2-1,   zz1>
                    <xx2,    y2,     zz2>
                }
                box {
                    <xx1,    y1,     zz1>
                    <xx2,    y2,     zz1 + 1>
                }
                box {
                    <xx1,    y1,     zz2 - 1>
                    <xx2,    y2,     zz2>
                }
                box {
                    <xx1,    y1,     zz1 + G_window_width/2 - .5>
                    <xx2,    y2,     zz1 + G_window_width/2 + .5>
                }
                texture { pigment { color VeryDarkBrown } }
            }
        #end
    #end
#end

// Haus H
#local x1 = H_x;
#local x2 = H_x + H_width;
#local y1 = 0;
#local y2 = H_levels * level_height;
#local z1 = H_z - H_depth;
#local z2 = H_z;
HausKasten(texture { Waende }, texture { Waende })

// Haus R
#local x1 = R_x;
#local x2 = R_x + R_width;
#local y1 = 0;
#local y2 = R_levels * level_height;
#local z1 = R_z - R_depth;
#local z2 = R_z;
HausKasten(texture { Waende }, texture { Waende })

Haus(B2_x, B2_z, B2_width, B2_depth, B2_levels, B2_color)
Haus(F2_x, F2_z, F2_width, F2_depth, F2_levels, F2_color)

// Trauerweide
#include "weeping_willow.inc"
#declare TREE_SCALE = level_height*.4;
#declare HEIGHT = weeping_willow_13_height * 1.3 * TREE_SCALE;
#declare WIDTH = HEIGHT*400/600;
//camera { orthographic location <1025, HEIGHT*0.45, 525-100>
//         right <WIDTH, 0, 0> up <0, HEIGHT, 0>
//         look_at <1025, HEIGHT*0.45, 525-80> }
#macro tree(pos_x, pos_z, p_size, p_rot)
union {
    object { weeping_willow_13_stems
        pigment {color BakersChoc} }
    object { weeping_willow_13_leaves
        texture { pigment {color DarkGreen}
                  finish { ambient 0.15 diffuse 0.8 }}}
    scale p_size rotate p_rot*y
    translate <pos_x, 0, pos_z>
}
#end
tree(1025,  525, 1.3 * TREE_SCALE, 100)
tree( 400,  600,       TREE_SCALE, 200)
tree(1040,  200,  .8 * TREE_SCALE, 300)
