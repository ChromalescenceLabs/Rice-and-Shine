shader_type canvas_item;

// ily aquinas_nz on godotshaders.com
uniform vec4 line_colour : source_color = vec4(1.0); // default = white
uniform float line_thickness : hint_range(0, 0.1) = 0.04; // the max distance from a transparent fragment to search for an opaque pixel - effectively the line width as named
uniform float border_visibility : hint_range(0, 1) = 1.0; // control to fade border in and out
uniform float gradient_intensity : hint_range(0, 5) = 3; // controls how quickly the gradient falls off
uniform float gradient_steps : hint_range(1, 20) = 10; // controls the 'fineness' of the gradient

// the directions to search for an opaque pixel - each a point on the unit circle (full distance multiplies this by line_thickness)
// more directions = more accurate detection = better results around curved edges or corners
const vec2 OFFSETS[16] = vec2[16](
    vec2(-1.000,  0.000),   // 0° (Left) - Actually 180°, but starting here for comparison
    vec2(-0.924, -0.383),   // 22.5°
    vec2(-0.707, -0.707),   // 45° (Down-Left)
    vec2(-0.383, -0.924),   // 67.5°
    vec2( 0.000, -1.000),   // 90° (Down)
    vec2( 0.383, -0.924),   // 112.5°
    vec2( 0.707, -0.707),   // 135° (Down-Right)
    vec2( 0.924, -0.383),   // 157.5°
    vec2( 1.000,  0.000),   // 180° (Right) - Actually 0°
    vec2( 0.924,  0.383),   // 202.5°
    vec2( 0.707,  0.707),   // 225° (Up-Right)
    vec2( 0.383,  0.924),   // 247.5°
    vec2( 0.000,  1.000),   // 270° (Up)
    vec2(-0.383,  0.924),   // 292.5°
    vec2(-0.707,  0.707),   // 315° (Up-Left)
    vec2(-0.924,  0.383)    // 337.5°
);

void fragment() {
    vec4 colour = texture(TEXTURE, UV);
    if(colour.a > 0.9 || border_visibility < 0.001)
    {
        COLOR = colour; // skip calculation for near fully opaque pixels or when fully faded
    } 
    else 
    {
        vec2 aspect_corrected_thickness = vec2(line_thickness, line_thickness / (TEXTURE_PIXEL_SIZE.x / TEXTURE_PIXEL_SIZE.y));

        // test each direction, finding any opaque pixels in range. note this isn't adjacent pixels, 
        // but 'up to line length' away in each of the offsets. this results in the thick border effect,
        // as the edge of the border still finds the edge of the opaque region in that direction
        float min_distance = 1.0;
        for (int i = 0; i < OFFSETS.length(); i++) {
            vec2 sample_uv = UV + OFFSETS[i] * aspect_corrected_thickness;
        
            // sample multiple points along the direction to get a distance estimate
            // more sample positions mean smoother gradient
            for (float t = 0.0; t <= 1.0; t += 1.0/gradient_steps) {
                vec4 sample_colour = texture(TEXTURE, mix(UV, sample_uv, t));
                if (sample_colour.a > 0.5) { // mostly opaque
                    min_distance = min(min_distance, t);
                    break;
                }
            }
        }

        // no opaque pixels found likely means we are > line_length away from the edge of the sprite
        if (min_distance >= 1.0) {
            discard;
        }

        float gradient = 1.0 - pow(min_distance, gradient_intensity);
        gradient *= border_visibility;
        
        vec4 outline_colour = line_colour;
        outline_colour.a *= gradient;

        COLOR = outline_colour;
    }
}
