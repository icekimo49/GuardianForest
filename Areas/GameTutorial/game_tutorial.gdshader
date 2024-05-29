shader_type canvas_item;

uniform sampler2D noise_texture : repeat_enable, filter_nearest;
uniform float density : hint_range(0.0, 1.0) = 0.25; 
uniform vec2 kecepatan = vec2(0.12, 0.1);

void fragment() { 
	vec2 uv = UV + kecepatan * TIME;
	float noise = texture(noise_texture, uv).r;
	float fog = clamp(noise *2.0 -1.0, 0.0, 1.0);
	
	COLOR.a *= fog * density;
}
