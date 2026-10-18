shader_type canvas_item;
uniform float outline_thickness: hint_range(1.0,100.0,0.1) = 8.0;
uniform float anti_alias_amount = 1.0;
uniform vec4 outline_color : source_color = vec4(1);
uniform bool enable_shader = true;

void fragment() {
	float max_dist = outline_thickness + anti_alias_amount;
	int max_offset = int(ceil(max_dist));
	float closest_outline_dist = max_dist;
	
	for (int x = -max_offset; x <= max_offset; x++) {
		for (int y = -max_offset; y <= max_offset;y++) {
		vec2 offset = vec2(float(x), float(y));
		float dist = length(offset);
		
		if (dist > max_dist) continue;
		
		if (texture(TEXTURE, UV + offset * TEXTURE_PIXEL_SIZE).a > 0.0) {
			closest_outline_dist = min(closest_outline_dist, dist);
			}
		}
	}
	
	float alpha = 1.0 - smoothstep(outline_thickness - anti_alias_amount, outline_thickness + anti_alias_amount, closest_outline_dist);
	vec4 tex_color = texture(TEXTURE, UV) * COLOR;
	if (enable_shader) {
		COLOR = mix(vec4(outline_color.rgb,alpha), tex_color, tex_color.a);
	} else {
		COLOR = tex_color;
	}
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
