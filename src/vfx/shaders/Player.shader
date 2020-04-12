shader_type canvas_item;
uniform float strength = 1;
uniform float noiseScale = 1;
uniform float timeStep = .25f;
uniform vec4 leftColour : hint_color;
uniform vec4 rightColour : hint_color;
uniform bool coloured = false;
uniform sampler2D noiseTex;

void fragment() {
		//Round to nearest texel
	vec2 rounded = round(UV/TEXTURE_PIXEL_SIZE) * TEXTURE_PIXEL_SIZE;
	//Round to nearest time step
	float roundedTime = round(TIME/timeStep) * timeStep;
	//Calculate a -1 to 1 offset
	vec2 offset = texture(noiseTex,fract((rounded + roundedTime ) * noiseScale)).xy * 2.0 - 1.0;
	//Calculate a texel offset
	vec2 coord = (vec2(offset.x * TEXTURE_PIXEL_SIZE.x * strength, offset.y * TEXTURE_PIXEL_SIZE.y * strength));
	//Sample noisily
	vec4 col = texture(TEXTURE,UV + coord);
	if(coloured){
		float multiplier = float(length(col.rgb - vec3(.317,.345,.368)) >.4) + .6;
		if(UV.x + coord.x > .5) col.rgb = rightColour.rgb * multiplier;
		else col.rgb = leftColour.rgb * multiplier;
	}
    COLOR = col;
}