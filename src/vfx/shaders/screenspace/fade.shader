shader_type canvas_item;

uniform sampler2D animTexture : hint_black_albedo;
uniform float progress :  hint_range(0, 1);

void fragment() {
	COLOR.rgb = vec3(0, 0, 0);
  COLOR.a = texture(animTexture, SCREEN_UV).r > progress ? 1f : 0f;
}
