//--------------------------------------------------------------------------
// author:  Sibel Toprak, Konstantin Möllers
// date:    2016-01-01
//--------------------------------------------------------------------------

// Alle Maße in Dezimetern (10 dm = 1 m)

#declare level_height = 35;                

// Materialien -------------------------------------------------------------
#declare Fenster = texture { pigment{ rgbf <0.98, 0.98, 0.98, 0.9> }
                    finish { diffuse 0.1 reflection 0.2  
                             specular 0.8 roughness 0.0003 phong 1 phong_size 400}
                   } // end of texture
//#declare Milchglas = texture { pigment{ rgbf <0.94, 0.98, 1, 0.8> }
//                    finish { diffuse 0.5 reflection 0.05
//                             specular 0.8 roughness 0.003 phong 1 phong_size 400}
//                   } // end of texture
#declare Milchglas = texture {pigment { rgbf <0.94, 0.98, 1, 0.8> }
                                  normal {bumps 0.02}
                                  finish {reflection 0.2
                                         specular 0.1
                                         roughness 1
                                         refraction 0.4
                                         ior 1.2
                                         crand 0.02}
                                 scale 0.01
                         }
#declare Ziegel = texture{
                          pigment{ brick
                                   color White  // Fugenfarbe
                                   color rgb<0.8,0.25,0.1>// Ziegelfarbe
                                   brick_size <4, 2, 1>
                                   // Ziegelformat in x-,y-,z-Richtung
                                   mortar 0.2 // Fugendicke
                                 }
                          normal { wrinkles 0.75 scale 0.01}
                          finish { diffuse 0.9 phong 0.2}
                  } // end of texture
#declare ZiegelZ = texture{
                          pigment{ brick
                                   color White  // Fugenfarbe
                                   color rgb<0.8,0.25,0.1>// Ziegelfarbe
                                   brick_size <1, 2, 4>
                                   // Ziegelformat in x-,y-,z-Richtung
                                   mortar 0.2 // Fugendicke
                                 }
                          normal { wrinkles 0.75 scale 0.01}
                          finish { diffuse 0.9 phong 0.2}
                  } // end of texture

#declare Dach =
      texture{ pigment{ color rgb<1,1,1>*0.4}
               normal { bumps 0.25 scale 0.005}
               finish { diffuse 0.9 phong 0.1}
             } // end of texture

#declare Innen = texture{ pigment { color Brass } }
#declare Waende = texture{ pigment { color Gray90 } }

// Haus A1
#declare A1_x      = 620;
#declare A1_z      = 170;
#declare A1_width  = 230;
#declare A1_depth  = 170;
#declare A1_color  = <193, 39, 45> / 255;
#declare A1_levels = 3;

// Haus A2
#declare A2_x      = 540;
#declare A2_z      = 170;
#declare A2_width  = 80;
#declare A2_depth  = 80;
#declare A2_color  = <0, 255, 0> / 255;
#declare A2_levels = 1;

// Haus B1
#declare B1_x      = 90;
#declare B1_z      = 400;
#declare B1_width  = 450;
#declare B1_depth  = 150;
#declare B1_color  = <255, 255, 0> / 255;
#declare B1_levels = 2;

// Haus B2
#declare B2_x      = 450;
#declare B2_z      = 250;
#declare B2_width  = 90;
#declare B2_depth  = 160;
#declare B2_color  = <115, 99, 87> / 255;
#declare B2_levels = 1;

// Haus C1
#declare C1_x      = 0;
#declare C1_z      = 1000;
#declare C1_width  = 170;
#declare C1_depth  = 430;
#declare C1_color  = <255, 0, 0> / 255;
#declare C1_levels = 2;

// Haus C2
#declare C2_x      = 170;
#declare C2_z      = 1000;
#declare C2_width  = 180;
#declare C2_depth  = 70;
#declare C2_color  = <0, 146, 69> / 255;
#declare C2_levels = 1;

// Haus C3
#declare C3_x      = 55;
#declare C3_z      = 620;
#declare C3_width  = 60;
#declare C3_depth  = 100;
#declare C3_color  = <0, 255, 255> / 255;
#declare C3_levels = 3;

// Haus D1
#declare D1_x      = 350;
#declare D1_z      = 1040;
#declare D1_m      = 740;
#declare D1_width  = 780;
#declare D1_depth  = 170;
#declare D1_color  = <41, 171, 226> / 255;
#declare D1_levels = 2;
#declare D1_margin = 13;

