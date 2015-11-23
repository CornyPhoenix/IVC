#macro Earth(pAngle, pScale)
	sphere {
		0, 1
		pigment
		{ image_map
		  { jpeg "txt/earth.jpg"
		    map_type 1
		  }
		}
		rotate (280 + pAngle) * y
		rotate (-53.8) * x
		// rotate 23 * z
		scale (pScale)
		translate pScale * z
	}
#end