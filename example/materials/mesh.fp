varying highp vec4 var_position;
varying mediump vec3 var_normal;
varying mediump vec3 var_color;
varying highp vec2 var_uv;

uniform mediump vec4 tint;
uniform mediump vec4 light_direction;
uniform mediump vec4 ambient_color;

uniform lowp sampler2D texture0;

void main()
{
    vec3 color = mix(tint.rgb, texture2D(texture0, var_uv).rgb * var_color, tint.a);

    // Directional light
    float ambient_strength = ambient_color.w;
    vec3 ambient = ambient_strength * ambient_color.rgb;
    float diff_light = max(dot(var_normal, normalize(-light_direction.xyz)), 0.0) * (1.0 - ambient_strength);

    // Final composition
    float gamma = 2.2;
    vec3 comp = min(color.rgb * min(diff_light + ambient, vec3(1.0)), vec3(1.0));
    gl_FragColor = vec4(pow(comp, vec3(1.0 / gamma)), 1.0);
}
