shader_type canvas_item;

uniform float blink_speed = 1.0;
uniform bool blink_toggle = false;

uniform float amplitude = 0.5;
uniform float frequency = 2.0;


void fragment() {
	vec4 color = texture(TEXTURE, UV);
	
	float pulsate = sin(TIME * frequency) * amplitude;
	
	if (blink_toggle){
		float blink = sin(TIME * blink_speed);
		
		color.a *= abs(blink);
	}

	
	color.a = max(94.0 / 255.0, min(164.0 / 255.0, color.a));
	COLOR = color;
}
