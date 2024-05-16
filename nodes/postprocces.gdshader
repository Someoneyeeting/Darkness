shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform float intense = 1.0;
uniform bool web = false;

void vertex() {
}

void fragment() {
	vec3 clr;
 	float toRadians = 3.14 / 180.;
	float rand = fract
        ( 10000.0
        * sin
            (
              ( SCREEN_UV.x
              + SCREEN_UV.y
              * TIME
              )
            * 30.0
            )
        );
	float rand2 = fract
        ( 10000.0
        * sin
            (
              ( SCREEN_UV.x
              + SCREEN_UV.y
              * TIME * 4. - 100.
              )
            * 40.0
            )
        );
	if(!web){
		clr = texture(SCREEN_TEXTURE,SCREEN_UV + vec2(0.00091,0.00087) * sin(TIME * 100.) * rand).rgb;
	}
	else{
		clr = texture(SCREEN_TEXTURE,SCREEN_UV).rgb;
	}
	rand /= intense;
	rand = rand;
	clr.rgb += vec3(rand) * clr.r;
	
	COLOR.rgb = clr;
}
