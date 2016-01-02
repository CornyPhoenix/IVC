//--------------------------------------------------------------------------
// author:  Sibel Toprak, Konstantin Möllers
// date:    2016-01-01
//--------------------------------------------------------------------------

// Alle Maße in Dezimetern (10 dm = 1 m)

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
#declare C3_x      = 80;
#declare C3_z      = 570;
#declare C3_width  = 90;
#declare C3_depth  = 40;
#declare C3_color  = <0, 255, 255> / 255;
#declare C3_levels = 3;

// Haus D1
#declare D1_x      = 350;
#declare D1_z      = 1040;
#declare D1_width  = 780;
#declare D1_depth  = 170;
#declare D1_color  = <41, 171, 226> / 255;
#declare D1_levels = 2;

// Haus D2
#declare D2_x      = 700;
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
#declare H_levels  = 2;

// Haus R
#declare R_x       = 1220;
#declare R_z       = 1750;
#declare R_width   = 270;
#declare R_depth   = 310;
#declare R_color   = <237, 30, 121> / 255;
#declare R_levels  = 2;

#macro Haus(px, pz, pwidth, pdepth, plevels, pcolor)
	box {
		<px, 0, pz - pdepth>
		<px + pwidth, 30 * plevels, pz>
		texture { pigment { color rgb pcolor } }
	}
#end
