shader_type canvas_item;

uniform float scale;

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

float fractal_noise(vec2 p, int layers) {
	float r = 0.0;
	float s = 1.0;
	for (int i = 0; i < layers; i++) {
		r += noise(p) * s;
		p *= 2.0;
		s /= 2.0;
	}
	return r - 0.5;
}

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 pos = (UV - 0.5) * 2.0;
	pos = round(pos * 500.0) / 500.0;
	float radius = 0.04 * scale - 0.002;
	float d = length(pos) - radius;
	float brightness = smoothstep(0.02, 0.0, abs(d)) * fractal_noise(pos * 100.0, 4);
	brightness += fract(smoothstep(0.0019, 0.021, d));
	COLOR = vec4(0.6, 1.0, 0.9, 1) * brightness;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
