shader_type canvas_item;

uniform float time;

vec2 random(vec2 uv){
    uv = vec2( dot(uv, vec2(127.1,311.7) ),
               dot(uv, vec2(269.5,183.3) ) );
    return -1.0 + 2.0 * fract(sin(uv) * 43758.5453123);
}

float noise(vec2 uv) {
    vec2 uv_index = floor(uv);
    vec2 uv_fract = fract(uv);

    vec2 blur = smoothstep(0.0, 1.0, uv_fract);

    return mix( mix( dot( random(uv_index + vec2(0.0,0.0) ), uv_fract - vec2(0.0,0.0) ),
                     dot( random(uv_index + vec2(1.0,0.0) ), uv_fract - vec2(1.0,0.0) ), blur.x),
                mix( dot( random(uv_index + vec2(0.0,1.0) ), uv_fract - vec2(0.0,1.0) ),
                     dot( random(uv_index + vec2(1.0,1.0) ), uv_fract - vec2(1.0,1.0) ), blur.x), blur.y) + 0.5;
}

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 pos = (UV - 0.5) * 2.0;
	float pixel_scale = 4000.0 * time;
	pos = round(pos * pixel_scale) / pixel_scale;
	
	float min_radius = time / 5.0;
	float max_radius = min_radius + 0.005;

	float d = length(pos);
	if (d > max_radius || d < min_radius) {
		discard;
	}

	COLOR = vec4(0.6, 1.0, 0.9, 1) * smoothstep(min_radius, max_radius, d + random(pos).x * 0.03);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
