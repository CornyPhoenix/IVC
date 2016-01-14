// This is REALLY slow! Only include for some scenes.

// Trauerweiden ------------------------------------------------------------
#include "Informatikum/weeping_willow.inc"
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
