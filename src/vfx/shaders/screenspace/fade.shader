shader_type canvas_item;

uniform sampler2D animTexture : hint_black_albedo;
uniform float progress :  hint_range(0, 1);

void fragment() {
    vec3 col = texture(TEXTURE, SCREEN_UV).xyz;
	vec2 tSize = 1.0/vec2(textureSize(animTexture,0));
	vec2 coord = round(SCREEN_UV/tSize) * tSize;
	if(texture(animTexture,coord).r > progress) col = vec3(0.0);

    COLOR.xyz = col;
		COLOR.a = 1f - col.r;
}
