shader_type canvas_item;

uniform float time;
uniform float speed;
uniform float angle;

vec2 rotate(vec2 p, float a)
{
	return p * mat2(vec2(cos(a), -sin(a)),
					vec2(sin(a), cos(a)));
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

float fractal_noise(vec2 p, int layers, float falloff) {
	float r = 0.0;
	float scale = 1.0;
	for (int i = 0; i < layers; i++) {
		r += noise(p) * scale;
		p *= 2.0;
		scale /= 2.0;
	}
	return r - 0.5;
}

vec3 hsv2rgb(vec3 c) {
	vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

vec3 star(vec2 uv) {
	vec2 tile_pos = round((uv) * 5.0) / 5.0;
	vec2 star_pos = tile_pos + random(tile_pos * 10.0) * 0.06;
	float star_dist = pow(distance(star_pos, uv), 0.5);
	return hsv2rgb(vec3(noise(tile_pos), 0.2, 1.0)) * smoothstep(0.1, 0.0, star_dist);
}

vec3 background(vec2 uv, vec2 d) {
	vec2 offset = d * speed;
	vec3 dust1 = vec3(0.1, 0.15, 0.25) * fractal_noise((uv + offset) * 12.0, 4, 0.0);
	vec3 dust2 = vec3(0.15, 0.0, 0.0) * fractal_noise((uv + offset * 2.0) * 8.0 + vec2(3.0, 4.0), 4, 0.0);

	vec3 star1 = star(uv + offset);
	vec3 star2 = star(uv + offset + vec2(1.0, 2.0));

	return dust1 + dust2 + star1 + star2;
}

void vertex() {}

void fragment() {
	vec2 uv = round(FRAGCOORD.xy / 8.0) * (SCREEN_PIXEL_SIZE * 8.0);
	vec2 d = rotate(vec2(-time, 0), angle);
	COLOR = vec4(background(uv, d), 1.0);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