// Haus D2
#declare D2_x      = 675;
#declare D2_z      = 960;
#declare D2_width  = 130;
#declare D2_depth  = 130;
#declare D2_color  = <102, 45, 145> / 255;
#declare D2_levels = 3;

// Haus F1
#declare F1_x      = 1250;
#declare F1_z      = 1440;
#declare F1_width  = 190;
#declare F1_depth  = 640;
#declare F1_color  = <0, 255, 0> / 255;
#declare F1_levels = 6;

// Haus F2
#declare F2_x      = 1160;
#declare F2_z      = 1440;
#declare F2_width  = 90;
#declare F2_depth  = 120;
#declare F2_color  = <255, 0, 255> / 255;
#declare F2_levels = 2;

// Haus G
#declare G_x       = 1630;
#declare G_z       = 1070;
#declare G_width   = 170;
#declare G_depth   = 770;
#declare G_color   = <247, 147, 30> / 255;
#declare G_levels  = 2;

// Haus H
#declare H_x       = 1440;
#declare H_z       = 1010;
#declare H_width   = 190;
#declare H_depth   = 90;
#declare H_color   = <0, 169, 157> / 255;
#declare H_levels  = 1;

// Haus R
#declare R_x       = 1220;
#declare R_z       = 1750;
#declare R_width   = 270;
#declare R_depth   = 310;
#declare R_color   = <237, 30, 121> / 255;
#declare R_levels  = 2;

#declare Bruecke_x1 = 1130;
#declare Bruecke_x2 = 1250;
#declare Bruecke_y1 = level_height + 15;
#declare Bruecke_y2 = 2 * level_height + 15;
#declare Bruecke_z1 = 935;
#declare Bruecke_z2 = 975;

// Kameras
#declare Camera_SO = camera {angle 100 
                            location  <2000, 500.0, -200>
                            right     x*image_width/image_height
                            look_at   <1300 , 0.0 , 500>}   

#declare Camera_HausF = camera {angle 100
                            location  <F1_x-90, 100, F1_z-F1_depth-200>
                            right     x*image_width/image_height
                            look_at   <F1_x+90 , 100.0 , F1_z>}  
#declare Camera_AusF = camera {angle 100
                            location  <F1_x+60, 3*level_height+17, F1_z-F1_depth+10>
                            right     x*image_width/image_height
                            look_at   <F1_x+50 , 3*level_height+17, F1_z-F1_depth-10>}  

#declare Camera_HausB = camera {angle 105
                            location  <B1_x+B1_width/2 - 100, 100, B1_z+100>
                            right     x*image_width/image_height
                            look_at   <B1_x+B1_width/2, 50, B1_z-B1_depth>}  

#declare Camera_HausC = camera {angle 105
                            location  <200+C1_x+C1_width/2, 50, C1_z-C1_depth-170>
                            right     x*image_width/image_height
                            look_at   <C1_x+C1_width/2, 25.0 , C1_z>}

#declare Camera_HausD = camera {angle 105
                            location  <100+D1_x+D1_width/2, 100, D1_z-D1_depth-300>
                            right     x*image_width/image_height
                            look_at   <40+D1_x+D1_width/2, 100.0 , D1_z>}

#declare Camera_HausG = camera {angle 105
                            location  <G_x - 150,       50,     G_z-G_depth/2>
                            right     x*image_width/image_height
                            look_at   <G_x+G_width/2,   50.0,   G_z-G_depth/2>}

#declare Camera_Bruecke = camera {angle 105
                            location  <1190,       level_height*1.5 + 10,     955>
                            right     x*image_width/image_height
                            look_at   <1000,   level_height*1.5 + 10,   955>}

#macro Haus(px, pz, pwidth, pdepth, plevels, pcolor)
	box {
		<px, 0, pz - pdepth>
		<px + pwidth, level_height * plevels, pz>
		texture { pigment { color rgb pcolor } }
	}
#end

#macro Wand(pWidth, pHeight)
	box {
		<0, 0, 0>
		<pWidth, pHeight, 2>
		texture { Ziegel }
	}
#end

#macro calcLevel(level, fundament, h)
    #declare y1 = level * level_height + fundament;
    #declare y2 = y1 + h;
#end
