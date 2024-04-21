shader_type canvas_item;

uniform float time;
uniform float brightness;
uniform vec2 begin;
uniform vec2 end;

void vertex() {
	// Called for every vertex the material is visible on.
}

float projectOnLine(vec2 a, vec2 b, vec2 p) {
    return clamp(dot(p - a, normalize(b - a)) / distance(a, b), 0.0f, 1.0f);
}

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
	float scale = 1.0;
	for (int i = 0; i < layers; i++) {
		r += noise(p) * scale;
		p *= 2.0;
		scale /= 2.0;
	}
	return r - 0.5;
}

bool isLeft(vec2 a, vec2 b, vec2 c) {
  return (b.x - a.x)*(c.y - a.y) - (b.y - a.y)*(c.x - a.x) > 0.0;
}

void fragment() {
	vec2 uv = round(FRAGCOORD.xy / 4.0) * 4.0;
	float t = projectOnLine(begin, end, uv) - 0.5;
	float dist = distance(uv, mix(begin, end, t + 0.5));
	vec2 local_uv = vec2(t * distance(begin, end) + time * 300.0, dist);
	
	if (isLeft(begin, end, uv)) {
		local_uv.y = -local_uv.y;
	}

	float pulse = sin(local_uv.x / 50.0) / 3.0 + 1.0;
	float noise1 = fractal_noise(local_uv / 25.0, 4);

	COLOR = vec4(0.6, 1.0, 0.9, 1) * smoothstep(50.0, 0.0, dist) * noise1 * pulse * brightness;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
