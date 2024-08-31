shader_type canvas_item;

uniform float time_scale = 20;
uniform float gb_ceil = 0.75;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	float time_cycle = sin(TIME * time_scale);
	vec4 tex_color = texture(TEXTURE, UV);
	
	COLOR = vec4(
		1.0,
		tex_color.g * time_cycle * gb_ceil,
		tex_color.b * time_cycle * gb_ceil,
		tex_color.a);

}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
